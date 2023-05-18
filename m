Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB1708B57
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 00:14:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzls8-0000v7-Lj; Thu, 18 May 2023 18:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pzls6-0000uu-N2
 for qemu-devel@nongnu.org; Thu, 18 May 2023 18:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1pzls4-0005Hx-Je
 for qemu-devel@nongnu.org; Thu, 18 May 2023 18:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684447995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koEpWQRYuc6mIbnKY9PF5Zlj6ikcfVpkIHyh+bW5XRc=;
 b=buIJqYn8HtUvnBeZrGCXoAGu146KABD4jCrpDgFtmevfHTeHJ0JUHEsBN25hw+/fbd/wG8
 jmYAgbeLIQOqXUuB5zQW1FAO3l20JQhpOfBTrtmWJAKWnD1F6YXPlH8C5zKIuuaKHV0aDy
 GJDKUWVjcPuqKYiwC0q6f7xQSbtpEy4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-HCzuTlu7PYCS2GblGf-ghw-1; Thu, 18 May 2023 18:13:13 -0400
X-MC-Unique: HCzuTlu7PYCS2GblGf-ghw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-763997ab8cdso415629339f.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 15:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684447992; x=1687039992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koEpWQRYuc6mIbnKY9PF5Zlj6ikcfVpkIHyh+bW5XRc=;
 b=arVhd/mrmcwJD7izQApp2e5wxtRtu6e0ttH7U4vfwNGxK9uJ/Y6kbXTmISpnfmuG19
 /zhhDKU+uIdnUGSsjOG1TDPU1EIcJC4Sp+nWkrUUns3QQj6RY9VD2RGXDPTzOBVkf1TE
 ebG5rScXe7bRalItjojQSG+XKODP7C40YTHnS61/yN7/V4J73aBceRJRCOYEtlMt3mOb
 sVKglArbYDE3uAM5E46XsMW9jb6GOXeDSOcwe4VUmv5JVUeAITxZOg0pimbsbgBdJdtp
 J6yxiY25F4X0K2DoajNLKUJq5/HeYNKFm2FV+iatF05gTATA+nCsYmb1bHoUILyUoYjv
 vCtA==
X-Gm-Message-State: AC+VfDyu0LtfkzEylFalwOZYOY29qlBl7AHfGspRZIwSmKeqM8ziWIQD
 Rzblou70TVMduiHPVaD65ASna782v5Lo7ewYfQjd8+LjINnUmsTtk2ZFQGJCyLB9/St+CUB7aI2
 5G/ReLn2SPlZc5KtYK9ItKGI=
X-Received: by 2002:a05:6602:cb:b0:74c:c6ed:6de with SMTP id
 z11-20020a05660200cb00b0074cc6ed06demr7773857ioe.12.1684447992272; 
 Thu, 18 May 2023 15:13:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79orF0EMnVJz25FZwzzWkdbZRtpSGxe/HjztFXy10xCM9ERLIt1x4tKzuQ6I4nKXkYubkAZA==
X-Received: by 2002:a05:6602:cb:b0:74c:c6ed:6de with SMTP id
 z11-20020a05660200cb00b0074cc6ed06demr7773849ioe.12.1684447991958; 
 Thu, 18 May 2023 15:13:11 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 q21-20020a02a995000000b0041698357280sm730213jam.59.2023.05.18.15.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 15:13:11 -0700 (PDT)
Date: Thu, 18 May 2023 16:13:09 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Robin Voetter <robin@streamhpc.com>, qemu-devel@nongnu.org, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/1] pcie: Allow atomic completion on PCIE root port
Message-ID: <20230518161309.369a5d6c.alex.williamson@redhat.com>
In-Reply-To: <20230518160043-mutt-send-email-mst@kernel.org>
References: <20230420153839.167418-1-robin@streamhpc.com>
 <20230421042013-mutt-send-email-mst@kernel.org>
 <5330c419-bcdb-8577-4ed0-88a483f461e8@streamhpc.com>
 <20230518160043-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, 18 May 2023 16:03:07 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Apr 21, 2023 at 06:06:49PM +0200, Robin Voetter wrote:
> > 
> > 
> > On 4/21/23 10:22, Michael S. Tsirkin wrote:  
> > > On Thu, Apr 20, 2023 at 05:38:39PM +0200, robin@streamhpc.com wrote:  
> > >> From: Robin Voetter <robin@streamhpc.com>
> > >>
> > >> The ROCm driver for Linux uses PCIe atomics to schedule work and
> > >> generally communicate between the host and the device.  This does not
> > >> currently work in QEMU with regular vfio-pci passthrough, because the
> > >> pcie-root-port does not advertise the PCIe atomic completer
> > >> capabilities.  When initializing the GPU from the Linux driver, it
> > >> queries whether the PCIe connection from the CPU to GPU supports the
> > >> required capabilities[1] in the pci_enable_atomic_ops_to_root
> > >> function[2].  Currently the only part where this fails is checking the
> > >> atomic completer capabilities (32 and 64 bits) on the root port[3].  In
> > >> this case, the driver determines that PCIe atomics are not supported at
> > >> all, and this causes ROCm programs to misbehave.  (While AMD advertises
> > >> that there is some support for ROCm without PCIe atomics, I have never
> > >> actually gotten that working...)
> > >>
> > >> This patch allows ROCm to properly function by introducing an
> > >> additional experimental property to the pcie-root-port,
> > >> x-atomic-completion.  
> > > 
> > > so what exactly makes it experimental? from this description
> > > it looks like it actually has to be enabled for things to work?  
> > 
> > I was not sure which would be appropriate, but I'm fine with making it a
> > non-experimental option.  
> 
> So I guess the real thing to do is to query this from vfio right?
> Unfortunately we don't have access to vfio when we
> are creating the root port, but I think the thing to do would
> be to check at the time when vfio is attached, and if
> atomic is set but not supported, fail attaching vfio.
> 
> Right?

We don't currently provide a way to query this in vfio, but I imagine
we could call pci_enable_atomic_ops_to_root() in the host kernel
ourselves with various sizes and expose which are supported via a
capability on the vfio-device.  I'm not sure what we do for VFs though
since that function is invalid for them (maybe worry about them later).
I also see that one of the in-kernel drivers (mlx5) tries to enable
128-bit support, so I wonder if we want separate options for 32/64-bit
and 128-bit.

QEMU device options are clearly the most straightforward path to enable
this, but would it actually make sense, perhaps in addition, to
implement the above in the kernel and then have the QEMU vfio-pci
driver enable the available completer bits in the root port during
realize?  We could probably get away with it on hotplug, but if
necessary it could be something we only do for cold-plug devices (we
also have a no-hotplug vfio-pci variant if we're concerned what happens
after the device is removed in the VM - again, be could probably get
away with clearing the bits on unplug).

I'm not entirely sure where we stand in QEMU on whether options that
can cause poor behavior should always be experimental or we allow users
to shoot themselves in the foot as they please.  Obviously it makes it
more difficult for libvirt to support such configurations, but maybe
they'd rely on the above automatic enabling rather than try to guess
themselves.  Thanks,

Alex


