Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDF57CA009
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHar-0006Kj-DP; Mon, 16 Oct 2023 03:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHah-0006Jy-Qv
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHaf-0001hW-Gm
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697439636;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/ToLcYH49yh6QYQiqaGt92pVOmozS0WU2Ea1Gy4Et1w=;
 b=Ec5KFQHHU8GR/IK3dx0GhY3UZETkA/HbzzxCzBrlNgzhC84yxU7uuLFqp4vlTl6KAmspIy
 6SjR+FrFbC9C8UCm9t4c9EW1lGsyh44OPZ+27xut6sJRu+RDwLipyEXs1NIk/zrYBgP8zE
 0g+81LqbzAXxCPTljdXnOLvNbDTarQI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-VUE7nOYAO-WUkYD52FT9sA-1; Mon, 16 Oct 2023 03:00:35 -0400
X-MC-Unique: VUE7nOYAO-WUkYD52FT9sA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so27254535e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697439634; x=1698044434;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ToLcYH49yh6QYQiqaGt92pVOmozS0WU2Ea1Gy4Et1w=;
 b=molgC9vaHV86xGj3O9PnalpvubZnKP0lb8mvRHAJeD1eGfcww+J8niDSDK7F63QhuF
 g9tfWzH9qp12c3Z68GuwPPQNlst1cQmDVHZz5tbXhUdOr/+tsAMZjyYpE/DGhq/xqcRK
 OqPGUTMizvdqUcmufX6RklaB430AY5J1xMbRVzSPyzMqKj7ipq/h1w9OciuH867f5ISZ
 zs7hMGyBJKE+VXAyu4uM6YaLG20PezGqYbAeKxR8DkWSp3j8vKTXDDdvCuuPWMsS+0RA
 CxJTKAkSctUd4HADoEzyMK7sY5wR8BHtd2dEA+svE/wp7VJx0756SI6u+ohy9pwKTU/M
 FbiA==
X-Gm-Message-State: AOJu0YzB+LXX78sEmSWtgSh3aXwjxxy1lqNOkW1rptUkbW8c8RPPyymw
 66oh7Moi4fL2Yc2NTWkwsbpFwBpduIF54RToqo1DEfsnAEOyB4oXzMypfyo9oXuL7RMr7EIli5K
 SsR9tBJfqGZecezs=
X-Received: by 2002:a05:600c:3b20:b0:406:847a:2934 with SMTP id
 m32-20020a05600c3b2000b00406847a2934mr26741675wms.28.1697439633751; 
 Mon, 16 Oct 2023 00:00:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/l9Pg9fKbyo8jPkaROEMHc33N4kfTIF11WIoewB0RuoBNuKL1hzhTOPzQmLh5nDohGkVeLw==
X-Received: by 2002:a05:600c:3b20:b0:406:847a:2934 with SMTP id
 m32-20020a05600c3b2000b00406847a2934mr26741650wms.28.1697439633323; 
 Mon, 16 Oct 2023 00:00:33 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2d1400b003fe2b081661sm6322551wmf.30.2023.10.16.00.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:00:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/10] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <8734yehdoc.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 13 Oct 2023 15:09:23 +0200")
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-4-quintela@redhat.com>
 <8734yehdoc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:00:31 +0200
Message-ID: <87a5sj59ww.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Juan Quintela <quintela@redhat.com> writes:
>
>> Set the 'block_incremental' migration parameter to 'true' instead.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> ---
>>
>> Improve documentation and style (thanks Markus)
>> ---
>>  docs/about/deprecated.rst | 7 +++++++
>>  qapi/migration.json       | 8 +++++++-
>>  migration/migration.c     | 6 ++++++
>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 1c4d7f36f0..1b6b2870cf 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -452,3 +452,10 @@ Migration
>>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>>  been used for more than 10 years.
>>  
>> +``inc`` migrate command option (since 8.2)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The new way to modify migration is using migration parameters.
>> +``inc`` functionality can be achieved by setting the
>> +``block-incremental`` migration parameter to ``true``.
>> +
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 6865fea3c5..56bbd55b87 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1492,6 +1492,11 @@
>>  #
>>  # @resume: resume one paused migration, default "off". (since 3.0)
>>  #
>> +# Features:
>> +#
>> +# @deprecated: Member @inc is deprecated.  Use migration parameter
>> +#     @block-incremental instead.
>
> This is fine now.  It becomes bad advice in PATCH 05, which deprecates
> @block-incremental.  Two solutions:
>
> 1. Change this patch to point to an alternative that will *not* be
> deprecated.

Ok, clearly I am not explaining myself properly O:-)

History of block migration:
* In the beggining there was -b and -i migrate options
  There was the only way to do storage of migration.
* We moved to use parameters and capabilities for migration
  So we created @block-incremental and @block.
  But we didn't remove the command line options (for backward
  compatibility).
* We were asked to modify migration so some storaged was migrated and
  some was not migrated during migration.  But block people found that
  it was a good idea to allow storage migration without migrating the
  vm, so they created this blockdev-mirror mechanism that is shinny,
  funny, faster, <whatever> better.

So now we have old code that basically nobody uses (the last big user
was COLO, but now it can use multifd).  So we want to drop it, but we
don't care about a direct replacement.

So, why I am interested in removing this?
- @block and @block-incremental: If you don't use block migration, their
  existence don't bother you.  They are "quite" independent of the rest
  of the migration code (they could be better integrated, but not big
  trouble here).
- migrate options -i/-b: This ones hurt us each time that we need to
  do changing in options.  Notice that we have "perfect" replacements
  with @block and @block-incremental, exactly the same
  result/semantics/...
  You can see the trobles in the RFC patches

     * [PATCH v4 07/10] [RFC] migration: Make -i/-b an error for hmp and qmp
     * [PATCH v4 08/10] [RFC] migration: Remove helpers needed for -i/-b migrate options

So what I want, I want to remove -i/-b in the next version (9.0?).  For
the other, I want to remove it, but I don't care if the code is around
in "deprecated" state for another couple of years if there are still
people that feel that they want it.

This is the reason that I put a pointer for -i/-b to
@block/@block-incremental.  They are "perfect" replacements.

I can put here to use blockdev-mirror + NBD, but the replacement is not
so direct.

Does this make sense?


> 2. Change PATCH 05.
>
> Same end result.
>
>> +#
>>  # Returns: nothing on success
>>  #
>>  # Since: 0.14
>> @@ -1513,7 +1518,8 @@
>>  # <- { "return": {} }
>>  ##
>>  { 'command': 'migrate',
>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>> +  'data': {'uri': 'str', '*blk': 'bool',
>> +           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>             '*detach': 'bool', '*resume': 'bool' } }
>>  
>>  ##
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 1c6c81ad49..ac4897fe0d 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1601,6 +1601,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>  {
>>      Error *local_err = NULL;
>>  
>> +    if (blk_inc) {
>> +        warn_report("@inc/-i migrate option is deprecated, set the"
>
> This is either about QMP migrate's parameter "inc", or HMP migrate's
> flags -i.

Needs to be @inc.  I want about the "-i" command option in other place.

> In the former case, we want something like "parameter 'inc' is
> deprecated".

This one.

> In the latter case, we want something like "-i is deprecated".

Ok, changing.

> Trying to do both in a single message results in a sub-par message.  If
> you want to do better, you have to check in hmp_migrate(), too.  Then
> hmp_migrate can refer to "-i", and migrate_prepare() to "parameter
> 'inc'".  Up to you.

That was the intention, but I forgot to update this message.

> If you decide a single message is good enough, use something like
> "parameter 'inc' / flag -i is deprecated".

Later, Juan.


