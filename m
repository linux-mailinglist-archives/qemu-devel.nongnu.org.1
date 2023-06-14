Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C587072F322
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:41:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HNF-0006N9-Pw; Tue, 13 Jun 2023 23:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9HND-0006Ll-6O
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 23:40:43 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9HNA-00068c-Gx
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 23:40:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31109cd8d8cso106613f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 20:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686714038; x=1689306038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6K/NmwQs8K/GbD67mVMV6a2RgYlMcLBnHP5k6Y04s4=;
 b=iorcpyY999QWehIb+CAgrA/F1N36in6cm7c1xcz3U7MfL2vyFgHedlBylx1ziCuvVS
 6hDNVpZ6lP7/9eAFG96KxzKNl2HhnwnKPK5QObniPPw2KacRaR45KHN5BNwQ/fBN1TXQ
 U5RpYQn/tF0sz0HWy9+ubLlJ7YnSBixn33/5t6Eq0CtS6cKkyc6K6OYYMQ/eFjAqYHCb
 hXETirYPQAPIQA8VlSLXLSEaDNiuMIatOAOvJhC+kyTgDnkFMtRqcljuLWr2TCuqESGi
 ocDTciV7b4uNGmeum+J6Upimotn2JRrMfMVdsGmEYxK3plrzy86NRJ5xIlO+VqD33li6
 D79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686714038; x=1689306038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6K/NmwQs8K/GbD67mVMV6a2RgYlMcLBnHP5k6Y04s4=;
 b=jg/XPA9cn6MEKsCxPcn0YE1jHgzKrFGH+6TETz3lUtkjYJtm7mKp0/0yaPVJP+22Dl
 uQYIjYcp+qTP0znYBte1kCfUUC0sS6b5kxdJFCkzGwmG6o0zReIGRtaZMs71txUQPwyH
 +8FEgvGDLKQjmSh+l5T3abrqY4IH5EThGWeqoi/HBxbQNBtSntKyNQIH2jh0hi8dvBhu
 W+aeRDQHAfcXsHAmpT1hEIgOh/eVXJbtSlOiT7mmNasJuDsCcUfllIfmonYFSkUrlBTs
 r5dMCbQUt4xWBp8Dlmak118nLwt/6IpbQyehLsDv3rjSAEfmo2S4jDZDQfuSKDw2BAlk
 MDrQ==
X-Gm-Message-State: AC+VfDyhxCF9FsX4J5qKQE8c2xFXcRR5MEorTvwdSAzkdeGq961b9LTu
 rXST43naSIxzQmhaxnB9JN40KA==
X-Google-Smtp-Source: ACHHUZ4aWTG5W05cUIT4zylXDSRz78kF6JI8I9XWAoMiPFUy6icBSFAV4yrrX70Rn2DB1VQxr5htrw==
X-Received: by 2002:adf:fa85:0:b0:30f:ba73:dff8 with SMTP id
 h5-20020adffa85000000b0030fba73dff8mr6002074wrr.28.1686714038089; 
 Tue, 13 Jun 2023 20:40:38 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003f17848673fsm16017895wmj.27.2023.06.13.20.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:40:37 -0700 (PDT)
Message-ID: <cd379806-ef2b-d13e-472c-a15d21532bb3@linaro.org>
Date: Wed, 14 Jun 2023 05:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/38] tests/multiarch: Add test-aes
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20230609022401.684157-1-richard.henderson@linaro.org>
 <20230609022401.684157-4-richard.henderson@linaro.org>
 <87zg5468ed.fsf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87zg5468ed.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/12/23 16:46, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Use a shared driver and backends for i386, aarch64, ppc64, riscv64.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tests/tcg/aarch64/test-aes.c            |  58 ++++++++
>>   tests/tcg/i386/test-aes.c               |  68 +++++++++
>>   tests/tcg/ppc64/test-aes.c              | 116 +++++++++++++++
>>   tests/tcg/riscv64/test-aes.c            |  76 ++++++++++
>>   tests/tcg/multiarch/test-aes-main.c.inc | 183
>> ++++++++++++++++++++++++
> 
> I find it odd the file with the main function is the c.inc and the per
> guest impl's are the plain .c files. Is it possible to have it the other
> way around?

Not with the way tests/tcg is structured, no.

> If we have a fallback library function for aes then we could
> enable the test for all targets (a true multiarch test) with some having CPU specific
> accelerations where available.

We don't have that either.


r~

