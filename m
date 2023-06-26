Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF073D87A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:29:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDgde-0001xq-25; Mon, 26 Jun 2023 03:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qDgda-0001xh-3D
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:27:50 -0400
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qDgdX-00056b-Ad
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:27:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.10])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 2F0912A5EA;
 Mon, 26 Jun 2023 07:27:37 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Jun
 2023 09:27:36 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0024af44f21-cb43-45ac-86ff-635e80a015eb,
 5C4EAD3502E8E3551B4A3CEBFDB3E85F9E4F3318) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Mon, 26 Jun 2023 09:27:35 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>
Subject: Re: [SPAM] [PATCH v4] 9pfs: deprecate 'proxy' backend
Message-ID: <20230626092735.2b27565e@bahia>
In-Reply-To: <E1qCgCZ-0001Yf-KB@lizzy.crudebyte.com>
References: <E1qCgCZ-0001Yf-KB@lizzy.crudebyte.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: cb9006d9-ef87-40c2-ad55-a78241fe5f5b
X-Ovh-Tracer-Id: 4461096907599616477
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehvddgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgfdufeeuieegveeiudejueeivefhueeivdekleekteekkeekgedvheehuedvhefgnecuffhomhgrihhnpehqvghmuhdrohhrghdpghhithhlrggsrdgtohhmpdhgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdgsvghrrhgrnhhgvgesrhgvughhrghtrdgtohhmpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=188.165.59.253; envelope-from=groug@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Fri, 23 Jun 2023 14:41:15 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> As recent CVE-2023-2861 once again showed, the 9p 'proxy' fs driver is in
> bad shape. Using the 'proxy' backend was already discouraged for safety
> reasons before and we recommended to use the 'local' backend (preferably
> in conjunction with its 'mapped' security model) instead, but now it is
> time to officially deprecate the 'proxy' backend.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  v3 -> v4:
>  - MAINTAINERS: also move virtfs-proxy-helper.rst to 'obsolete' section
>  - deprecated.rst: suggest virtiofsd as alternative.
>  - deprecated.rst: mention a considerable future reimplementation of
>    'proxy' using 'vhost'.
>  - QEMU runtime warning: merge deprecation warnings of '-virtfs proxy' and
>    '-fsdev proxy' into a single deprecation warning and mention virtiofsd
>    as alternative.
>  - virtfs-proxy-helper daemon: print runtime deprecation warning here as
>    well.
>  - commit log: mention 'mapped' security model.
> 
>  MAINTAINERS                        |  9 ++++++++-
>  docs/about/deprecated.rst          | 23 +++++++++++++++++++++++
>  docs/tools/virtfs-proxy-helper.rst |  3 +++
>  fsdev/qemu-fsdev.c                 |  8 ++++++++
>  fsdev/virtfs-proxy-helper.c        |  9 +++++++++
>  hw/9pfs/9p-proxy.c                 |  5 +++++
>  hw/9pfs/9p-proxy.h                 |  5 +++++
>  meson.build                        |  2 +-
>  qemu-options.hx                    |  6 +++++-
>  9 files changed, 67 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 436b3f0afe..3aa70b5c21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2118,13 +2118,20 @@ S: Odd Fixes
>  W: https://wiki.qemu.org/Documentation/9p
>  F: hw/9pfs/
>  X: hw/9pfs/xen-9p*
> +X: hw/9pfs/9p-proxy*
>  F: fsdev/
> -F: docs/tools/virtfs-proxy-helper.rst
> +X: fsdev/virtfs-proxy-helper.c
>  F: tests/qtest/virtio-9p-test.c
>  F: tests/qtest/libqos/virtio-9p*
>  T: git https://gitlab.com/gkurz/qemu.git 9p-next
>  T: git https://github.com/cschoenebeck/qemu.git 9p.next
>  
> +virtio-9p-proxy
> +F: hw/9pfs/9p-proxy*
> +F: fsdev/virtfs-proxy-helper.c
> +F: docs/tools/virtfs-proxy-helper.rst
> +S: Obsolete
> +
>  virtio-blk
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  L: qemu-block@nongnu.org
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 0743459862..4ce75722f3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -343,6 +343,29 @@ the addition of volatile memory support, it is now necessary to distinguish
>  between persistent and volatile memory backends.  As such, memdev is deprecated
>  in favor of persistent-memdev.
>  
> +``-fsdev proxy`` and ``-virtfs proxy`` (since 8.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The 9p ``proxy`` filesystem backend driver has been deprecated and will be
> +removed (along with its proxy helper daemon) in a future version of QEMU. Please
> +use ``-fsdev local`` or ``-virtfs local`` for using the 9p ``local`` filesystem
> +backend instead, or alternatively consider deploying virtiofsd instead.

Maybe drop the first "instead" to avoid repetition ?

> +
> +The 9p ``proxy`` backend was originally developed as an alternative to the 9p
> +``local`` backend. The idea was to enhance security by dispatching actual low
> +level filesystem operations from 9p server (QEMU process) over to a separate
> +process (the virtfs-proxy-helper binary). However this alternative never gained
> +momentum. The proxy backend is much slower than the local backend, hasn't seen
> +any development in years, and showed to be less secure, especially due to the
> +fact that its helper daemon must be run as root, whereas with the local backend
> +QEMU is typically run as unprivileged user and allows to tighten behaviour by
> +mapping permissions et al by using its 'mapped' security model option.
> +
> +Nowadays it would make sense to reimplement the ``proxy`` backend by using
> +QEMU's ``vhost`` feature, which would eliminate the high latency costs under
> +which the 9p ``proxy`` backend currently suffers. However as of to date nobody
> +has indicated plans for such kind of reimplemention unfortunately.
> +
>  
>  Block device options
>  ''''''''''''''''''''
> diff --git a/docs/tools/virtfs-proxy-helper.rst b/docs/tools/virtfs-proxy-helper.rst
> index 6cdeedf8e9..bd310ebb07 100644
> --- a/docs/tools/virtfs-proxy-helper.rst
> +++ b/docs/tools/virtfs-proxy-helper.rst
> @@ -9,6 +9,9 @@ Synopsis
>  Description
>  -----------
>  
> +NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> +removed, along with this daemon, in a future version of QEMU!
> +
>  Pass-through security model in QEMU 9p server needs root privilege to do
>  few file operations (like chown, chmod to any mode/uid:gid).  There are two
>  issues in pass-through security model:
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 3da64e9f72..9a50ee370b 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -133,6 +133,14 @@ int qemu_fsdev_add(QemuOpts *opts, Error **errp)
>      }
>  
>      if (fsdriver) {
> +        if (strncmp(fsdriver, "proxy", 5) == 0) {
> +            warn_report(
> +                "'-fsdev proxy' and '-virtfs proxy' are deprecated, use "
> +                "'local' instead of 'proxy, or consider deploying virtiofsd "
> +                "instead"

Ditto.

LGTM.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +            );
> +        }
> +
>          for (i = 0; i < ARRAY_SIZE(FsDrivers); i++) {
>              if (strcmp(FsDrivers[i].name, fsdriver) == 0) {
>                  break;
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index d9511f429c..144aaf585a 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -9,6 +9,11 @@
>   * the COPYING file in the top-level directory.
>   */
>  
> +/*
> + * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> + * removed in a future version of QEMU!
> + */
> +
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>  #include <sys/resource.h>
> @@ -1057,6 +1062,10 @@ int main(int argc, char **argv)
>      struct statfs st_fs;
>  #endif
>  
> +    fprintf(stderr, "NOTE: The 9p 'proxy' backend is deprecated (since "
> +                    "QEMU 8.1) and will be removed in a future version of "
> +                    "QEMU!\n");
> +
>      prog_name = g_path_get_basename(argv[0]);
>  
>      is_daemon = true;
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 99d115ff0d..905cae6992 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -15,6 +15,11 @@
>   * https://wiki.qemu.org/Documentation/9p
>   */
>  
> +/*
> + * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> + * removed in a future version of QEMU!
> + */
> +
>  #include "qemu/osdep.h"
>  #include <sys/socket.h>
>  #include <sys/un.h>
> diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
> index b84301d001..9be4718d3e 100644
> --- a/hw/9pfs/9p-proxy.h
> +++ b/hw/9pfs/9p-proxy.h
> @@ -10,6 +10,11 @@
>   * the COPYING file in the top-level directory.
>   */
>  
> +/*
> + * NOTE: The 9p 'proxy' backend is deprecated (since QEMU 8.1) and will be
> + * removed in a future version of QEMU!
> + */
> +
>  #ifndef QEMU_9P_PROXY_H
>  #define QEMU_9P_PROXY_H
>  
> diff --git a/meson.build b/meson.build
> index 34306a6205..05c01b72bb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4170,7 +4170,7 @@ if have_block
>    summary_info += {'Block whitelist (ro)': get_option('block_drv_ro_whitelist')}
>    summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
>    summary_info += {'VirtFS (9P) support':    have_virtfs}
> -  summary_info += {'VirtFS (9P) Proxy Helper support': have_virtfs_proxy_helper}
> +  summary_info += {'VirtFS (9P) Proxy Helper support (deprecated)': have_virtfs_proxy_helper}
>    summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
>    summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
>    summary_info += {'bochs support':     get_option('bochs').allowed()}
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b57489d7ca..3a6c7d3ef9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1735,7 +1735,9 @@ SRST
>          Accesses to the filesystem are done by QEMU.
>  
>      ``proxy``
> -        Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +        Accesses to the filesystem are done by virtfs-proxy-helper(1). This
> +        option is deprecated (since QEMU 8.1) and will be removed in a future
> +        version of QEMU. Use ``local`` instead.
>  
>      ``synth``
>          Synthetic filesystem, only used by QTests.
> @@ -1867,6 +1869,8 @@ SRST
>  
>      ``proxy``
>          Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +        This option is deprecated (since QEMU 8.1) and will be removed in a
> +        future version of QEMU. Use ``local`` instead.
>  
>      ``synth``
>          Synthetic filesystem, only used by QTests.

-- 
Greg

