Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 798397EBFEA
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:04:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Cjy-0007Kv-Cq; Wed, 15 Nov 2023 05:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3Cjw-0007Kf-2a; Wed, 15 Nov 2023 05:03:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=a0ac=G4=kaod.org=clg@ozlabs.org>)
 id 1r3Cju-0006Vf-69; Wed, 15 Nov 2023 05:03:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SVdyn1Rl4z4wcM;
 Wed, 15 Nov 2023 21:03:13 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SVdyl2w8Jz4wdD;
 Wed, 15 Nov 2023 21:03:10 +1100 (AEDT)
Message-ID: <a6674a60-55fa-4c78-aa4a-bb77d196175a@kaod.org>
Date: Wed, 15 Nov 2023 11:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Add powernv10 I2C devices and tests
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=a0ac=G4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Nick,

On 11/14/23 20:56, Glenn Miles wrote:
> This series of patches includes support, tests and fixes for
> adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.
> 
> The PCA9552 device is used for PCIe slot hotplug power control
> and monitoring, while the PCA9554 device is used for presence
> detection of IBM CableCard devices.  Both devices are required
> by the Power Hypervisor Firmware on Power10 platforms.
> 
> Changes from previous version:
>    - Added Fixes: tag to commits 3 and 4

Are you preparing a QEMU 8.2 PR for fixes ?

Thanks,

C.



>    - Fixed formatting errors in commits 2 and 8
> 
> Glenn Miles (8):
>    ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug power control
>    ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
>    ppc/pnv: PNV I2C engines assigned incorrect XSCOM addresses
>    ppc/pnv: Fix PNV I2C invalid status after reset
>    ppc/pnv: Use resettable interface to reset child I2C buses
>    misc: Add a pca9554 GPIO device model
>    ppc/pnv: Add a pca9554 I2C device to powernv10
>    ppc/pnv: Test pnv i2c master and connected devices
> 
>   MAINTAINERS                     |   2 +
>   hw/misc/Kconfig                 |   4 +
>   hw/misc/meson.build             |   1 +
>   hw/misc/pca9554.c               | 328 ++++++++++++++++
>   hw/ppc/Kconfig                  |   2 +
>   hw/ppc/pnv.c                    |  35 +-
>   hw/ppc/pnv_i2c.c                |  47 ++-
>   include/hw/misc/pca9554.h       |  36 ++
>   include/hw/misc/pca9554_regs.h  |  19 +
>   tests/qtest/meson.build         |   1 +
>   tests/qtest/pnv-host-i2c-test.c | 650 ++++++++++++++++++++++++++++++++
>   11 files changed, 1103 insertions(+), 22 deletions(-)
>   create mode 100644 hw/misc/pca9554.c
>   create mode 100644 include/hw/misc/pca9554.h
>   create mode 100644 include/hw/misc/pca9554_regs.h
>   create mode 100644 tests/qtest/pnv-host-i2c-test.c
> 


