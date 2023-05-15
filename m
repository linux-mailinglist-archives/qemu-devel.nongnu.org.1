Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BF703287
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyapL-0007Cm-3F; Mon, 15 May 2023 12:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyapD-0007CR-QI; Mon, 15 May 2023 12:13:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pyapC-0003by-3H; Mon, 15 May 2023 12:13:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D68F6025;
 Mon, 15 May 2023 19:13:09 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19C6555AC;
 Mon, 15 May 2023 19:13:08 +0300 (MSK)
Message-ID: <810d20a1-4af7-ab16-0f38-a4b56dc27f97@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 19:13:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] hw/pvrdma: Protect against buggy or malicious guest
 driver
Content-Language: en-US
To: Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org,
 soulchen8650@gmail.com, secalert@redhat.com, mcascell@redhat.com,
 qemu-security@nongnu.org, marcel.apfelbaum@gmail.com,
 Laurent Vivier <laurent@vivier.eu>
References: <20230301142926.18686-1-yuval.shaia.ml@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230301142926.18686-1-yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
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

01.03.2023 17:29, Yuval Shaia wrote:
> Guest driver allocates and initialize page tables to be used as a ring
> of descriptors for CQ and async events.
> The page table that represents the ring, along with the number of pages
> in the page table is passed to the device.
> Currently our device supports only one page table for a ring.
> 
> Let's make sure that the number of page table entries the driver
> reports, do not exceeds the one page table size.
> 
> Reported-by: Soul Chen <soulchen8650@gmail.com>
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> ---
> v0 -> v1:
> 	* Take ring-state into account
> 	* Add Reported-by
> ---
>   hw/rdma/vmw/pvrdma_main.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)

Fixes: CVE-2023-1544

Ping ^2?
Laurent, maybe you can take this one too?
I understand the fact you picked up the previous one in this area
does not make you pvrdma maintainer, but it is definitely being stuck.. :)

/mjt

