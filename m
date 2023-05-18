Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E937088F1
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzjqJ-0007bh-RO; Thu, 18 May 2023 16:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjqI-0007bY-Gy
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzjqH-0004sL-3E
 for qemu-devel@nongnu.org; Thu, 18 May 2023 16:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684440196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NQo78BvpysIWY/s1l2LdSuPU6piefOhuzY8nxSOxX20=;
 b=YWSaotkVeq++exePKF9eWpoduhMYo1VctWiCuEhOErqarW6hAWJzDNBILfJW+prDag8ZAN
 O81KjT1EEhkJcVbouimigL+eYE9hYRQDS5zRsr+XdpMjKkZTDZEIeN89evtCN/4t+yjEu/
 vp5glgAekMPNapnBQv11PsG/u3yFDEE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-_B5OV9ZHNVOrWHRSnh_C-g-1; Thu, 18 May 2023 16:03:14 -0400
X-MC-Unique: _B5OV9ZHNVOrWHRSnh_C-g-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2aed331e597so474901fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 13:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684440193; x=1687032193;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQo78BvpysIWY/s1l2LdSuPU6piefOhuzY8nxSOxX20=;
 b=R/N+lP1vcgHhlSSw7E/xDKseCLXNSwC4n/gxPXcTLY1s3WI9il71PoY2KUTfBI2TfK
 qmqLBMgT2FnN9DB1kfEnRkIj/IOau7Q0SAfAosDlo+M2Lm3QdWksobjhgKAzQTDpkzT/
 G6v8p55hYPLcNhLhrMfZdyva2dHr9plTzkmmlGk0cRd29hfRBqoOHdWMWU+ZAZzcWcm7
 FpX7Hd4rTUgjYhM8knZ0DWP1x5K435Tu2rVqOq6QddHDUbqTbXy3DsNEtWEMkbcYdxKW
 n85Za6I26tnu5tDIgoSeSzp2L4din/fix83k851Mdxb2vhI1z1QY8qEQwqLfuiPnIZ/1
 8GcQ==
X-Gm-Message-State: AC+VfDyU+irlhxfzyHlAgl+e5+8ClwjiCBp/JEHs81N0SyfzrnjQ3jvi
 VzIR67Uusy26P2Zhbrg0VjAMsmYkNXj2BGhomhFwEJlnNIZFqyXC+X99GD7gJUJJVVh4MIgEEF2
 jhjbCTGlc5njIHa4=
X-Received: by 2002:a2e:aa25:0:b0:2af:18a9:782f with SMTP id
 bf37-20020a2eaa25000000b002af18a9782fmr984721ljb.0.1684440193342; 
 Thu, 18 May 2023 13:03:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sAVzO241x4ZZ75PqO0aG2mMZjJ02PEeiGowoiNMhNKH3whsyvS5KwE7ndeh/tTvi9AGZGDw==
X-Received: by 2002:a2e:aa25:0:b0:2af:18a9:782f with SMTP id
 bf37-20020a2eaa25000000b002af18a9782fmr984715ljb.0.1684440192912; 
 Thu, 18 May 2023 13:03:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a2e361a000000b002ab397f1b0bsm457256lja.3.2023.05.18.13.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 13:03:12 -0700 (PDT)
Date: Thu, 18 May 2023 16:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Voetter <robin@streamhpc.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/1] pcie: Allow atomic completion on PCIE root port
Message-ID: <20230518160043-mutt-send-email-mst@kernel.org>
References: <20230420153839.167418-1-robin@streamhpc.com>
 <20230421042013-mutt-send-email-mst@kernel.org>
 <5330c419-bcdb-8577-4ed0-88a483f461e8@streamhpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5330c419-bcdb-8577-4ed0-88a483f461e8@streamhpc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Apr 21, 2023 at 06:06:49PM +0200, Robin Voetter wrote:
> 
> 
> On 4/21/23 10:22, Michael S. Tsirkin wrote:
> > On Thu, Apr 20, 2023 at 05:38:39PM +0200, robin@streamhpc.com wrote:
> >> From: Robin Voetter <robin@streamhpc.com>
> >>
> >> The ROCm driver for Linux uses PCIe atomics to schedule work and
> >> generally communicate between the host and the device.  This does not
> >> currently work in QEMU with regular vfio-pci passthrough, because the
> >> pcie-root-port does not advertise the PCIe atomic completer
> >> capabilities.  When initializing the GPU from the Linux driver, it
> >> queries whether the PCIe connection from the CPU to GPU supports the
> >> required capabilities[1] in the pci_enable_atomic_ops_to_root
> >> function[2].  Currently the only part where this fails is checking the
> >> atomic completer capabilities (32 and 64 bits) on the root port[3].  In
> >> this case, the driver determines that PCIe atomics are not supported at
> >> all, and this causes ROCm programs to misbehave.  (While AMD advertises
> >> that there is some support for ROCm without PCIe atomics, I have never
> >> actually gotten that working...)
> >>
> >> This patch allows ROCm to properly function by introducing an
> >> additional experimental property to the pcie-root-port,
> >> x-atomic-completion.
> > 
> > so what exactly makes it experimental? from this description
> > it looks like it actually has to be enabled for things to work?
> 
> I was not sure which would be appropriate, but I'm fine with making it a
> non-experimental option.

So I guess the real thing to do is to query this from vfio right?
Unfortunately we don't have access to vfio when we
are creating the root port, but I think the thing to do would
be to check at the time when vfio is attached, and if
atomic is set but not supported, fail attaching vfio.

Right?

-- 
MST


