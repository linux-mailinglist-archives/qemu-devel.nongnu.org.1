Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84189827A1E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:17:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwzE-00070X-FW; Mon, 08 Jan 2024 16:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwzC-00070I-HB
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:16:42 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMwzB-0000ow-1n
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:16:42 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b267007fso970628b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704748599; x=1705353399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lbGaZWex2OUKKq6WOfTecnw9l714LReYotC+p6RZMpY=;
 b=NCFUf9Q0uR80enXAkFINZGYJDRyJM2QbhPxecqH14MmJC471kWDR1cBC0YT+aZST01
 oP7ybpBWh15hupyakV+NPb3KfXZMjbQLYRGT3KiewjyO6VfauaadGrGfJvEnMxwY/Q56
 w1HHZs4kjWEYkTetkmmMPffXv8K9jfOrSKAlIf3njl6EnnAyFO2rqH54Wot2g0S20vOP
 X4bT+Kk5774+oRcOND+U5jyklap3zkrWTYnIpvUg4sunjPg2g9OXX8Bg2/i1ASMym9JC
 R64rH740BT1IOUMKQj5pDZudj6iG9uUwNjwXWfLkuFdJyD0UW55ikt/K9O9+lfqfktM5
 hTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704748599; x=1705353399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbGaZWex2OUKKq6WOfTecnw9l714LReYotC+p6RZMpY=;
 b=LecPNgHX2A2sPlz0rH1vOZr9t0PCSkzVP4jYv18WijTzMFEHIzZzTOKQK6o2SY7r1/
 Y++7ueDWzBAKcl74I0MP6oJuOUGBWCoaRA82cOjpeorY0AyRT8K5YcTPzVayAn/7k7kr
 kAonYLDYGL89GpAATpagQP3tDmvrrJYy96w47UurQA48aCwmU3zmH1b2v+GP1l/edIEG
 /E1dMitJRT85UJ+jGbP74fNDJh0O3jOHiN4WFFjFnrbKRF3PVsS2r20xm6LzT7VsSdQn
 ISiDfQOO7RoBGC34HjKMYldGnifh6Jr6uP6x0JWFigSekzhGQNoPxt7U9AC/2ZZGqZOk
 QVWA==
X-Gm-Message-State: AOJu0YyR0W2Vl2OKwC2w2A0ZzSFFdCwkRR71jtBiRKZ4gveqBOlBpS6o
 WMe4DWHa0KvCoXAVezc4lNHoqT6tpV1m5g==
X-Google-Smtp-Source: AGHT+IHWXDr0CijZZ6W7pd5AHNC64Bu5BeWmEJdvllecdfQw4nUY/WZhoQmwEYLD3eW3+TLu5GNnNA==
X-Received: by 2002:a05:6a00:2e09:b0:6d9:b5ba:3ddb with SMTP id
 fc9-20020a056a002e0900b006d9b5ba3ddbmr1907005pfb.11.1704748599522; 
 Mon, 08 Jan 2024 13:16:39 -0800 (PST)
Received: from [192.168.1.66] ([103.194.3.133])
 by smtp.gmail.com with ESMTPSA id
 p30-20020a056a0026de00b006d99cbe22f5sm300466pfw.217.2024.01.08.13.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 13:16:39 -0800 (PST)
Message-ID: <de87c8e2-7b16-42d0-b127-8b2961ce2f12@linaro.org>
Date: Tue, 9 Jan 2024 08:16:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] accel/tcg: Remove tb_invalidate_phys_page() from
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231130205600.35727-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130205600.35727-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/1/23 07:56, Philippe Mathieu-Daudé wrote:
> Since previous commit, tb_invalidate_phys_page() is not used
> anymore in system emulation. Make it static for user emulation
> and remove its public declaration in "exec/translate-all.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231130203241.31099-1-philmd@linaro.org>
> ---
>   include/exec/translate-all.h |  1 -
>   accel/tcg/tb-maint.c         | 24 +-----------------------
>   2 files changed, 1 insertion(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

