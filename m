Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FD77D5BD
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW27t-0008Lw-3v; Tue, 15 Aug 2023 18:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW27r-0008Lb-I8
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:02:55 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW27p-0003rm-CJ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:02:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686daaa5f1fso4109090b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692136971; x=1692741771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jNdWl3U7vrSDOsSq8Uobb8lvRTLRUWv3dQL9+8TLEy8=;
 b=WD6OSNmGW/GYvazHsW9ZwsKShaGicYDlz/ihWADcxj5z8t0PQ1DPhSLSV9iRyIeJsJ
 TANXAShxxsrzXq+IT2kKje6BF/yFyx7/kgLCpuQgSp6ZCLbsL+d4k/GO2auj5W8bxdkL
 ucwJBA93JnDZJFwaoKfhZaGay2qhTs3n+IAnxxU/2tW5bfx2YsnVWFwcCuhgne5C2pU4
 5aS7y0bidGY/E6zaiuvv1V/NU58aopwC7xjYYAIN5Qwc6ORy5f/Oza6lZY7mSfJSlxdy
 yJsF+ciXY/G2e+Sz8iw01PdxndzmFaapT/ONqMdmbFHch3pg4qtu3TfhHNdUeVJH7f3H
 LsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692136971; x=1692741771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jNdWl3U7vrSDOsSq8Uobb8lvRTLRUWv3dQL9+8TLEy8=;
 b=h01dvcfaS6+k7Sm6A/iH0d1Yqccq+SijXvcVC1VPr4S3MUlujbFP/xN5JQy+s3FTZv
 kwBbLN8KDaM+NttIXkYr0bcWcPpCm4eGURAGGb7gjpnL1KD0e6yB3QiPwiI1a48tdmZD
 o/PBdprX/aJJiKyk8fHwSjzTHLCD714oFDWGIINkH3uXj7HMWC6dYRCXCmC0LiZrB6AR
 0kcJLQ9Bkj26od+uIRahBe+9c/dGbylJhnwZJHtD8stzxjPJfq9KA89D7WHQ4clRGWoM
 c7kzzyVY066ZTCoaMIMt9OdFaY/PbbG2OIi+TXpm27RVH52IS5/6eP1djFGQ5dDvin8L
 nYPA==
X-Gm-Message-State: AOJu0YyjtSkb1ym6IkCisfP3jV1FS+UKJ/ggH29LThb7/YqXZBzk030i
 yPvE+6blQyV9G4kM0w5GLApvbA==
X-Google-Smtp-Source: AGHT+IGonAs0DtxpkFxxWHDVQDavriNICMx4pkEm0nndwA1nAGoh041fQ3lMszLfhx0Z3XJKb+7EuA==
X-Received: by 2002:a05:6a00:a17:b0:687:596e:fa72 with SMTP id
 p23-20020a056a000a1700b00687596efa72mr61116pfh.5.1692136970688; 
 Tue, 15 Aug 2023 15:02:50 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8d06:f27b:d26c:91c1?
 ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 d12-20020aa78e4c000000b006884844dfcdsm1457010pfr.55.2023.08.15.15.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 15:02:50 -0700 (PDT)
Message-ID: <0410b8a2-7154-8d21-7ff0-70f27568d8d1@linaro.org>
Date: Tue, 15 Aug 2023 15:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 07/12] target/riscv/cpu.c: add
 ADD_CPU_QDEV_PROPERTIES_ARRAY() macro
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
 <20230815201559.398643-8-dbarboza@ventanamicro.com>
 <40ec95c2-7775-4a40-f73a-8f92d3cfb00c@linaro.org>
 <9197e0e0-7b68-9fb0-10ab-b6834ade60df@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9197e0e0-7b68-9fb0-10ab-b6834ade60df@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
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

On 8/15/23 14:15, Daniel Henrique Barboza wrote:
> I assume that you don't fancy this macro usage, and probably for a good reason,

I prefer to use macros only for things that cannot be done another way.
When debugging, one cannot step through macros in any reasonable way.


r~

