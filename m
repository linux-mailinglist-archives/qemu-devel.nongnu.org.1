Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F428979F9B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Sep 2024 12:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq9Cj-00052d-VH; Mon, 16 Sep 2024 06:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sq9Ci-00051k-DV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:43:36 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sq9Cg-0007J2-HB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 06:43:36 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d8b679d7f2so3492607a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 03:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726483413; x=1727088213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDFXwJNy2sB25Q3vce5EzL0XjgmTJianlmZpkRbgqGg=;
 b=GdlUc1/vHVwMoC7ARy4BDCKPOq2hm4yss8THZLrU5TAxU3tGamDQjivSWd4Y8Pq3xe
 TLeIQCB3EPPtjQxE7S51Y1ZvexHNE+qGJfwEL+1tr3tFEyFC6sfaW8aGNoYt/bBoJ5b3
 H9DE+vxXpVK7bfPOWhJVu0ZaYF1fuujXFMAuVCYEeW4xk8yMRRwoPsbIx10EHn2IBqmT
 80CG89DkMRg0PsV/d5YtRJuLWG3Rcpy6B8Lq6JM4SaDqh+J+ORNJRwZuRnco/ePkMqNy
 c4dvI6jhoY9LY6DYxxgpyYhaIHtwukYZ1DWrhTO3KfM5ofNszwO13/5AJFiUKUiObZn4
 q2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726483413; x=1727088213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDFXwJNy2sB25Q3vce5EzL0XjgmTJianlmZpkRbgqGg=;
 b=IrhiufYJx4qxmCbdnNoA7HfECk8h9u9Pbw3WS6rQ7JfRtsPcqg6MLGOC1C2dXcHrvW
 dVssA5bepDt7p4S0rAJr+bJzTb/OUS6yRDHSp9H8sGFkMwCwb4PdNOGOOfgEsxE5ELcZ
 5LL6XXKO7Duaxr5en9uXPQcNdrw5Ns7NBoXAJYqZfoyczgzbguVZpB41jXbEzFfRqI5o
 HHueJd+j1qU/o3F/HYZUwjmn84PvP/2IjXZkmU+qRsG4dCKKZx3y1a5tX/ybxcyITc6M
 FwC6VpCF3oXtoRsgPuFLhRG1jwBg7TlL+W9yHtakYog9zOJ+aZ1Ef47v413BnGfuPTYG
 U3kQ==
X-Gm-Message-State: AOJu0YzHwDROGYmt0f8EW0muz4x28gVBTGfGi3am26u9SkeGbuNccfMy
 /EnJhsOI9baH/1XqNc2O+9qkpjE93za+Qz8sCzHXuDbBCszw0ajGnQlJUUYOFz4=
X-Google-Smtp-Source: AGHT+IHkFgu1yFhW5sthUoj5TWJ/5hPlEcTQDsbsk+p10MaSEo1YIJO0VLRDk054zgWbLJV14ouhjA==
X-Received: by 2002:a17:90a:7408:b0:2d8:b91d:d284 with SMTP id
 98e67ed59e1d1-2db9ff91f8bmr17222763a91.16.1726483412936; 
 Mon, 16 Sep 2024 03:43:32 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-33.dsl.telesp.net.br.
 [201.68.240.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dbcfcf7f3fsm4882814a91.14.2024.09.16.03.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 03:43:32 -0700 (PDT)
Message-ID: <1dca30ec-f2b1-4936-8531-6e273fc13e55@ventanamicro.com>
Date: Mon, 16 Sep 2024 07:43:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
 <CAKmqyKOFnajGSsKS2k=kYsB--uRjoCZZTv3QSxbEm40HK_k1jA@mail.gmail.com>
 <4aa984d0-db18-4a41-808c-e4d164c03d13@ventanamicro.com>
 <9b97cbc4-7074-40bb-aa47-93e495c8786e@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <9b97cbc4-7074-40bb-aa47-93e495c8786e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1034.google.com
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



On 9/16/24 3:12 AM, Thomas Huth wrote:
> On 15/09/2024 21.58, Daniel Henrique Barboza wrote:
>> Hi Peter, Alistair,
>>
>> On 9/14/24 6:15 AM, Alistair Francis wrote:
>>> On Fri, Sep 13, 2024 at 8:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Thu, 12 Sept 2024 at 06:30, Alistair Francis <alistair23@gmail.com> wrote:
>>>>>
>>>>> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:
>>>>>
>>>>>    Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/ stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>    https://github.com/alistair23/qemu.git tags/pull-riscv-to- apply-20240912-1
>>>>>
>>>>> for you to fetch changes up to 90d5d3c1115399d8e27621efd69dfa74a35a4932:
>>>>>
>>>>>    hw/intc: riscv-imsic: Fix interrupt state updates. (2024-09-12 15:05:10 +1000)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> RISC-V PR for 9.2
>>>>>
>>>>> * Add a property to set vl to ceil(AVL/2)
>>>>> * Enable numamem testing for RISC-V
>>>>> * Consider MISA bit choice in implied rule
>>>>> * Fix the za64rs priv spec requirements
>>>>> * Enable Bit Manip for OpenTitan Ibex CPU
>>>>> * Fix the group bit setting of AIA with KVM
>>>>> * Stop timer with infinite timecmp
>>>>> * Add 'fcsr' register to QEMU log as a part of F extension
>>>>> * Fix riscv64 build on musl libc
>>>>> * Add preliminary textra trigger CSR functions
>>>>> * RISC-V IOMMU support
>>>>> * RISC-V bsd-user support
>>>>> * Respect firmware ELF entry point
>>>>> * Add Svvptc extension support
>>>>> * Fix masking of rv32 physical address
>>>>> * Fix linking problem with semihosting disabled
>>>>> * Fix IMSIC interrupt state updates
>>>>
>>>> Hi; this fails to build on FreeBSD:
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/jobs/7817823771
>>
>> Is this one of those jobs that are only available when running the main pipeline? I don't
>> have this x86-freebsd runner when triggering the gitlab pipeline. I ended up installing a
>> FreeBSD VM and using it to reproduce the problem.
>>
>> Would be nice to have access to a FreeBSD runner as a regular user, even if just for x86_64,
>> to help detect these build problems before sending a PR.
> 
> You can enable this job for your pipelines, too, see .gitlab-ci.d/cirrus/README.rst for information how to configure it.

Nice! Thanks!

> 
> If you have a Linux host with KVM, you could alternatively also use "make vm-build-freebsd" on your local machine instead.


Way easier than what I did :D next time I'll grep the docs.


Daniel

> 
>   Thomas
> 

