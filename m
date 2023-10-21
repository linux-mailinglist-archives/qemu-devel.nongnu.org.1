Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5A7D1B89
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 09:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu6XA-00023j-59; Sat, 21 Oct 2023 03:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qu6X7-00023O-AL; Sat, 21 Oct 2023 03:36:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qu6X5-0005LO-GG; Sat, 21 Oct 2023 03:36:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1BB832C30F;
 Sat, 21 Oct 2023 10:36:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0237330654;
 Sat, 21 Oct 2023 10:36:12 +0300 (MSK)
Message-ID: <63013dc8-2a5b-4bc1-9d6f-85bbfe7edd2c@tls.msk.ru>
Date: Sat, 21 Oct 2023 10:36:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sd/sdhci: Block Size Register bits [14:12] is lost
Content-Language: en-US
To: Lu Gao <lu.gao@verisilicon.com>, qemu-devel@nongnu.org
Cc: Jianxian Wen <jianxian.wen@verisilicon.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
References: <20230922020312.30828-1-lu.gao@verisilicon.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230922020312.30828-1-lu.gao@verisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

22.09.2023 05:03, Lu Gao:
> Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
> in register write, but it is needed in SDMA transfer. e.g. it will be
> used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.
> 
> Missing this field will cause wrong operation for different SDMA Buffer
> Boundary settings.
> 
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")

Is this change stable-worthy?  Not understanding the implications, so
have to ask :)

Thanks,

/mjt

