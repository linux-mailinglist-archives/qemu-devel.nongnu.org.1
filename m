Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA977380B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTFpp-0004aJ-0B; Tue, 08 Aug 2023 02:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTFpm-0004Zs-8V
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:04:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTFpk-0001D3-BH
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 02:04:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EBFE18D5B;
 Tue,  8 Aug 2023 09:04:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6DF981C27E;
 Tue,  8 Aug 2023 09:04:40 +0300 (MSK)
Message-ID: <165b8dea-9afb-3aeb-7551-9ecacb225fb0@tls.msk.ru>
Date: Tue, 8 Aug 2023 09:04:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/3] hw/nvme: bug fixes and doc update
Content-Language: en-US
To: Ankit Kumar <ankit.kumar@samsung.com>, kbusch@kernel.org, its@irrelevant.dk
Cc: qemu-devel@nongnu.org
References: <CGME20230807160836epcas5p34398954fecd7388469012404b09b78f9@epcas5p3.samsung.com>
 <20230807212745.70151-1-ankit.kumar@samsung.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230807212745.70151-1-ankit.kumar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

08.08.2023 00:27, Ankit Kumar wrote:
> This series fixes two bugs
> 1. CRC64 generation when metadata buffer is used.
> 2. Protection information disable check for Type 3 protection.
> 
> This series also updates the documentaion for pi (protection information),
> and adds missing pif (protection information format) entry.
> 
> Ankit Kumar (3):
>    hw/nvme: fix CRC64 for guard tag
>    hw/nvme: fix disable pi checks for Type 3 protection
>    docs: update hw/nvme documentation for protection information

At least the CRC64 change smells like a -stable material, - the bug
is present in, for example, qemu-7.2 too. But I don't know how important
it is to keep nvme updated in 8.0 or before, and what the outcome of this
bug is, to begin with. Somehow I think nvme was in preliminary shape
before 8.0.

Are the other changes also relevant for -stable?

Please keep Cc: qemu-stable@nongnu.org for anything you think is worth
to have in previous/stable releases.

Thanks,

/mjt

