Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD128725C9F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qwM-0001h2-NY; Wed, 07 Jun 2023 07:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1q6qvq-0001fU-7n
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:02:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1q6qvn-0003LO-GG
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=4PAJT098JBvy4iaRBItM2y/emNtLvqz+VXCbI5b3HOM=; b=XFQyrF6T6RxVvRoABcsjZhTJxw
 +OgnmReXprMDXw6Jk9MIVg+9SUeH9Ur1C7mHqMfaOPWGIkL78ss+kzcr1p/7jWWWLCVttqluZz5co
 xZJG8pEBjVySVFlf1av7eM9c9sfQqqYW/WuzyH0dH9Ad4Uxxl96+qyoKA+Y883A+G7OvI4Br8EsVR
 qO5n0p1XAbGNqFMAkFKzHZwpjIfsM3Sah/jPNGBNPA55nBrWpcmdwTd9KCw3siN5zipl+Rasy1DFO
 akxGghnDv8UgosPb7GwsjPIoHMC9mskXpP0nA9I04zyliBjug1/G949RBQXDZQrrnBYLb2xMb9wZE
 MNdTFwVbzVSqy36hyfM2OJd3CAWPtnuAvGP4yNeNMih9BXGoRoocELCdNZO/BZHdT7LvUtEihublf
 QbXjEXXqcyr7xZKMfyZ5w2exDQYHns3t5op26W/t9brXITZ73AaD2kgIKGeMy1/LU9clnwcDP8sbI
 1Tl50nF3GoVaFiodRq3pLlL6unXqgo6nnHuXEAGnfvMs4EK38rNCW//7fBRMSY1gHasTtMYuQ4Ulj
 FfrXzgD0r47Buh+9aDR8nWSMBnvCgIXlVpV3oWnQpqS6XrOJJ7nyo5h/y35C9Yv8eqHGb+bu5x/pW
 7GMipp/+72k4OXE5rQpPKk+jdGwcpHH8Mnz5Sk4kw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>
Cc: yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2] 9pfs: prevent opening special files (CVE-2023-2861)
Date: Wed, 07 Jun 2023 13:02:17 +0200
Message-ID: <2567904.5Pe2IrQ8Qc@silver>
In-Reply-To: <20230606180028.5305af87@bahia>
References: <E1q6XIJ-0005RX-AW@lizzy.crudebyte.com>
 <20230606180028.5305af87@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tuesday, June 6, 2023 6:00:28 PM CEST Greg Kurz wrote:
> Hi Christian,
> 
> On Tue, 06 Jun 2023 15:57:50 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > The 9p protocol does not specifically define how server shall behave when
> > client tries to open a special file, however from security POV it does
> > make sense for 9p server to prohibit opening any special file on host side
> > in general. A sane Linux 9p client for instance would never attempt to
> > open a special file on host side, it would always handle those exclusively
> > on its guest side. A malicious client however could potentially escape
> > from the exported 9p tree by creating and opening a device file on host
> > side.
> > 
> > With QEMU this could only be exploited in the following unsafe setups:
> > 
> >   - Running QEMU binary as root AND 9p 'local' fs driver AND 'passthrough'
> >     security model.
> > 
> > or
> > 
> >   - Using 9p 'proxy' fs driver (which is running its helper daemon as
> >     root).
> > 
> > These setups were already discouraged for safety reasons before,
> > however for obvious reasons we are now tightening behaviour on this.
> > 
> > Fixes: CVE-2023-2861
> > Reported-by: Yanwu Shen <ywsPlz@gmail.com>
> > Reported-by: Jietao Xiao <shawtao1125@gmail.com>
> > Reported-by: Jinku Li <jkli@xidian.edu.cn>
> > Reported-by: Wenbo Shen <shenwenbo@zju.edu.cn>
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  v1 -> v2:
> >  - Add equivalent fix for 'proxy' fs driver.
> >  - Minor adjustments on commit log.
> > 
> 
> Note that this might be a bit confusing for reviewers since
> v1 was never posted to qemu-devel. Technically, this should
> have been posted without the v2 tag.

I felt it wouldn't make it any better, as it might otherwise confuse those who
already got the previous two patch emails.

> >  fsdev/virtfs-proxy-helper.c | 48 +++++++++++++++++++++++++++++++++++--
> >  hw/9pfs/9p-util.h           | 29 ++++++++++++++++++++++
> >  2 files changed, 75 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> > index 5cafcd7703..f311519fa3 100644
> > --- a/fsdev/virtfs-proxy-helper.c
> > +++ b/fsdev/virtfs-proxy-helper.c
> > @@ -26,6 +26,7 @@
> >  #include "qemu/xattr.h"
> >  #include "9p-iov-marshal.h"
> >  #include "hw/9pfs/9p-proxy.h"
> > +#include "hw/9pfs/9p-util.h"
> >  #include "fsdev/9p-iov-marshal.h"
> >  
> >  #define PROGNAME "virtfs-proxy-helper"
> > @@ -338,6 +339,49 @@ static void resetugid(int suid, int sgid)
> >      }
> >  }
> >  
> > +/*
> > + * Open regular file or directory. Attempts to open any special file are
> > + * rejected.
> > + *
> > + * returns file descriptor or -1 on error
> > + */
> > +static int open_regular(const char *pathname, int flags, mode_t mode) {
> > +    int fd;
> > +    struct stat stbuf;
> > +
> > +    fd = open(pathname, flags, mode);
> > +    if (fd < 0) {
> > +        return fd;
> > +    }
> > +
> > +    /* CVE-2023-2861: Prohibit opening any special file directly on host
> > +     * (especially device files), as a compromised client could potentially
> > +     * gain access outside exported tree under certain, unsafe setups. We
> > +     * expect client to handle I/O on special files exclusively on guest side.
> > +     */
> > +    if (qemu_fstat(fd, &stbuf) < 0) {
> > +        close_preserve_errno(fd);
> > +        return -1;
> > +    }
> > +    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
> > +        /* Tcreate and Tlcreate 9p messages mandate to immediately open the
> > +         * created file for I/O. So this is not (necessarily) due to a broken
> > +         * client, and hence no error message is to be reported in this case.
> > +         */
> > +        if (!(flags & O_CREAT)) {
> 
> Tlcreate is explicitly about creating regular files only (see [1] and
> v9fs_lcreate()) and I don't quite see how open() could successfully
> create a regular file and the resulting fd is fstat'ed as something
> else.
> 
> Tcreate seems to cover more types but again only regular files (with O_CREAT)
> or directories (without O_CREAT) are expected here (see v9fs_create()).
> 
> Unless I'm missing something, it seems that the comment and the O_CREAT
> check should be removed.
> 
> [1] https://github.com/chaos/diod/blob/master/protocol.md#lcreate----create-regular-file

You are right about Tlcreate, but for Tcreate 9p2000.u specifies, quote:

"In addition to creating directories with DMDIR, 9P2000.u allows the creation
 of symlinks (DMSYMLINK), devices (DMDEVICE), named pipes (DMNAMEPIPE), and
 sockets (DMSOCKET)."

http://ericvh.github.io/9p-rfc/rfc9p2000.u.html#anchor17

So I just remove mentioning Tlcreate in the comment?

> 
> > +            error_report_once(
> > +                "9p: broken or compromised client detected; attempt to open "
> > +                "special file (i.e. neither regular file, nor directory)"
> > +            );
> > +        }
> > +        close(fd);
> > +        errno = ENXIO;
> > +        return -1;
> > +    }
> > +
> > +    return fd;
> > +}
> > +
> >  /*
> >   * send response in two parts
> >   * 1) ProxyHeader
> > @@ -682,7 +726,7 @@ static int do_create(struct iovec *iovec)
> >      if (ret < 0) {
> >          goto unmarshal_err_out;
> >      }
> > -    ret = open(path.data, flags, mode);
> > +    ret = open_regular(path.data, flags, mode);
> >      if (ret < 0) {
> >          ret = -errno;
> >      }
> > @@ -707,7 +751,7 @@ static int do_open(struct iovec *iovec)
> >      if (ret < 0) {
> >          goto err_out;
> >      }
> > -    ret = open(path.data, flags);
> > +    ret = open_regular(path.data, flags, 0);
> >      if (ret < 0) {
> >          ret = -errno;
> >      }
> > diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> > index c314cf381d..9da1a0538d 100644
> > --- a/hw/9pfs/9p-util.h
> > +++ b/hw/9pfs/9p-util.h
> > @@ -13,6 +13,8 @@
> >  #ifndef QEMU_9P_UTIL_H
> >  #define QEMU_9P_UTIL_H
> >  
> > +#include "qemu/error-report.h"
> > +
> >  #ifdef O_PATH
> >  #define O_PATH_9P_UTIL O_PATH
> >  #else
> > @@ -95,6 +97,7 @@ static inline int errno_to_dotl(int err) {
> >  #endif
> >  
> >  #define qemu_openat     openat
> > +#define qemu_fstat      fstat
> >  #define qemu_fstatat    fstatat
> >  #define qemu_mkdirat    mkdirat
> >  #define qemu_renameat   renameat
> > @@ -118,6 +121,7 @@ static inline int openat_file(int dirfd, const char *name, int flags,
> >                                mode_t mode)
> >  {
> >      int fd, serrno, ret;
> > +    struct stat stbuf;
> >  
> >  #ifndef CONFIG_DARWIN
> >  again:
> > @@ -142,6 +146,31 @@ again:
> >          return -1;
> >      }
> >  
> > +    /* CVE-2023-2861: Prohibit opening any special file directly on host
> > +     * (especially device files), as a compromised client could potentially
> > +     * gain access outside exported tree under certain, unsafe setups. We
> > +     * expect client to handle I/O on special files exclusively on guest side.
> > +     */
> > +    if (qemu_fstat(fd, &stbuf) < 0) {
> > +        close_preserve_errno(fd);
> > +        return -1;
> > +    }
> > +    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
> > +        /* Tcreate and Tlcreate 9p messages mandate to immediately open the
> > +         * created file for I/O. So this is not (necessarily) due to a broken
> > +         * client, and hence no error message is to be reported in this case.
> > +         */
> 
> Same remark as with the proxy helper.
> 
> If you agree with my suggestions, feel free to add my R-b right away.
> 
> Cheers,

I'll definitely take the time for another (v3) round in this case. Thanks!

> --
> Greg
> 
> > +        if (!(flags & O_CREAT)) {
> > +            error_report_once(
> > +                "9p: broken or compromised client detected; attempt to open "
> > +                "special file (i.e. neither regular file, nor directory)"
> > +            );
> > +        }
> > +        close(fd);
> > +        errno = ENXIO;
> > +        return -1;
> > +    }
> > +
> >      serrno = errno;
> >      /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
> >       * do that with O_PATH since fcntl(F_SETFL) isn't supported, and openat()
> 
> 



