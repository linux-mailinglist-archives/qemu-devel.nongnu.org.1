Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801A07CFD92
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUag-0002MM-6b; Thu, 19 Oct 2023 11:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtUad-0002M9-Ts
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:05:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtUac-0001J0-DQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:05:35 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso5528217b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697727933; x=1698332733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKZF/uRaQUJBO9T+TMdFThONHyKPGc1tx90zbhDeoFI=;
 b=Ou7S7ny/W7EXaPVp4D3MvkTSPAPJQ6fPimIKVAYArvN64dAEhdCDtworQakWbEhGim
 s/6BfamqGRnCFESzmFcTkVKWo9sQXbG4Tvn8N0k1XS28ZP5HAVdKKq8mPFK01U8l0Zmi
 VgrdzBN7Tw/vfyXP2Z0OtGZUnjWTVGM2mDMeUAlo9KJNkPDxHm8mwK9sfE1sYWBcyCXA
 N42E/+kXKTcDnxvN8Bkfw49tjD9HfhddrQnDHO/APUZZuws056kBF5UWbFeQLMRPBmXK
 ZFFxh4a8Es2/vVzeMROs8U+knonjvr/pXxaDSBFXV9f7kLuIgq5rPIAYYJnBTII6dQd4
 AaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727933; x=1698332733;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKZF/uRaQUJBO9T+TMdFThONHyKPGc1tx90zbhDeoFI=;
 b=gu99zX9BtVV4vxht98AG1YT+i6GHHnkjY+1yx45653SVjq7QXskiY06foRr1VCBhDF
 QUPTDQHZUP6r3hT/qyni28N3ExZYF1dxL4edKV9oD7FX3nRqFfjeyXkHqO9XIqycjY1g
 b1+X7oVThikpxPrN8zX6rC/OztQV1fxN+Uz5vDZvUZyvb8OVP4Kijv8W/FSTTrKpBS1q
 elCViSKhEzfq09tgdAcneXvczXkgrDR8+4NTX0akOaJx+zDHNQd3eYb94Jl2os2OKpAd
 umcc7iwzYfvJMuX1irzGITZziuZmNp7ugiDqyG/2AbGwQqJBnaHPY/QwyKX9saymX/ov
 /c4g==
X-Gm-Message-State: AOJu0Ywe8pbGaQOJzzQapBc3Ltb8eMFe+OxZCYZeUEFBJfBbWPadndf9
 15eOqYKDmQ7q0AgJ0PH5npYd7w==
X-Google-Smtp-Source: AGHT+IE82MV0jaE0qya3omJ4aKSzULKLvNm0U/xGenVEbPY7SQbnAbIdTU1l7hQMRrKsgRjyZVs3mQ==
X-Received: by 2002:a05:6a20:da83:b0:163:2dc7:d077 with SMTP id
 iy3-20020a056a20da8300b001632dc7d077mr2882052pzb.55.1697727932787; 
 Thu, 19 Oct 2023 08:05:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006be0bd6a4d8sm5213528pfj.36.2023.10.19.08.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:05:32 -0700 (PDT)
Message-ID: <00b05b3f-10c9-4e93-b0e7-e11cef45fc65@linaro.org>
Date: Thu, 19 Oct 2023 08:05:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/i386: move remaining conditional operations
 to new decoder
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-17-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> Move long-displacement Jcc, SETcc and CMOVcc to the new decoder.
> While filling in the tables makes the code seem longer, the new
> emitters are all just one line of code.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 56 ++++++++++++++++++++++++++++++++
>   target/i386/tcg/decode-new.h     |  1 +
>   target/i386/tcg/emit.c.inc       | 10 ++++++
>   target/i386/tcg/translate.c      |  4 ++-
>   4 files changed, 70 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

