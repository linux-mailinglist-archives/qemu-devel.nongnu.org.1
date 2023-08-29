Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E878C8E1
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:48:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0vE-0006p1-2C; Tue, 29 Aug 2023 11:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb0ux-0006mr-7m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:46:17 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qb0un-0004cW-Gt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:46:08 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4cbso1381985a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693323958; x=1693928758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kWbJdHMnSeKM00o8lDhxFIvWzq7KymiNDgl6PBpQHrU=;
 b=b7LP6KVaSnpHcdnFnMn6k5AhpU4DLZsgtLQx0K4oDEFoSkmURATiFqn2B243m69uId
 f8YfGn7T/yJigNyuJrMK2DUJ4+xVnYp5KtVOek/shp6iWXJeBp2S1KF8cvlwQCWlddKX
 MwpGtT7uHPNjHf0ZvoqoO0EnPjP+SE6bvx2g5beHMMYvDHGRhiymLXeydUBx7gJxlwMj
 fXiRUOxlt9FpNmbGbTrkWfa9YRHZDRxAFGrW8PlDNMxRBfE5mk1DEl1qtQX1j3fWkuKg
 zRd4sjfm2igMCpUJp4PhR4T6Xzt+jbov/trqq0Wl4GCGeKQJpWoekRRgJnJ/NQDqHzI4
 3pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323958; x=1693928758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kWbJdHMnSeKM00o8lDhxFIvWzq7KymiNDgl6PBpQHrU=;
 b=VLVBmf+368lI9v9R9cWem1c6l4f4fcxRTh0w0v56CT7aSA3LzHtG1ouafO3Jez9YK6
 /7er2JO6P5b+XRXaXKoSO32aOkMebGFjkkatvEN0FWnKN6Em65nNcRK3yRBkwmzq+ukU
 tpG2iFXas6Ajuz6La0DU6e+5qTmeCXCt3AheV5aYtS//v+YtvKyAqJ/4BwExiRvJUhFX
 M+BWYjwqSVMIern2ONh2EEi8TFDgsOHSoDFQTLVrRM7/W+EtleP4N5RXqWRHTwAkV0ey
 DXZkxPsjXj5r4hhiHwE1qlA4WITpGR85GVfe3BnC9CF7qQCvFBdWGjORX6UTiS4cPbng
 iIdg==
X-Gm-Message-State: AOJu0YxGJiDp296UvyZOqdE8IiUlFtVK8xIM3ZWtRmh9LZeNjDPm/VY9
 1IMF07OZO872zq1NP1QDkq8BvPhqfodpuMhEtxU=
X-Google-Smtp-Source: AGHT+IEPaefw+ndSxjrYSah7tlW1ZKuAxMfeLeiLuygXrqkHFkwFbjEQ4JPGTfdiHWPrRiWvomOsbA==
X-Received: by 2002:a17:907:7758:b0:9a1:ec3d:9004 with SMTP id
 kx24-20020a170907775800b009a1ec3d9004mr14603647ejc.9.1693323958420; 
 Tue, 29 Aug 2023 08:45:58 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 a20-20020a1709064a5400b00992b50fbbe9sm6082959ejv.90.2023.08.29.08.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 08:45:57 -0700 (PDT)
Message-ID: <20000658-5398-f4d7-0659-1abc248adb84@linaro.org>
Date: Tue, 29 Aug 2023 17:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/i386: raise FERR interrupt with iothread locked
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230829152604.101542-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829152604.101542-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29/8/23 17:25, Paolo Bonzini wrote:
> Otherwise tcg_handle_interrupt() triggers an assertion failure:
> 
>    #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
>    #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
>    #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
>    #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
>    #9  0x00007fffa42bde14 in code_gen_buffer ()
>    #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
> Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/fpu_helper.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sysemu/fpu_helper.c
> index 1c3610da3b9..fd8cc72a026 100644
> --- a/target/i386/tcg/sysemu/fpu_helper.c
> +++ b/target/i386/tcg/sysemu/fpu_helper.c
> @@ -31,7 +31,9 @@ void x86_register_ferr_irq(qemu_irq irq)
>   void fpu_check_raise_ferr_irq(CPUX86State *env)
>   {
>       if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
> +        qemu_mutex_lock_iothread();
>           qemu_irq_raise(ferr_irq);
> +        qemu_mutex_unlock_iothread();
>           return;
>       }
>   }

OK, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Maybe for completeness, squash this? :

-- >8 --
diff --git a/target/i386/tcg/sysemu/fpu_helper.c 
b/target/i386/tcg/sysemu/fpu_helper.c
index 1c3610da3b..320bd69f43 100644
--- a/target/i386/tcg/sysemu/fpu_helper.c
+++ b/target/i386/tcg/sysemu/fpu_helper.c
@@ -45,6 +45,8 @@ void cpu_clear_ignne(void)
  void cpu_set_ignne(void)
  {
      CPUX86State *env = &X86_CPU(first_cpu)->env;
+
+    g_assert(qemu_mutex_iothread_locked());
      env->hflags2 |= HF2_IGNNE_MASK;
      /*
---

Somehow similar pattern so what about MIPS MTC0?:

mtc0_compare() ->
   helper_mtc0_compare() ->
     cpu_mips_store_compare() ->
       qemu_irq_lower()

Regards,

Phil.

