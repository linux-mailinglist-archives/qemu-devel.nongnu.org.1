Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A47CC534
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskV8-0001c9-M1; Tue, 17 Oct 2023 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qskV7-0001bj-8U
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qskV5-0006Ro-Ms
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697550767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrWWPJigrYKbXfIM47tE4uMbN4SHYEXy9rDbo2vCu0M=;
 b=Ai1hoxLn4fRnxXJVeWBjunpSorCbVQF1aryLZV7Q2AI87xnbTEDjXITYV3Kn4kE3DGGFvD
 GYAUU6D0uGCyUCaiujhCWDHxj5Nc4LVhckPxUF64onRJXpVXw00ZwgYUtkv4Jq9pM/04ZB
 aRGrqfByRZoZCYq6jQO9r0MtDQ1r9RY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-z5qLax47POqkk7NKBknMGQ-1; Tue, 17 Oct 2023 09:52:37 -0400
X-MC-Unique: z5qLax47POqkk7NKBknMGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A5A88F15C5;
 Tue, 17 Oct 2023 13:52:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5272027045;
 Tue, 17 Oct 2023 13:52:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0171521E6A1F; Tue, 17 Oct 2023 15:52:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 2/7] migration: migrate 'inc' command option is
 deprecated.
References: <20231017115238.18309-1-quintela@redhat.com>
 <20231017115238.18309-3-quintela@redhat.com>
Date: Tue, 17 Oct 2023 15:52:18 +0200
In-Reply-To: <20231017115238.18309-3-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 17 Oct 2023 13:52:33 +0200")
Message-ID: <87zg0h5pbh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Use blockdev-mirror with NBD instead.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
>
> Improve documentation and style (thanks Markus)
> ---
>  docs/about/deprecated.rst      | 8 ++++++++
>  qapi/migration.json            | 8 +++++++-
>  migration/migration-hmp-cmds.c | 5 +++++
>  migration/migration.c          | 5 +++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2febd2d12f..fc6adf1dea 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -461,3 +461,11 @@ Migration
>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>  been used for more than 10 years.
>  
> +``inc`` migrate command option (since 8.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use blockdev-mirror with NBD instead.
> +
> +As an intermediate step the ``inc`` functionality can be achieved by
> +setting the ``block-incremental`` migration parameter to ``true``.
> +But this parameter is also deprecated.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index db3df12d6c..fa7f4f2575 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1524,6 +1524,11 @@
>  #
>  # @resume: resume one paused migration, default "off". (since 3.0)
>  #
> +# Features:
> +#
> +# @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
> +#     NBD instead.
> +#
>  # Returns: nothing on success
>  #
>  # Since: 0.14
> @@ -1545,7 +1550,8 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> +  'data': {'uri': 'str', '*blk': 'bool',
> +           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>             '*detach': 'bool', '*resume': 'bool' } }
>  
>  ##
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index a82597f18e..fee7079afa 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -745,6 +745,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
>  
> +    if (inc) {
> +        warn_report("option '-i' is deprecated.  Use 'blockdev-mirror + NBD'"
> +                    " instead.");

Convention: an error or warning message is a single phrase, with no
newline or trailing punctuation.  The simplest way to conform to it is
something like

           warn_report("option '-i' is deprecated;"
                       " use blockdev-mirror with NBD instead.");

> +    }
> +
>      qmp_migrate(uri, !!blk, blk, !!inc, inc,
>                  false, false, true, resume, &err);
>      if (hmp_handle_error(mon, err)) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 6ba5e145ac..b8b3ba58df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1603,6 +1603,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>  {
>      Error *local_err = NULL;
>  
> +    if (blk_inc) {
> +        warn_report("parameter 'inc' is deprecated.  Use blockdev-mirror with"
> +                    " NBD instead");

Likewise.

> +    }
> +
>      if (resume) {
>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>              error_setg(errp, "Cannot resume if there is no "

Other than that
Reviewed-by: Markus Armbruster <armbru@redhat.com>


