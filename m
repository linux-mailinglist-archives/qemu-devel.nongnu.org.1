Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349CF798317
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVcl-0000lA-EB; Fri, 08 Sep 2023 03:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org>)
 id 1qeVcj-0000k8-Eh; Fri, 08 Sep 2023 03:09:49 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org>)
 id 1qeVcg-0001p3-8H; Fri, 08 Sep 2023 03:09:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RhnKr15hXz4xFR;
 Fri,  8 Sep 2023 17:09:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RhnKq0MsCz4xFS;
 Fri,  8 Sep 2023 17:09:34 +1000 (AEST)
Message-ID: <be868ef0-cbc3-a380-3307-512857e2a4a2@kaod.org>
Date: Fri, 8 Sep 2023 09:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/26] aspeed queue
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230901094214.296918-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230901094214.296918-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fJ+a=EY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/23 11:41, Cédric Le Goater wrote:
> The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:
> 
>    Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20230901
> 
> for you to fetch changes up to c3287c0f70dae07dd12322c5c8663f7b878826e7:
> 
>    hw/sd: Introduce a "sd-card" SPI variant model (2023-09-01 11:40:04 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Fixes for the Aspeed I2C model
> * New SDK image for avocado tests
> * blockdev support for flash device definition
> * SD refactoring preparing ground for eMMC support
> 
> ----------------------------------------------------------------
> Cédric Le Goater (10):
>        aspeed: Introduce helper for 32-bit hosts limitation
>        tests/avocado/machine_aspeed.py: Update SDK images
>        hw/ssi: Add a "cs" property to SSIPeripheral
>        hw/ssi: Introduce a ssi_get_cs() helper
>        aspeed/smc: Wire CS lines at reset
>        hw/ssi: Check for duplicate CS indexes
>        aspeed: Create flash devices only when defaults are enabled
>        m25p80: Introduce an helper to retrieve the BlockBackend of a device
>        aspeed: Get the BlockBackend of FMC0 from the flash device
>        hw/sd: Introduce a "sd-card" SPI variant model
> 
> Hang Yu (3):
>        hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
>        hw/i2c/aspeed: Fix TXBUF transmission start position error

Michael,

I think the two above are candidates for stable.

Thanks,

C.


>        hw/i2c/aspeed: Add support for buffer organization
> 
> Joel Stanley (1):
>        hw/sd: Add sd_cmd_SEND_TUNING_BLOCK() handler
> 
> Philippe Mathieu-Daudé (12):
>        hw/sd/sdcard: Return ILLEGAL for CMD19/CMD23 prior SD spec v3.01
>        hw/sd: When card is in wrong state, log which state it is
>        hw/sd: When card is in wrong state, log which spec version is used
>        hw/sd: Move proto_name to SDProto structure
>        hw/sd: Introduce sd_cmd_handler type
>        hw/sd: Add sd_cmd_illegal() handler
>        hw/sd: Add sd_cmd_unimplemented() handler
>        hw/sd: Add sd_cmd_GO_IDLE_STATE() handler
>        hw/sd: Add sd_cmd_SEND_OP_CMD() handler
>        hw/sd: Add sd_cmd_ALL_SEND_CID() handler
>        hw/sd: Add sd_cmd_SEND_RELATIVE_ADDR() handler
>        hw/sd: Add sd_cmd_SET_BLOCK_COUNT() handler
> 
>   docs/system/arm/aspeed.rst          |  35 +++-
>   include/hw/block/flash.h            |   4 +
>   include/hw/i2c/aspeed_i2c.h         |   5 +-
>   include/hw/sd/sd.h                  |   5 +
>   include/hw/ssi/ssi.h                |   5 +
>   hw/arm/aspeed.c                     |  40 ++---
>   hw/arm/stellaris.c                  |   7 +-
>   hw/arm/xilinx_zynq.c                |   1 +
>   hw/arm/xlnx-versal-virt.c           |   1 +
>   hw/arm/xlnx-zcu102.c                |   2 +
>   hw/block/m25p80.c                   |   6 +
>   hw/i2c/aspeed_i2c.c                 |  40 ++---
>   hw/microblaze/petalogix_ml605_mmu.c |   1 +
>   hw/riscv/sifive_u.c                 |   3 +-
>   hw/sd/sd.c                          | 348 ++++++++++++++++++++++--------------
>   hw/sd/sdmmc-internal.c              |   2 +-
>   hw/ssi/aspeed_smc.c                 |   8 +
>   hw/ssi/ssi.c                        |  43 +++++
>   tests/avocado/machine_aspeed.py     |  12 +-
>   19 files changed, 367 insertions(+), 201 deletions(-)


