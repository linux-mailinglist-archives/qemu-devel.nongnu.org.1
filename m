Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A61F7C866D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHxW-0007IZ-QM; Fri, 13 Oct 2023 09:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHxS-0007Hn-II
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrHxQ-0006FG-2P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697202718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09weQMBWm5vRY+b7HNJVLePtaMN+T8qg6AHAbVT8K4s=;
 b=CQDxJSYvOsSYYk5snFvluilTCQ8r8K4YZq8VXCkPThD+TKVTqO9Afg6JtYh+P6AzWfSmV+
 pdlmWktnBophsJHB3QXTOs2GeKZjh/TRn7nlWNbDUVk46jR1ng77BSC8YSSFjLlz01M4bO
 mWynz2boYl/noj4XgJbaaaq15OGa14Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-z7FsjNMoMLeGrcHD63KXbw-1; Fri, 13 Oct 2023 09:11:40 -0400
X-MC-Unique: z7FsjNMoMLeGrcHD63KXbw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F04D481DA8B;
 Fri, 13 Oct 2023 13:11:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCEBF1C060DF;
 Fri, 13 Oct 2023 13:11:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC69221E6A21; Fri, 13 Oct 2023 15:11:38 +0200 (CEST)
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
Subject: Re: [PATCH v4 04/10] migration: migrate 'blk' command option is
 deprecated.
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-5-quintela@redhat.com>
Date: Fri, 13 Oct 2023 15:11:38 +0200
In-Reply-To: <20231013104736.31722-5-quintela@redhat.com> (Juan Quintela's
 message of "Fri, 13 Oct 2023 12:47:30 +0200")
Message-ID: <87y1g6fz05.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Set the 'block' migration capability to 'true' instead.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> ---
>
> Improve documentation and style (markus)
> ---
>  docs/about/deprecated.rst | 7 +++++++
>  qapi/migration.json       | 6 ++++--
>  migration/migration.c     | 5 +++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 1b6b2870cf..e6928b96cf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -459,3 +459,10 @@ The new way to modify migration is using migration parameters.
>  ``inc`` functionality can be achieved by setting the
>  ``block-incremental`` migration parameter to ``true``.
>  
> +``blk`` migrate command option (since 8.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The new way to modify migration is using migration parameters.
> +``blk`` functionality can be achieved by setting the
> +``block`` migration capability to ``true``.
> +
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 56bbd55b87..64ebced761 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1495,7 +1495,8 @@
>  # Features:
>  #
>  # @deprecated: Member @inc is deprecated.  Use migration parameter
> -#     @block-incremental instead.
> +#     @block-incremental instead. Member @blk is deprecated. Set

Two spaces between sentences for consistency.

> +#     migration capability 'block' to 'true' instead.
>  #
>  # Returns: nothing on success
>  #
> @@ -1518,7 +1519,8 @@
>  # <- { "return": {} }
>  ##
>  { 'command': 'migrate',
> -  'data': {'uri': 'str', '*blk': 'bool',
> +  'data': {'uri': 'str',
> +           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
>             '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
>             '*detach': 'bool', '*resume': 'bool' } }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index ac4897fe0d..9e4ae6b772 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1607,6 +1607,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>                      " instead.");
>      }
>  
> +    if (blk) {
> +        warn_report("@blk/-i migrate option is deprecated, set the "
> +                    "'block' capability to 'true' instead.");
> +    }
> +
>      if (resume) {
>          if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
>              error_setg(errp, "Cannot resume if there is no "

My comments for PATCH 01 apply.


