Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B202177E5C7
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIua-0000J2-2y; Wed, 16 Aug 2023 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIuW-0000I6-Ip
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:58:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIuU-00088I-1l
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:58:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68878ca7ca0so1035390b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692201492; x=1692806292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=16Esi9JwccTE9I4/5tY6xJnw1tyAEPrEh9hoUI1ykSk=;
 b=HcM0hQlUg/4bbfKlsda3h3bxtuWrrCV7BgIgBGjORa+ewy+cAuouA8SMlGCZBKXCUZ
 9924SPbarO0pH10HjMwyULC3aPvGNZiZvJiQw153h1mgT7Q4Z8wW9KPMTq9/b/cIhsUJ
 EbBTcfLk6xZHXfE7ULtRCwSJply3ycVeLZzkZUjLvgeaACT//iLjWK7+BSPX4eaJFigW
 BRGky2n3M7/KRaxmwHiCDE3BFmaaWIo0CUUa3gDMLfUMBRaV3idLE5e+qv+hOM02yB5/
 MJPsot2tyNxsvq9IQ6Qiuhc7MrllslSCBcn+yuwoL+IqcTw2ByO3AQ1q3ks7GAxePcGj
 rCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692201492; x=1692806292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=16Esi9JwccTE9I4/5tY6xJnw1tyAEPrEh9hoUI1ykSk=;
 b=hCUNhVxf4SjsaiPly4ln6872cOpnyrRs0nrn8Gq61SA5lkv3gd6HFucI7HK0af5uZ7
 sO/xT7U4jPmYxcfrS827H2jk3neLfZRY2owxfbsuTnO4NtojlWa8AH66rX2SyTWY2Z82
 H2qX0wiCvUB/GaPAgw8Z0nWWSKh1Ay//Z0bf2HWZNlNww/7w3aYDcQFh01plUm1P3J2c
 Eh3UtAc5m0jDssvtyWyBEliRdw8zzIwh/J34Xdko+OktvCkoRG809CILxhisCfksLB5t
 XlyRP9gtRlnbu999oixqRaj1B1eWUHeu0Nosl3HgUGo5VnKDiXV8aVvYVoa1hkUHZtni
 7jvg==
X-Gm-Message-State: AOJu0YyeBt1ZgKQ99+k2Shs2OIRb5c16zI7MkVRGVZZ/OAKcqeKmEMNd
 ZG2eMR12uAl6fGg4nedtXua+hg==
X-Google-Smtp-Source: AGHT+IGvjA6m7ZYXWLIDWYZtoj7Je+Y9DK5ONCdilFdn1arQ+I4wKwl9FX15eEVPcG+GTvQoD+K4gA==
X-Received: by 2002:a05:6a21:3e0d:b0:135:4388:3978 with SMTP id
 bk13-20020a056a213e0d00b0013543883978mr2231557pzc.29.1692201492631; 
 Wed, 16 Aug 2023 08:58:12 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 ff10-20020a056a002f4a00b00682a8e600f0sm11299136pfb.35.2023.08.16.08.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:58:12 -0700 (PDT)
Message-ID: <7bf4aaac-e952-6d3b-0128-06dcc7f7c780@linaro.org>
Date: Wed, 16 Aug 2023 08:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 06/25] hw/core/cpu: Replace gdb_core_xml_file with
 gdb_core_feature
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-7-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-7-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index f155936289..b54162cbeb 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -391,7 +391,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
>       cc->gdb_write_register = hexagon_gdb_write_register;
>       cc->gdb_num_core_regs = TOTAL_PER_THREAD_REGS;
>       cc->gdb_stop_before_watchpoint = true;
> -    cc->gdb_core_xml_file = "hexagon-core.xml";
> +    cc->gdb_core_feature = gdb_find_static_feature("hexagon-core.xml");

Missing the change to init cc->gdb_num_core_regs.
(Which presumably itself will go away at some point.)

> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 02b7aad9b0..eb56226865 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7381,9 +7381,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>   
>       cc->gdb_arch_name = ppc_gdb_arch_name;
>   #if defined(TARGET_PPC64)
> -    cc->gdb_core_xml_file = "power64-core.xml";
> +    cc->gdb_core_feature = gdb_find_static_feature("power64-core.xml");
>   #else
> -    cc->gdb_core_xml_file = "power-core.xml";
> +    cc->gdb_core_feature = gdb_find_static_feature("power-core.xml");
>   #endif
>       cc->disas_set_info = ppc_disas_set_info;

Likewise.



r~

