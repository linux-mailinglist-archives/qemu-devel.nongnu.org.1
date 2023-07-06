Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48688749FAB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:49:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQHD-0007EU-Ek; Thu, 06 Jul 2023 10:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQH8-000798-3N
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qHQH6-0000W4-1G
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688654882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBd7QhwVF87UnyoCwN4BvGtkWPpexkW5vgQ0WVX6y1U=;
 b=Ore6Cw8OFYy8PDxCgYyCsUNU0DvSRHMtcLfy5TovSODTRTxGDNJ7lMRMisEK8qO4vpsbNw
 3F/qkDiO0qLHdrNu8KFeSvSlx7aJyDlzFdIkyyZUVaUWsJUWyqF6o00MNtBO7w3lUCjxEq
 NM/KjoywIN4LAhbPFLCrpVw+AXIZ4NA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-XN0fKsywMbW1FKj2DyNygw-1; Thu, 06 Jul 2023 10:47:59 -0400
X-MC-Unique: XN0fKsywMbW1FKj2DyNygw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8796D185A793;
 Thu,  6 Jul 2023 14:47:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65D034CD0CA;
 Thu,  6 Jul 2023 14:47:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E74921E6A1F; Thu,  6 Jul 2023 16:47:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Juan
 Quintela <quintela@redhat.com>,  "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v7 3/9] qapi/migration: Introduce vcpu-dirty-limit
 parameters
References: <168853615963.17240.15832775267134683267-3@git.sr.ht>
Date: Thu, 06 Jul 2023 16:47:57 +0200
In-Reply-To: <168853615963.17240.15832775267134683267-3@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 22:58:32 +0800")
Message-ID: <87h6qhp04i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

~hyman <hyman@git.sr.ht> writes:

> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Introduce "vcpu-dirty-limit" migration parameter used
> to limit dirty page rate during live migration.
>
> "vcpu-dirty-limit" and "x-vcpu-dirty-limit-period" are
> two dirty-limit-related migration parameters, which can
> be set before and during live migration by qmp
> migrate-set-parameters.
>
> This two parameters are used to help implement the dirty
> page rate limit algo of migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 384b768e03..aa590dbf0e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -793,6 +793,9 @@
>  #                             live migration. Should be in the range 1 t=
o 1000ms,
>  #                             defaults to 1000ms. (Since 8.1)
>  #
> +# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> +#                    Defaults to 1. (Since 8.1)
> +#

"Dirty rate" with a space, because that's how we spell it elsewhere.

Please format like

   # @vcpu-dirty-limit: Dirty rate limit (MB/s) during live migration.
   #     Defaults to 1. (Since 8.1)
   #

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -816,7 +819,8 @@
>             'max-cpu-throttle', 'multifd-compression',
>             'multifd-zlib-level', 'multifd-zstd-level',
>             'block-bitmap-mapping',
> -           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable=
'] } ] }
> +           { 'name': 'x-vcpu-dirty-limit-period', 'features': ['unstable=
'] },
> +           'vcpu-dirty-limit'] }
>=20=20
>  ##
>  # @MigrateSetParameters:
> @@ -955,6 +959,9 @@
>  #                             live migration. Should be in the range 1 t=
o 1000ms,
>  #                             defaults to 1000ms. (Since 8.1)
>  #
> +# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> +#                    Defaults to 1. (Since 8.1)
> +#

Likewise.

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -995,7 +1002,8 @@
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> -                                            'features': [ 'unstable' ] }=
 } }
> +                                            'features': [ 'unstable' ] },
> +            '*vcpu-dirty-limit': 'uint64'} }
>=20=20
>  ##
>  # @migrate-set-parameters:
> @@ -1154,6 +1162,9 @@
>  #                             live migration. Should be in the range 1 t=
o 1000ms,
>  #                             defaults to 1000ms. (Since 8.1)
>  #
> +# @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> +#                    Defaults to 1. (Since 8.1)
> +#

Likewise.

>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> @@ -1191,7 +1202,8 @@
>              '*multifd-zstd-level': 'uint8',
>              '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
>              '*x-vcpu-dirty-limit-period': { 'type': 'uint64',
> -                                            'features': [ 'unstable' ] }=
 } }
> +                                            'features': [ 'unstable' ] },
> +            '*vcpu-dirty-limit': 'uint64'} }
>=20=20
>  ##
>  # @query-migrate-parameters:


