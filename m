Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1B37C7C8B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9g1-0007GL-HD; Fri, 13 Oct 2023 00:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9g0-0007EH-07
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:21:28 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9fy-0008Dr-Hi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:21:27 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7ab9f1efecfso624467241.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170885; x=1697775685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9CldIcChCmi76IlfRtpMVJFIC5MqbRn/6eiJ8SW2DH8=;
 b=vnkKf/Bt210zALRcqIrwrzSNxMF6ddMcXhaW4g8D+qyHUU7C38ihtEosJE+ww1Rvye
 gj3VCNJ6UAEpIVwfPrVDgkjy+BCJVOeowrJDq5IelK4qnl5lHdE1Fndl1mB8pUpnNN1/
 fH8lYSbf76EeiMXD79HrqodEmd1zXRDbAjBsHyvbubqN6qV1q8TXTUxzt4xKu5bohJoZ
 ggfqFfGcSDcKZJm6oSIqv0k3V7pDyMI4Sx1UNMLMkzpjC44LMxNNo0SeeljKIZ3nPhKJ
 ZXoPHdTHeN3B3poMvpOwr+EQpMRw7Ea+uLW+55V5nrdz7+R45cgJKBqzfErhZQOuriLF
 sGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170885; x=1697775685;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9CldIcChCmi76IlfRtpMVJFIC5MqbRn/6eiJ8SW2DH8=;
 b=tvcrjdcMfV/vm36J/I5B8qzSn67qQFtqbdy0DuiIuqRjc5B4z4wig/2dpnmsff75C/
 zQDLDWg44q057OYEhVjoPIszic+u3ukinBDs1jtJw2MUgHK2xU2aY+LekzFtUQ3HJfhv
 9hi+yUPSpu4h0fgeQXROtBnU0t/ZeCZnuFbYzt6OKDZxghKZ4H811KiRcy8ca4aWT75u
 1WfsAnFIJIe2TyveJ4dVS1DvQKPV0XkywHwpc2cdJeKHN82QQbCV5Xg2NYy3Vr3w4gYv
 XjjVBrXqohP2n+LZeDjWS+oKLk9eu4nyu4RoUSWu0hmakQC4hOqqFX22/EHrvHoZbxWZ
 HPQw==
X-Gm-Message-State: AOJu0YyzM9rWbwXwNrw5gERGpJOSTptraBNVo5ryGq6BnFfCkQZsXjm9
 DnFGwm19/vgTCsFOsxoECGJZcQ==
X-Google-Smtp-Source: AGHT+IGdV5CmNo3VDr+mbSYsB1YntKef9+EvIxS40VAOriFMUmnxxByD4RUhIxlGHSYVE2LFJFZrMw==
X-Received: by 2002:a67:e3cd:0:b0:452:55f5:55e9 with SMTP id
 k13-20020a67e3cd000000b0045255f555e9mr24753770vsm.14.1697170885638; 
 Thu, 12 Oct 2023 21:21:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fa18-20020a056a002d1200b006829969e3b0sm12479047pfb.85.2023.10.12.21.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:21:25 -0700 (PDT)
Message-ID: <ab090a44-96b0-45ac-9c42-f64a26ea2899@linaro.org>
Date: Thu, 12 Oct 2023 21:21:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/sparc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ua1-x92b.google.com
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> In few commits we are going to add more types, so replace
> the type_register_static() to ease further reviews.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

