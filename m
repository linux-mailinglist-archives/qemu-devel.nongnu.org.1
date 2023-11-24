Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000347F6E50
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 09:37:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Rg6-0002WI-Uu; Fri, 24 Nov 2023 03:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Rg5-0002Uq-NL; Fri, 24 Nov 2023 03:36:45 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org>)
 id 1r6Rfy-0000bw-KO; Fri, 24 Nov 2023 03:36:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sc7cg1Sf4z4wdB;
 Fri, 24 Nov 2023 19:36:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sc7cd46VNz4wd6;
 Fri, 24 Nov 2023 19:36:33 +1100 (AEDT)
Message-ID: <ff4eb381-4b9f-431f-ba79-68afa8c75859@kaod.org>
Date: Fri, 24 Nov 2023 09:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Add powernv10 I2C devices and tests
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZyQH=HF=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 11/21/23 20:09, Glenn Miles wrote:
> This series of patches includes support, tests and fixes for
> adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.
> 
> The PCA9552 device is used for PCIe slot hotplug power control
> and monitoring, while the PCA9554 device is used for presence
> detection of IBM CableCard devices.  Both devices are required
> by the Power Hypervisor Firmware on the Power10 Ranier platform.
> 
> Changes from previous version:
>    - Removed two already merged patches
>    - Various formatting changes
>    - Capitalized "Rainier" in machine description string
>    - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")


Nick,

could this series go through the ppc-next queue ?


Thanks,

C.




> 
> Glenn Miles (9):
>    misc/pca9552: Fix inverted input status
>    misc/pca9552: Let external devices set pca9552 inputs
>    ppc/pnv: New powernv10-rainier machine type
>    ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power
>      control
>    ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
>    ppc/pnv: Use resettable interface to reset child I2C buses
>    misc: Add a pca9554 GPIO device model
>    ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
>    ppc/pnv: Test pnv i2c master and connected devices
> 
>   MAINTAINERS                     |  10 +-
>   hw/misc/Kconfig                 |   4 +
>   hw/misc/meson.build             |   1 +
>   hw/misc/pca9552.c               |  58 ++-
>   hw/misc/pca9554.c               | 328 ++++++++++++++++
>   hw/ppc/Kconfig                  |   2 +
>   hw/ppc/pnv.c                    |  72 +++-
>   hw/ppc/pnv_i2c.c                |  15 +-
>   include/hw/misc/pca9552.h       |   3 +-
>   include/hw/misc/pca9554.h       |  36 ++
>   include/hw/misc/pca9554_regs.h  |  19 +
>   include/hw/ppc/pnv.h            |   1 +
>   tests/qtest/meson.build         |   1 +
>   tests/qtest/pca9552-test.c      |   6 +-
>   tests/qtest/pnv-host-i2c-test.c | 650 ++++++++++++++++++++++++++++++++
>   15 files changed, 1190 insertions(+), 16 deletions(-)
>   create mode 100644 hw/misc/pca9554.c
>   create mode 100644 include/hw/misc/pca9554.h
>   create mode 100644 include/hw/misc/pca9554_regs.h
>   create mode 100644 tests/qtest/pnv-host-i2c-test.c
> 


