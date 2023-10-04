Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E181D7B7806
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvYW-0006uL-Po; Wed, 04 Oct 2023 02:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvYT-0006u3-Kq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:40:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvYS-0004ss-3w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:40:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso1719362f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696401618; x=1697006418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBhVfeagGLvxjcW1Zk5jOEdtOy0qI92i9Xi5C4AgP6I=;
 b=K+M+GosJ+UhGNavt0c2B7T9O7Mj99owLgczxM4ov9rumeVZZdxgp9iBDFz1sD6H3a3
 wOkd4HCLGOusfz3unqnZ4HnV8MSCCLODWpS6jZK2RwqEV0XhYcXmhualDzxnVZ0ZmI5r
 ucszwd8m/eWRxoRqovHFf06VzfgZH/b8RMBU+Lup6DV7YZ+aQl6Y2+bFjqBoDKK79qPx
 jL0NrCZjNEbX8t3yfwc3Ib8Z2vFB476O+2rWhonU7sSP2jluy48+GkC8/O1NMDdiu3xa
 q9fVN9GGieoS8s/jFt8UPZMAYVmuD22jXdE5cCW9mfrF8zmZ4l4S9ZeHg+cB2bpqH+ew
 J6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696401618; x=1697006418;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBhVfeagGLvxjcW1Zk5jOEdtOy0qI92i9Xi5C4AgP6I=;
 b=glE0WiKLuYD4wbGerAsxA2JAm38gm474eh4uqHuriivNwjNz9LjPW9CBRP97AR1/8C
 EpHNdgrbdfcEoK8y0gYmPtUTGB/z03V3QAyLheBzUJ3R8nos1JQQsok3fB1oGaGggabL
 Vx9qrn5vYBYktjRvj8pS2WAtv02uPYUkK5/ZGU7ZEIKZbh7QbcQWC29Jb4HOkmrMzyLR
 7pnYy8dA0kD1hWRUrdqIYlq0qVvP2nPb8mmt8Nr2vIK8ZP8unSBL2gmWUJJ/Fn645sRV
 CxLB3spXjr4ITBdjVNDK5XD/p0QdEOAlKhUsfGgmGpEIaX5E9qOB9z5dgXNN5PcVG4ui
 pLtA==
X-Gm-Message-State: AOJu0Yx2xNcIGV+x0sLUml/GfdQzwRr6gKamVb3IFFzkMvXNYM92FmH9
 AmGg78LyWvraPKtSzi49w+ya4gvMFcHJUu1bIHE=
X-Google-Smtp-Source: AGHT+IEOlkd0ltrHwyx0lMmAfOwx0KY6E1yvaCY6mmB1m6QfZvfoOQXoiTh6HqaiOGRoYtAVZA4+iQ==
X-Received: by 2002:adf:e3ca:0:b0:321:6f5f:78ab with SMTP id
 k10-20020adfe3ca000000b003216f5f78abmr1240873wrm.56.1696401617897; 
 Tue, 03 Oct 2023 23:40:17 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 m9-20020a5d6a09000000b003232380ffd5sm3197499wru.106.2023.10.03.23.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:40:17 -0700 (PDT)
Message-ID: <6449302d-6378-868c-eb7a-37c4f6582219@linaro.org>
Date: Wed, 4 Oct 2023 08:40:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 08/10] tcg/ppc: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 284 ++++++++++++++++++++-------------------
>   1 file changed, 143 insertions(+), 141 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 90d76c2c2c..e378233568 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -103,9 +103,7 @@
>   
>   #define have_isel  (cpuinfo & CPUINFO_ISEL)
>   
> -#ifndef CONFIG_SOFTMMU
> -#define TCG_GUEST_BASE_REG 30
> -#endif
> +#define TCG_GUEST_BASE_REG  TCG_REG_R30

Unrelated cleanup, maybe mention it? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


