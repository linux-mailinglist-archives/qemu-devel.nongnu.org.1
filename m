Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E4E7EDE1C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:03:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZBr-0005Ao-Sk; Thu, 16 Nov 2023 05:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ZBp-0005AJ-VB
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:01:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3ZBo-0004go-5Q
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 05:01:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40a48775c58so4841115e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 02:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700128894; x=1700733694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0GOBjPQgq/BDEfRrJAbTfI8qHwKw2XyQ2WJKVxI/iDc=;
 b=dnzR3x3XyoRymj39V1B8dBe4NOQD0vsjeHFISCC9cXfBWQpLiORDe7qXcYFz/RPpuh
 kROHAJr9fY1vTsDoEcqDlfoP1RfsM/o8Ws7yw5IavvDcdAeqAngvKt9mISJNXmzFB4UR
 C7gB0yp1zkn+6KDVENsnqyE9NrcJ28WFutSoyB+S4Vy234YshMeFJ0H96hxxZZe5k2g3
 MoeSsMM56qkHFenjqSeJ91UMcL/IQfAC9EvdE0acoXQsihsCh4byHfxLOM3KgytCf+o5
 mU+iC84AGaJ6fCxkVdDFkqkC9ha8dCIo73L6p17vJHsvEUhlEiNBIMNvIvpc+zJ4BpnX
 4rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700128894; x=1700733694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0GOBjPQgq/BDEfRrJAbTfI8qHwKw2XyQ2WJKVxI/iDc=;
 b=ffp571ht270Xo6yS3HVREXDRftUD0nyg5RvWBOrVrw412CRBII4c7PJxu0fe1BFYfz
 nXTEJXnXk5XaZxHOHrZ4bhuveeJXQU4KZ+cHm3hmVhhGKWNVfLTq5u7XnelZWc1IQvcH
 XmmL2D0Yr/Tu+FHbwQkMa/7ylIToxVYVoPxZEMsyVBKGiy9cIHvZyOXJdyyPy14dg9bP
 8IU+9StTQMwJR5iOkp0f7Mu6+gpNQoe5s1PJ3gn+PVcNPbEh17lBbjgHKCB4RZbjxXP+
 pNxSlr1i1lomT/LxH+BomA5txJ5azY8ihx8AomHoiuM3pOojR+bdAXqDrPYw9kbJ5VwT
 PXwA==
X-Gm-Message-State: AOJu0Yxyci96O6hh0NrrsWcaLHB1p2wkeEr0VtfpA7iAYi0Ce8XWocD1
 ljDOX4cEUglORwJEDLUxbKzgKQ==
X-Google-Smtp-Source: AGHT+IHhvffqxkYoWomuXXJhCxGmUoPIBt8//4SwNOSc7ONPC/BOYPdbyC6hBgM1JXY5ILIX6zuFiQ==
X-Received: by 2002:a05:6000:1250:b0:32f:8085:7411 with SMTP id
 j16-20020a056000125000b0032f80857411mr1396165wrx.24.1700128893288; 
 Thu, 16 Nov 2023 02:01:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 x15-20020adfffcf000000b0031984b370f2sm13066668wrs.47.2023.11.16.02.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 02:01:32 -0800 (PST)
Message-ID: <d5b43eb1-93b4-4e3e-8c37-1dabd5a4cb52@linaro.org>
Date: Thu, 16 Nov 2023 11:01:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/31] Unified CPU type check
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Gavin,

On 15/11/23 00:55, Gavin Shan wrote:
> There are two places where the user specified CPU type is checked to see
> if it's supported or allowed by the board: machine_run_board_init() and
> mc->init(). We don't have to maintain two duplicate sets of logic. This
> series intends to move the check to machine_run_board_init() so that we
> have unified CPU type check.
> 
> PATCH[01-04] consolidate CPUClass::class_by_name() so that the returned
>               CPU class is checked for once in cpu_class_by_name()
> PATCH[05]    add generic helper cpu_model_from_type() to extract the CPU
>               model name from the CPU type name
> PATCH[06]    add generic cpu_list(), to be reused by most of the targets
> PATCH[07-21] switch to generic cpu_list() for most of the targets
> PATCH[22]    use generic helper cpu_model_from_type() for several targets
> PATCH[23-31] validate the CPU type in machine_run_board_init() for the
>               individual board
> 
> v1: https://lists.nongnu.org/archive/html/qemu-arm/2023-07/msg00302.html
> v2: https://lists.nongnu.org/archive/html/qemu-arm/2023-07/msg00528.html
> v3: https://lists.nongnu.org/archive/html/qemu-arm/2023-09/msg00157.html
> v4: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00005.html

Maybe I missed the comment in earlier series, but what is the plan for
the following targets?

$ git grep 'define cpu_list'
target/i386/cpu.h:2289:#define cpu_list x86_cpu_list
target/ppc/cpu.h:1623:#define cpu_list ppc_cpu_list
target/s390x/cpu.h:922:#define cpu_list s390_cpu_list
target/sparc/cpu.h:673:#define cpu_list sparc_cpu_list

Thanks,

Phil.

