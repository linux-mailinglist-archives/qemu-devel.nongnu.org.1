Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7B766651
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:06:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIEY-0004U7-G0; Fri, 28 Jul 2023 03:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qPIEA-0004Qa-PY
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qPIE1-00055A-Eu
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690530562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkGe1fEbcEoaFdKxAxSgQUkHfHZjliGd4qXwt1R/P8s=;
 b=GosLxjgzjig0eYHNLIDGYRqgMybGaed7B0fBqaVf9vimHCzE0dOpsacKw9GjfuZsQcMVXr
 xwaOfFs05fC5nfhxfN1Pmn0bRv7GQkp6go0VT0qNID/rCfgyr4+SrNISRVHB/czKTGLr+J
 h42Xf+xqL5mw3j0W23tdLdP4kj5HJZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-8uvd82nWNQyXXs6IDghq0Q-1; Fri, 28 Jul 2023 03:49:18 -0400
X-MC-Unique: 8uvd82nWNQyXXs6IDghq0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BE6D1008142;
 Fri, 28 Jul 2023 07:49:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EA7D2166B25;
 Fri, 28 Jul 2023 07:49:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE37721E6690; Fri, 28 Jul 2023 09:49:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~hyman <yong.huang@smartx.com>,  Juan Quintela
 <quintela@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH QEMU 1/2] qapi: Reformat and craft the migration doc
 comments
References: <169040075240.21656.5651891935411754498-1@git.sr.ht>
Date: Fri, 28 Jul 2023 09:49:16 +0200
In-Reply-To: <169040075240.21656.5651891935411754498-1@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 27 Jul 2023 01:27:50 +0800")
Message-ID: <87y1j0lblv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
> Reformat migration doc comments to conform to current conventions
> as commit a937b6aa739 (qapi: Reformat doc comments to conform to
> current conventions).
>
> Also, craft the dirty-limit capability comment.

Split into two patches?

> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> ---
>  qapi/migration.json | 66 +++++++++++++++++++++------------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6b49593d2f..5d5649c885 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -258,17 +258,17 @@
>  #     blocked.  Present and non-empty when migration is blocked.
>  #     (since 6.0)
>  #
> -# @dirty-limit-throttle-time-per-round: Maximum throttle time (in micros=
econds) of virtual
> -#                                       CPUs each dirty ring full round,=
 which shows how
> -#                                       MigrationCapability dirty-limit =
affects the guest
> -#                                       during live migration. (since 8.=
1)
> -#
> -# @dirty-limit-ring-full-time: Estimated average dirty ring full time (i=
n microseconds)
> -#                              each dirty ring full round, note that the=
 value equals
> -#                              dirty ring memory size divided by average=
 dirty page rate
> -#                              of virtual CPU, which can be used to obse=
rve the average
> -#                              memory load of virtual CPU indirectly. No=
te that zero
> -#                              means guest doesn't dirty memory (since 8=
.1)
> +# @dirty-limit-throttle-time-per-round: Maximum throttle time
> +#     (in microseconds) of virtual CPUs each dirty ring full round,
> +#     which shows how MigrationCapability dirty-limit affects the

Perhaps "for each ... round"?

Remind me, what's a "dirty ring full round"?

> +#     guest during live migration.  (Since 8.1)
> +#
> +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> +#     time (in microseconds) each dirty ring full round. The value

Likewise.

> +#     equals dirty ring memory size divided by average dirty page

"the dirty ring memory size divided by the average ..."

> +#     rate of the virtual CPU, which can be used to observe the
> +#     average memory load of the virtual CPU indirectly. Note that
> +#     zero means guest doesn't dirty memory.  (Since 8.1)

Two spaces between sentences for consistency.

>  #
>  # Since: 0.14
>  ##
> @@ -519,15 +519,11 @@
>  #     are present.  'return-path' capability must be enabled to use
>  #     it.  (since 8.1)
>  #
> -# @dirty-limit: If enabled, migration will use the dirty-limit algo to
> -#               throttle down guest instead of auto-converge algo.
> -#               Throttle algo only works when vCPU's dirtyrate greater
> -#               than 'vcpu-dirty-limit', read processes in guest os
> -#               aren't penalized any more, so this algo can improve
> -#               performance of vCPU during live migration. This is an
> -#               optional performance feature and should not affect the
> -#               correctness of the existing auto-converge algo.
> -#               (since 8.1)
> +# @dirty-limit: If enabled, migration will throttle vCPUs as needed to
> +#     keep their dirty page rate within @vcpu-dirty-limit.  This can
> +#     improve responsiveness of large guests during live migration,
> +#     and can result in more stable read performance.  Requires KVM
> +#     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>  #
>  # Features:
>  #
> @@ -822,17 +818,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during  live migration. Should be in the range 1 to 1000ms,

Single space in "during live", and two space between sentences, please.

> +#     defaults to 1000ms.  (Since 8.1)

I dislike that we mix milli- and microseconds.  Too late to fix, I'm
afraid.

Remind me, what't the "periodic time of dirty limit during live
migration"?

>  #
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> -#                    Defaults to 1. (Since 8.1)
> +#     Defaults to 1.  (Since 8.1)
>  #
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> -#            are experimental.
> +#     are experimental.
>  #
>  # Since: 2.4
>  ##
> @@ -988,17 +984,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms,

Two spaces between sentences.

> +#     defaults to 1000ms.  (Since 8.1)
>  #
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> -#                    Defaults to 1. (Since 8.1)
> +#     Defaults to 1.  (Since 8.1)
>  #
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> -#            are experimental.
> +#     are experimental.
>  #
>  # TODO: either fuse back into MigrationParameters, or make
>  #     MigrationParameters members mandatory
> @@ -1191,17 +1187,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms,

Two spaces between sentences.

> +#     defaults to 1000ms.  (Since 8.1)
>  #
>  # @vcpu-dirty-limit: Dirtyrate limit (MB/s) during live migration.
> -#                    Defaults to 1. (Since 8.1)
> +#     Defaults to 1.  (Since 8.1)
>  #
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
> -#            are experimental.
> +#     are experimental.
>  #
>  # Since: 2.4
>  ##


