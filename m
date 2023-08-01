Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81876B4DC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQoaW-000061-3V; Tue, 01 Aug 2023 08:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qQoaT-0008Vu-Bd
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:34:53 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qQoaR-0003Kt-FG
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:34:53 -0400
Received: from blackfin.pond.sub.org (p50902994.dip0.t-ipconnect.de
 [80.144.41.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id CBCC525F9E;
 Tue,  1 Aug 2023 14:34:45 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A567721E692A; Tue,  1 Aug 2023 14:34:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: ~hyman <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH QEMU v3 1/3] qapi: Reformat the dirty-limit migration
 doc comments
References: <169073570563.19893.2928364761104733482-1@git.sr.ht>
Date: Tue, 01 Aug 2023 14:34:43 +0200
Message-ID: <87mszb0wm4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> Reformat the dirty-limit migration doc comments to conform
> to current conventions as commit a937b6aa739 (qapi: Reformat
> doc comments to conform to current conventions).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Unexpected S-o-b.  Accident?

> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> ---
>  qapi/migration.json | 69 ++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 35 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 6b49593d2f..a74ade4d72 100644
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
> +#     guest during live migration.  (Since 8.1)
> +#
> +# @dirty-limit-ring-full-time: Estimated average dirty ring full
> +#     time (in microseconds) for each dirty ring full round. The

Two spaces between sentences for consistency.

> +#     value equals the dirty ring memory size divided by the average
> +#     dirty page rate of the virtual CPU, which can be used to
> +#     observe the average memory load of the virtual CPU indirectly.
> +#     Note that zero means guest doesn't dirty memory.  (Since 8.1)
>  #
>  # Since: 0.14
>  ##
> @@ -519,15 +519,14 @@
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
> +# @dirty-limit: If enabled, migration will use the dirty-limit
> +#     algorithim to throttle down guest instead of auto-converge
> +#     algorithim. Throttle algorithim only works when vCPU's dirtyrate
> +#     greater than 'vcpu-dirty-limit', read processes in guest os
> +#     aren't penalized any more, so this algorithim can improve
> +#     performance of vCPU during live migration. This is an optional
> +#     performance feature and should not affect the correctness of the
> +#     existing auto-converge algorithim.  (Since 8.1)
>  #
>  # Features:
>  #
> @@ -822,17 +821,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms.
> +#     Defaults to 1000ms.  (Since 8.1)

Likewise.

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
> @@ -988,17 +987,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms.
> +#     Defaults to 1000ms.  (Since 8.1)

Likewise.

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
> @@ -1191,17 +1190,17 @@
>  #     Nodes are mapped to their block device name if there is one, and
>  #     to their node name otherwise.  (Since 5.2)
>  #
> -# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty l=
imit during
> -#                             live migration. Should be in the range 1 t=
o 1000ms,
> -#                             defaults to 1000ms. (Since 8.1)
> +# @x-vcpu-dirty-limit-period: Periodic time (in milliseconds) of dirty
> +#     limit during live migration. Should be in the range 1 to 1000ms.
> +#     Defaults to 1000ms.  (Since 8.1)

Likewise.

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

No need for another respin, I'm happy to tidy up spacing in my tree.

