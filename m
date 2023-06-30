Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36F7442D7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFK24-0001t1-QD; Fri, 30 Jun 2023 15:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFK22-0001sr-LT
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:43:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFK21-0001fm-1u
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=odkRXlSgICw7DggbiqP+vAK1cE6XTBq+39k39qFH4wk=; b=yr/n61v5/DXvsILBR4PIJMZb1k
 snkCOjYJ0Yxkfe36tOgbf5AQ0c18cR4OJuvtpfxW0OF+OlRWGRoxuA/9gL5QLT9+uCVbvUzir3T1U
 mFiRfgw8jfUfDhLVcJXwBBjRFOOoAYFn5kJ0V5Zam/f5dkjDZ1kJv4mQ2IGxuapEJyropfN9xsA+A
 zZh8/VMjOk+W0KF2BCQEv0cdERaonuEeda2a7ujpgvhqmNrFDcs1TpuCCSAWxrIbXGoAukckmOsQC
 Ce6Rw4gAbQA5ANlSFQ3dUlcL9EOyZDWL76KUBdZUAF6I4ZUh9+VbQEGCYfDby5h84JErmM9HtQ0p+
 HQGuPfHOjyK0G8fUo8VxLwsHsPHuJI1FPi3aRVz/rT8NIqyWYlOdHCv6//xz5KKSsPJ343p++iBNq
 bX/rnIYfvrhv/gOqHlSMc0YSaMBor9kIrcuhIAIVpQSCelQaJWQ9Zf+ICM8m4/iy25aJW8R1bTmvz
 G1rX64VeGRSjxupJP4TTEaUUS+aKYRuEKcEu5AB5Piyizv9BgAQwYI4Oj8NHHhcsDD8pE8L1k3ss5
 Jg1WHIMj12c0GeNpWaFsyrJe+Hd/pNrGiJg2m+fmgzkI/vsKJ3lATiWoJw0N9VEwoayQ3S9qr2TPG
 RCtqJwbiBhjgkJ3VfOtHq6MbsPtrbFmbUa3O3EqHM=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFK1g-000B3f-K3; Fri, 30 Jun 2023 20:43:35 +0100
Message-ID: <0de296b5-e310-5119-65f0-30805b7ad19d@ilande.co.uk>
Date: Fri, 30 Jun 2023 20:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20230620164040.912490-1-richard.henderson@linaro.org>
 <2044463e-24eb-722e-9cc1-a5a90c3f7ea3@ilande.co.uk>
 <1266753f-b973-2600-f5f5-b9576bb53f98@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1266753f-b973-2600-f5f5-b9576bb53f98@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 30/06/2023 19:05, Richard Henderson wrote:

> On 6/22/23 16:36, Mark Cave-Ayland wrote:
>> On 20/06/2023 17:40, Richard Henderson wrote:
>>
>>> With the addition of TCG_GUEST_DEFAULT_MO, there's nothing in
>>> the cpu emulation preventing this from working.  There is some
>>> board model work to be done for sparc64, where max_cpus = 1.
>>
>> I've tried testing this with the Advent Calendar image at 
>> https://qemu-advent-calendar.org/2018/download/day11.tar.xz and even without these 
>> patches applied I'm seeing hangs with -smp 2. When applied on top of the other 
>> "target/sparc: Use tcg_gen_lookup_and_goto_ptr" series I get assert() after a 
>> minute or two:
> 
> Would you try again, now that we've solved the issues with lookup_and_goto_ptr?

The wording above is a bit clumsy on my part, but I was still seeing the hangs on git 
master with -smp 2, but with the older tcg_gen_lookup_and_goto_ptr series not only 
would I see the hangs but I would hit the assert() within a couple of minutes.

My notes on the wiki at https://wiki.qemu.org/Documentation/Platforms/SPARC#Timeline 
suggest that it was working on QEMU 6.2, so I'll need to find a moment to bisect it 
down to see where things broke.


ATB,

Mark.


