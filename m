Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3C7CC758
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsltU-00038U-1w; Tue, 17 Oct 2023 11:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsltN-00034I-TG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsltE-0005rr-8D
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697556106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QHu8bFs/GLLR0WvLRbINArQc9PcH+OxEA0WdmVjJqAg=;
 b=D67Vnn3i7dGdRm4WgjcTqnJkO4/2sgbs0rb4KhsI4wn+AfvEL3rvE/9X5Nt45Nvf/ym1av
 8DLSQC8JOVK0gA0HwPUGP0cvn/xIWYIrc6AjHvXB3gdHI/SViSv6/7njnOrE9cI7bVIBtx
 7oz1EZhSfFdvenAPEVrq71pA/tF5Gfk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-4meVCfeYNOWOk3wOCahYMA-1; Tue, 17 Oct 2023 11:21:44 -0400
X-MC-Unique: 4meVCfeYNOWOk3wOCahYMA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4077e9112b4so18447705e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697556104; x=1698160904;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHu8bFs/GLLR0WvLRbINArQc9PcH+OxEA0WdmVjJqAg=;
 b=vHX71V/fBrOgA/UFsARZBK7O1MLivPATwoZ9XCXjescO6YzGJztINxXsUYy6r8rBgI
 oaWzGqKUB1Oe9D+xa99AGbXLJZMpAmgjbH8YOR2973jTo+Kjnepjmi/f0d57+xTAKcgK
 aazIGQLPKgtctRwjkek6OKNqbXfEzUHgoOUywZGLizHxLMfAApAY+laFAztlSQrcVNd/
 01XhQMv2A3U7ilxrsCZJxZtiojJCTVXBWGFiVvSsFTQu6iQEUlVTwqstK6lKS+4gjqhX
 2eKW30+p4uffnDNduDypKcmyRDL+iX6gI2PzTZrvXcj8TO86dhQAcr+n1lkqnO1K7OSm
 bsQw==
X-Gm-Message-State: AOJu0YwWtGtpvcoOo2AXT4yTAOqAJAsnVR0pH9t6uCRhQ2rMUskENe2j
 1LkyEVa5Pi0eLlWB5urcyjmMsqSiPIkgIqS+JMIWGQts8Adp0Kzs7ZwSrqSMw4T1+XByr0WmN2t
 J4SU8BsKYpB3jkOo=
X-Received: by 2002:a05:600c:6d6:b0:3fe:d630:f568 with SMTP id
 b22-20020a05600c06d600b003fed630f568mr1863437wmn.39.1697556103822; 
 Tue, 17 Oct 2023 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpUBnEI9eBE3F3MNBXqCK32YpX16QX4LheQjLR1HUV22hKqoTBkyMq6ka6ZOiKA9HczeGC3A==
X-Received: by 2002:a05:600c:6d6:b0:3fe:d630:f568 with SMTP id
 b22-20020a05600c06d600b003fed630f568mr1863416wmn.39.1697556103427; 
 Tue, 17 Oct 2023 08:21:43 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f12-20020a05600c4e8c00b0040772934b12sm10328128wmq.7.2023.10.17.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:21:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 2/7] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <87zg0h5pbh.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 17 Oct 2023 15:52:18 +0200")
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-3-quintela@redhat.com>
 <87zg0h5pbh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 17:21:42 +0200
Message-ID: <87lec1z33t.fsf@secure.mitica>
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
>> Use blockdev-mirror with NBD instead.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> ---
>>
>> Improve documentation and style (thanks Markus)
>> ---
>>  docs/about/deprecated.rst      | 8 ++++++++
>>  qapi/migration.json            | 8 +++++++-
>>  migration/migration-hmp-cmds.c | 5 +++++
>>  migration/migration.c          | 5 +++++
>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 2febd2d12f..fc6adf1dea 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -461,3 +461,11 @@ Migration
>>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>>  been used for more than 10 years.
>>  
>> +``inc`` migrate command option (since 8.2)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +Use blockdev-mirror with NBD instead.
>> +
>> +As an intermediate step the ``inc`` functionality can be achieved by
>> +setting the ``block-incremental`` migration parameter to ``true``.
>> +But this parameter is also deprecated.
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index db3df12d6c..fa7f4f2575 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1524,6 +1524,11 @@
>>  #
>>  # @resume: resume one paused migration, default "off". (since 3.0)
>>  #
>> +# Features:
>> +#
>> +# @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
>> +#     NBD instead.
>> +#
>>  # Returns: nothing on success
>>  #
>>  # Since: 0.14
>> @@ -1545,7 +1550,8 @@
>>  # <- { "return": {} }
>>  ##
>>  { 'command': 'migrate',
>> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
>> +  'data': {'uri': 'str', '*blk': 'bool',
>> +           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>>             '*detach': 'bool', '*resume': 'bool' } }
>>  
>>  ##
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index a82597f18e..fee7079afa 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -745,6 +745,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>      const char *uri = qdict_get_str(qdict, "uri");
>>      Error *err = NULL;
>>  
>> +    if (inc) {
>> +        warn_report("option '-i' is deprecated.  Use 'blockdev-mirror + NBD'"
>> +                    " instead.");
>
> Convention: an error or warning message is a single phrase, with no
> newline or trailing punctuation.  The simplest way to conform to it is
> something like
>
>            warn_report("option '-i' is deprecated;"
>                        " use blockdev-mirror with NBD instead.");

then the trailing dot is not needed, right?

>> +    }
>> +
>>      qmp_migrate(uri, !!blk, blk, !!inc, inc,
>>                  false, false, true, resume, &err);
>>      if (hmp_handle_error(mon, err)) {
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 6ba5e145ac..b8b3ba58df 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1603,6 +1603,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>  {
>>      Error *local_err = NULL;
>>  
>> +    if (blk_inc) {
>> +        warn_report("parameter 'inc' is deprecated.  Use blockdev-mirror with"
>> +                    " NBD instead");
>
> Likewise.
>
>> +    }
>> +
>>      if (resume) {
>>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>>              error_setg(errp, "Cannot resume if there is no "
>
> Other than that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

OK, fixing it.


