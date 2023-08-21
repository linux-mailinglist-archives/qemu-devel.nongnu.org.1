Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD8782385
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyEq-0001uh-WF; Mon, 21 Aug 2023 02:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyEo-0001tF-BV
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:18:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyEl-0006BN-JE
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:18:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fef3c3277bso1156395e9.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692598682; x=1693203482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gl1eOXu8iN7Kzx956eSc8+DM/IwL9/EWz9C+OcIYleo=;
 b=G6wbMkkuVZuzvgda16Ed2H0QKsO4W/bBecLy9OIOqZ9Rg2lGl07aozi6HADgGHYD5a
 L6GgtpFgFHBIE0dpw6WQdvHy81Myec1C1lPDJc/+YiN3wRHS2QMj4HRTHiVufNBWo7lg
 TAWlA1eTitXfbpXQZwDOCdjS1v48BDtbW20Sb5QTSnipsswzmXro4dlLUvaD48sL9Q66
 eketLE7AOfczr3IK7HmIMU+AgPm+wHRY+YUYPYkZgszvJUMfoNOUlKSb4qdmgOW1qhXa
 ZqB1hQBHE7/5YtqtSVTWsHQaSryIgitNlnv0GpEd0F4g4YxNzSXYB3iw5lYBAEOBh26l
 VKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692598682; x=1693203482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gl1eOXu8iN7Kzx956eSc8+DM/IwL9/EWz9C+OcIYleo=;
 b=VtNjOp2RtCcFJ/+1aK0XtFtiXKBybuXJzzS6ydkh9kMVr3CsHT1aZeCHtEvCtmdEIi
 7M5BgRAcqyrfiWabyRitIgkv49EK1pDhZ09aeVG/slvRWrfvhyAsDjJ2QGhh+F+UPPc9
 eUN6zKXvotNbYkGjeuz2y+TvRn/6CdHvhyz3PTh83fR1vyZ1zv1ci5Plh/b1EIgRKgAP
 yP+xZqgh6DNuxd5MJ+BIQcNQ2E6cE+rOcmlR0vgQOqEowNF9LsYnRogxayu0VFJDBcs2
 JBhOonK1RwhU2J+VZJE9DTa/gyAXwsKAW9+tp/NId5p04kAw71vDGqjp04FDz2fVdd6e
 9A7A==
X-Gm-Message-State: AOJu0YwBhBW2sBFGJGsi+2T/m3jmlNZvI1BlDUqWsgq/AjUS+/4ZmYnP
 PYT/tx/93Z6YJK1I0f2wYhyhsQ==
X-Google-Smtp-Source: AGHT+IF+7IgJeC1qEJWOIpu6yhx2qpm9bC2u68HHQbFhYq65VhQbzvYaA6Aaesv5Amw2/CQ3XpODCQ==
X-Received: by 2002:a5d:5962:0:b0:319:7b96:a1be with SMTP id
 e34-20020a5d5962000000b003197b96a1bemr3274272wri.71.1692598681971; 
 Sun, 20 Aug 2023 23:18:01 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 n16-20020adfe790000000b0030ae53550f5sm11153442wrm.51.2023.08.20.23.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:18:01 -0700 (PDT)
Message-ID: <d4465e1c-c01d-568a-a002-818f56a391e6@linaro.org>
Date: Mon, 21 Aug 2023 08:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] target/arm: Fix 64-bit SSRA
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20230821022025.397682-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230821022025.397682-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 21/8/23 04:20, Richard Henderson wrote:
> Typo applied byte-wise shift instead of double-word shift.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 631e565450c ("target/arm: Create gen_gvec_[us]sra")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1779
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


