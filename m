Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABE7C6B7C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtGk-0000pE-KN; Thu, 12 Oct 2023 06:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqtGj-0000ow-F5
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:50:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqtGg-0004i9-Oj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697107805;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=910cz+J/ckmxW2u/m3VL7v8jBlaNfiB4ydCKJF857Bs=;
 b=Cy/Uf6R/oT4MSnord9bUKGJso8lwLPXZbVM3j9MmQT6tmrNnBnnQYI6aR0fX7JjFuJufXd
 q7tItnYMnD0Dpyte86fdcXreB3Ec+01nIgM38D9gxJnaa5bSCP5x6ZqQf2QOxFSvyemS8A
 SSmK1GoLfXDgEWoruUt07CjsxgvIYzQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-j_s5ke1uOOGimt3R0Ilumw-1; Thu, 12 Oct 2023 06:50:03 -0400
X-MC-Unique: j_s5ke1uOOGimt3R0Ilumw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so3820575e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697107802; x=1697712602;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=910cz+J/ckmxW2u/m3VL7v8jBlaNfiB4ydCKJF857Bs=;
 b=qxinJpcIAZDsj/Fwl8763rXz785prDB7F4awEA2hBBHNz26Ymd9bRduc2CzGZCrr/1
 OU+LM+dfQX7jkGyj1mOIlqcD5WpM8o70LW0/H+DiumPq1K1/Jhe+IoNHRYdxz0fHckbD
 PgDVXL7dfJDGQxhumnXpPFgYs/VNSgl0F68ej26Ky1jDL760QlxrdZD63RJD9di0fe3x
 xjpICtF5JKL2pZ3K2EMhz9wMN+c86VW6CKx4aFNDJvWJF5nFlm9JXpMs8CpAU8T/suKI
 pjegsMg9NDA1hPYHAL+727dpcQGGvtGjDJMFAZ8vxkjny9GiJUkd0ZTreBa1s2AGx8TI
 +8WQ==
X-Gm-Message-State: AOJu0YxRriJ4YhJwxhV8Kce6CJ/8quHYLyx9sBHzmkSRKzuCKWm8Lsy3
 joSmK5yvn7CJ/mcr5urywyoKxWB6iH35QZrWrv1syLXjXzVyXMUeC4MNo22DngVpMYh+u8egAV1
 Pb7SziqcxTgmu8us=
X-Received: by 2002:a05:600c:358e:b0:407:3e94:bcca with SMTP id
 p14-20020a05600c358e00b004073e94bccamr13539075wmq.1.1697107802104; 
 Thu, 12 Oct 2023 03:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBz8KKBnAfxiABzby0TDwl3fUoMwWtRFQe73Otfpis0IsNU/nLytWj5h1V1wE3xP1aLfJeWw==
X-Received: by 2002:a05:600c:358e:b0:407:3e94:bcca with SMTP id
 p14-20020a05600c358e00b004073e94bccamr13539056wmq.1.1697107801776; 
 Thu, 12 Oct 2023 03:50:01 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c204400b00403b63e87f2sm19107003wmg.32.2023.10.12.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 03:50:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,  Eric Blake
 <eblake@redhat.com>,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 1/4] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <87zg0oyxpz.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 12 Oct 2023 11:52:08 +0200")
References: <20231011204711.9744-1-quintela@redhat.com>
 <20231011204711.9744-2-quintela@redhat.com>
 <87zg0oyxpz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 12 Oct 2023 12:50:00 +0200
Message-ID: <87il7c6ron.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>>  # @blk: do block migration (full disk copy)
>>  #
>> -# @inc: incremental disk copy migration
>> +# @inc: incremental disk copy migration.  This option is deprecated.
>> +#     Set the 'block-incremetantal' migration parameter to 'true'
>> +#     instead.
>
> 'block-incremental'

Done, thanks.

>>  #
>>  # @detach: this argument exists only for compatibility reasons and is
>>  #     ignored by QEMU
>>  #
>>  # @resume: resume one paused migration, default "off". (since 3.0)
>>  #
>> +# Features:
>> +#
>> +# @deprecated: option @inc should be enabled by setting the
>> +#     'block-incremental' migration parameter to 'true'.
>> +#
>
> You add deprecation notices, one to the member documentation, and one to
> the "Features:" section.  You should add just one, to the "Features:"
> section.  Suggest:
>
>    # @deprecated: Member @inc is deprecated.  Use migration parameter
>    # @block-incremental instead.

Done.

>>  # Returns: nothing on success
>>  #
>>  # Since: 0.14
>> @@ -1514,7 +1521,8 @@
>>  # <- { "return": {} }
>>  ##
>>  { 'command': 'migrate',
>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>> +  'data': {'uri': 'str', '*blk': 'bool',
>> +           '*inc': { 'type': 'bool', 'features': ['deprecated'] },
>
> For better or worse, we format like [ 'deprecated' ].

Done.

>>             '*detach': 'bool', '*resume': 'bool' } }
>>  
>>  ##
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 1c6c81ad49..c7e4c37b8a 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1601,6 +1601,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>  {
>>      Error *local_err = NULL;
>>  
>> +    if (blk_inc) {
>> +        warn_report("-inc migrate option is deprecated, set the "
>> +                    "'block-incremental' migration parameter to 'true'"
>> +                    " instead.");
>
> There is no "-inc migrate option".  You're refering to QMP command
> migrate's parameter @inc / HMP command migrate's flag -i.

Changed to:


s|-inc|@inc/-i|

>> +    }
>> +
>>      if (resume) {
>>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>>              error_setg(errp, "Cannot resume if there is no "
>
> As far as I can see, HMP command migrate still uses the deprecated
> interface:
>
>     qmp_migrate(uri, !!blk, blk, !!inc, inc,
>                 false, false, true, resume, &err);
>
> Its use should be replaced before we deprecate it.

We need to drop it.

Blockjobs are much more flexible.  We want to get rid of the whole
concept of block migration inside the migration protocol/machinery.

Block migration requires that one:

- migrate all devices, i.e. no way to select some shared some local.

- I think that incremental bit requires that you use qcow2 images, but I
  haven't even double checked them.

I just want to drop it in the near future, if 9.0 is too soon, for
10.0.

Later, Juan.


