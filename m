Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A477D4345
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4Ts-00053b-8J; Mon, 23 Oct 2023 19:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Tk-0004wH-Ms
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:37:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qv4Ti-0001FT-4r
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:37:00 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so3197526b3a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698104211; x=1698709011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AhLrPyfDoiky8PjTGc4g3clGs5K6LmgJEHlOcD9aCw=;
 b=qrNDi1gk3pLfnN7NCCE6hX9blBP4sWdIFyj/chUoWKHOIq1ybIqcLk+BQJf1PHDtas
 tkrlFXS5hur3NgcKbknpO2T8YBSH9PwzP3WFhXjxmoXppIU23BAkcg3WhRWT8TZMuWI7
 aMP5iWgHX/zu77Shoinsy0gpasUhcpOWwtG/4wIO8gxKnw9PGVa4GBMPB5uRlmoqneyj
 Wgf3lOtqf/RuePmpGZ+ghvC7nd4epD6eLIkCCkzgfAhT/qRzdgIPV2qj9qAopZKco3Z6
 jVtVWj6QKtj/LY4Z/qSNRgS0E04hAx8UrZxJNCFNtWjByFwQZMgue91PUf8bkupC5sza
 sw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104211; x=1698709011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AhLrPyfDoiky8PjTGc4g3clGs5K6LmgJEHlOcD9aCw=;
 b=TFHaUALsRNOavw85EZx8wtL/4xDPV22thC+yDF+akep8ua4Ux11EHTSkapjWNdS2FM
 Ot79xbpemANcPohH1+qnZ5MRDYeI07YWgKUFIJr37sCoZPbTzCCw+C8Iuwf7M8yfL2lc
 B83ms5BDQuSs1BrPFOu9F+iHqB5SB3s4KC+mFMLNbMuri5VItyEdm2Kgnx/Wf8AzjfxP
 /Xr32zD5YQD8ATmGrNINsk3sUOFsE+dA/VJx46Eo7pIlSUPGGvoCcPsHc/p9D9iBu7Ps
 ISZOM24iuZjlKcuVUY4WGl4RdM7Hkq8vx1VTNTykhL9jmMJc2kkOX8UlYnbhUv46ln+n
 tTaQ==
X-Gm-Message-State: AOJu0Yx9n1Y98bWDlmRhHg3pkyIf3OynHL9eyIOMp4YXMmyukWGt34Kb
 uyn6kXRmG9Jdsg2zzPLQfncxrA==
X-Google-Smtp-Source: AGHT+IGaw7FQ+MEm/KuJYUkzwkmEIz0Oo2+VkkPtRhnRClW5bdb1VlkNkRMLwOARHQMFZn3/nKZIWA==
X-Received: by 2002:a05:6a00:b47:b0:68f:f650:3035 with SMTP id
 p7-20020a056a000b4700b0068ff6503035mr9860198pfo.12.1698104211205; 
 Mon, 23 Oct 2023 16:36:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a62f243000000b00682d79199e7sm6588355pfl.200.2023.10.23.16.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 16:36:50 -0700 (PDT)
Message-ID: <e7eb7fb3-81e4-4355-94d4-0e542d7e606c@linaro.org>
Date: Mon, 23 Oct 2023 16:36:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] target/cris: Use tcg_gen_extract_tl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231023160944.10692-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/cris/translate.c     | 3 +--
>   target/i386/tcg/translate.c | 9 +++------
>   2 files changed, 4 insertions(+), 8 deletions(-)

Accidental merge of two patches, but they both look fine.  :-)

With the split, to both:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

