Perk TOUGH_HEAD
{
  defenseDamageFactor=-15850
  chance=0.25
  defense="HeadDefense"
  iconFrames=90

  Trigger TOUGH_HEAD
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Target=="Me", event.Defense==defense, event.Critical, random() < chance )
    }
    
    Action
    {
      ModAttributes ( Player="Enemy", DamageFactor=defenseDamageFactor, Frames=1 )
      ModIcon ( Name="Icon", Frames=iconFrames )
    }
  }
}
Perk FITNESS
{
  unarmedAttackBoostChance = 0.3
  weaponAttackBoostChance = 0.02
  defenseBoostChance = 0.1
  attackDamageFactor = 10000
  defenseDamageFactor = -66439

  Trigger FITNESS_UNARMED_ATTACK
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Target=="Enemy", event.Animation=="Unarmed", random() < unarmedAttackBoostChance )
    }
    
    Action
    {
      ModAttributes ( DamageFactor=attackDamageFactor, Frames=1, Player="Me" )
    }
  }
  
  Trigger FITNESS_WEAPON_ATTACK
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Target=="Enemy", event.Animation=="Weapon", random() < weaponAttackBoostChance )
    }
    
    Action
    {
      ModAttributes ( DamageFactor=attackDamageFactor, Frames=1, Player="Me" )
    }
  }
  
  Trigger FITNESS_DEFENSE
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Target=="Me", random() < defenseBoostChance )
    }
    
    Action
    {
      ModAttributes ( DamageFactor=defenseDamageFactor, Frames=1, Player="Enemy" )
    }
  }
}
Perk HELM_BREAKER
{
  attackDamageFactor = 5850
  chance = 0.2
  iconFrames = 300
  initialBoostFrames = 60
  restrictionFrames = 600
  defense = "HeadDefense"
  
  Trigger HELM_BREAKER_INITIAL_RESTRICTION
  {
    Event
    {
      return "FightStart"
    }
    
    Condition
    {
      return true
    }
    
    Action
    {
      ModIcon ( Name="Head_Breaker_restriction", Frames = restrictionFrames, Player="Enemy")
    }
  }
  
  Trigger HELM_BREAKER_INITIAL_BOOST
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND (  event.Target=="Enemy", event.Defense==defense, not event.Block, random() < chance, 
      not ModExists( Name = "Head_Breaker_restriction" ), not ModExists ( Name = "Icon" ), not ModExists( Name = "Initial_Boost_Icon" )
    }
    
    Action
    {
      ModIcon ( Name="Initial_Boost_Icon", Frames=initialBoostFrames, Player="Enemy" )
    }
  }
  
  Trigger HELM_BREAKER_BOOST
  {
    Event
    {
      return "ModExpires"
    }
    
    Condition
    {
      return event.Name=="Initial_Boost_Icon"
    }
    
    Action
    {
      ModIcon ( Name="Icon", Frames=iconFrames-initialBoostFrames, Player="Enemy" )
    }
  }
  
  Trigger HELM_BREAKER_INITIAL_BOOST_END
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Player=="Enemy", event.Defense==defense, not event.Block, ModExists ( Name = "Initial_Boost_Icon" ) )
    }
    
    Action
    {
      ModAttributes ( DamageFactor=attackDamageFactor*2, Frames="1" )
    }
  }
  
  Trigger HELM_BREAKER_BOOST_END
  {
    Event
    {
      return "PreHit"
    }
    
    Condition
    {
      return AND ( event.Player=="Enemy", event.Defense==defense, not event.Block, ModExists ( Name = "Icon" ) )
    }
    
    Action
    {
      ModAttributes ( DamageFactor=attackDamageFactor, Frames="1" )
    }
  }
}
