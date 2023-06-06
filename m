Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FF5724BBD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bjo-0003xC-IS; Tue, 06 Jun 2023 14:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6bjk-0003vq-5S
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:48:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q6bjh-0004Jh-Bb
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:48:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8A5FB211;
 Tue,  6 Jun 2023 21:48:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C7F7A005;
 Tue,  6 Jun 2023 21:48:49 +0300 (MSK)
Message-ID: <8f32cd65-83e8-89d4-0825-1fe62f5b09ad@tls.msk.ru>
Date: Tue, 6 Jun 2023 21:48:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] 9pfs: prevent opening special files (CVE-2023-2861)
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn
References: <E1q6XIJ-0005RX-AW@lizzy.crudebyte.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <E1q6XIJ-0005RX-AW@lizzy.crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.06.2023 16:57, Christian Schoenebeck wrote:
..

> +++ b/fsdev/virtfs-proxy-helper.c

> +static int open_regular(const char *pathname, int flags, mode_t mode) {
> +    int fd;
> +    struct stat stbuf;
> +
> +    fd = open(pathname, flags, mode);
> +    if (fd < 0) {
> +        return fd;
> +    }
> +
> +    /* CVE-2023-2861: Prohibit opening any special file directly on host
> +     * (especially device files), as a compromised client could potentially
> +     * gain access outside exported tree under certain, unsafe setups. We
> +     * expect client to handle I/O on special files exclusively on guest side.
> +     */
> +    if (qemu_fstat(fd, &stbuf) < 0) {
> +        close_preserve_errno(fd);
> +        return -1;
> +    }
> +    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
> +        /* Tcreate and Tlcreate 9p messages mandate to immediately open the
> +         * created file for I/O. So this is not (necessarily) due to a broken
> +         * client, and hence no error message is to be reported in this case.
> +         */
> +        if (!(flags & O_CREAT)) {
> +            error_report_once(
> +                "9p: broken or compromised client detected; attempt to open "
> +                "special file (i.e. neither regular file, nor directory)"
> +            );
> +        }
> +        close(fd);
> +        errno = ENXIO;
> +        return -1;
> +    }
> +
> +    return fd;
> +}


> +++ b/hw/9pfs/9p-util.h

> @@ -118,6 +121,7 @@ static inline int openat_file(int dirfd, const char *name, int flags,
>                                 mode_t mode)
>   {
>       int fd, serrno, ret;
> +    struct stat stbuf;
>   
>   #ifndef CONFIG_DARWIN
>   again:
> @@ -142,6 +146,31 @@ again:
>           return -1;
>       }
>   
> +    /* CVE-2023-2861: Prohibit opening any special file directly on host
> +     * (especially device files), as a compromised client could potentially
> +     * gain access outside exported tree under certain, unsafe setups. We
> +     * expect client to handle I/O on special files exclusively on guest side.
> +     */
> +    if (qemu_fstat(fd, &stbuf) < 0) {
> +        close_preserve_errno(fd);
> +        return -1;
> +    }
> +    if (!S_ISREG(stbuf.st_mode) && !S_ISDIR(stbuf.st_mode)) {
> +        /* Tcreate and Tlcreate 9p messages mandate to immediately open the
> +         * created file for I/O. So this is not (necessarily) due to a broken
> +         * client, and hence no error message is to be reported in this case.
> +         */
> +        if (!(flags & O_CREAT)) {
> +            error_report_once(
> +                "9p: broken or compromised client detected; attempt to open "
> +                "special file (i.e. neither regular file, nor directory)"
> +            );
> +        }
> +        close(fd);
> +        errno = ENXIO;
> +        return -1;
> +    }
> +

can't we re-use this same code used in two places, placing it into an inline
function, such as is_file_regular_or_dir(fd) ?  It smells like a very good
candidate for implementing it in a single place..

Thanks,

/mjt

