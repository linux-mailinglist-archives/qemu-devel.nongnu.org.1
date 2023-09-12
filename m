Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FC79D17B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2yF-0007jS-V4; Tue, 12 Sep 2023 08:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qg2xs-0007cB-SH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qg2xq-0006nw-JO
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694523477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPd9Wfl5fvCMXasQWD1chaOZV+jMzOhEPXONl2XNEbo=;
 b=K4h0hlfU6pWUxm2vIUKYLHMmtiGyevsrjQsX+Bt3b1CZdXUfLMOCGxj6bsnIBCj2lCgkEx
 ZHENmGEkKo6XE43xgpnB0hjoc36/7tTg99IH4FhLgwJYXAHf78hVT9kBRYHz3xGSZzymwS
 f3vgduH45hl4hD7FP1jiFloNBo1f/L4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-StMKj0HUPiybQCJ7YpV0Ww-1; Tue, 12 Sep 2023 08:57:56 -0400
X-MC-Unique: StMKj0HUPiybQCJ7YpV0Ww-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7916aa85aa2so370969139f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694523475; x=1695128275;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPd9Wfl5fvCMXasQWD1chaOZV+jMzOhEPXONl2XNEbo=;
 b=b7QvFY0WoqB4OvnSsvNwuGwfNbOh+bGBDCsvBJzwHmm6C0xEoWFU+SfELyMaaguEhS
 NUJU6062GMFs+sVMD/gnU5tH0MFV3yNU2YbgdHFyiUTY5Yp4HfCIYLeM5J3wn6krV3b7
 QxkQ37gGbE1qPKTDM94pvDNMnBvg4cxR+2W7PWDSKnSJVZdw89JKHyrY54u63+JzaPXW
 BcR16s/NRVxUsx66J35oEeb0bbc/9HxAgrl7yDX+AD0tbbnxoNYiijbx8LJYkjuKftXq
 V2rD6Jg3BzFE9r+HqbMerSSd9zZn0OTY8CZC5iMlYa1+UO47n4CuSuBctmIVgkm2D2RT
 CyLg==
X-Gm-Message-State: AOJu0YwDTv3PIWU3hylFmSt9ZF6c7LskMeiGRo9iTBMAIQGakX0MxkYg
 S4BLRFRU+VvbBb2w8WPj5O98NWJiyDjM6d1dk/Wm90/XbXy05gRHq+FqlGxZ/ShBSd1vvcPn0w3
 EWBDBwqfkBdxyWGE=
X-Received: by 2002:a5d:8057:0:b0:792:4994:d1bf with SMTP id
 b23-20020a5d8057000000b007924994d1bfmr14202807ior.9.1694523475673; 
 Tue, 12 Sep 2023 05:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP44vmOoaQ6r78s9Tq1d3GFDm82IfZZb2ooZFxe8B+3njAjH0F56gwlQeN2u7YvfEBpwW3UQ==
X-Received: by 2002:a5d:8057:0:b0:792:4994:d1bf with SMTP id
 b23-20020a5d8057000000b007924994d1bfmr14202792ior.9.1694523475385; 
 Tue, 12 Sep 2023 05:57:55 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 w17-20020a029691000000b0042b3ad1656bsm2855765jai.45.2023.09.12.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 05:57:54 -0700 (PDT)
Date: Tue, 12 Sep 2023 06:57:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Shlomo Pongratz <shlomopongratz@gmail.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater <clg@redhat.com>, qemu-discuss <qemu-discuss@nongnu.org>, QEMU
 Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>
Subject: Re: Usage of vfio-pci without KVM.
Message-ID: <20230912065753.37de2393.alex.williamson@redhat.com>
In-Reply-To: <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
References: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
 <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 12 Sep 2023 14:47:41 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Cc'ing VFIO maintainers.
>=20
> On 12/9/23 14:39, Shlomo Pongratz wrote:
> > Hi,
> > I'm running qemu-system-aarch64 (QEMU emulator version 7.0.93) on
> > Ubuntu 20.04.4 LTS i with Intel's i7.
> > I'm trying to pass a Samsung NVME device using vfio-pci. I detached
> > the device from the nvme driver and attached it to the vfio-pci.
> > Using lspci I can see "Kernel driver in use: vfio-pci"
> > In QEMU script I've written "-device vfio-pci,host=3D0000:03:00.0" where
> > 0000:03:00.0 is the device PCI address.
> > I get the error
> > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: VFIO_MAP_DMA
> > failed: Invalid argument
> > qemu-system-aarch64: -device vfio-pci,host=3D0000:03:00.0: vfio
> > 0000:03:00.0: failed to setup container for group 15: memory listener
> > initialization failed: Region mach-virt.ram:
> > vfio_dma_map(0x55855c75bf00, 0x40000000, 0x100000000, 0x7f5197e00000)
> > =3D -22 (Invalid argument
> >=20
> > My question is vfio-pci is supported with cross architecture?

It does, but reserved address ranges need to be honored.  x86 has a
reserved range at 0xfee00000 for MSI mapping, so the VM address space
needs to be such that it avoids trying to place mappings there.  Thanks,

Alex


