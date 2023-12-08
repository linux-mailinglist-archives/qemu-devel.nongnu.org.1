Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E78F809F3A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:26:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBX6y-00045r-Ga; Fri, 08 Dec 2023 04:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBX6w-00045U-5E
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rBX6r-0001Rg-Lj
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702027524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CgufJ2Or7ZGKARHAUypKtPm9NRz4skjhdvuVsbqdfA=;
 b=exH1BNrnCm8i+Dw618vX7TFvEJiroh19p/ohZFzXhf6HqjjuBTV0OO72aGFK3PUbhstKVG
 hfGqQnj7k6smGAa6wIRgqgJ4U270LkEXHhMH59zIjqDMgoAz0RX948betbL8QY5RoghI4P
 uT2nruzSeSiO7MECKMVcLKeHxJAwl+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-x8w-IU0nNBijROHioS_Q7g-1; Fri, 08 Dec 2023 04:25:20 -0500
X-MC-Unique: x8w-IU0nNBijROHioS_Q7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C2DA85A58A;
 Fri,  8 Dec 2023 09:25:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D106C2026D66;
 Fri,  8 Dec 2023 09:25:19 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:25:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Young <m.a.young@durham.ac.uk>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
Message-ID: <ZXLg_YCHM-P6drQV@redhat.com>
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

CC'ing the Xen folks

On Thu, Dec 07, 2023 at 11:12:48PM +0000, Michael Young wrote:
> Builds of qemu-8.2.0rc2 with xen-4.18.0 are currently failing
> with errors like
> ../hw/arm/xen_arm.c:74:5: error: ‘GUEST_VIRTIO_MMIO_SPI_LAST’ undeclared (first use in this function)
>    74 |    (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> as there is an incorrect comparision in include/hw/xen/xen_native.h
> which means that settings like GUEST_VIRTIO_MMIO_SPI_LAST
> aren't being defined for xen-4.18.0

The conditions in arch-arm.h for xen 4.18 show:

$ cppi arch-arm.h | grep -E '(#.*if)|MMIO'
#ifndef __XEN_PUBLIC_ARCH_ARM_H__
# if defined(__XEN__) || defined(__XEN_TOOLS__) || defined(__GNUC__)
# endif
# ifndef __ASSEMBLY__
#  if defined(__XEN__) || defined(__XEN_TOOLS__)
#   if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#   endif
#  endif /* __XEN__ || __XEN_TOOLS__ */
# endif
# if defined(__XEN__) || defined(__XEN_TOOLS__)
#  define PSR_MODE_BIT  0x10U /* Set iff AArch32 */
/* Virtio MMIO mappings */
#  define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
#  define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
#  define GUEST_VIRTIO_MMIO_SPI_FIRST   33
#  define GUEST_VIRTIO_MMIO_SPI_LAST    43
# endif
# ifndef __ASSEMBLY__
# endif
#endif /*  __XEN_PUBLIC_ARCH_ARM_H__ */

So the MMIO constants are available if __XEN__ or __XEN_TOOLS__
are defined. This is no different to the condition that was
present in Xen 4.17.

What you didn't mention was that the Fedora build failure is
seen on an x86_64 host, when building the aarch64 target QEMU,
and I think this is the key issue.

The constants are defined in arch-arm.h, which is only included
under:

  #if defined(__i386__) || defined(__x86_64__)
  #include "arch-x86/xen.h"
  #elif defined(__arm__) || defined (__aarch64__)
  #include "arch-arm.h"
  #else
  #error "Unsupported architecture"
  #endif


When we are building on an x86_64 host, we not going to get
arch-arm.h included, even if we're trying to build the aarch64
system emulator.

I don't know how this is supposed to work ?

Are we expecting to build Xen support for non-arch native QEMU
system binaries or not ?

> Signed-off-by: Michael Young <m.a.young@durham.ac.uk>
> ---
>  include/hw/xen/xen_native.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 6f09c48823..04b1ef4d34 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
>  }
>  #endif
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41700

This change is not correct

We can see the upstream change was introduced in 4.17:

  $ git describe  2128143c114
  4.16.0-rc4-967-g2128143c11

IOW, if we have 4.17 or newer these constants already
exist. If we have 4.16 or older, then we need to define
them to provide back compat.

>  #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
>  #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
>  #define GUEST_VIRTIO_MMIO_SPI_FIRST   33

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


