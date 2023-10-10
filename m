Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED67C01F7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqFum-0002SB-Bn; Tue, 10 Oct 2023 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFuk-0002Rs-4M
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:48:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqFug-0004mX-Vb
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 12:48:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c8a6aa0cd1so14906225ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696956533; x=1697561333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TuYqLaIKIhucI88JlrhEjY0cytVk7nf2wWm13ybe4pY=;
 b=ymR095Rgbfd1Nv5BD/+W0YDqZ4kBHUCbXUIyjxkx8zFYPLKPooTNC0XxPPXRurJACp
 mIF6PSK0YE2+5nj1qe6+HdHhYP0PTscOCotPvJVNEP0TYA8Q5hqdwwU5SDVXvtoaVfnc
 BKhUgrFBsHQ9LR53CFMeGzmw8ED6XEyZ/9BYaU/ghPgt+X5Pf/mGEjG0eJ/vWJKk35a6
 BeKXbJ3klnFAxMKBod6mAZLzwXm0YbJwB795f/It7fmj6+sIma+lEOP1AVGThWdMAEcO
 NB0ChVFhxH1liRtoM7m7sEhyXrsoMZLdFFawOECORi0kDatFZqpUxO4zVH3a0i+/uvO1
 CAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696956533; x=1697561333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TuYqLaIKIhucI88JlrhEjY0cytVk7nf2wWm13ybe4pY=;
 b=sa7zBHTDmYec56K0Evkqo2J9/18QBVMFjlC1iGKuKiJcg4WPppw+pDuaCkCq7xuzdp
 ftIxiLrTxXGFx6FPlQawiTgzHONp5t1YEQeHkubsREMZca0C7naeLhGg3DBJaV9EpegA
 QHQCCUHasTNGIhWD9c2KhySXYGXuA+Gl8dO6uyRA2QQByJOd6s33CL0YMFqOnNFtIgPK
 ceHiI+CmFFdANqjjKwK82rDsD3kMTvat5MW2jOn2qaPi5/D0J4aJLdWO1jT9ryjTFExB
 aX1ku2FZjmVkuMQwhieVWiLwtvJPsFsKJZXxxxIIMfNkVpTI1r7e7aBsFi8BQ/zcbwlE
 V10A==
X-Gm-Message-State: AOJu0YyUEnwOZPGfJWYdFkrYPMV/78U8wRkQsJ1fITAVBovrcKUCmgsj
 TqhzQVLyAas6mIncPclFoy3YFO/nSmnSkfKfrcU=
X-Google-Smtp-Source: AGHT+IG9c0F1jz3X+OZWLAtQUIedsi61kYyzn+hNoqOTOL7CozFTlrwMFOE0zybDv0bH6sX2T/CrLA==
X-Received: by 2002:a17:903:11c7:b0:1c7:36ff:1ffd with SMTP id
 q7-20020a17090311c700b001c736ff1ffdmr19119161plh.61.1696956533158; 
 Tue, 10 Oct 2023 09:48:53 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001c9bc811d59sm1532862plb.307.2023.10.10.09.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 09:48:52 -0700 (PDT)
Message-ID: <a2e69691-d3e7-4bdb-b2a3-c3f4b07f731c@linaro.org>
Date: Tue, 10 Oct 2023 09:48:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Use env_archcpu for better performance
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, philmd@linaro.org
References: <20231009124859.3373696-1-rjones@redhat.com>
 <20231009124859.3373696-2-rjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231009124859.3373696-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/9/23 05:48, Richard W.M. Jones wrote:
> RISCV_CPU(cs) uses a checked cast.  When QOM cast debugging is enabled
> this adds about 5% total overhead when emulating RV64 on x86-64 host.
> 
> Using a RISC-V guest with 16 vCPUs, 16 GB of guest RAM, virtio-blk
> disk.  The guest has a copy of the qemu source tree.  The test
> involves compiling the qemu source tree with 'make clean; time make -j16'.
> 
> Before making this change the compile step took 449 & 447 seconds over
> two consecutive runs.
> 
> After making this change: 428 & 421 seconds.
> 
> The saving is over 5%.
> 
> Thanks: Paolo Bonzini
> Thanks: Philippe Mathieu-Daudé
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>   target/riscv/cpu_helper.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

