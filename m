Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAE7EAE3E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:43:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qsU-0001N9-Uo; Tue, 14 Nov 2023 05:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qsS-0001Mu-1R
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qsL-0002jw-6L
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699958552;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XLxeVgzyrCeYBInS3E3OazEvAIyaSDoWSbprfFn6YQ=;
 b=Zr7whtQD6tN3pY090zoGcdZXmkrw/DLc2wov6eFywI8Ol6qzuRemR91ovsQL8Tm3bYm6hO
 GQyE3bUjDY65gLX0cfcnIO0EVdOE7HHDwZJY5QWHvI/AWPr6+KRSwL37mjXZ06pVfdPnBT
 hs5Orqkga6W9buC7ACOnfuFhEvaQvEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-M-e391lMP2mHKlSFjRHx-g-1; Tue, 14 Nov 2023 05:42:30 -0500
X-MC-Unique: M-e391lMP2mHKlSFjRHx-g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084d08235fso35870505e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 02:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699958549; x=1700563349;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2XLxeVgzyrCeYBInS3E3OazEvAIyaSDoWSbprfFn6YQ=;
 b=U0J1cAvbPZdR/nJ9UqzORsUKDFW03PrJE77A10qqvGHiziWhr8g2NB4FKW7puHRgEn
 d5peI2yB3iGwMgFWrtrbkQ1lVdrynJhF5O48TIUNvI/BwcP75SLtZhO0fFptmrVI67S8
 o3fsDPr+ZzgiHMhrXDEiuMNiKukuL+1PAbMO1QouLMs1tm/bpN6cmaUGNdaIAesZkQ15
 Znubt568QwZlUaoqqiAK35Z4bjk8j8AnV0icCGsyQ/1CrsLmfl9AKr+thbH0Gwii3AUw
 OJAmSkejiBsSAxn8twHsbtlL2sc8pOPKrekIXKtgXPk/QH1IEtPUKAoPl2n/2fYI5may
 1J/g==
X-Gm-Message-State: AOJu0Yy+CSgfT0MBDLXWVCCMlbuIyp1xCfMoc/aUkDynKYRpAGX6OL2j
 zQd+Nz+e9RKrTiEpwn7WTVGWE+bgPoJ6jvv3lX6LKGpKA+gpX40VuN3Wm8/tt+aaJlaqLt5Hg9H
 W5exqbb7HhkpO4jE=
X-Received: by 2002:a05:600c:5126:b0:40a:57b4:3d35 with SMTP id
 o38-20020a05600c512600b0040a57b43d35mr2899393wms.13.1699958549460; 
 Tue, 14 Nov 2023 02:42:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBLT+P+1p1fjdW0aHl/h6seWVmgcKyDxC/Sl7HiXLFHovTpzpr4m9muWg0cfeKJHeBIJ7EGg==
X-Received: by 2002:a05:600c:5126:b0:40a:57b4:3d35 with SMTP id
 o38-20020a05600c512600b0040a57b43d35mr2899370wms.13.1699958549032; 
 Tue, 14 Nov 2023 02:42:29 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 fm14-20020a05600c0c0e00b003fee8793911sm10881840wmb.44.2023.11.14.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 02:42:28 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: Configuring migration
In-Reply-To: <ZVNNTgYD2bikZVxH@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 14 Nov 2023 10:34:54 +0000")
References: <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
 <ZVM5xmsaE41WJYgb@redhat.com> <87pm0cochf.fsf@secure.mitica>
 <ZVNNTgYD2bikZVxH@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 14 Nov 2023 11:42:27 +0100
Message-ID: <87h6loobu4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Tue, Nov 14, 2023 at 11:28:28AM +0100, Juan Quintela wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> > On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
>> >> Now let's try to apply this to migration.
>> >>
>> >> As long as we can have just one migration, we need just one QAPI obje=
ct
>> >> to configure it.
>> >>=20
>> >> We could create the object with -object / object_add.  For convenienc=
e,
>> >> we'd probably want to create one with default configuration
>> >> automatically on demand.
>> >>=20
>> >> We could use qom-set to change configuration.  If we're not comfortab=
le
>> >> with using qom-set for production, we could do something like
>> >> blockdev-reopen instead.
>> >
>> > Do we even need to do this via a QAPI object ?
>> >
>> > Why are we not just making the obvious design change of passing everyt=
hing
>> > with the 'migrate' / 'migrate-incoming' commands that kick it off:
>> >
>> > ie:
>> >
>> > { 'command': 'migrate',
>> >   'data': {'uri': 'str',
>> >            '*channels': [ 'MigrationChannel' ],
>> > 	   '*capabilities': [ 'MigrateCapability' ],
>> > 	   '*parameters': [ 'MigrateParameters' ],
>> >            '*detach': 'bool', '*resume': 'bool' } }
>>=20
>> Once that we are doing incompatible changes:
>
> This is not incompatible - it is fully backcompatible with existing
> usage initially, which should make it pretty trivial to introduce
> to the code. Mgmt apps can carry on using migrate-set-capabilities
> and migrate-set-parameters, and ignore these new 'capabilities'
> and 'parameters' fields if desired.
>
> Only once we decide to deprecate migrate-set-capabilities, would
> it become incompatible.

Oh, I mean that the interface is incompatible.  Not that we can't do the
current one on top of this one.

>> - resume can be another parameter
>
> Potentially yes, but 'resume' is conceptually different to all
> the other capabilities and parameters, so I could see it remaining
> as a distinct field as it is now

It is conceptually different.  But it is the _only_ one needed that
capability.  And putting that on the parameters and just checking it
first will achieve the same result.  I think that being special here
don't help, for instance, to check for incompatible things, we need to
also pass resume (it is only valid for postcopy).

>> - detach is not needed.  QMP don't use it, and HMP don't need to pass it
>>   to qmp_migrate() to make the non-detached implemntation.
>
> We could deprecate that today then.

Yeap.  Will do it.

>> >      (deprecated bits trimmed for clarity)
>> >
>> > and the counterpart:
>> >
>> > { 'command': 'migrate-incoming',
>> >              'data': {'*uri': 'str',
>> >                       '*channels': [ 'MigrationChannel' ],
>> >                       '*capabilities': [ 'MigrateCapability' ],
>> >                       '*parameters': [ 'MigrateParameters' ] } }
>> >
>> > such that the design is just like 99% of other commands which take
>> > all their parameters directly. We already have 'migrate-set-parameters'
>> > remaining for the runtime tunables, and can deprecate the usage of this
>> > when migration is not already running, and similarly deprecate
>> > migrate-set-capabilities.
>>=20
>> This makes sense to me, but once that we change, we could try to merge
>> capabilities and parameters.  See my other email on this topic.
>> Basically the distition is arbitrary, so just have one of them.
>>=20
>> Or better, as I said in the other email, we have two types of
>> parameters:
>> - the ones that need to be set before migration starts
>> - the ones that can be changed at any time
>>=20
>> So to be simpler, I think that 1st set should be passed to the commands
>> themselves and the others should only be set with
>> migrate_set_parameters.
>
> As a mgmt app dev I don't want there to be an arbitrary distinction
> between what I can pass with 'migrate' and what I have to use a
> separate command for.

If it ever wants to set the parameter that it "can" change after
migration starts, it needs to know that they are different.

Once told that, I don't write management apps and you do so I am not
discussing further O:-)

> If I'm starting a migration, I just want to
> pass all the settings with the 'migrate' command. I should not have
> to care about separate 'migrate-set-parameters' command at all, unless
> I actually need to change something on the fly (many migrates will
> never need this).


What OpenStack/CNV do?

If my memory is right, at least one of them used progressive downtimes
every couple of iterations or something like that.

Later, Juan.

> With regards,
> Daniel


