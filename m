Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F2786FF1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:09:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZA4a-0005nJ-Td; Thu, 24 Aug 2023 09:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qZA4Q-0005l2-KI; Thu, 24 Aug 2023 09:08:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qZA4N-0000rf-1O; Thu, 24 Aug 2023 09:08:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 071161CA13;
 Thu, 24 Aug 2023 16:08:30 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3696921925;
 Thu, 24 Aug 2023 16:08:09 +0300 (MSK)
Message-ID: <c2eb17e2-0f8c-fee9-6203-413e9c07f977@tls.msk.ru>
Date: Thu, 24 Aug 2023 16:08:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 1/2] hw/nvme: fix null pointer access in directive receive
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <j.devantier@samsung.com>
References: <20230809133909.45818-4-its@irrelevant.dk>
 <20230809133909.45818-5-its@irrelevant.dk>
 <556b1036-fa1c-f207-6ce6-a9cf22805e6c@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <556b1036-fa1c-f207-6ce6-a9cf22805e6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -97
X-Spam_score: -9.8
X-Spam_bar: ---------
X-Spam_report: (-9.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

24.08.2023 15:44, Philippe Mathieu-Daudé wrote:
..
> This patch fixes CVE-2023-40360 ("QEMU: NVMe: NULL pointer
> dereference in nvme_directive_receive"). Were you aware of
> the security implications?
> 
> Too bad we hadn't committed "Fixes: CVE-2023-40360" as that
> would have helped downstream distributions cherry-picking
> security fixes ASAP, since our stable is not that frequent.

https://tracker.debian.org/news/1455443/accepted-qemu-1804dfsg-2-source-into-unstable/

FWIW.

/mjt

