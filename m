Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53957C8666
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHv5-0005xG-Dg; Fri, 13 Oct 2023 09:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHv1-0005wt-GJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHuz-0005RU-RX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697202569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2kAckS0DCgZ880RJqz2AyWHC0btK2z156WqsdzeVRzI=;
 b=JBbN7IdaUC88R/qkdxtgZiA6rcKaff4G3NH6kTcV5zjfePeqSmFKy9g91yTc0ar1nbDkPi
 VGZlCIaIyUOTxlvjZpUmoay33HSFG2Gz1e1dAuhA/24TYAGm/zy78l0dFt6DeKygC1oyK0
 NzvBxtp5uOgd1xbHz7nv4IL3OanalZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-54RxBKBaMPizHEXOj1eudQ-1; Fri, 13 Oct 2023 09:09:25 -0400
X-MC-Unique: 54RxBKBaMPizHEXOj1eudQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01481023112;
 Fri, 13 Oct 2023 13:09:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA8840C6F79;
 Fri, 13 Oct 2023 13:09:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 698E221E6A21; Fri, 13 Oct 2023 15:09:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
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
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-4-quintela@redhat.com>
Date: Fri, 13 Oct 2023 15:09:23 +0200
In-Reply-To: <20231013104736.31722-4-quintela@redhat.com> (Juan Quintela's
 message of "Fri, 13 Oct 2023 12:47:29 +0200")
Message-ID: <8734yehdoc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Juan Quintela <quintela@redhat.com> writes:

> Set the 'block_incremental' migration parameter to 'true' instead.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> ---
>
> Improve documentation and style (thanks Markus)
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  qapi/migration.json       | 8 +++++++-
>  migration/migration.c     | 6 ++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1c4d7f36f0..1b6b2870cf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -452,3 +452,10 @@ Migration
>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>  been used for more than 10 years.
>  
> +``inc`` migrate command option (since 8.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The new way to modify migration is using migration parameters.
> +``inc`` functionality can be achieved by setting the
> +``block-incremental`` migration parameter to ``true``.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6865fea3c5..56bbd55b87 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1492,6 +1492,11 @@
>  #
>  # @resume: resume one paused migration, default "off". (since 3.0)
>  #
> +# Features:
> +#
> +# @deprecated: Member @inc is deprecated.  Use migration parameter
> +#     @block-incremental instead.

This is fine now.  It becomes bad advice in PATCH 05, which deprecates
@block-incremental.  Two solutions:

1. Change this patch to point to an alternative that will *not* be
deprecated.

2. Change PATCH 05.

Same end result.

> +#
>  # Returns: nothing on success
>  #
>  # Since: 0.14
> @@ -1513,7 +1518,8 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
> +  'data': {'uri': 'str', '*blk': 'bool',
> +           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>             '*detach': 'bool', '*resume': 'bool' } }
>  
>  ##
> diff --git a/migration/migration.c b/migration/migration.c
> index 1c6c81ad49..ac4897fe0d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1601,6 +1601,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>  {
>      Error *local_err = NULL;
>  
> +    if (blk_inc) {
> +        warn_report("@inc/-i migrate option is deprecated, set the"

This is either about QMP migrate's parameter "inc", or HMP migrate's
flags -i.

In the former case, we want something like "parameter 'inc' is
deprecated".

In the latter case, we want something like "-i is deprecated".

Trying to do both in a single message results in a sub-par message.  If
you want to do better, you have to check in hmp_migrate(), too.  Then
hmp_migrate can refer to "-i", and migrate_prepare() to "parameter
'inc'".  Up to you.

If you decide a single message is good enough, use something like
"parameter 'inc' / flag -i is deprecated".

> +                    "'block-incremental' migration parameter to 'true'"
> +                    " instead.");

Again, fine now, becomes bad advice in PATCH 05.

> +    }
> +
>      if (resume) {
>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>              error_setg(errp, "Cannot resume if there is no "


