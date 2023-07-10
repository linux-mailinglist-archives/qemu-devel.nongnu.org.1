Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82A74D91F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIs07-00005d-Lx; Mon, 10 Jul 2023 10:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qIrzx-00005I-RQ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:36:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qIrzv-0007bs-Mc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:36:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD1F212C69;
 Mon, 10 Jul 2023 17:36:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5978113DB8;
 Mon, 10 Jul 2023 17:36:07 +0300 (MSK)
Message-ID: <4d05ddfe-0e80-bd9e-e0c8-38d6195c9a8a@tls.msk.ru>
Date: Mon, 10 Jul 2023 17:36:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 07/11] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
References: <20230710074848.456453-1-clg@redhat.com>
 <20230710074848.456453-8-clg@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230710074848.456453-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

10.07.2023 10:48, Cédric Le Goater пишет:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> vfio_realize() has the following flow:
> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
> 2. msix_early_setup().
> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
> 
> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
> allocated.
> 
> In this case, vfio_bars_finalize() is called as part of the error flow
> to free the bars' resources. However, vfio_bars_finalize() calls
> object_unparent() for VFIOBAR->mr after checking only VFIOBAR->size, and
> thus we get a null pointer dereference.
> 
> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
> 
> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

It looks like it's a -stable material too. Queued this one.
If it shouldn't go to stable, please let me know.

Thanks,

/mjt

