Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4FE749DF6
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPBg-00005m-6a; Thu, 06 Jul 2023 09:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHPBe-00005M-CD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHPBc-0000Vh-1B
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688650698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Gw7JOFFDlGyVQl/PhY2gVqoAqQ/3SS1mgO/pbrQHf0=;
 b=UJH191w+Ba6JN6eZZnUB/1GEWeIQlO4Vtt0tPiQcWnN/CzvSMAVp3Fzlzk1Ve3AKpVClrD
 m/fB2MoLCqRukzgPxl8SgipW4hQfI+sAHz+FvEa0uXHCmvN3tJuaiu6rweFW6OfVxMnWkC
 s/YhAEJ2+hBDkHq8o9iVtEYletdfQLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-G09rrTnqOkmVa9dlwIFh8Q-1; Thu, 06 Jul 2023 09:38:15 -0400
X-MC-Unique: G09rrTnqOkmVa9dlwIFh8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C171858F1E;
 Thu,  6 Jul 2023 13:38:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E40A6492B02;
 Thu,  6 Jul 2023 13:38:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCD6221E6A1F; Thu,  6 Jul 2023 15:38:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 1/2] migration: switchover-hold parameter
References: <20230706124331.377939-1-peterx@redhat.com>
 <20230706124331.377939-2-peterx@redhat.com>
Date: Thu, 06 Jul 2023 15:38:13 +0200
In-Reply-To: <20230706124331.377939-2-peterx@redhat.com> (Peter Xu's message
 of "Thu, 6 Jul 2023 08:43:30 -0400")
Message-ID: <87v8exqhx6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> Add a new migration parameter switchover-hold which can block src qemu
> migration from switching over to dest from running.
>
> One can set this flag to true so src qemu will keep iterating the VM data,
> not switching over to dest even if it can.
>
> It means now live migration works somehow like COLO; we keep syncing data
> from src to dst without stopping.

Out of curiosity: does it share code with COLO?

> When the user is ready for the switchover, one can set the parameter from
> true->false.  That'll contain a implicit kick to migration thread to be
> alive and re-evaluate the switchover decision.
>
> This can be used in two cases so far in my mind:
>
>   (1) One can use this parameter to start pre-heating migration (but not
>       really migrating, so a migrate-cancel will cancel the preheat).  When
>       the user wants to really migrate, just clear the flag.  It'll in most
>       cases migrate immediately because most pages are already synced.
>
>   (2) Can also be used as a clean way to do qtest, in many of the precopy
>       tests we have requirement to run after 1 iteration without completing
>       the precopy migration.  Before that we have either set bandwidth to
>       ridiculous low value, or tricks on detecting guest memory change over
>       some adhoc guest memory position.  Now we can simply set this flag
>       then we know precopy won't complete and will just keep going.
>
> Here we leveraged a sem to make sure migration thread won't busy spin on a
> physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
> its best to sync with dest QEMU from time to time.  Note that the sem is
> prone to outdated counts but it's benign, please refer to the comment above
> the semaphore definition for more information.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json            | 25 ++++++++++--
>  migration/migration.h          | 17 +++++++++
>  migration/migration-hmp-cmds.c |  7 ++++
>  migration/migration.c          | 69 ++++++++++++++++++++++++++++++++--
>  migration/options.c            | 17 +++++++++
>  5 files changed, 128 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 47dfef0278..c050081555 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -789,6 +789,15 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU, even if we can finish migration in the

Spell out "source" and "destination", please.

Recommend to spell it out in the commit message, too.

> +#     downtime specified.  By default off, so precopy migration will
> +#     complete as soon as possible.  One can set it to explicitly keep
> +#     iterating during precopy migration until set the flag to false
> +#     again to kick off the final switchover.  Note, this does not

"until the flag is set to false again"

or

"until the flag is cleared".

> +#     affect postcopy switchover, because the user can control that
> +#     using "migrate-start-postcopy" command explicitly.  (Since 8.1)
> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -810,7 +819,7 @@
>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level' ,'multifd-zstd-level',
> -           'block-bitmap-mapping' ] }
> +           'block-bitmap-mapping', 'switchover-hold' ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -945,6 +954,10 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU.  For more details, please refer to
> +#     MigrationParameter entry of the same field.  (Since 8.1)

We normally duplicate the documentation.  This would be the first
instance where we reference instead.  Do we want that?

> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -982,7 +995,8 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1137,6 +1151,10 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> +# @switchover-hold: Whether we should hold-off precopy switchover from
> +#     src to dest QEMU.  For more details, please refer to
> +#     MigrationParameter entry of the same field.  (Since 8.1)

Likewise.

> +#
>  # Features:
>  #
>  # @unstable: Member @x-checkpoint-delay is experimental.
> @@ -1171,7 +1189,8 @@
>              '*multifd-compression': 'MultiFDCompression',
>              '*multifd-zlib-level': 'uint8',
>              '*multifd-zstd-level': 'uint8',
> -            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
> +            '*switchover-hold': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

[...]


