Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C47BE134
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqc2-0007hC-In; Mon, 09 Oct 2023 09:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpqc0-0007gq-O3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:47:56 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpqbz-00027D-3Z
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:47:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9b2f73e3af3so781104966b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696859273; x=1697464073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iIhjZXXfBcqVwNrG8gAU7SfIRsCQhUzUqx8RbtwksNc=;
 b=I/QjLMiQIdh9JVL4uGS4FHHKsXJA/s+V5xhpjW2uHEi6gwpbD3hbBgUN+q4aKSDJin
 et9O/oBtxqERtRny+uVNef11QTiX5E2lSO+wa9WvyCR0A4Viu1iwj/mwC4Asqjlxdudd
 Fph5v4PsUSzrCCd5CrLClkTStzU7z5UaVL1IIqOBl8VKPKwFe+8si1MUGhwo/Vcy5DtB
 f/y/miOUNivsTJSUHVbi+3SNePUMwZLM7Q2UcCDBn5RKXmtdtesWFk6RP+ebifoHGbKx
 XsBxYzEZzP+7IaDTS85i1/4wvJqu1iISXa4bAkuZUw5Q6fxhRIrD7Z+81Ryu/fN61PhW
 jgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859273; x=1697464073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iIhjZXXfBcqVwNrG8gAU7SfIRsCQhUzUqx8RbtwksNc=;
 b=rOkIHJQ0Lz8o72uBEil9WMHxXHiZycbkaQNlsx2eBrN02exVrL/29/9kldDtnFVZ4X
 kpdS/vIXfBqrbwV5yGz31yDE4Wni1hae+u3LENpeARA0tAmEfZmGYUYVX5BdloyN6af8
 FBzz4KDoZgwglw+ZwhuTroBzMHlzMKSI6ZbTYs48mrDo8OgWZN7B9i4yXZUxvPTAki3W
 1W/Fi+AcMKUHDfe1czuOs6VajF2HGcAuXIE7pIneI8w64NAogEVUpcdvcVidhS23FAHi
 9M0M1Ki4wbnSHNGc+GJh3QQaEDEAIthdrXM3IRwimKvVbmsZLdQvRQiQwBdMx4jkSFEq
 7CKQ==
X-Gm-Message-State: AOJu0Yzt0KBfCLfFQwyQJuCv9dz+zwsrzOIpvsg28iE2d9Woz20wPBHz
 APOfvue6ihD6MIJXc149bRLPNQ==
X-Google-Smtp-Source: AGHT+IGhC5VfftW8wCixsolpi1lKt6Tfbvbn1/fsmcZQuv0jblxNpegIMa0rxZQEKJru1iI77jxRGg==
X-Received: by 2002:a17:906:8452:b0:9b2:a7c9:fcfe with SMTP id
 e18-20020a170906845200b009b2a7c9fcfemr11989254ejy.36.1696859272719; 
 Mon, 09 Oct 2023 06:47:52 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170906831100b0098e78ff1a87sm6667220ejx.120.2023.10.09.06.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:47:52 -0700 (PDT)
Message-ID: <86ee8b11-aabc-fbfd-088c-ceb6551602f9@linaro.org>
Date: Mon, 9 Oct 2023 15:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] target/riscv: Use env_archcpu for better performance
Content-Language: en-US
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com
References: <20231009124859.3373696-1-rjones@redhat.com>
 <20231009124859.3373696-2-rjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009124859.3373696-2-rjones@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 9/10/23 14:48, Richard W.M. Jones wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


