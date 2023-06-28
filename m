Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7A740D87
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERmf-0002uW-5Z; Wed, 28 Jun 2023 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qERmc-0002tZ-JY
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:48:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qERma-0005FO-Eb
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XT1I1/d069RQZJVBhP5AW2FwHsbd1GfLkKHElEzynrM=; b=TBBbpignwkdU4q4/jRhWSMWDaN
 hki0tzsl21YnFXDaajfNRMFvZuMfS6SuUdb7688LjnpXkJG9OP3o73EtIUuBWi0jVBvkAWhdh1TMj
 b4x67oeGE1oGmWVmMfk4JW7UTAhEdqBcvom+oKZWiC1eYROAf0Mis9Humi0Y7Hf4KcbBc+D8FdJPr
 Tg0lab0OoyqtBjjf/TxzNcPE4DmkUWtY4L0caLAvuFE46qFYHqTi0NHsnEoK9Kllf1vmDyFMFOqTE
 MVdhAEQ6ylFnGHvu64Zw/W2V2CXgbgow6nVawc1vJ/1YW7hdnkEwI1ITUwMFie4sapi6Kvkafh8ht
 2eGND1rPIKglmfgnCdlqUApJZZxTa1eSTi4X1X6YCaThoJTaFcIQAW4dpLPQ/bZ4SmoesK5avk2NG
 2DGcFUvhspYMdVqiNSEnCyjDIgFVuzGDQ0byTibYlCx/fRXQg7TCpnh7to/mcCUK2qRho9sAXSAfG
 v9QOGCT61bTFK3/Th80T2bzP7n+3sPBiJmKuUe1IPipXKMlISnh0j1V01jFE7/kvvXvRWbLel88AG
 Dw2lPfuawM3jS7Em2KBxgIQUjhRSlBzk42PO634N2N6lStEYhtUPS87Ubb+zj0APvw6s+eTX2lcxJ
 QySVtrm601siHXyI3QyupW4NWzxPH+hPn3nPxMqMk=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qERmL-000CBS-Nb; Wed, 28 Jun 2023 10:48:02 +0100
Message-ID: <2646948c-13a8-3a12-00d2-ccdad4d519c3@ilande.co.uk>
Date: Wed, 28 Jun 2023 10:48:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230628071202.230991-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 28/06/2023 08:11, Richard Henderson wrote:

> Changes from v2:
>    * Patch 4 relaxes the checking on NPC:
>      (1) save_npc has just asserted that if the low 2 bits are non-zero,
>          then we have exactly one of our 3 special cases.
>      (2) The difference between DYNAMIC_PC_LOOKUP and DYNAMIC_PC within
>          NPC are not relevant to chaining, only those two values within PC.
>      Therefore simplify the test in sparc_tr_tb_stop.
> 
> 
> r~
> 
> 
> Richard Henderson (8):
>    target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
>    target/sparc: Fix npc comparison in sparc_tr_insn_start
>    target/sparc: Drop inline markers from translate.c
>    target/sparc: Introduce DYNAMIC_PC_LOOKUP
>    target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
>    target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
>    target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
>    target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI
> 
>   target/sparc/translate.c | 402 ++++++++++++++++++++++-----------------
>   1 file changed, 225 insertions(+), 177 deletions(-)

This fixes the issue seen with the real PROM and a run of my OpenBIOS boot tests 
shows all is still well, so I'll get this queued to qemu-sparc and send a PR shortly.


ATB,

Mark.


