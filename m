Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269677FF476
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:14:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jey-0005JR-Ul; Thu, 30 Nov 2023 11:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r8jew-0005Im-OL
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r8jev-0003mA-1O
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701360778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxkAbcD+QZ+lUPEt/bYoZphhQA5DUXqdFu18EF1pDQA=;
 b=HwDKp+pxa0ul6cARKMnLSv39ftGCMQFb2z9kbleArTBqrlPVTquvLdsLQlH+F2AvHDm9Nm
 3PmNdJBf9LI9Z03gsto7WLeyjIjHqmfBlhglqTwY4LpM4YnEI3UCMPxTMMBC1zc271ZkK8
 9uROp9hW+iAoXxWD1/wFq4kgKyfk2SA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-RgLcYhs3NceE_9CNKItDVg-1; Thu, 30 Nov 2023 11:12:57 -0500
X-MC-Unique: RgLcYhs3NceE_9CNKItDVg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-332e82bb756so808853f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701360776; x=1701965576;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxkAbcD+QZ+lUPEt/bYoZphhQA5DUXqdFu18EF1pDQA=;
 b=QBKVC8QP6uy7DdJqx+22eLPmvPteDRUO5Qx/yuOEfokKtoYkoVckhxsWXJDFlZD7YS
 ZD1FTsTAoA397kmgxdrUIdjrpnj/4Fzz524MzbzUC4QW0pi+yHiO5cTnlqXjxoQTBmsJ
 1DfdOyVm/Jf8yR7OQZcFBFSsrBMIWYbs6NUh4v8hyraE8IHrN9bzeLW4VV3Ef8a8nR21
 vIxVawacFXZaBfUNmLKBXHdgqcv4fA/CLkoi/lWXevlAlJZZRw5IJ7J+ElDW44J4Z1Xx
 bKryDLKWBwFD6s53E6gmCT9oVvnt4VQiRnzdvfyec2YJEruUq0gXx8NQpmayEGYRZ1AA
 yZVQ==
X-Gm-Message-State: AOJu0Yx6netGpuMnAZPGgKgRfkS62kHyf22bGyzBvUtMRh317ffFeZH1
 vJL70eZ4SV1fY8/ksmO02mijtYrv6o2UhC5UaMKDqHMZE2WBlNZoqW8f7NNOooqjRbm2DbnssNO
 eskBsf55j0vck1NQ=
X-Received: by 2002:a5d:570a:0:b0:333:2ec2:6717 with SMTP id
 a10-20020a5d570a000000b003332ec26717mr309166wrv.34.1701360776050; 
 Thu, 30 Nov 2023 08:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFukir5HaUvHCqs4u162MWYxXpDMoJ3PRYRH67RJ7zyY2xcQx6V7CNOIkMijxxh+950HS8VLA==
X-Received: by 2002:a5d:570a:0:b0:333:2ec2:6717 with SMTP id
 a10-20020a5d570a000000b003332ec26717mr309151wrv.34.1701360775754; 
 Thu, 30 Nov 2023 08:12:55 -0800 (PST)
Received: from redhat.com ([109.253.210.168]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b0040b561924bbsm4155410wmo.21.2023.11.30.08.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 08:12:55 -0800 (PST)
Date: Thu, 30 Nov 2023 11:12:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: YangHang Liu <yanghliu@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] pcie_sriov: Remove g_new assertion
Message-ID: <20231130111211-mutt-send-email-mst@kernel.org>
References: <20231123075630.12057-1-akihiko.odaki@daynix.com>
 <53966853-640a-4581-a08d-8b452afc4c2a@redhat.com>
 <CAGYh1E-4fiF+Y0JBKPRwJNbuJzdJuWnR6yA-eNLBjW9++xov3w@mail.gmail.com>
 <1d43153f-215a-4e2f-810f-553e4192c27f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d43153f-215a-4e2f-810f-553e4192c27f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Thu, Nov 30, 2023 at 04:37:43PM +0100, Cédric Le Goater wrote:
> On 11/30/23 10:52, YangHang Liu wrote:
> > After applying this patch, the VM with a igbvf will not crash during reboot.
> > 
> > Tested-by: Yanghang Liu<yanghliu@redhat.com <mailto:yanghliu@redhat.com>>
> 
> Michael, do you have plans to send a PR for -rc3 ?
> 
> Thanks,
> 
> C.


Yes.

> 
> 
> > 
> > On Mon, Nov 27, 2023 at 5:12 PM Cédric Le Goater <clg@redhat.com <mailto:clg@redhat.com>> wrote:
> > 
> >     On 11/23/23 08:56, Akihiko Odaki wrote:
> >      > g_new() aborts if the allocation fails so it returns NULL only if the
> >      > requested allocation size is zero. register_vfs() makes such an
> >      > allocation if NumVFs is zero so it should not assert that g_new()
> >      > returns a non-NULL value.
> >      >
> >      > Fixes: 7c0fa8dff8 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
> >      > Buglink: https://issues.redhat.com/browse/RHEL-17209 <https://issues.redhat.com/browse/RHEL-17209>
> >      > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>>
> > 
> > 
> >     Reviewed-by: Cédric Le Goater <clg@redhat.com <mailto:clg@redhat.com>>
> > 
> >     Thanks,
> > 
> >     C.
> > 
> > 
> >      > ---
> >      >   hw/pci/pcie_sriov.c | 1 -
> >      >   1 file changed, 1 deletion(-)
> >      >
> >      > diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> >      > index 5ef8950940..a1fe65f5d8 100644
> >      > --- a/hw/pci/pcie_sriov.c
> >      > +++ b/hw/pci/pcie_sriov.c
> >      > @@ -178,7 +178,6 @@ static void register_vfs(PCIDevice *dev)
> >      >       num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
> >      >
> >      >       dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
> >      > -    assert(dev->exp.sriov_pf.vf);
> >      >
> >      >       trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
> >      >                                PCI_FUNC(dev->devfn), num_vfs);
> > 
> > 


