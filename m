Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776680AFEC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 23:50:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBjf8-0001YZ-Cp; Fri, 08 Dec 2023 17:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rBjf3-0001YO-W7
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:49:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rBjf1-0007LT-On
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:49:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3CF76625E4;
 Fri,  8 Dec 2023 22:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033DDC433C8;
 Fri,  8 Dec 2023 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702075769;
 bh=Str9XyP63a08WIpfTICrG8sa3qrLzGScb0cGu5pCjAY=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KP7L0fJ8FKKbwj55yW7m3fIyRWRPC52ATtHCNwdTyX4PMwCDq5kjj+WJ5RH4wsvOk
 Dlsua+qeG4+pGszMsk9y5Q0VA0FlNm2UWzs4QsQTloINSvGaIAWbwECyLYOJ4B9eIR
 mfLAMMsOgWxWq49HXubXvHi2P7aIEtCwCh200Tz3l1Ho4krCmRQ74xmUyvYTfg4QiK
 9pRyNiaeJox6ZVCWbYEaodnzu/MxUhKtw9odGkudkMNg5O79KDOT/D6NCiMyHRym6c
 zbmRVfVVK9etF1na+DsXM7zBm4JnpFnVGeEajwH/xOASZqfoNNN4atTXMCVPl/zpBs
 OdxknJSmuMa/w==
Date: Fri, 8 Dec 2023 14:49:27 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
cc: Michael Young <m.a.young@durham.ac.uk>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
In-Reply-To: <ZXLg_YCHM-P6drQV@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2312081422490.1703076@ubuntu-linux-20-04-desktop>
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
 <ZXLg_YCHM-P6drQV@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-855051027-1702074176=:1703076"
Content-ID: <alpine.DEB.2.22.394.2312081423010.1703076@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-855051027-1702074176=:1703076
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2312081423011.1703076@ubuntu-linux-20-04-desktop>

On Fri, 8 Dec 2023, Daniel P. Berrangé wrote:
> CC'ing the Xen folks
> 
> On Thu, Dec 07, 2023 at 11:12:48PM +0000, Michael Young wrote:
> > Builds of qemu-8.2.0rc2 with xen-4.18.0 are currently failing
> > with errors like
> > ../hw/arm/xen_arm.c:74:5: error: ‘GUEST_VIRTIO_MMIO_SPI_LAST’ undeclared (first use in this function)
> >    74 |    (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > as there is an incorrect comparision in include/hw/xen/xen_native.h
> > which means that settings like GUEST_VIRTIO_MMIO_SPI_LAST
> > aren't being defined for xen-4.18.0
> 
> The conditions in arch-arm.h for xen 4.18 show:
> 
> $ cppi arch-arm.h | grep -E '(#.*if)|MMIO'
> #ifndef __XEN_PUBLIC_ARCH_ARM_H__
> # if defined(__XEN__) || defined(__XEN_TOOLS__) || defined(__GNUC__)
> # endif
> # ifndef __ASSEMBLY__
> #  if defined(__XEN__) || defined(__XEN_TOOLS__)
> #   if defined(__GNUC__) && !defined(__STRICT_ANSI__)
> #   endif
> #  endif /* __XEN__ || __XEN_TOOLS__ */
> # endif
> # if defined(__XEN__) || defined(__XEN_TOOLS__)
> #  define PSR_MODE_BIT  0x10U /* Set iff AArch32 */
> /* Virtio MMIO mappings */
> #  define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
> #  define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
> #  define GUEST_VIRTIO_MMIO_SPI_FIRST   33
> #  define GUEST_VIRTIO_MMIO_SPI_LAST    43
> # endif
> # ifndef __ASSEMBLY__
> # endif
> #endif /*  __XEN_PUBLIC_ARCH_ARM_H__ */
> 
> So the MMIO constants are available if __XEN__ or __XEN_TOOLS__
> are defined. This is no different to the condition that was
> present in Xen 4.17.
> 
> What you didn't mention was that the Fedora build failure is
> seen on an x86_64 host, when building the aarch64 target QEMU,
> and I think this is the key issue.

Hi Daniel, thanks for looking into it.

- you are building on a x86_64 host
- the target is aarch64
- the target is the aarch64 Xen PVH machine (xen_arm.c)

But is the resulting QEMU binary expected to be an x86 binary? Or are
you cross compiling ARM binaries on a x86 host?

In other word, is the resulting QEMU binary expected to run on ARM or
x86?


> Are we expecting to build Xen support for non-arch native QEMU
> system binaries or not ?

The ARM xenpvh machine (xen_arm.c) is meant to work with Xen on ARM, not
Xen on x86.  So this is only expected to work if you are
cross-compiling. But you can cross-compile both Xen and QEMU, and I am
pretty sure that Yocto is able to build Xen, Xen userspace tools, and
QEMU for Xen/ARM on an x86 host today.


> The constants are defined in arch-arm.h, which is only included
> under:
> 
>   #if defined(__i386__) || defined(__x86_64__)
>   #include "arch-x86/xen.h"
>   #elif defined(__arm__) || defined (__aarch64__)
>   #include "arch-arm.h"
>   #else
>   #error "Unsupported architecture"
>   #endif
> 
> 
> When we are building on an x86_64 host, we not going to get
> arch-arm.h included, even if we're trying to build the aarch64
> system emulator.
> 
> I don't know how this is supposed to work ?

It looks like a host vs. target architecture mismatch: the #if defined
(__aarch64__) check should pass I think.


The following is a guess. Maybe Xen gets enabled because you have x86
Xen installed, and you are building QEMU for an aarch64 target (aarch64
emulation, running on a x86 host). So this is not meant to work for
xen_arm.c and it would be better to disable xen_arm.c.

On the other hand if you are trying to cross-build a QEMU binary meant
to run on an aarch64 host, cross-building it on an x86_64 host, then yes
this is meant to work and we need to figure out why the #if defined
(__aarch64__) is not passing.



> > Signed-off-by: Michael Young <m.a.young@durham.ac.uk>
> > ---
> >  include/hw/xen/xen_native.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> > index 6f09c48823..04b1ef4d34 100644
> > --- a/include/hw/xen/xen_native.h
> > +++ b/include/hw/xen/xen_native.h
> > @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
> >  }
> >  #endif
> >  
> > -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41700
> 
> This change is not correct
> 
> We can see the upstream change was introduced in 4.17:
> 
>   $ git describe  2128143c114
>   4.16.0-rc4-967-g2128143c11
> 
> IOW, if we have 4.17 or newer these constants already
> exist. If we have 4.16 or older, then we need to define
> them to provide back compat.
> 
> >  #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
> >  #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
> >  #define GUEST_VIRTIO_MMIO_SPI_FIRST   33
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
--8323329-855051027-1702074176=:1703076--

