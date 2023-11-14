Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D57EAE0B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:29:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qf1-0003mW-J9; Tue, 14 Nov 2023 05:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qer-0003d7-Ej
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r2qeo-00085h-Os
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699957713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L1FTf7BQgnbDoJi8opqoaaXzrdRJrFpqx7q1EzrOBbk=;
 b=XUIZe6WJO62c/FbjWqBimYZybmULRjFqL1jzR4qIrn2ukz4nZsjZ9uA2on7P4q8I88b294
 N88iAYS+c850jMYAsUDEMTBz/T7xfnHOtqSPLqeGoMLx/omDqST755Ab+ixUKM4T8qzYnD
 3c8sUzWeZSz+ZxmuNK/HodTd5cxakfg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-liTTrh7EMuutA8u4AJ2LAw-1; Tue, 14 Nov 2023 05:28:32 -0500
X-MC-Unique: liTTrh7EMuutA8u4AJ2LAw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so2785566f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 02:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699957709; x=1700562509;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1FTf7BQgnbDoJi8opqoaaXzrdRJrFpqx7q1EzrOBbk=;
 b=Fst6Sq6oZTfLA3gUbx2nC2OawIULPhZgWqZCA7LqXssvWu7pvIhOqBpSuvcWAVh9nJ
 L84oi5UXQEwmDcMC3XLhpkC2pu0eThC2mHlL6QkavVKcJwToR8lsou/uxRihnxkzYE0V
 SZu8nFCe8HzFTanSMafaYQcvuYGNNNgYz40df/TXCDBiq4JQ5pClbyxGgXGULu8o7wMf
 UGZa2uJSLaLn3ONCnzTUbEU3yKZArY+MX/LR5iavE05L8lFHUFBHQK2sOi7xgFFvMEvb
 EpLewf8hTo14Xd7vPDuVXIBwgDhdlYmPkLSWQjSaMqRRn1RoOlTTIuet3EONmPwDrcRX
 i//A==
X-Gm-Message-State: AOJu0YzUsH3M647osd+KvZxVjwkNrD37afzyepGYa3X/UcH5Z6Sp5ght
 ouA8RK4O83kQWaN96YwZupPoH3nhrwqp8E+aEUO90/uwX2vJJEqbx8RFKMP7gheroa7jXcsg6Mw
 j9hp4ncx088w/D5l4cT9WT6c4Lg==
X-Received: by 2002:a5d:60ca:0:b0:32d:9d64:b429 with SMTP id
 x10-20020a5d60ca000000b0032d9d64b429mr6084912wrt.21.1699957709367; 
 Tue, 14 Nov 2023 02:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLMIxLzmI32aAyQgazFHmX8Nuz0SGj7c2FroRM7lWLsfw/NGkduzQUrVrYLXaAUDt9pNiHzw==
X-Received: by 2002:a5d:60ca:0:b0:32d:9d64:b429 with SMTP id
 x10-20020a5d60ca000000b0032d9d64b429mr6084897wrt.21.1699957709071; 
 Tue, 14 Nov 2023 02:28:29 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f13-20020a5d4dcd000000b0032f7c563ffasm7416940wru.36.2023.11.14.02.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 02:28:28 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: Configuring migration
In-Reply-To: <ZVM5xmsaE41WJYgb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 14 Nov 2023 09:13:30 +0000")
References: <87sf6k2dax.fsf@pond.sub.org> <ZSVoK6YMgNzrDYGQ@x1n>
 <878r8ajngg.fsf@pond.sub.org> <ZSWvYgKcGXlucXx6@x1n>
 <875y3dixzp.fsf@pond.sub.org> <8734yhgrzl.fsf@pond.sub.org>
 <ZShI4AucDGvUvJiS@x1n> <877cnrjd71.fsf@pond.sub.org>
 <87zfzz82xq.fsf@secure.mitica> <87msvw6xm2.fsf_-_@pond.sub.org>
 <ZVM5xmsaE41WJYgb@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 14 Nov 2023 11:28:28 +0100
Message-ID: <87pm0cochf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Nov 02, 2023 at 03:25:25PM +0100, Markus Armbruster wrote:
>> Now let's try to apply this to migration.
>>
>> As long as we can have just one migration, we need just one QAPI object
>> to configure it.
>>=20
>> We could create the object with -object / object_add.  For convenience,
>> we'd probably want to create one with default configuration
>> automatically on demand.
>>=20
>> We could use qom-set to change configuration.  If we're not comfortable
>> with using qom-set for production, we could do something like
>> blockdev-reopen instead.
>
> Do we even need to do this via a QAPI object ?
>
> Why are we not just making the obvious design change of passing everything
> with the 'migrate' / 'migrate-incoming' commands that kick it off:
>
> ie:
>
> { 'command': 'migrate',
>   'data': {'uri': 'str',
>            '*channels': [ 'MigrationChannel' ],
> 	   '*capabilities': [ 'MigrateCapability' ],
> 	   '*parameters': [ 'MigrateParameters' ],
>            '*detach': 'bool', '*resume': 'bool' } }

Once that we are doing incompatible changes:
- resume can be another parameter
- detach is not needed.  QMP don't use it, and HMP don't need to pass it
  to qmp_migrate() to make the non-detached implemntation.


>      (deprecated bits trimmed for clarity)
>
> and the counterpart:
>
> { 'command': 'migrate-incoming',
>              'data': {'*uri': 'str',
>                       '*channels': [ 'MigrationChannel' ],
>                       '*capabilities': [ 'MigrateCapability' ],
>                       '*parameters': [ 'MigrateParameters' ] } }
>
> such that the design is just like 99% of other commands which take
> all their parameters directly. We already have 'migrate-set-parameters'
> remaining for the runtime tunables, and can deprecate the usage of this
> when migration is not already running, and similarly deprecate
> migrate-set-capabilities.

This makes sense to me, but once that we change, we could try to merge
capabilities and parameters.  See my other email on this topic.
Basically the distition is arbitrary, so just have one of them.

Or better, as I said in the other email, we have two types of
parameters:
- the ones that need to be set before migration starts
- the ones that can be changed at any time

So to be simpler, I think that 1st set should be passed to the commands
themselves and the others should only be set with
migrate_set_parameters.

Later, Juan.


