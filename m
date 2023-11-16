Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3EE7EDE72
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:28:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZbS-0007tJ-5s; Thu, 16 Nov 2023 05:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ZbQ-0007sC-2x
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:28:04 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ZbN-0005Dh-5x
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:28:02 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso8089841fa.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 02:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700130478; x=1700735278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JveVE4p5jS0nvLMubZk7bqzjVrxYYUswNQaT3Q44FiI=;
 b=wu0VFkkgGJoB4JL0o3YgeHjf6IeAUlyNreLxiDD1wA2lMUlbhF9W1hQPNgFAZzr+bl
 pzHu1sZ1gbx9eu+83BLQN6lF3VdN29zKdv/w55pyxGP1kRZfSv/tqEcMFbZbMeBtgLT5
 tUlFDLyOYKlK4JlTRGSbSjmUIjAZCiMxU5BAfVdFhJyKG7UxN9U6vb9xqLxNdJzZm9U3
 /ALrbZfVC0YofObxOnqDlyhL9O2f9lP3HcZGfJkCttAnTqKd3bOsiDWZ307Xcik3dVi+
 Y6ASi2VkoEXosc1AWWwVXJpMtqDWUQG+Lf/o7Gs9twXapll4EBUU3Z4hRM46RR2yBLKV
 P2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700130478; x=1700735278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JveVE4p5jS0nvLMubZk7bqzjVrxYYUswNQaT3Q44FiI=;
 b=QFOYQwZ2eFS9NZSKN6l9ne4XWXred7ec+70NeUpHPeAT7B7IneIkVxZcSlX74DHAo5
 6VUB8VEbIFFrWG2BFA4ydxQDpPhMV1dPJeWY1bnDm+iFXuLBOhJnLOVmDcpBVnEoe9pr
 XFLqkxZ5uy15UJNxblMaFkKhP0blVB8PX6ShslG8CLI2f8t8PJ6F917egDS+cBPDQYFS
 3lkt84mY8+OfcXhNS7Bixl6woMCZUaLTV6i+vGCvAptTMYmKnkCKUrauHJ3Vq5GrgU1q
 dMT+CDk7FVgsLRRIb14XO6xBmjpbTm61WGIFoIt5BSD1y2Zsf/Oi7/jtCyLWsQIJes/P
 qURQ==
X-Gm-Message-State: AOJu0Yy4cmi8kq49miM/wS94khYxgTsa07XPFSUIvWuL9B/iCBmwW7PE
 VEzU3ucipGLNOjjtLzSh6WTzWbdDJu9AHREca7Y=
X-Google-Smtp-Source: AGHT+IFexTX6zOyELCQ3jKIEktN3RyuWKhykHjp5J+rVJOqXrvEh7PNoWMgpfZwb8r1ddrcJN1nAbQ==
X-Received: by 2002:a2e:bc28:0:b0:2c6:eccb:344d with SMTP id
 b40-20020a2ebc28000000b002c6eccb344dmr8657052ljf.40.1700130478019; 
 Thu, 16 Nov 2023 02:27:58 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b003fee6e170f9sm3001006wmf.45.2023.11.16.02.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 02:27:57 -0800 (PST)
Message-ID: <dc0498ee-6ec2-4636-9325-71b8d8ef99cd@linaro.org>
Date: Thu, 16 Nov 2023 11:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/31] target/m68k: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-15-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-15-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 15/11/23 00:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-m68k -cpu ?
> cfv4e
> m5206
> m5208
> m68000
> m68010
> m68020
> m68030
> m68040
> m68060
> any
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-m68k -cpu ?
> Available CPUs:
>    any
>    cfv4e
>    m5206
>    m5208
>    m68000
>    m68010
>    m68020
>    m68030
>    m68040
>    m68060
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/m68k/cpu.h    |  4 ----
>   target/m68k/helper.c | 40 ----------------------------------------
>   2 files changed, 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


