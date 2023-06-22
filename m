Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C073A32F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLQa-000606-J4; Thu, 22 Jun 2023 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qCLQY-0005zP-J0
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:36:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qCLQW-000806-UQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v8fgw6ZtNr8W4WxhKEsSjvR80rsltbNMck88qEvkSzE=; b=qceCzuDkT4XfWEgQFAxuc1DVj8
 udBVtVpy/hpTTmB2hfeXnhPHb8eYRV8ZQcsr1EobcrKDLoQw6MqBpZZGF0/Ck9MEVWYnS9/yuv9YT
 cUngmKL8FLDZOy/YnzdiajeIgns8IburaObdDPzTmW/Y3/r5239mBzU/jhpGnEs1JCRFvNSCDNdb9
 cIAwIzWO4FKc/CVmy+hnabgfyRVqM2w/i24KFXSQflNSaJysRmqZNGrXGaN4ex8CXOAF0yUHW8euo
 OCy7q6TaAixqrjcQUH4R+WLKNBEkX+vuTMV4POTBmoAtl73bqw0vTWG0dZIE5fJHFhR/6aWiZ3DuN
 bV3ifg1yZB/OfphLwfum12waSKopx/LMy50mo+ljrsK9b6ROeYBJ33/X4h4A5SP5r38nWtDHr+PpQ
 beIum7qP4PtgqEKCPzK+uGgcAMgqJW37NEYvcSgrp88TmE2QXRbOm45/ajPKdTwE+bwNSAVS3jyga
 3myDU7S13+vWjR10t/BhJE5wJxvDpY9+od93dchYQ/5ku3EOcs9l7ulZIFHJkI/zzXUTDbGjCyA3S
 JeVWB8n8Mk59bKSuGXhX+FloO+aOZj+Q6jNpuJIQNUcZ4sEW5YupCTr+WwB/DFZf+wJUPxvD8jFEE
 57LNbIdvijgeNXn5+7B+mBWe+2R6bkpi2LV34/n0Y=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qCLQJ-000BeX-Ed; Thu, 22 Jun 2023 15:36:39 +0100
Message-ID: <2044463e-24eb-722e-9cc1-a5a90c3f7ea3@ilande.co.uk>
Date: Thu, 22 Jun 2023 15:36:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20230620164040.912490-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230620164040.912490-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/2] target/sparc: Enable MTTCG
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20/06/2023 17:40, Richard Henderson wrote:

> With the addition of TCG_GUEST_DEFAULT_MO, there's nothing in
> the cpu emulation preventing this from working.  There is some
> board model work to be done for sparc64, where max_cpus = 1.

I've tried testing this with the Advent Calendar image at 
https://qemu-advent-calendar.org/2018/download/day11.tar.xz and even without these 
patches applied I'm seeing hangs with -smp 2. When applied on top of the other 
"target/sparc: Use tcg_gen_lookup_and_goto_ptr" series I get assert() after a minute 
or two:

ERROR:../accel/tcg/tcg-accel-ops-mttcg.c:110:mttcg_cpu_thread_fn: assertion failed: 
(cpu->halted)
Bail out! ERROR:../accel/tcg/tcg-accel-ops-mttcg.c:110:mttcg_cpu_thread_fn: assertion 
failed: (cpu->halted)

It may be wise to try and figure out what's going on with git head first before 
applying this. In particular /proc/cpuinfo suggests things aren't right with -smp 2:

# cat /proc/cpuinfo
cpu             : Texas Instruments, Inc. - SuperSparc-(II)
fpu             : SuperSparc on-chip FPU
promlib         : Version 3 Revision 2
prom            : 2.25
type            : sun4m
ncpus probed    : 2
ncpus active    : 1
CPU0Bogo        : 213.50
CPU0ClkTck      : 0
MMU type        : TI Viking/MXCC
contexts        : 65536
nocache total   : 3145728
nocache used    : 375552

> Richard Henderson (2):
>    target/sparc: Set TCG_GUEST_DEFAULT_MO
>    configs: Enable MTTCG for sparc, sparc64
> 
>   configs/targets/sparc-softmmu.mak   |  1 +
>   configs/targets/sparc64-softmmu.mak |  1 +
>   target/sparc/cpu.h                  | 23 +++++++++++++++++++++++
>   3 files changed, 25 insertions(+)


ATB,

Mark.


