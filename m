Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90247CC78D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsm6W-0000q2-1h; Tue, 17 Oct 2023 11:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsm6S-0000ZH-NR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsm6R-0000NB-0K
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697556925;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=yxQR2cWAR/sZvmErQHvpfeIY20fhuUtL4cmuQwhwiGA=;
 b=BD/4dSTHOXmwzK3oI2fQeAUhd/dF8n1VeVWsQs8f59rF6c1gDvxum+pW7tfAuso+mjjdsg
 zYT/44rT/xN7dEfRjxUVN6ZL1/NOYRQsl+BfhdB2HehtEGXjmUP3c9vmmB7YxijgjAFW7M
 6Gr9GfeYR6jawPio1btHxAWbUH0wofg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-RYOqHaH2MMqCAXK8xyjtNw-1; Tue, 17 Oct 2023 11:35:08 -0400
X-MC-Unique: RYOqHaH2MMqCAXK8xyjtNw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso3706829f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697556907; x=1698161707;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxQR2cWAR/sZvmErQHvpfeIY20fhuUtL4cmuQwhwiGA=;
 b=h3U4HsuXn5mgUzQ2MhCqSUZ72RPXi23wy0+fsljSqpcXr7qZ6I6R5exY1Jy4+Bm6hf
 cnt5/ttr2bGzjYbHfSAxcmWEO/VTHQ9PX0Nh1wyYOEU/qluMx2/0QZs1qCfwdd0WrC3Z
 M+3DTdSZm0mI/1xIVi++jWpMXtH3xKrysfH5rbTexV0zgoFjs94IZoBPG13e8BRdRWmK
 UuJ+zPDTYkritjzIyLi6M8tLAF4O5wg9hnyfb4MBHlFnPhofEHvy94hLlUMB/OeHS9on
 a/YIeIE9bDrMSA/IE6sUzxjQm7xUruhDneRgnkeYa2ZgxtXMv4XtH/7cnyc8g5Pq2eT0
 zNLg==
X-Gm-Message-State: AOJu0YxAxj7pVygR538Fu+lS/RVtxmFzQiF+kXaTGLUlb1q/lNvEORuc
 cHnTw2topWqdXxexXV/0JqkYLcLIS7YXc5ZBQv0e//KqhYHXQEBI+8CC/D5GG+8BXORRRlvoqoX
 gG6L6sRow6l6ydMg=
X-Received: by 2002:a5d:40c8:0:b0:329:6b35:d141 with SMTP id
 b8-20020a5d40c8000000b003296b35d141mr2083598wrq.44.1697556907009; 
 Tue, 17 Oct 2023 08:35:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw5+/AXOlJWGMi7bREJ9belBWFuGfyOzn+0jaNPkAsOW6AEfW7MBvCm55ZHn/novXseaO25Q==
X-Received: by 2002:a5d:40c8:0:b0:329:6b35:d141 with SMTP id
 b8-20020a5d40c8000000b003296b35d141mr2083581wrq.44.1697556906625; 
 Tue, 17 Oct 2023 08:35:06 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k6-20020adfe8c6000000b0030647449730sm19931wrn.74.2023.10.17.08.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:35:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 3/7] migration: migrate 'blk' command option is
 deprecated.
In-Reply-To: <87sf695p2o.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Oct 2023 15:57:35 +0200")
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-4-quintela@redhat.com>
 <87sf695p2o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 17:35:05 +0200
Message-ID: <87h6mpz2hi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> Use blocked-mirror with NBD instead.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> ---
>>
>> Improve documentation and style (markus)
>> ---
>>  docs/about/deprecated.rst      | 10 ++++++++++
>>  qapi/migration.json            |  6 ++++--
>>  migration/migration-hmp-cmds.c |  5 +++++
>>  migration/migration.c          |  5 +++++
>>  4 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index fc6adf1dea..0149f040b6 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -469,3 +469,13 @@ Use blockdev-mirror with NBD instead.
>>  As an intermediate step the ``inc`` functionality can be achieved by
>>  setting the ``block-incremental`` migration parameter to ``true``.
>>  But this parameter is also deprecated.
>> +
>> +``blk`` migrate command option (since 8.2)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Use blockdev-mirror with NBD instead.
>> +
>> +As an intermediate step the ``blk`` functionality can be achieved by
>> +setting the ``block`` migration capability to ``true``.
>> +But this capability is also deprecated.
>> +
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index fa7f4f2575..59a07b50f0 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1527,7 +1527,8 @@
>>  # Features:
>>  #
>>  # @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
>> -#     NBD instead.
>> +#     NBD instead.  Member @blk is deprecated.  Use blockdev-mirror
>> +#     with NBD instead.
>
> Better:
>
>    # @deprecated: Members @inc and @blk are deprecated.  Use
>    #     blockdev-mirror with NBD instead.

Fixed.

>>  #
>>  # Returns: nothing on success
>>  #
>> @@ -1550,7 +1551,8 @@
>>  # <- { "return": {} }
>>  ##
>>  { 'command': 'migrate',
>> -  'data': {'uri': 'str', '*blk': 'bool',
>> +  'data': {'uri': 'str',
>> +           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>             '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>             '*detach': 'bool', '*resume': 'bool' } }
>>  
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index fee7079afa..bfeb1a476a 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -750,6 +750,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>                      " instead.");
>>      }
>>  
>> +    if (blk) {
>> +        warn_report("option '-b' is deprecated.  Use 'blockdev-mirror + NBD'"
>> +                    " instead.");
>
>            warn_report("option '-b' is deprecated;"
>                        " use blockdev-mirror with NBD instead.");

Fixed (removed the trailing dot)

>> +    }
>> +
>>      qmp_migrate(uri, !!blk, blk, !!inc, inc,
>>                  false, false, true, resume, &err);
>>      if (hmp_handle_error(mon, err)) {
>> diff --git a/migration/migration.c b/migration/migration.c
>> index b8b3ba58df..4da7fcfe0f 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1608,6 +1608,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>                      " NBD instead");
>>      }
>>  
>> +    if (blk) {
>> +        warn_report("capability 'blk is deprecated.  Use blockdev-mirror with"
>> +                    " NBD instead");
>> +    }
>
> Capability?  Isn't this a parameter?
>
> "'blk" lacks a closing single quote.

You are right.  You need to set the 'blk capability for substitution,
but this is a parameter.  My fault.

> I figure we want
>
>            warn_report("parameter 'blk' is deprecated;"
>                        " use blockdev-mirror with NBD instead.");
>
>> +
>>      if (resume) {
>>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>>              error_setg(errp, "Cannot resume if there is no "
>
> Other than that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks,


