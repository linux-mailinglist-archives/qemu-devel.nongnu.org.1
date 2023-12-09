Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E24180B4F4
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Dec 2023 15:47:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rByaK-0006E6-Hb; Sat, 09 Dec 2023 09:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rByaC-0006Dm-UW
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 09:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rByaA-0008G5-UH
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 09:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702133128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9adiU32g/APD7Vv6o8ypy71Ydd+TZ4SesUbEpDe0KcY=;
 b=Jc5/+oECVvE8WR8odhmw/54Uav97U+fd33W+fVYVqZHpSVwz9SS1FzU0w7mQgCycKS+U+l
 +JOLAC1ujYnneCQMjGFnBMLaXtM5wdt2yXxV3gIKNep/5Y2PvDIZ9yeyt9akvLmWdC7axP
 tpB2W9mAHO6W5Xfj78FMdAlJgMEDrj8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-O4yGZAnDNHC3N5breWKgng-1; Sat,
 09 Dec 2023 09:45:26 -0500
X-MC-Unique: O4yGZAnDNHC3N5breWKgng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768A23C0C88B;
 Sat,  9 Dec 2023 14:45:26 +0000 (UTC)
Received: from localhost (unknown [10.42.28.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0D982166B35;
 Sat,  9 Dec 2023 14:45:25 +0000 (UTC)
Date: Sat, 9 Dec 2023 14:45:25 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <stefano.stabellini@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Young <m.a.young@durham.ac.uk>
Subject: Re: [PATCH] xen: fix condition for enabling the Xen accelerator
Message-ID: <20231209144525.GP7636@redhat.com>
References: <20231209143222.2916891-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231209143222.2916891-1-pbonzini@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Dec 09, 2023 at 03:32:22PM +0100, Paolo Bonzini wrote:
> A misspelled condition in xen_native.h is hiding a bug in the enablement of
> Xen for qemu-system-aarch64.  The bug becomes apparent when building for
> Xen 4.18.
>
> While the i386 emulator provides the xenpv machine type for multiple
> architectures, and therefore can be compiled with Xen enabled even
> when the host is Arm, the opposite is not true: qemu-system-aarch64
> can only be compiled with Xen support enabled when the host is Arm.
>
> Expand the computation of accelerator_targets['CONFIG_XEN'] similar
> to what is already there for KVM, and fix xen_native.h.

Here's a Fedora scratch build with Xen 4.18.0 which includes this patch:

https://koji.fedoraproject.org/koji/taskinfo?taskID=110105806

Rich.

> Cc: Stefano Stabellini <stefano.stabellini@amd.com>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Reported-by: Michael Young <m.a.young@durham.ac.uk>
> Supersedes: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


