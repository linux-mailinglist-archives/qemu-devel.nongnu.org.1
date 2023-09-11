Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5179AB26
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 22:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfnAJ-00085R-3g; Mon, 11 Sep 2023 16:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfnAD-000847-PT
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:05:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qfnAA-0001CI-1c
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 16:05:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48E8A20E49;
 Mon, 11 Sep 2023 23:05:36 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6C61E2754D;
 Mon, 11 Sep 2023 23:05:33 +0300 (MSK)
Message-ID: <43052340-5f2e-abd9-6624-b3108ae9ecf3@tls.msk.ru>
Date: Mon, 11 Sep 2023 23:05:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL v2 42/45] target/riscv: Allocate itrigger timers only once
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-43-alistair.francis@wdc.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230911064320.939791-43-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

11.09.2023 09:43, Alistair Francis пишет:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> riscv_trigger_init() had been called on reset events that can happen
> several times for a CPU and it allocated timers for itrigger. If old
> timers were present, they were simply overwritten by the new timers,
> resulting in a memory leak.
> 
> Divide riscv_trigger_init() into two functions, namely
> riscv_trigger_realize() and riscv_trigger_reset() and call them in
> appropriate timing. The timer allocation will happen only once for a
> CPU in riscv_trigger_realize().
> 
> Fixes: 5a4ae64cac ("target/riscv: Add itrigger support when icount is enabled")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20230818034059.9146-1-akihiko.odaki@daynix.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

This smells like one more change from this series which should be
picked up for stable-8.1.  Picking this one up, please let me know
if I shuldn't.

Thanks,

/mjt

