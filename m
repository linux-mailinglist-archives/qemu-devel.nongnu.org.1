Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE3734CBD
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9iA-0002vf-2D; Mon, 19 Jun 2023 03:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9i5-0002vA-QI
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:54:01 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9hy-0007Di-3k
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:53:56 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso3868268e87.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687161230; x=1689753230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwQn+cxZZmM/7t4F9QM5Wy1b3ibHe2PWsJ7TnbktXPk=;
 b=WTTmTpvtyU2z+/2iKH0OrJosTS/F2L8a34wkC6/i7msX2Gd3PhH8gYAboKxrcl53SM
 dY7XNFPYba3smYjiDAINDfkLtcHdR+bBUcZvnFtLIGMehEr5rHqsEWTwpmbPTsd0Njd4
 M+Jkug8Dq3ibitNdXbp3A+IogPfqokVa21rf5xuBOwxKG8qtIubich26pwqvuLbFuWMU
 Sqf25jXmifC91h4Midrtc20K2H8RjGN1KLM9O+JRIEH1nCpqhafMpOzfxtLdoXVoMqNv
 5JA/SQAQJFwx4QmWoUR7/rZZNmkF+Eyt6l4AKOUoFLwGtNtQ4AJAU1qdIr1kp1HTU0bn
 cm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687161230; x=1689753230;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rwQn+cxZZmM/7t4F9QM5Wy1b3ibHe2PWsJ7TnbktXPk=;
 b=lgEPcCioMAc+B6pdDwF/wFlHk7VTr71f8h5Xg1Nv7fOWYO0lr/JkIYyVE2/DdxuahZ
 PhO6KdDaXMjNG1ugNcHhRVqTmVsj41MQvNohYN8Qsve8E4JUsGyfndjKOtDO/klQcuAN
 gEOqAwOhpGJTDcGFXL5IW3e8+Aa1fPU97wTLJDUmxqrKWb86tNEEBd9WENHMLawVq9yb
 4NmPbIqEJDQ/snXJYFaErbsaS5yAvc/3BEAdvhQJuljW8U4Nfmq2Qjw9naX1OtwNRLqM
 fCTdboxBzS+ZQgmRm6mJdqkq4gbzdRmxnEMGCjMvDthtO0laELM0YBCeDwFsy0rXH9aZ
 dTuQ==
X-Gm-Message-State: AC+VfDyGdUELVTZjss8cy9cpA6qDERg4eBINrZu62egHmyQZGcNvCRmR
 aJSfg8FQI7HMlX1Uqk9NHNYpLA==
X-Google-Smtp-Source: ACHHUZ4KcfZiMt+uPEWYFkSjTd9DoEjWPXSSzcNNTZDn8qHGTMX/nt7gTWs6ONE4EqlrmLlEnm83nQ==
X-Received: by 2002:ac2:5b46:0:b0:4f6:3677:54e with SMTP id
 i6-20020ac25b46000000b004f63677054emr4340112lfp.36.1687161230292; 
 Mon, 19 Jun 2023 00:53:50 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b003f9b3829269sm873088wmq.2.2023.06.19.00.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:53:49 -0700 (PDT)
Message-ID: <32a3d2a4-a7d0-f186-eb04-f4711cb8ffb4@linaro.org>
Date: Mon, 19 Jun 2023 09:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] target/i386: implement WBNOINVD in TCG
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> WBNOINVD is the same as INVD or WBINVD as far as TCG is concerned, but it does
> not generate a vmexit if the processor supports it.  If it does not, it is treated
> as WBINVD and generates a vmexit.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c           |  3 ++-
>   target/i386/tcg/translate.c | 10 +++++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

