Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453917B2796
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:35:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyfD-0008Ag-QZ; Thu, 28 Sep 2023 17:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyfC-0008AN-Bg
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:35:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyf9-0005eu-Az
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:35:13 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690d2e13074so10816221b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936910; x=1696541710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bbqwvvGn2FzogpTYxtn6ijeiphRSPGl5RPjPA+15lM=;
 b=P8r/p6AkGV++0LJHpXjGlev934sKMXhBRyh4lRHeaBjfVkWiERe1xT452DtYKtf3UI
 vpa9ZH/4bjjWP6KXBE6BlQiacLb1fidDqvzuPY3qSFIKCKu0m9a5hU2Z6oeDntzW+ZAi
 mjVmnTwl5AfxsCwSyRZiI5Ccm79lM6INIKQyeYRJpMo0PzC3qHE5dwK8qXhZZCQifNOO
 nzTlA1ay46jatxxGBjz8DPqs+r9IH0MSl0ZR0EJ9Q4NUKkrZMvELmiFoDakBfVvJXNL2
 uDdOkKRbcBX06vzr5llGe9eF8Q73etCgmVaJE3efpKeb+yhGyQlVULtpLTrjTAtQrN58
 MXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936910; x=1696541710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bbqwvvGn2FzogpTYxtn6ijeiphRSPGl5RPjPA+15lM=;
 b=WB0umo28LRQrMi7fwb3XRmAFajSp3RhsczOYoqtCpN9D4X79thHqjIm4NImZUbdYPY
 FokWmyZi15M+48nAJMq67P5nrzyT9nLr0/Etd+3sXAVL59nAqXl/GhrT6kFd211IKbZ3
 Xx9KdVPT3VqOF5vtONeHzCbhZoWXXyvwa9xmUBh8ciiyA2VJ+CUAKjb2jHS8Efbzr7kw
 NV2gYs82bz/JOt/BmPK0K7fRUFfwYHabIx6fCuaSHWmWVw+L5aAMcfEy0pTSAlEI2CbK
 QKaofxY2cDmFNmtLjIYAGqsqQXCrve8ThmETgDAn2NieLud48q4+kIStgP1lzL54go1x
 kKBw==
X-Gm-Message-State: AOJu0YyYfT1TxP6xHY38I8I+1g3TIO5Gwa5v+Q+AD0zp9tRx+M7wpMcG
 ujxe5Jglj2qjSioUBvm/AOe9cA==
X-Google-Smtp-Source: AGHT+IGvOZzU9cgRZE2So+LZppZ1kMWdzHb+bl2Yu+/nX6iQGIX6ytrm9xb2+NXhA+IkCFaZLnlEGw==
X-Received: by 2002:a05:6a21:66c5:b0:154:e7e6:85c8 with SMTP id
 ze5-20020a056a2166c500b00154e7e685c8mr2526921pzb.31.1695936909604; 
 Thu, 28 Sep 2023 14:35:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 6-20020a17090a1a0600b00263dfe9b972sm29765pjk.0.2023.09.28.14.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:35:09 -0700 (PDT)
Message-ID: <de8992b1-9f7c-b6ae-aaf3-af267674f71b@linaro.org>
Date: Thu, 28 Sep 2023 14:35:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/8] target/sparc: Fix VIS fpmerge input registers.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-7-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-7-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/24/23 01:03, Nick Bowler wrote:
>                   case 0x04b: /* VIS I fpmerge */
>                       CHECK_FPU_FEATURE(dc, VIS1);
> -                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpmerge);
> +                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
> +                    cpu_src2_32 = gen_load_fpr_F(dc, rs2);
> +                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
> +                    gen_helper_fpmerge(cpu_dst_64, cpu_src1_32, cpu_src2_32);
> +                    gen_store_fpr_D(dc, rd, cpu_dst_64);
>                       break;

Use gen_ne_fop_DFF.


r~

