Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3373F8DD
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE595-0001SK-5q; Tue, 27 Jun 2023 05:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE593-0001SB-Hk
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:37:57 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE591-0000K4-AQ
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:37:57 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso636677166b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687858673; x=1690450673;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hCSAZ+1OhhMKHOWP/hM/AzADgVC7TK7L8NA+nqnAj08=;
 b=FuNMie6Hpx6OeQJz+mGlHKVKFHdY99xjhH/ssqwKDOoQ/s/CwQlaGZHbhubgfg1s2f
 PzIY2B9IwssvV5qkUZYnxks0R4R6N69+TdVSi9luSRfJlTyC7qAb4e6MRCrl6yOIK7mi
 txcJDI/R7awKQoZjyIJNF/T4LM/2jjzH9piBECu21QXOpZbbRQ/n+1rekvKoYTFEm8on
 aY/UecwtvojSYL4+VGKl9AJ8xcquw1TCyRbONbcv4Tlfh8fsQiFlO2FWwpuXWDA+MgZm
 ZNSaQI+Chi265Kum1gQmW2pO5PwJZZeYYEgwkkJR0MgZsh6kOa/4HLlUKBgBz8806kAq
 gM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687858673; x=1690450673;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hCSAZ+1OhhMKHOWP/hM/AzADgVC7TK7L8NA+nqnAj08=;
 b=XFdK6q/ctBRjXsjwygHMZkiWEsTfm+fO70SfNJDV75ACzhiSVM723+zC+jDlQPdYRg
 Q/uBy79mvRMXZKbl8LmqcxWK63bgRJLdLaklcEDK0BUNY4aGwyfRb5w+LKeqAbHISHnq
 mXlIL5ik8r4p3soU/phRyGqko/6x11UOSyS7dC3jM/cxZ3Vxob+6Bbn0ZXr9bNokZffT
 zN48imBW9rtfKdDm1tc5IbBq4Kq8vOTbPCpY+YdIQwIx5a0kIdaYar5xmLP/bcnca3SD
 USI0XSUpYv2hf4uKin/EN+eC8ndnB+BNRy5YxXpcpqUb6CqXcPKTjiYMrpQMZbtrkoiB
 GlHg==
X-Gm-Message-State: AC+VfDwo1tCdQA8qcpnbfYrTBEvt+42nowG1316XDzDNF2+SeX3nb0gK
 C1Kz4mCpp/IrAnM4oG7rSjbc0A==
X-Google-Smtp-Source: ACHHUZ4rykFdxwgS0nQuieUqCrUqRpohKrKTtcUQyU4IYhYTiSYtS82u02giFJ7+EgUtbEwmjcAe5A==
X-Received: by 2002:a17:907:271c:b0:992:872:76d4 with SMTP id
 w28-20020a170907271c00b00992087276d4mr1401807ejk.17.1687858673540; 
 Tue, 27 Jun 2023 02:37:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a170906249300b0098e4aef0791sm2858598ejb.66.2023.06.27.02.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:37:53 -0700 (PDT)
Message-ID: <35013658-5131-19f6-c95a-c74b73f90ecc@linaro.org>
Date: Tue, 27 Jun 2023 11:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <2f11ee14-9bf2-85fe-581c-e3024efd2124@ilande.co.uk>
 <c83c2500-08d1-bb03-24d6-990a2f07b01b@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c83c2500-08d1-bb03-24d6-990a2f07b01b@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 27/6/23 08:46, Mark Cave-Ayland wrote:
> On 22/06/2023 13:26, Mark Cave-Ayland wrote:
> 
>> On 21/06/2023 19:05, Richard Henderson wrote:
>>
>>> Changes from v1:
>>>    * Split into teeny weeny pieces.
>>>
>>>    * It turns out the sparc_tr_tb_stop hunk of v1 was buggy,
>>>      in that things that are not simple branches use DYNAMIC_PC,
>>>      e.g. the RETT (return from trap) instruction.
>>>
>>>      Introduce DYNAMIC_PC_LOOKUP to distinguish the couple of
>>>      places where we have a dynamic pc, but no other change
>>>      of state (conditional branches, JMPL, RETURN).
>>>
>>>    * Drop the change for WRFPRS, because it's too infrequent.
>>>      The WRASI change affects memcpy/memset, so that's more important.
>>>
>>> Boots Mark's sol8 install cdrom.  :-)
>>>
>>> Top of the profile changes from
>>>
>>>      41.55%  qemu-system-sparc              [.] cpu_exec_loop
>>>      14.02%  qemu-system-sparc              [.] cpu_tb_exec
>>>       8.74%  qemu-system-sparc              [.] tb_lookup
>>>       2.11%  qemu-system-sparc              [.] tcg_splitwx_to_rw
>>>       1.63%  memfd:tcg-jit (deleted)        [.] 0x0000000000000004
>>>
>>> to
>>>
>>>      31.59%  qemu-system-sparc              [.] helper_lookup_tb_ptr
>>>      17.79%  qemu-system-sparc              [.] tb_lookup
>>>       5.38%  qemu-system-sparc              [.] compute_all_sub
>>>       2.38%  qemu-system-sparc              [.] helper_compute_psr
>>>       2.36%  qemu-system-sparc              [.] helper_check_align
>>>       1.79%  memfd:tcg-jit (deleted)        [.] 0x000000000063fc8e
>>>
>>> This probably indicates that cpu_get_tb_cpu_state could be
>>> improved to not consume so much overhead.
>>
>> Nice! I've just run this through all of my sun4m/sun4u/sun4v test 
>> images and I don't see any regressions with v2. The guests feel 
>> noticeably more responsive too :)
>>
>> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> I've skimmed the patches and without looking in too much detail they 
>> seem to be okay so I'm happy to give:
>>
>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Side note: the niagara tests require the patch at 
>> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03537.html 
>> which still hasn't been merged yet.
>>
>>> Richard Henderson (8):
>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
>>>    target/sparc: Fix npc comparison in sparc_tr_insn_start
>>>    target/sparc: Drop inline markers from translate.c
>>>    target/sparc: Introduce DYNAMIC_PC_LOOKUP
>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
>>>    target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
>>>    target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI
>>>
>>>   target/sparc/translate.c | 410 ++++++++++++++++++++++-----------------
>>>   1 file changed, 233 insertions(+), 177 deletions(-)
> 
> I've just noticed during testing there is an issue with this series when 
> used with a real SS-5 PROM image (I was using OpenBIOS for my previous 
> tests) which causes it to assert() almost immediately on startup:
> 
> $ ./qemu-system-sparc -bios ss5.bin
> ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code should not 
> be reached
> Bail out! ERROR:../target/sparc/translate.c:5695:sparc_tr_tb_stop: code 
> should not be reached
> Aborted

Could you try this fix:

-- >8 --
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5682,5 +5682,5 @@ static void sparc_tr_tb_stop(DisasContextBase 
*dcbase, CPUState *cs)

          save_npc(dc);
-        switch (dc->npc) {
+        switch (dc->npc & 3) {
          case DYNAMIC_PC_LOOKUP:
              if (may_lookup) {
---

?

