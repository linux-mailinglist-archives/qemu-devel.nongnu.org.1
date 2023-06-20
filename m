Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899F73715A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBe82-0003PZ-K9; Tue, 20 Jun 2023 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe7y-0003P4-OL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:22:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBe7x-0005bY-38
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:22:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so458380166b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687278163; x=1689870163;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPd4Jk9iITg7ARMPaCSzyu8NA7k08UawGoUNlT8a0Yg=;
 b=bCnIamBwnR8kBvErXo3FU+cbTo5jt4UDJNGOQVf0pO7iddUnLhUh2POHbgObw2j4AO
 wk2+CZeYmbe2p4lPqtSjFkSUvGsYpFA/cBkpZoAGKJZt4lmqT2kpDpKZcJf/abqOHcNb
 vJq+QUtnEKelQI64XtejXCpoQaeXFTep92VJW3Fd7myhjALUDU28vreb82qym47xakZO
 qZ7HMdr5iL0QKOPqPovbFfpHD5zU9ww7Slr+6GdaUIA3pS0971viU/0RJ21wKnsJRimM
 8AP74e9U/bZQOmsD4eWUZBXbSqZuh0HvXNBiQdTsKxOSkLKyy9aX3G8dKCBWsgvi8Hg4
 1KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687278163; x=1689870163;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPd4Jk9iITg7ARMPaCSzyu8NA7k08UawGoUNlT8a0Yg=;
 b=WSS3/qYaI3lorJGYB/7hYjL2xT3G9/0aCBSjkbu+QIATQgka2i+J+oq9wZ3KDBVHsG
 sm8EN19QzqEQdE500XjquVxigfj4Y8BRYAsGMUUP1q4mqSjLN72qjTHOZFy/Z4VLhh2J
 CxkU8HFofx3El1ZOxGR1ZchXrjzMU+mGIB2VugbiE+W7fS2oEYxT/PVFTY2dBzQmcK2C
 e733b8AtI+/Wp/xiUJJzUSgw7bSEGwCOtfJ7TdMgqSypXG7zxZBzlwCl/O/xoq3jnTKU
 kGVa2ByMvEDZETK06ZJeFNEhv/x/qDsnZ2DZ0DeeYAmt60K7egarriXzZj9MGReldsyE
 yYFQ==
X-Gm-Message-State: AC+VfDxg4U6QCcH86Aie3IVBct4nLdaw0FqFjHJLBVuJSsafQFPMDr/n
 K/u5h13A1bX5se4lhIeXFcO4eQ==
X-Google-Smtp-Source: ACHHUZ4tUhEc+yQCElJmh7igzrLDTTgizrivpVJFG3Rxy2qGmPyyEdUEmrdT/hzLfRuEegjAogyhUg==
X-Received: by 2002:a17:907:360a:b0:982:a022:a540 with SMTP id
 bk10-20020a170907360a00b00982a022a540mr14009589ejc.11.1687278162986; 
 Tue, 20 Jun 2023 09:22:42 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090608cb00b00985ed2f1584sm1626007eje.187.2023.06.20.09.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:22:42 -0700 (PDT)
Message-ID: <80401c46-0d52-a538-04e7-d860795d83e9@linaro.org>
Date: Tue, 20 Jun 2023 18:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/10] target/i386: implement 32-bit SYSENTER for
 linux-user
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> TCG reports the SEP feature (SYSENTER/SYSEXIT) in user mode emulation,
> but does not plumb it into the linux-user run loop.  Split the helper into
> system emulation and user-mode emulation cases and implement the latter.
> 
> SYSENTER does not have the best design for a kernel-mode entry
> instruction, and therefore Linux always makes it return to the
> vsyscall page.  Because QEMU does not provide the_contents_  of
> the vsyscall page, the instructions executed after SYSEXIT have
> to be emulated by hand until the first RET.
> 
> Some corner cases, such as restarting the system call after the
> system call has rewritten the SYSENTER instruction, are not emulated
> correctly.  On Linux, the system call restart uses the SYSENTER
> call in the vsyscall page, while on QEMU it uses the emulated
> program's instruction.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   linux-user/i386/cpu_loop.c          | 51 +++++++++++++++++++++++++++--
>   target/i386/cpu.c                   |  9 ++++-
>   target/i386/cpu.h                   |  1 +
>   target/i386/helper.h                |  2 +-
>   target/i386/tcg/seg_helper.c        | 33 -------------------
>   target/i386/tcg/sysemu/seg_helper.c | 33 +++++++++++++++++++
>   target/i386/tcg/translate.c         |  2 +-
>   target/i386/tcg/user/seg_helper.c   | 16 +++++++++
>   8 files changed, 109 insertions(+), 38 deletions(-)

I'm not keen on this.

This belongs with the rest of the vdso (see patches posted years ago; committing binary 
blobs rejected, still waiting on a decent way to invoke cross-compilers to build them).

Further, this shouldn't ever be reachable, because AT_SYSINFO won't be present to give the 
guest libc the location of the vdso routine to call.


r~

