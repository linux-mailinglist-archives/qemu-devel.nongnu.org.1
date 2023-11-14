Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F07EADE5
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:21:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qXZ-0000zw-Fz; Tue, 14 Nov 2023 05:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qXX-0000yP-Aq
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qXT-0006ja-UK
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699957257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Fq6TSgcDUNjjoV19+XloXf5QEt90Ljy8kIheevGKY5A=;
 b=BlDA3P43TbHu+jpF3tTRuolzeuKeQ99RFD/D1SbyE25Rjw6Wwg/p7HMguGvNkttAR/VN1t
 YGAvTOxs7paSxNDtErlS8bdpCRhZUTfP44cshNfRygUiMGxOssHVwZZCmtzKAGRSkHcReO
 kLOV5e1cBiz9o/BKdhMvuxJsYrSqJ2k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-WwDSWXQAM666tmnkD9ckkg-1; Tue, 14 Nov 2023 05:20:56 -0500
X-MC-Unique: WwDSWXQAM666tmnkD9ckkg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f820c471fso2554535f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 02:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699957255; x=1700562055;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fq6TSgcDUNjjoV19+XloXf5QEt90Ljy8kIheevGKY5A=;
 b=Un7xPQBL8caKvmdAHTV8WBTRBKxWocKHuldCJcr3p/uRfRA2HufcKwRk+Y6+/foqWR
 NOp9s8kSmE4D/5hyiWub7zjpZaqovI2SY9CFRszN5IGpJ4dORfpyKsR6ii2LxYNfUDAq
 CkP0oAKhh2h2VWTTF3qWjgwYuKna6TpiesEuZFz2+gVcvREaZk2GjBPWZOqAIPnHTvA/
 vVwoEsBUD6lZhRuppvp5Aqf/WJ827h8cOXl5wYD56FnL9ciaxUBRJ/e2+UZ3ru9Rni0I
 tOrZ2pcnGDVFWdMbdD7JcPi8IXZGvm+z640xcUv8zyBlfKTB6fDV8plGvycZ0yv+F3tD
 Ad/w==
X-Gm-Message-State: AOJu0Yz2jGjLRDtjuqjWnMzCgWmSaqhRI3ltepZd6oP9HqzZLs68dj5z
 YLkwZhTH8D7oaFQqFQtyJUIU37JN79Hi7VZvGo6fUZRbgUaGqIAOxuXsoJ4A2jio9W6k72r5RV+
 ENBOd+ctRi3yIGwE=
X-Received: by 2002:a05:6000:144c:b0:32f:71e2:adfb with SMTP id
 v12-20020a056000144c00b0032f71e2adfbmr7870390wrx.3.1699957254737; 
 Tue, 14 Nov 2023 02:20:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE85NYnQzvH2lZ41DGes3MILPAmKZGBnv0FGdE7X2+eCTzOwY9mQ5OtxGRV2JkA8j1dQiVrTg==
X-Received: by 2002:a05:6000:144c:b0:32f:71e2:adfb with SMTP id
 v12-20020a056000144c00b0032f71e2adfbmr7870364wrx.3.1699957254249; 
 Tue, 14 Nov 2023 02:20:54 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j30-20020adfb31e000000b003197869bcd7sm7509627wrd.13.2023.11.14.02.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 02:20:53 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Configuring migration
In-Reply-To: <875y24iyl8.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 14 Nov 2023 08:27:31 +0100")
References: <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
 <ZUPk33GUF/PvAPPo@x1n> <875y24iyl8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 14 Nov 2023 11:20:53 +0100
Message-ID: <87ttpoocu2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
D> Cc: Paolo for QOM expertise.
>
> Peter Xu <peterx@redhat.com> writes:
>
>> On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
>
> [...]
>
>>> Migration has its own idiosyncratic configuration interface, even though
>>> its configuration needs are not special at all.  This is due to a long
>>> history of decisions that made sense at the time.
>>> 
>>> What kind of interface would we choose if we could start over now?
>>> 
>>> Let's have a look at what I consider the two most complex piece of
>>> configuration to date, namely block backends and QOM objects.
>>> 
>>> In both cases, configuration is a QAPI object type: BlockdevOptions and
>>> ObjectOptions.
>>> 
>>> The common members are the configuration common to all block backends /
>>> objects.  One of them is the type of block backend ("driver" in block
>>> parlance) or QOM object ("qom-type").
>>> 
>>> A type's variant members are the configuration specific to that type.
>>> 
>>> This is suitably expressive.
>>> 
>>> We create a state object for a given configuration object with
>>> blockdev-add / object-add.
>>> 
>>> For block devices, we even have a way to modify a state object's
>>> configuration: blockdev-reopen.  For QOM objects, there's qom-set, but I
>>> don't expect that to work in the general case.  Where "not work" can
>>> range from "does nothing" to "explodes".
>>> 
>>> Now let's try to apply this to migration.
>>> 
>>> As long as we can have just one migration, we need just one QAPI object
>>> to configure it.
>>> 
>>> We could create the object with -object / object_add.  For convenience,
>>> we'd probably want to create one with default configuration
>>> automatically on demand.
>>> 
>>> We could use qom-set to change configuration.  If we're not comfortable
>>> with using qom-set for production, we could do something like
>>> blockdev-reopen instead.
>>> 
>>> Could we move towards such a design?  Turn the existing ad hoc interface
>>> into compatibility sugar for it?
>>
>> Sounds doable to me.
>>
>> I'm not familiar with BlockdevOptions, it looks like something setup once
>> and for all for all relevant parameters need to be set in the same request?
>
> Yes, but you can "reopen", which replaces the entire configuration.
>
> blockdev-add creates a new block backend device, and blockdev-reopen
> reopens a set of existing ones.  Both take the same arguments for each
> device.
>
>> Migration will require each cap/parameter to be set separately anytime,
>> e.g., the user can adjust downtime / bandwidth even during migration in
>> progress.
>
> "Replace entire configuration" isn't a good fit then, because users
> would have to repeat the entire configuration just to tweak one thing.

We have two types of parameters:
- multifd_channels type: we need to set them before the migration start
- downtime: We can change it at any time, even during migration

So I think we need two types of parameters.
For the parameters that one can't change during migration, it could be a
good idea to set all of them at once, i.e.

(qemu) migration_set multifd on multifd-channels 6 multifd_compression none

Whatever syntax we see fit.  That would make it easier to:
- document what parameters make sense together (they need to be set at
  the same time)
- convert migrate_params_check()/migrate_params_test_apply()/migrate_params_apply()
  into a sane interface.
- this parameters don't need to be atomic, they are set by definition by
  the main thread before the migration starts.  The other parameters
  needs to be atomic.

>> Making all caps/parameters QOM objects, or one object containing both
>> attributes, sounds like a good fit.  object_property_* APIs allows setters,
>> I think that's good enough for migration to trigger whatever needed (e.g.
>> migration_rate_set() updates after bandwidth modifications).
>>
>> We can convert e.g. qmp set parameters into a loop of setting each
>> property, it'll be slightly slower because we'll need to do sanity check
>> for each property after each change, but that shouldn't be a hot path
>> anyway so seems fine.
>
> I figure doing initial configuration in one command is convenient.  The
> obvious existing command for that is object-add.
>
> The obvious interface for modifying configuration is a command to change
> just one parameter.  The obvious existing command for that is qom-set.

As said before, I think we need two commands:

- migrate_set_method method [list of method arguments with values]
  Values that need to be set before migration

- migrate_set_parameter parameter value
  Values that can be changed at any time

> Problem: qom-set is a death trap in general.  It can modify any QOM
> property with a setter, and we test basically none of them.  Using it
> for modifying migration configuration would signal it's okay to use
> elsewhere, too.  I'm not sure we want to send that message.  Maybe we
> want to do the opposite, and make it an unstable interface.
>
> Aside: I believe the root problem is our failure to tie "can write" to
> the object's state.  Just because a property can be set with object-add
> doesn't mean it can be validly changed at any time during the object's
> life.

Yeap.

> Problem: when several parameters together have to satisfy constraints,
> going from one valid configuration to another valid configuration may
> require changing several parameters at once, or else go through invalid
> intermediate configurations.

There are other things that "currently" we are not considering and that
make things really strange.

(qemu) migrate_set_capability xbzrle on
(qemu) migrate_set_parameter xbzrle_cache $foo
(qemu) migrate $bar

migration fails for whatever reason

we try again with another method, let's say multifd

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_parameter multifd-channels $foo2
(qemu) migrate $bar2

At this point, xbrzrle_cache is still set, but it makes no sense.  So I
think that if we change the interface, the migrate_set_method that I
suggested would just clean-up all values to its defaults.


> This problem is not at all specific to the migration object.
>
> One solution is careful design to ensure that there's always a sequence
> of transitions through valid configuration.  Can become complicated as
> configuration evolves.  Possible even impractical or impossible.

This is a nightmare.  See migrate_params_check().  Basically everytime
that we add a capability/parameter we need to go through all the list to
see if anything is compatible/incompatible.  It is much better that we
set all that kind of parameters at once, so this is much easier to understand.

> Another solution is a command to modify multiple parameters together,
> leaving alone the others (unlike blockdev-reopen, which overwrites all
> of them).

I still think we need both methods because we have the two kinds of
parameters.

Actually, it is even worse than that, because there are parameters that
need to be set before the migration start but that are not related to
the migration method at all.



>> It'l still be a pity that we still cannot reduce the triplications of qapi
>> docs immediately even with that.  But with that, it seems doable if we will
>> obsolete QMP migrate-set-parameters after we can do QOM-set.

Trying to be practical, this are the capabilities:

{ 'enum': 'MigrationCapability',
  'data': [

'xbzrle'  <- how we compress, but it is used on top of anything else
             except multifd/rdma
'rdma-pin-all' <- this is a rdma parameter, but at the time there were
             not parameters, so here we are.

'auto-converge' <- this is obsolete.  Dirty limit features are better
                   for this.  But this again is independent of anything
                   else.  I will have to double check to see if it can
                   be set at any moment.
'zero-blocks' <- only for storage migration, clearly a parameter.

{ 'name': 'compress', 'features': [ 'deprecated' ] } <- migration
           compression method
'events' <- this should be default and make it a nop for backwards
           compatibility.  I think libvirt sets it always.

'postcopy-ram' <- we want to do postcopy.  I don't even remember why
                  this is a capability when we have to issue a command
                  to start it anyways

{ 'name': 'x-colo', 'features': [ 'unstable' ] }, <- colo is
                  experimental, not even enter here.

'release-ram' <- This only makes sense if:
                 * we are in postcopy
                 * we are migration with the guest stopped (and not sure
                   if in this case it even works)

{ 'name': 'block', 'features': [ 'deprecated' ] } <- deprecated, don't
           spent time here.

'return-path' <-  basically everything except exec should have this.
                  this is way from destination to give us back errors.
                  exec basically is not able to give any error.

'pause-before-switchover' <-  This is independent of anything else, but
                              it makes sense to require to set it before
                              migration start.  Used when you need to
                              "lock" things, like block devices to a
                              single user.  Think iscsi block devices
                              that can only be enabled at the same time
                              on source or destination, but not both.

'multifd' <- migration method

'dirty-bitmaps' <- block migration is weird.  I don't remember this one.


'postcopy-blocktime' <- don't even remember

'late-block-activate' <- I think this is somehow related to
                         pause-before-switchover, but I don't ever
                         remember the details.  I guess we did it wrong
                         the fist time.

{ 'name': 'x-ignore-shared', 'features': [ 'unstable' ] } <- we need to
           mark this stable.  Basically means that:
           * we are migratin on the same machine
           * RAM is mmaped in source/destination shared
           * so we don't need to migrate it.

'validate-uuid' <- making sure that we are migration to the right
                   destination.  Independent of anything else.  Should
                   be set before migration starts.

'background-snapshot' <- block devices are big and slow.  Migrating them
           is complilaceed.  Forgot about them.

'zero-copy-send' <- only valid for multifd, should be a paramter

'postcopy-preempt' <-  We create a new channel for postcopy, depends on
                       postcopy and needs to be set before migration starts.

'switchover-ack' <- Independent of anything else.  Needs to be set
           before migration starts.

'dirty-limit' <- Autoconverge was bad.  We create another way of doing
                 the same functionality.


And now we go with migration_parametres:

'announce-initial', 'announce-max',
'announce-rounds', 'announce-step',
	I think we should set all of them at the same time.
        Before migration ends.  This is SDN for you, sometimes we need
        to repeat the ARP packets to get they passed through routers.
        Hello openstack.


{ 'name': 'compress-level', 'features': [ 'deprecated' ] },
{ 'name': 'compress-threads', 'features': [ 'deprecated' ] },
{ 'name': 'decompress-threads', 'features': [ 'deprecated' ] },
{ 'name': 'compress-wait-thread', 'features': [ 'deprecated'] },

	Parameters for old compression method.  Should be set before we start.

'throttle-trigger-threshold',
'cpu-throttle-initial',
'cpu-throttle-increment',
'cpu-throttle-tailslow',
'max-cpu-throttle'
	Autoconverge parameters.  Make sense to change them after we start.
        Remember that autoconverge was a good idea and a bad
        implementation.

'tls-creds', 'tls-hostname', 'tls-authz',

        They are only needed if we are using TLS.  But we only need TLS
        depending on the URI we are using (tcp+tls).

'max-bandwidth',
        Can be changed at any time.

'avail-switchover-bandwidth',
        Can be changed at any time.  Better explained, it shouldn't be
        needed.  But we know that it is needed after migration starts,
        so ...

'downtime-limit',
        Can be changed at any point.

{ 'name': 'x-checkpoint-delay', 'features': [ 'unstable' ] },
	Colo parameter.  Needs to be set before migration starts.

{ 'name': 'block-incremental', 'features': [ 'deprecated' ] },
	deprecated, but needs to be set before migration starts.

'multifd-channels',
	Needs to be set before migration starts.

'xbzrle-cache-size'
	Needs to be set before migration starts.
        It *could* be changed after migration starts, but ...

'max-postcopy-bandwidth'
	When we are in postcopy stage, reasonable thing to do is to use
	all available bandwidth.  When that is not true, use this parameter.


'multifd-compression'
'multifd-zlib-level'
'multifd-zstd-level'
	multifd compression parameters.  Depending of
        multifd-compression value, the others make sense or not.

'block-bitmap-mapping',
	I don't understand/remember this new block migration, so I can't comment.

{ 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable'] },
	Needs to be set before migration starts.
'vcpu-dirty-limit',
	One could defend to change it after migration starts, but ....

'mode'
        set before migration starts


So you can see that we have lots of parameters to try to make sense of.

Later, Juan.


