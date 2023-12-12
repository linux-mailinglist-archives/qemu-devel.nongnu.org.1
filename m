Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D521F80EE92
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:21:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3cE-0006Wk-7Z; Tue, 12 Dec 2023 09:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rD3cB-0006W4-S8
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:20:03 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rD3c9-0001aC-Fq
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:20:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c3984f0cdso41868535e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1702390799; x=1702995599; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9FAI7uzbx1boNO4jdXWmLoa3VhRnZzRtn67+r1dQPVg=;
 b=k0hG0gfhZ20lqG63+IHCApOTVNB5rzvfuq4cLE0mQEq/G49yfeN1osNpoy2u+Dxpbp
 4nG7O/RT76QDEpje2pXRY+MlnZSVnBVUYngObT9/avhtlKGTlpmZqjG3Ov/q/YM84iAr
 BmyZF93PJHiR1OZITKMtLFKwpQQqN6Q/7Xvkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702390799; x=1702995599;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9FAI7uzbx1boNO4jdXWmLoa3VhRnZzRtn67+r1dQPVg=;
 b=H+nGd3KdJUARUVPYu5F9JzdkncyzjBmDqlIguDAWb9iNyD3yVhumy3Q7VNIIVwwLv1
 6nR5aaUnlXdH+zJN1JwVJqBqWLWLep5BCWY+Dewd66IhEUljv23k7zThpcUnE/OlZU/f
 //7kFBSAxClaCSJtSupysLhZmn8mnqVV+belEgBcDlyH1D1arEnQwa96ZjVu+G1JMerc
 6WWTtG0UmfdSKg2+iSQcZz2GSScOraNXlx6giaEiVqUExZ4r7/caLIJjPTcG/md3WKyV
 PTTcDDZauVP/hrkI/4eFOy/3gaTJS06vlFFb9rXRKHKsGmQfn2FPv8hwWrwoSxNlBJHN
 YVJQ==
X-Gm-Message-State: AOJu0YxbSglBQirFwh3K5OAWkcC8Sj39097avmkYVosiHabfvAf+bQ1i
 S/K8CqA775cMd9ruA618IBUQkw==
X-Google-Smtp-Source: AGHT+IHMf4wc+LjrEtjZfWSxgAjvqtb7DfFrjTR+mRfO3I0NS7/jpv8Zlatopp2RJfNs/iBeMkOl8A==
X-Received: by 2002:a05:600c:2b0e:b0:40c:337e:f059 with SMTP id
 y14-20020a05600c2b0e00b0040c337ef059mr3258621wme.65.1702390798868; 
 Tue, 12 Dec 2023 06:19:58 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a05600c4f9500b0040b36ad5413sm16310403wmq.46.2023.12.12.06.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 06:19:58 -0800 (PST)
Date: Tue, 12 Dec 2023 14:19:57 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Young <m.a.young@durham.ac.uk>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
Message-ID: <8be72952-88b6-4c74-b696-fecfa8313c96@perard>
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
 <ZXLg_YCHM-P6drQV@redhat.com>
 <alpine.DEB.2.22.394.2312081422490.1703076@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2312081422490.1703076@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 08, 2023 at 02:49:27PM -0800, Stefano Stabellini wrote:
> On Fri, 8 Dec 2023, Daniel P. Berrangé wrote:
> > On Thu, Dec 07, 2023 at 11:12:48PM +0000, Michael Young wrote:
> > > Builds of qemu-8.2.0rc2 with xen-4.18.0 are currently failing
> > > with errors like
> > > ../hw/arm/xen_arm.c:74:5: error: ‘GUEST_VIRTIO_MMIO_SPI_LAST’ undeclared (first use in this function)
> > >    74 |    (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
> > >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > as there is an incorrect comparision in include/hw/xen/xen_native.h
> > > which means that settings like GUEST_VIRTIO_MMIO_SPI_LAST
> > > aren't being defined for xen-4.18.0
> > 
> > The conditions in arch-arm.h for xen 4.18 show:
> > 
> > $ cppi arch-arm.h | grep -E '(#.*if)|MMIO'
> > #ifndef __XEN_PUBLIC_ARCH_ARM_H__
> > # if defined(__XEN__) || defined(__XEN_TOOLS__) || defined(__GNUC__)
> > # endif
> > # ifndef __ASSEMBLY__
> > #  if defined(__XEN__) || defined(__XEN_TOOLS__)
> > #   if defined(__GNUC__) && !defined(__STRICT_ANSI__)
> > #   endif
> > #  endif /* __XEN__ || __XEN_TOOLS__ */
> > # endif
> > # if defined(__XEN__) || defined(__XEN_TOOLS__)
> > #  define PSR_MODE_BIT  0x10U /* Set iff AArch32 */
> > /* Virtio MMIO mappings */
> > #  define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
> > #  define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
> > #  define GUEST_VIRTIO_MMIO_SPI_FIRST   33
> > #  define GUEST_VIRTIO_MMIO_SPI_LAST    43
> > # endif
> > # ifndef __ASSEMBLY__
> > # endif
> > #endif /*  __XEN_PUBLIC_ARCH_ARM_H__ */
> > 
> > So the MMIO constants are available if __XEN__ or __XEN_TOOLS__
> > are defined. This is no different to the condition that was
> > present in Xen 4.17.
> > 
> > What you didn't mention was that the Fedora build failure is
> > seen on an x86_64 host, when building the aarch64 target QEMU,
> > and I think this is the key issue.
> 
> Hi Daniel, thanks for looking into it.
> 
> - you are building on a x86_64 host
> - the target is aarch64
> - the target is the aarch64 Xen PVH machine (xen_arm.c)
> 
> But is the resulting QEMU binary expected to be an x86 binary? Or are
> you cross compiling ARM binaries on a x86 host?
> 
> In other word, is the resulting QEMU binary expected to run on ARM or
> x86?
> 
> 
> > Are we expecting to build Xen support for non-arch native QEMU
> > system binaries or not ?
> 
> The ARM xenpvh machine (xen_arm.c) is meant to work with Xen on ARM, not
> Xen on x86.  So this is only expected to work if you are
> cross-compiling. But you can cross-compile both Xen and QEMU, and I am
> pretty sure that Yocto is able to build Xen, Xen userspace tools, and
> QEMU for Xen/ARM on an x86 host today.
> 
> 
> > The constants are defined in arch-arm.h, which is only included
> > under:
> > 
> >   #if defined(__i386__) || defined(__x86_64__)
> >   #include "arch-x86/xen.h"
> >   #elif defined(__arm__) || defined (__aarch64__)
> >   #include "arch-arm.h"
> >   #else
> >   #error "Unsupported architecture"
> >   #endif
> > 
> > 
> > When we are building on an x86_64 host, we not going to get
> > arch-arm.h included, even if we're trying to build the aarch64
> > system emulator.
> > 
> > I don't know how this is supposed to work ?
> 
> It looks like a host vs. target architecture mismatch: the #if defined
> (__aarch64__) check should pass I think.


Building qemu with something like:
    ./configure --enable-xen --cpu=x86_64
used to work. Can we fix that? It still works with v8.1.0.
At least, it works on x86, I never really try to build qemu for arm.
Notice that there's no "--target-list" on the configure command line.
I don't know if --cpu is useful here.

Looks like the first commit where the build doesn't work is
7899f6589b78 ("xen_arm: Add virtual PCIe host bridge support").

Could we get that fixed?

I'm sure distribution will appreciate to be able to build a single qemu
package for xen and other, rather than having a dedicated qemu-xen
package.

Cheers,

-- 
Anthony PERARD

