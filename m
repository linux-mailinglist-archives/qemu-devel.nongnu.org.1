Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810EA72D67F
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 02:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8s4j-0004DZ-S5; Mon, 12 Jun 2023 20:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8s4h-0004DH-Me
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 20:39:55 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8s4c-00081P-V3
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 20:39:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51496f57e59so6871774a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 17:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686616789; x=1689208789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xUA+5kP0Jy7BxZAeLelLyV0nPtLhUdB9KgniWYyraxE=;
 b=QQtsNZy2h5GPAIWGbsKo2MXlvgKQFKELBZMSxuRtasATWPwKN2MRpGRyiwrm812Kjk
 44jgiMpJJuXDzdU/qS6y4zJkZ30iUJaFNdg+SM4h1mVI6gg5UVMJbngPoFrS/OVOG6t1
 6fpJCIrtAxCSJRo77Aou47iXWNfC6/GcBSvIu7qMz4UxgtXZKaVTCUkPZrBWrXvBFTAI
 hBVwV7NKXMilzhjrovpprEFINUa6p8UgY4M0pgQ9yb21ZzYgaGtpzEcB8E1LFVAWyCdR
 2R4RyDUEUmczTz2sMlaCD0L4m20OAhxe11WSoZb0ehY/07Sw2uOFhlNK4grW+pgR3ApV
 i5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686616789; x=1689208789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUA+5kP0Jy7BxZAeLelLyV0nPtLhUdB9KgniWYyraxE=;
 b=FK3P+iPRCDd9ai5ap1pkWFMDdMVbe1dy7KsBu+7DhyLZgmqgE0gogNYIuKn6vZsD4L
 /BzlDTKcXJZgjhvt3cOUqPtuxTopgja0QrTDuylY3g90E+f3rJ5SS0oDWZxJv/83F/+D
 lY9gwQ48Our98/rDlXl0uXFSPnqCgexLHc9S/aWyWhr8lronWzGv5bRAhaPzwOxsWI1t
 s5fVoPeRDRJc4vZQi/OePYP9b6F9ybk+GTVwNouqFjuJeAikQ2F/AjhSdoYnN8r/Y8YZ
 5L0yeVsYgKwHa+PqCFQn9EVhvTNfPD/KSH59eTTl8Ba0CYDKgeHUUgJQDLJBzdJ3rTOc
 JFeg==
X-Gm-Message-State: AC+VfDz4/wsfp5KSrBEYqyJ8Y43WuWdVZYt/WoP3dp+QOMaDXO8Km+OL
 mS0MVnL23dI6bWD7cxtMOjmUrRBPcV2xyBrtxxaZIfEq
X-Google-Smtp-Source: ACHHUZ4faerP9HRW5pUzvKnD4lH2zZZW6j7Lxr8ZEcrxMXQASkRXV+i+uhwWG6yZWWE1/WAv90p9bw==
X-Received: by 2002:aa7:d94e:0:b0:518:721e:f594 with SMTP id
 l14-20020aa7d94e000000b00518721ef594mr702272eds.37.1686616788918; 
 Mon, 12 Jun 2023 17:39:48 -0700 (PDT)
Received: from [10.61.102.56] ([46.189.28.77])
 by smtp.gmail.com with ESMTPSA id
 g16-20020aa7c590000000b0051056dc47e0sm5607411edq.8.2023.06.12.17.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 17:39:48 -0700 (PDT)
Message-ID: <f1e462f7-67bc-2a4d-72f9-a5a4641d05ce@daynix.com>
Date: Tue, 13 Jun 2023 02:39:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] elf2dmp: Don't abandon when Prcb is set to 0
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor@daynix.com>
References: <20230611033434.14659-1-akihiko.odaki@daynix.com>
 <260451686566561@lduixalyeduyxu6q.myt.yp-c.yandex.net>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <260451686566561@lduixalyeduyxu6q.myt.yp-c.yandex.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/06/12 12:42, Viktor Prutyanov wrote:
>> Prcb may be set to 0 for some CPUs if the dump was taken before they
>> start. The dump may still contain valuable information for started CPUs
>> so don't abandon conversion in such a case.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> contrib/elf2dmp/main.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>>
>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>> index d77b8f98f7..91c58e4424 100644
>> --- a/contrib/elf2dmp/main.c
>> +++ b/contrib/elf2dmp/main.c
>> @@ -312,6 +312,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
>> return 1;
>> }
>>
>> + if (!Prcb) {
>> + eprintf("Context for CPU #%d is missing\n", i);
>> + continue;
>> + }
>> +
>> if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
>> &Context, sizeof(Context), 0)) {
>> eprintf("Failed to read CPU #%d ContextFrame location\n", i);
>>
>> --
>> 2.40.1
> 
> Hi Akihiko,
> 
> How this fix can be tested?

It is a bit difficult to test it as you need to interrupt the very early 
stage of boot. I applied the following change to TCG so that it stops 
immediately after the first processor configures Prcb.

diff --git a/target/i386/tcg/sysemu/misc_helper.c 
b/target/i386/tcg/sysemu/misc_helper.c
index e1528b7f80..f68eba9cac 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -25,6 +25,9 @@
  #include "exec/address-spaces.h"
  #include "exec/exec-all.h"
  #include "tcg/helper-tcg.h"
+#include "exec/gdbstub.h"
+#include "hw/core/cpu.h"
+#include "sysemu/runstate.h"

  void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
  {
@@ -217,7 +220,10 @@ void helper_wrmsr(CPUX86State *env)
          env->segs[R_FS].base = val;
          break;
      case MSR_GSBASE:
+        printf("%s: %" PRIx64 "\n", __func__, val);
          env->segs[R_GS].base = val;
+        gdb_set_stop_cpu(current_cpu);
+        vm_stop(RUN_STATE_PAUSED);
          break;
      case MSR_KERNELGSBASE:
          env->kernelgsbase = val;

> 
> NumberProcessors field is still set to qemu_elf.state_nr, how does WinDbg react to this?

If Prcb for processor 1 is missing, WinDbg outputs: KiProcessorBlock[1] 
is null.
You can still debug the started processors with no issue.

Regards,
Akihiko Odaki

> 
> Viktor

