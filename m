Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCC7C7C88
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9fP-0006ff-LH; Fri, 13 Oct 2023 00:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9fL-0006fP-Am
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:20:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9fJ-0007k1-7Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:20:46 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-690bd8f89baso1367365b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170843; x=1697775643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ejsxDmwLsRItc1LirtO9se56wZEU4pDTazi1tCu+w8c=;
 b=RX4MVl8R7oA8mOz9DlmuP4p0xe+FGAWahycUfeQlwBLq+AvH7qZQMP709BKu0jMwDt
 FuVdyctiTgjKgmimy0kgeT4dxfFuvUnpFUhVc0MRWIJFCCUum38F3A94tcx170KD/QRy
 ThqhJ3U2e0a8Lz2nO7RHNTZyBoZEjQX6YEK+y4GL2TbgZkoVKQsDlMWrB0p0DrkRbaMx
 /QNtywO0+R1KZDexsS3Eqnll0KHUdAYSMSN9XGdQsKC8DekttybE65cGYMXF6fKLyBiQ
 qD9DTOoTns+am4JKB3VnUuL46BeWzoEyxciZZTgs6Zuv/iuQcoAgb2dlMAwcxjIKxzFP
 yr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170843; x=1697775643;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejsxDmwLsRItc1LirtO9se56wZEU4pDTazi1tCu+w8c=;
 b=G8CbUlt2AihhU/CYGFs9XApyC8e1qh2yi+/pKQkws0SSLit+9n9f5KYrIBeU1+rQJ5
 UvxLf+Np3/mt20U3kooyqaG6E11h1j8//VUOz2kmjqrbfUcwwBFpuI1VfSTcErkOprbr
 mFOVpuRfZG7jAYTR2vgQ01IGAD2RloTOyDo24TYTqs9d8BTRqIR1v3zIb7iGVy5Gp+yS
 zx1S7Nyw9vkhMVrSsRIUhl4dVdQz8PjFzx/IzM0GVzphy7je9ncWEia0Ux3ZlV6fPUUR
 Rbf6u89ItEuxTPIzeNSBZog7RQYTkOe2TOGozbO4O4l+Turf4fRD1cKqDGxz/w7ynewH
 BzNA==
X-Gm-Message-State: AOJu0YzdqHhem++U5sC3Q5t20wR88vJLBghCpgNBrFXEdIlk9K5hL1Bv
 vQ/XNDSXzJzO2gIiNr4fYAmlCQ==
X-Google-Smtp-Source: AGHT+IFbgvgAXWSi/cynQnRgQBhkTRmUmdWhkr9DKxXCq4ANyqO3E5sAGqdouoAlx6XPXnJtgchAGA==
X-Received: by 2002:a05:6a00:1a8a:b0:68f:c865:5ba8 with SMTP id
 e10-20020a056a001a8a00b0068fc8655ba8mr26756116pfv.18.1697170842889; 
 Thu, 12 Oct 2023 21:20:42 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fa18-20020a056a002d1200b006829969e3b0sm12479047pfb.85.2023.10.12.21.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:20:42 -0700 (PDT)
Message-ID: <e06e9bfc-4907-4e36-9bbd-0252f26352aa@linaro.org>
Date: Thu, 12 Oct 2023 21:20:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/ppc: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-14-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
>   target/ppc/cpu_init.c | 52 +++++++++++++++++++------------------------
>   1 file changed, 23 insertions(+), 29 deletions(-)'

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

