Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853E725CA1
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 13:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qz1-000300-0P; Wed, 07 Jun 2023 07:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1q6qyv-0002zL-Bg
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:05:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1q6qyt-0004Vj-Rg
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 07:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=BIoABrxamJQCVeRVOyshXSrpyoEcFDHe6Rbnc9VMOs8=; b=wzC0r5zSesO4GzX93wEtqzGmg4
 uWq4T+gUdSjBdkw9q+yv3iG4iZ63+8sVmFKYOO7s79kDTN+02dLDz5FF7s3ogXkTg/54OU+TaRQNr
 2asrCsDJgYxlbjre55QAYnrMc5So1hW76dYF64BdZ0KbO5gQejlkZLRMG2GWY0jhvEZ/+lXilQZdT
 N6sah2QRPijzEhE2czizDdLPcaSZMukPzLPkgtQCEPOzv7IAAwowXeSWPxzYoJqczECkTorYMGPp4
 I82JyR2SIs+6Dj6yoPNt8YASnDEekrHlFu8srQVgfabFfu7XlTSoM6epUlEWByz2SzFQ4orT8ahS7
 pUd4sMIVL26BzimhibjMtWYGZXRKOmTNlthjqhQBk273aGgqQPph3cvpNrXfpLD1deLbRoygRzqeg
 UYaH8Zz3NPMjoBBUxNumncHoEucjJdQ1PPzK80tu92xr7VVS8nIAPYhHHetEwyz6l0w0hKYHeyvKi
 zZgWp9hjqLpULw8gx6BkreFruB9gp1yn231+iRuAmQC9GEic6sNG4IlTySn36uXUP+J7+zpp9h66s
 NHPUVewlqZHBku1fV/YOuez5hegpCIL6fBx2bzgqfadUbKhXO6hn4OS2DaFqoI0hgyOxbqG76jvpu
 r6VLcBTprUybGe4J/f1HPXma+xv0nq0yqlRc6+Ilw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 yw s <ywsplz@gmail.com>, shawtao1125@gmail.com, jkli@xidian.edu.cn,
 shenwenbo@zju.edu.cn, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] 9pfs: prevent opening special files (CVE-2023-2861)
Date: Wed, 07 Jun 2023 13:05:29 +0200
Message-ID: <2270849.YxrqnBgBBS@silver>
In-Reply-To: <8f32cd65-83e8-89d4-0825-1fe62f5b09ad@tls.msk.ru>
References: <E1q6XIJ-0005RX-AW@lizzy.crudebyte.com>
 <8f32cd65-83e8-89d4-0825-1fe62f5b09ad@tls.msk.ru>
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

On Tuesday, June 6, 2023 8:48:49 PM CEST Michael Tokarev wrote:
> 06.06.2023 16:57, Christian Schoenebeck wrote:
[...]
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
> 
> can't we re-use this same code used in two places, placing it into an inline
> function, such as is_file_regular_or_dir(fd) ?  It smells like a very good
> candidate for implementing it in a single place..

Yeah, my plan was to officially deprecate 9p proxy subsequently, so I didn't
care too much about code duplication, but I guess you are right, it is simple
enough to do it right.

Best regards,
Christian Schoenebeck



