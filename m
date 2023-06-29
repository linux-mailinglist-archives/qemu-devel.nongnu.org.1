Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F07426D1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErF9-0003HN-HV; Thu, 29 Jun 2023 08:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErF4-0003H1-S7
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:59:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErF3-0000NP-5s
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:59:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31409e8c145so696339f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688043554; x=1690635554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VQO2ckrFRTohI8w8jBxUswkLIjb7q5ZekMTiAF9kwk=;
 b=GIqPDw/x342GS07XoMPCCtNklTjrRM4RkLavwAjI6v/0gG96Hn/GtCBbEPTlBI4i2s
 xSIRG+CqwHJ2VlxnSaowQZkdovps7bJnVrJ40tfuPUHNYzMFik7mQpUa1LMCNK2Kjpwd
 SJppk+7xOtrNBkw43U/2rlHBLG8ds0juD+qenTu3vndxVYZ9AgY15xz6jsL2UXKo91CS
 pN128D8kve37zhdR8+F//SAVRSfmpOLW//Y+CdyZczl9njA/0n2S98Avlp+Dcj9lp3PX
 +IMskvc7Y189XkpVCEs34UBzJnNbTFUU36qUwvW1SiTS83+uCcDzaqzu0v/YhiEmZeeg
 bMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688043554; x=1690635554;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VQO2ckrFRTohI8w8jBxUswkLIjb7q5ZekMTiAF9kwk=;
 b=Lvd6LexA3OlYF0Mv7uMkyuCwxYAjAoCwYOLSAXRQLbnUkFpY4+oPd1nXSnq251PulB
 YCgkK6h9CbNGyW0bG5HQMLzl74H3UuZWoek+fn2ikYgVxb15XCOJJOiVnqrRGmygjSeu
 HjECaoRu438teUvKCIweU2etHg+6Qd27ufYzPF5Z/UpKuPjeFZaiMsxP76/Ymcf1vY+V
 8iJxmRhSqRWYpN185tobJZ1B27bLqc01RWQh9fsvNWa7uUqkPwot43PoVDMC4XhGRN3a
 nKMvNjKz0wTK9dQrK33I8M7HtJciBH8lJNjvY5i9vQbHvpSVczwEbeF7C3IPX1trZdpy
 DS8g==
X-Gm-Message-State: AC+VfDzfqHAeJEz1NornqWbDWVW7LTAGEJe832Zmc0OMwg54Rq0aYdT9
 nmtWvs/zxl/QXIUGQr7QHY/xlA==
X-Google-Smtp-Source: ACHHUZ5SyCSnwA4JonlM7Ch6IE8XmfFaE41Pv/lAO7FMt+4ZKrqkYl0EltedD7ORaiFlfwh24yv1uQ==
X-Received: by 2002:adf:e54f:0:b0:313:edaa:24f7 with SMTP id
 z15-20020adfe54f000000b00313edaa24f7mr11150377wrm.11.1688043554161; 
 Thu, 29 Jun 2023 05:59:14 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff845000000b003141b9ddab3sm913128wrq.114.2023.06.29.05.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 05:59:13 -0700 (PDT)
Message-ID: <4262fd2f-7d89-42b5-151b-0b6f4382bb9c@linaro.org>
Date: Thu, 29 Jun 2023 14:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/5] x86, main loop changes for 2023-06-29
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230629101918.9800-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/29/23 12:19, Paolo Bonzini wrote:
> The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:
> 
>    Merge tag 'pull-tcg-20230626' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-06-26 17:40:38 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 40a205da415e9c10ff02505078700e14ead77092:
> 
>    target/i386: emulate 64-bit ring 0 for linux-user if LM feature is set (2023-06-29 10:49:43 +0200)
> 
> ----------------------------------------------------------------
> * Make named CPU models usable for qemu-{i386,x86_64}
> * Fix backwards time with -icount auto

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


