Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1978A6CC
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:52:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaX1q-0006I2-Dy; Mon, 28 Aug 2023 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qaX1Z-0006Gw-FW
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qaX1T-0006vK-KR
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693209053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+IulFdLh/UZzWdmgJ3IY6iNTFVp22PU6qOD/YF8+Z8=;
 b=M++zzB1fZIFGD4gs8U0gMnX47qAYF/VQ+4SjgLl+T6xE4sPjobrodmCUrAezwViry9r0pf
 k/S3NTGCoTShI9ZM/jwqP/E3gqv/dzi7yGP4IpowZt0KA3DeC0/t1hPuZpowg6G5DFcrtJ
 mneCdVT1gotN76oqK5FIChK8uoNVUZU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-O2oeY66RNlSSOmlHh7qcJg-1; Mon, 28 Aug 2023 03:50:45 -0400
X-MC-Unique: O2oeY66RNlSSOmlHh7qcJg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500777449e5so3321930e87.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693209044; x=1693813844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+IulFdLh/UZzWdmgJ3IY6iNTFVp22PU6qOD/YF8+Z8=;
 b=YS/7FL07ThV7TGSpMKEzjsIx5C6aTOJRHIFxGfe/GFPgDhyUIbcrbYcI7qHhLgosOL
 jLD0KjZeIwrBQjO/WO7wN3MwTma2uF13+nhwj7xQwr1rUEsytDY13B3YA/zflawMFZIb
 6wB3fzdPobChaKnJ9ukMjWEth6C8Y3vWZ7pGVnzUouiTG8yKQeG40gLhkXmsRfssF4Tu
 VxlAJmOH5nlyTmzbZZrZw+VGHz2ADUACMilQYVqXmQyiRlOnaWp4+RLdYKJ3fC/Woca+
 W4rX6n2XEMp0OEenDuxiMPPtSBruUTwGxZQEg6za5yKoiUcx/dMDAt49jqTvpsNVyapO
 KG6Q==
X-Gm-Message-State: AOJu0Yw17x8A0ufoIIVt+RttplIHAtC+fOUGotO7hcP6bPSOHRRnpYNv
 sG/WOofJ42O3AD1KdWS97Ru/cgkgNA3fgpSXqmfVW67bpKYk0Kaw8k8QfHQNxCaLSC41CdjTDgk
 YFUrfJE5Vn96uRvGHMA7d+GmpFw9Kcok=
X-Received: by 2002:ac2:4c82:0:b0:4fd:d92e:31ca with SMTP id
 d2-20020ac24c82000000b004fdd92e31camr16674831lfl.36.1693209044121; 
 Mon, 28 Aug 2023 00:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsXZRzsra9/sZh0KEOTe9mrVGSpaLtVGHofgaGTy07T7Sxl4cvntbA6rYdhrwd7iDy722CAhzXretx704OwIw=
X-Received: by 2002:ac2:4c82:0:b0:4fd:d92e:31ca with SMTP id
 d2-20020ac24c82000000b004fdd92e31camr16674818lfl.36.1693209043768; Mon, 28
 Aug 2023 00:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230802081449.2528-1-avihaih@nvidia.com>
In-Reply-To: <20230802081449.2528-1-avihaih@nvidia.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Mon, 28 Aug 2023 15:50:32 +0800
Message-ID: <CAGYh1E89zRRO==Q1g5m+MfgyYjX3dv3D=T0VQCYe3cZ9V4H0tw@mail.gmail.com>
Subject: Re: [PATCH for-8.2 v3 0/6] vfio/migration: Add P2P support for VFIO
 migration
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Test result of multiple Mellanox CX-7 VFs migration:  PASS

[1] create two VFs and bind them to mlx5_vfio_pci driver
[2] start a VM with two VFs
[3] migrate the VM
[4] check if the VM works well

Tested-by: YangHang Liu <yanghliu@redhat.com>

Best Regards,
YangHang Liu
On Wed, Aug 2, 2023 at 4:16=E2=80=AFPM Avihai Horon <avihaih@nvidia.com> wr=
ote:
>
> Hi all,
>
> The first patch in this series adds a small optimization to VFIO
> migration by moving the STOP_COPY->STOP transition to
> vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed that
> this can reduce downtime by up to 6%.
>
> The rest of the series adds P2P support for VFIO migration.
>
> VFIO migration uAPI defines an optional intermediate P2P quiescent
> state. While in the P2P quiescent state, P2P DMA transactions cannot be
> initiated by the device, but the device can respond to incoming ones.
> Additionally, all outstanding P2P transactions are guaranteed to have
> been completed by the time the device enters this state.
>
> The purpose of this state is to support migration of multiple devices
> that might do P2P transactions between themselves.
>
> To implement P2P migration support, all the devices must be transitioned
> to the P2P quiescent state before being stopped or started.
>
> This behavior is achieved by adding an optional prepare callback to
> VMChangeStateEntry. These callbacks are invoked before the main VM state
> change callbacks, transitioning all the VFIO devices to the P2P state,
> and only then are the main callbacks invoked, which stop or start the
> devices.
>
> This will allow migration of multiple VFIO devices if all of them
> support P2P migration.
>
> Thanks.
>
> Changes from v2 [2]:
> * Registered VFIO prepare callback only if P2P migration is supported by
>   the device. (Cedric)
> * Added Cedric R-b tags to patches 2,3 and 6.
>
> Changes from v1 [1]:
> * Rebased on latest master branch.
> * Renamed pre_change_cb to prepare_cb and adjusted relevant code
>   accordingly. (Cedric)
> * Split VFIO vmstate change handler to two separate handlers, one for
>   prepare callback and another for main callback. (Cedric)
> * Renamed vfio_should_block_multiple_devices_migration() to
>   vfio_multiple_devices_migration_is_supported() and reverted its logic
>   accordingly. (Cedric)
> * Rephrased "that are doing P2P" to "that might do P2P" in docs and
>   commit message. (Jason)
> * Added Cedric R-b tag to patch #4.
>
> [1]
> https://lore.kernel.org/qemu-devel/20230716081541.27900-1-avihaih@nvidia.=
com/
>
> [2]
> https://lore.kernel.org/qemu-devel/20230731102521.15335-1-avihaih@nvidia.=
com/
>
> Avihai Horon (5):
>   vfio/migration: Move from STOP_COPY to STOP in vfio_save_cleanup()
>   sysemu: Add prepare callback to struct VMChangeStateEntry
>   qdev: Add qdev_add_vm_change_state_handler_full()
>   vfio/migration: Add P2P support for VFIO migration
>   vfio/migration: Allow migration of multiple P2P supporting devices
>
> Joao Martins (1):
>   vfio/migration: Refactor PRE_COPY and RUNNING state checks
>
>  docs/devel/vfio-migration.rst     | 93 +++++++++++++++++++------------
>  include/hw/vfio/vfio-common.h     |  2 +
>  include/sysemu/runstate.h         |  7 +++
>  hw/core/vm-change-state-handler.c | 14 ++++-
>  hw/vfio/common.c                  | 50 +++++++++++++----
>  hw/vfio/migration.c               | 75 ++++++++++++++++++++-----
>  softmmu/runstate.c                | 40 +++++++++++++
>  hw/vfio/trace-events              |  1 +
>  8 files changed, 218 insertions(+), 64 deletions(-)
>
> --
> 2.26.3
>
>


