Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1717263E1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6urT-0002Pt-V2; Wed, 07 Jun 2023 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1q6urR-0002O6-Tt
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:14:09 -0400
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1q6urP-00053r-VR
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:14:09 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.25])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 0DBB82B12C;
 Wed,  7 Jun 2023 15:14:03 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 17:14:02 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003ffcb67e4-fdba-4121-8b03-9f6bb9fa6e9a,
 54EBAD7D0EB3B635C0D3A21D42FFDCE0366FD9B4) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Wed, 7 Jun 2023 16:50:59 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Mauro Matteo Cascella <mcascell@redhat.com>, yw s
 <ywsplz@gmail.com>, <shawtao1125@gmail.com>, <jkli@xidian.edu.cn>,
 <shenwenbo@zju.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v3] 9pfs: prevent opening special files (CVE-2023-2861)
Message-ID: <20230607164950.2f4f6f39@bahia>
In-Reply-To: <E1q6tfP-0008VX-K3@lizzy.crudebyte.com>
References: <E1q6tfP-0008VX-K3@lizzy.crudebyte.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 91d1f77a-975f-452f-bcc3-b693e86bfa7a
X-Ovh-Tracer-Id: 11437454207054223724
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdelledpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpmhgtrghstggvlhhlsehrvgguhhgrthdrtghomhdphiifshhplhiisehgmhgrihhlrdgtohhmpdhshhgrfihtrghoudduvdehsehgmhgrihhlrdgtohhmpdhjkhhlihesgihiughirghnrdgvughurdgtnhdpshhhvghnfigvnhgsohesiihjuhdrvgguuhdrtghnpdhmjhhtsehtlhhsrdhmshhkrdhruhdpoffvtefjohhsthepmhhohe
 ehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.45.220; envelope-from=groug@kaod.org;
 helo=5.mo552.mail-out.ovh.net
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

On Wed, 7 Jun 2023 15:50:01 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The 9p protocol does not specifically define how server shall behave when
> client tries to open a special file, however from security POV it does
> make sense for 9p server to prohibit opening any special file on host side
> in general. A sane Linux 9p client for instance would never attempt to
> open a special file on host side, it would always handle those exclusively
> on its guest side. A malicious client however could potentially escape
> from the exported 9p tree by creating and opening a device file on host
> side.
> 
> With QEMU this could only be exploited in the following unsafe setups:
> 
>   - Running QEMU binary as root AND 9p 'local' fs driver AND 'passthrough'
>     security model.
> 
> or
> 
>   - Using 9p 'proxy' fs driver (which is running its helper daemon as
>     root).
> 
> These setups were already discouraged for safety reasons before,
> however for obvious reasons we are now tightening behaviour on this.
> 
> Fixes: CVE-2023-2861
> Reported-by: Yanwu Shen <ywsPlz@gmail.com>
> Reported-by: Jietao Xiao <shawtao1125@gmail.com>
> Reported-by: Jinku Li <jkli@xidian.edu.cn>
> Reported-by: Wenbo Shen <shenwenbo@zju.edu.cn>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  v2 -> v3:
>  - Drop O_CREAT check and its comment.
>  - Eliminate code duplication.
> 
>  fsdev/virtfs-proxy-helper.c | 26 ++++++++++++++++++++++++--
>  hw/9pfs/9p-util.h           | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 5cafcd7703..256d7bfcec 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -26,6 +26,7 @@
>  #include "qemu/xattr.h"
>  #include "9p-iov-marshal.h"
>  #include "hw/9pfs/9p-proxy.h"
> +#include "hw/9pfs/9p-util.h"
>  #include "fsdev/9p-iov-marshal.h"
>  
>  #define PROGNAME "virtfs-proxy-helper"
> @@ -338,6 +339,27 @@ static void resetugid(int suid, int sgid)
>      }
>  }
>  
> +/*
> + * Open regular file or directory. Attempts to open any special file are
> + * rejected.
> + *
> + * returns file descriptor or -1 on error
> + */
> +static int open_regular(const char *pathname, int flags, mode_t mode) {
> +    int fd;
> +
> +    fd = open(pathname, flags, mode);
> +    if (fd < 0) {
> +        return fd;
> +    }
> +
> +    if (check_is_regular_file_or_dir(fd) < 0) {
> +        return -1;
> +    }
> +
> +    return fd;
> +}
> +
>  /*
>   * send response in two parts
>   * 1) ProxyHeader
> @@ -682,7 +704,7 @@ static int do_create(struct iovec *iovec)
>      if (ret < 0) {
>          goto unmarshal_err_out;
>      }
> -    ret = open(path.data, flags, mode);
> +    ret = open_regular(path.data, flags, mode);
>      if (ret < 0) {
>          ret = -errno;
>      }
> @@ -707,7 +729,7 @@ static int do_open(struct iovec *iovec)
>      if (ret < 0) {
>          goto err_out;
>      }
> -    ret = open(path.data, flags);
> +    ret = open_regular(path.data, flags, 0);
>      if (ret < 0) {
>          ret = -errno;
>      }
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index c314cf381d..9b0a9e5878 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -13,6 +13,8 @@
>  #ifndef QEMU_9P_UTIL_H
>  #define QEMU_9P_UTIL_H
>  
> +#include "qemu/error-report.h"
> +
>  #ifdef O_PATH
>  #define O_PATH_9P_UTIL O_PATH
>  #else
> @@ -95,6 +97,7 @@ static inline int errno_to_dotl(int err) {
>  #endif
>  
>  #define qemu_openat     openat
> +#define qemu_fstat      fstat
>  #define qemu_fstatat    fstatat
>  #define qemu_mkdirat    mkdirat
>  #define qemu_renameat   renameat
> @@ -108,6 +111,32 @@ static inline void close_preserve_errno(int fd)
>      errno = serrno;
>  }
>  
> +/* CVE-2023-2861: Prohibit opening any special file directly on host
> + * (especially device files), as a compromised client could potentially gain
> + * access outside exported tree under certain, unsafe setups. We expect
> + * client to handle I/O on special files exclusively on guest side.
> + */
> +static inline int check_is_regular_file_or_dir(int fd)
> +{
> +    struct stat stbuf;
> +
> +    if (qemu_fstat(fd, &stbuf) < 0) {
> +        close_preserve_errno(fd);

Maybe worth to mention somewhere that this function not only
checks but also closes the fd if it doesn't point to a regular
file or directory. Or maybe change the name, e.g.
filter_out_special_files() ?

Anyway the fix is fine enough to address the CVE.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +        return -1;
> +    }
> +    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
> +        error_report_once(
> +            "9p: broken or compromised client detected; attempt to open "
> +            "special file (i.e. neither regular file, nor directory)"
> +        );
> +        close(fd);
> +        errno = ENXIO;
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static inline int openat_dir(int dirfd, const char *name)
>  {
>      return qemu_openat(dirfd, name,
> @@ -142,6 +171,10 @@ again:
>          return -1;
>      }
>  
> +    if (check_is_regular_file_or_dir(fd) < 0) {
> +        return -1;
> +    }
> +
>      serrno = errno;
>      /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
>       * do that with O_PATH since fcntl(F_SETFL) isn't supported, and openat()



-- 
Greg

