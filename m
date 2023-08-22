Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6D5784CAB
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 00:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYZUN-0000z7-Mn; Tue, 22 Aug 2023 18:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZUL-0000yx-IO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:04:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZUJ-00081k-9c
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:04:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso4469046f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692741873; x=1693346673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FhNkrEHy8FmRkibSbQLK5bDMCXrTTDXfIQ1rgX/TluI=;
 b=mecB2GGs0VTmSzGb5f+Bj+/IH7iAvut6Q5q/nRikvj2Sj4P9wM69qPoqzLUa24dV3n
 ZH3FpPvcUxqq9MAjiahzp5aPR46rBU8XPV4EwHx28MLYfCZr0j2xJ2+a67TF865QIeyH
 Qq88fxJ1g/B/DuMPPmlGnay1qcwYJQuC+Mz/bfjvWiwJ/ntV8a0u25qM3VFLDtvOdUfj
 J65PcE3DoB5Xt8uSrEpjuustOnn0V6/Kle8eNiqkx0vVyKZVh9WIJO+EphwS5B+O0otG
 kEmFpJoVd32v4OTuGy35mZ3QfhkAQpIBD2lowFWMDQfehEVJrXTCBElP6bpYNVL0r3TJ
 nY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692741873; x=1693346673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FhNkrEHy8FmRkibSbQLK5bDMCXrTTDXfIQ1rgX/TluI=;
 b=jCA6M4h3XNL62pYvFg0GBNz/b9h1xjeu9SWUzlRb4N5xEp3nNaU/Y4UhavSnEwReh7
 WNkB/IzYzU/I7kgF7DzaZk0gCZ++YBrmWMcMcwvGKKUDi72KJueZkW8Nn8tjzJ22xugM
 oDMC7s11rBqpKKdiPXqtjTOAu20WBOLcvw0Y/sY0sPX82I7BJlEW8I5G6B814QjjgBqT
 xzKhqBrQpmAepw0duw5irXHjPaZGBXiiA3CMRq839ooCmE0+NklW+0ssM0TZEbgaGmFR
 EKspPh9iG2UiyDOA0EbTwi+Nt5x7FwK51dtEUfWaNIfJp73j0+uJYxMhtClqsWq3IR+k
 MSWQ==
X-Gm-Message-State: AOJu0YzunYGz7/UzziW2jyRb6OegIElpRO2+R5P1fswKsg9w08+46fC+
 1yl0q3NPwjZzBLzQB6viYTZOOg==
X-Google-Smtp-Source: AGHT+IFF8sZdX7DIoioRXbE/OdLfaVuLfBFQXc02iEPeCvdleISAohVHj8go5ilWLHPoaZ+kc+wXFQ==
X-Received: by 2002:a5d:42ca:0:b0:319:7b66:7803 with SMTP id
 t10-20020a5d42ca000000b003197b667803mr8623578wrr.55.1692741872933; 
 Tue, 22 Aug 2023 15:04:32 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0031773a8e5c4sm16931321wrm.37.2023.08.22.15.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 15:04:32 -0700 (PDT)
Message-ID: <c845cfaa-e529-8260-9793-33cd33a7d1b8@linaro.org>
Date: Wed, 23 Aug 2023 00:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/7] tcg/tcg-op: Document bswap16() byte pattern
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-2-philmd@linaro.org>
 <c538a498-05e4-23ed-328e-7355436f6c7a@linaro.org>
 <09f4ba68-e7f3-8a90-e996-e475b760c64a@linaro.org>
 <408ba512-b15c-5284-8598-6653293a8f51@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <408ba512-b15c-5284-8598-6653293a8f51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 19:29, Richard Henderson wrote:
> On 8/22/23 10:22, Philippe Mathieu-Daudé wrote:
>>          } else {
>>              tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. (IZ=0) */
>>                                              /*       .ab. (IZ=1) */
>>          }
>>
>>          tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (IZ=1 or 
>> OZ=1) */
>>                                              /*     = ssba 
>> (OS=1)         */
>>                                              /*     = xxba (no 
>> flag)      */
> 
> Clearer with xaba for no flag?

Right :)

> Otherwise it looks ok.

Thanks!


