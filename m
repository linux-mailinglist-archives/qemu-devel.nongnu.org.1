Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF872F40D
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Iqd-00041I-PB; Wed, 14 Jun 2023 01:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Iqa-0003zn-CA
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:15:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IqX-0000fO-5S
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:15:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4456631f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686719703; x=1689311703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MoyoJuP23Bw8Ze7mOXHxgQzuOcLqIfN5RWRdROWIjy4=;
 b=YIwc0YRI/azSD4oj7159JmDW0QkUrMOTXtds+kcn0SmPTiftV6Q6jTyrhGEZr0s6rQ
 AL5zlnz1WVLLBBtjtI58mqmzviM2t+s7wB0A7bolaFCEiJcrZ52F3IIiT3PW4j9OutXz
 W0NM6ghGR+boYpkycQllifWRaTsP8KGnE5nHCNwYcK4n1UMaqsyX2Ey2D/6KzABOULXm
 UPl+MHwBjNgb91PioJBdet4U510xFw76AIlvKaeTWizBndl+JEZw95BN4xZsQS2p0pwh
 4E2f10fMath50bNx+iCTaFpCN8ajNjVaY3GoNLrKJd8TyzxWMwcxee7rc0Uuvj9iCaDK
 v/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686719703; x=1689311703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MoyoJuP23Bw8Ze7mOXHxgQzuOcLqIfN5RWRdROWIjy4=;
 b=QxyhG9tFNxm14Xd3j/OuU3EEUnDeajwWWVYUbYzDKejPfSOJS+Yd8OnsqAxkpqL54t
 nFQ65Hu0fNVBswXK1ClAUFUo2MINwLLKMa6+KYiX4aIWoKKNcyBKNPD5E5XEf2MGwEbl
 wghZTDN2SbI7jP5ZRpiIjOSEANOQchagsywxd8bywDHjrukTXoLjC2Luec1xJsfHY8uh
 oWNxAKQWZCdJcPzOMLrPqS51yVAdVdvhxknCFT9bEXkNvnEvkXm46hlhJ4URqjYgOGHH
 P9YWEmwUdh3yOtu+EUu2louMen2K3lJ+zQvsOfM2ot65AXemXNOShEUmrW06kpJkwVR+
 xk8A==
X-Gm-Message-State: AC+VfDzPnAAYzBl2fpgFzPqVmcN9QgxVX3IkGvcDKjayvEJo6qv+bCNO
 vJEbuAqCbSwSOfls6LiXCbUIpA==
X-Google-Smtp-Source: ACHHUZ50pu8GtgFDj3ahlcOJXANBLw5oIguja3R/W+tpOa0elmUYpyS26WMiyVCRFe4wCqflFz8+sw==
X-Received: by 2002:a5d:67c4:0:b0:30e:590f:78d1 with SMTP id
 n4-20020a5d67c4000000b0030e590f78d1mr8259415wrw.63.1686719703405; 
 Tue, 13 Jun 2023 22:15:03 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 v17-20020adfedd1000000b0030630de6fbdsm16968233wro.13.2023.06.13.22.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:15:03 -0700 (PDT)
Message-ID: <f4bfc853-b926-6ae3-698e-9a4fbb75c76e@linaro.org>
Date: Wed, 14 Jun 2023 07:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/9] target/i386: Simplify i386_tr_init_disas_context()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230613133347.82210-1-philmd@linaro.org>
 <20230613133347.82210-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230613133347.82210-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 6/13/23 15:33, Philippe Mathieu-Daudé wrote:
> Since cpu_mmu_index() is well-defined for user-only,
> we can remove the surrounding #ifdef'ry entirely.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/tcg/translate.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

