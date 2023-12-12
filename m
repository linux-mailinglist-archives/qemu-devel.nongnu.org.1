Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A968180E056
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 01:35:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCqjJ-0002J4-Dn; Mon, 11 Dec 2023 19:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rCqjH-0002Ht-6u
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:34:31 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1rCqjE-0002UL-VR
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:34:30 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E21A8CE11BD;
 Tue, 12 Dec 2023 00:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6221BC433C7;
 Tue, 12 Dec 2023 00:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702341262;
 bh=gjOcFpvF48FLu7i3ovdS7rvh+edLNdlP1NvuUCiiVkI=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Nseh3HMoRnLy3WMZ1i5IEgOJJ1XxvKjUUCETVgggSZjxtH2FYDAeN/bdocVTkcy3+
 aZ1M2o2kBBc572E4b0CtfG2PP2n42/s10XBU545djhnA5rQr5MtOVZtJr47mHx0AXA
 N2H5tlVFrht9UVK9ivoqrXC7n2wDA7BlK08kLeLuj5uJ5ii423kH7m+/B5H51fBZK3
 Zzq+eLmzENLSBl47eBlZNu+argzMRk6D81IEd8jdb5iGgFPF8EuPUlgUz56M1JeRCa
 wYG78ytn7fiGWNHUM53RYfR4+uOF1kGsuwD0logCAUkJ3xu4ppMYHkbOB7OvY3AuQY
 mpVjrGQcCMWtQ==
Date: Mon, 11 Dec 2023 16:34:19 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, Stefano Stabellini <stefano.stabellini@amd.com>, 
 "Richard W . M . Jones" <rjones@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Young <m.a.young@durham.ac.uk>
Subject: Re: [PATCH] xen: fix condition for enabling the Xen accelerator
In-Reply-To: <20231209143222.2916891-1-pbonzini@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2312111632040.1703076@ubuntu-linux-20-04-desktop>
References: <20231209143222.2916891-1-pbonzini@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="8323329-1904100162-1702341261=:1703076"
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=sstabellini@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--8323329-1904100162-1702341261=:1703076
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 9 Dec 2023, Paolo Bonzini wrote:
> A misspelled condition in xen_native.h is hiding a bug in the enablement of
> Xen for qemu-system-aarch64.  The bug becomes apparent when building for
> Xen 4.18.
> 
> While the i386 emulator provides the xenpv machine type for multiple architectures,
> and therefore can be compiled with Xen enabled even when the host is Arm, the
> opposite is not true: qemu-system-aarch64 can only be compiled with Xen support
> enabled when the host is Arm.
> 
> Expand the computation of accelerator_targets['CONFIG_XEN'] similar to what is
> already there for KVM, and fix xen_native.h.
> 
> Cc: Stefano Stabellini <stefano.stabellini@amd.com>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Michael Young <m.a.young@durham.ac.uk>
> Supersedes: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/hw/xen/xen_native.h |  2 +-
>  meson.build                 | 17 ++++++++++-------
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 6f09c48823b..1a5ad693a4d 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
>  }
>  #endif
>  
> -#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41700
>  #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
>  #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
>  #define GUEST_VIRTIO_MMIO_SPI_FIRST   33
> diff --git a/meson.build b/meson.build
> index ec01f8b138a..67f4ede8aea 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -123,21 +123,24 @@ if get_option('kvm').allowed() and targetos == 'linux'
>    kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
>  endif
>  config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
> -
>  accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>  
> +if cpu in ['x86', 'x86_64']
> +  xen_targets = ['i386-softmmu', 'x86_64-softmmu']
> +elif cpu in ['arm', 'aarch64']
> +  # i386 emulator provides xenpv machine type for multiple architectures
> +  xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
> +else
> +  xen_targets = []
> +endif
> +accelerator_targets += { 'CONFIG_XEN': xen_targets }
> +
>  if cpu in ['aarch64']
>    accelerator_targets += {
>      'CONFIG_HVF': ['aarch64-softmmu']
>    }
>  endif
>  
> -if cpu in ['x86', 'x86_64', 'arm', 'aarch64']
> -  # i386 emulator provides xenpv machine type for multiple architectures
> -  accelerator_targets += {
> -    'CONFIG_XEN': ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu'],
> -  }
> -endif
>  if cpu in ['x86', 'x86_64']
>    accelerator_targets += {
>      'CONFIG_HVF': ['x86_64-softmmu'],
> -- 
> 2.43.0
> 
> 
--8323329-1904100162-1702341261=:1703076--

