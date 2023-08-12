Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4D77A171
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 19:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUsUI-0004fS-HS; Sat, 12 Aug 2023 13:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUsUG-0004f1-Qc
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 13:33:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUsUF-0007sE-87
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 13:33:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso20924655ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691861593; x=1692466393;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2YXgfMDrYPzIYbCrlFGkfAndljXKF00LrYlHbIPl8E=;
 b=TrAyIJoU5bY7OGtgxdvqtrypJ5KKuzr+jPELwPkUSu/NRGaGcarvwl5tdJZOEPxgNN
 /g172ObWvX2ekoOWpJ5oRJ+MveWcRlzpdemh4D1IfnCUIqvlgyoiN6QeGdmNa9LDwiFx
 e1Gl6NtDr66lSrj4pbtyUmhy8xjSIqO7HTK4p2WVeHYhEuW2wze16yWZJW5gRtiPV9s4
 /6AMgXBY0FycvkFVkBKEgMEoUNox8oRZEBe359kXVq8hq+nplo3NDO1v9zEZMXEXRCe9
 Ax1NLKv+kHcm2hUr3xezbjFo+hD6d849VcIlNjPBkX4K28AZLZXWnjf6tiLh4SRqU6Mz
 p6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691861593; x=1692466393;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2YXgfMDrYPzIYbCrlFGkfAndljXKF00LrYlHbIPl8E=;
 b=fKPKH+cdn/x0EpMxgcUrzxP7AWSJIwG/3Gx9PbNBS667YfXk32cv0B8r67vyITwyB9
 JNhBE4QAzOwI10hzYovu2eXIa+ergyq1ykK/d0lNNlByw0m7fuJ8D38kqhY79acENfOe
 gw3Pa9xBO8w1H3URH2wU/h+3CTLeAUs6gAjwFNz1ssV7GoFGOB0gGkuNHTa8T22/CZjj
 D9P+6QgQrPlCF1/Rzb94VmlRHyty7cElBmyCGFkz/4QLrFbMSwrwaBvrHtJ3Lq3lBmYf
 eqKin+zvRYsSXIPnJs4qpwRc0XjY0BcOAwTWz0ARfCwVMcclbAEgn3u/27ITU2jzPKkt
 uXIw==
X-Gm-Message-State: AOJu0YwLHN4x380MmKk0C8QRKIxbsX9qtkaC2yk5u84ikE6bHZCpucKS
 zRh43qbvUrmWW+VJCoN2wSACqA==
X-Google-Smtp-Source: AGHT+IH27/m/HfDS3Y+CAiEW1TgXfTwOA3WWivC8ZvvNMxVoqKZ4tuQMhVRSBPqAUXSThHhGG1CKRg==
X-Received: by 2002:a17:902:f68c:b0:1b8:a67f:1c15 with SMTP id
 l12-20020a170902f68c00b001b8a67f1c15mr11622196plg.25.1691861593549; 
 Sat, 12 Aug 2023 10:33:13 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a229:715e:62f0:756f?
 ([2602:47:d483:7301:a229:715e:62f0:756f])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902d50100b001bc445e249asm6111829plg.124.2023.08.12.10.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 10:33:12 -0700 (PDT)
Message-ID: <56908f79-c883-0d83-c990-e7a86714b6da@linaro.org>
Date: Sat, 12 Aug 2023 10:33:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix signal handler to detect crashes in qemu-linux-user
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230812164314.352131-1-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230812164314.352131-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 8/12/23 09:43, Helge Deller wrote:
> +/* _init and _fini are provided by the linker */
> +extern char _init;
> +extern char _fini;
> +
>   static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
>   {
>       CPUArchState *env = thread_cpu->env_ptr;
> @@ -819,6 +848,13 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
>           if (host_sig == SIGSEGV) {
>               bool maperr = true;
> 
> +            /* Did segfault happened in qemu source code? */
> +            if ((pc >= (uintptr_t) &_init && pc < (uintptr_t) &_fini) ||
> +                (TARGET_ABI_BITS == 32 && HOST_LONG_BITS == 64
> +                 && !h2g_valid(host_addr))) {
> +                qemu_show_backtrace(info);
> +            }

This is incorrect.

I did mention that you should look at adjust_signal_pc,
which has a lot of commentary on the subject.

(0) Place this after the write-protect and restart check
just below, since that is not an error of any sort.

(1) If helper_retaddr == 1, then this is a fault reading
for translation and is a guest SIGSEGV.

(2) If helper_retaddr != 0, then this is a fault in some
cpu_ldst.h operation and is a guest SIGSEGV.

(3) If in_code_gen_buffer(host_signal_pc()), then this
is a fault within generated code and is a guest SIGSEGV.

Otherwise it's a host SIGSEGV.


r~

