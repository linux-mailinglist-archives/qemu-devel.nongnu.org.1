Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4D7CD1D3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvPx-0008OL-3v; Tue, 17 Oct 2023 21:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvPv-0008O3-1R
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:32:11 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvPt-0002I2-Ek
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:32:10 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c4bad60a1aso3829410a34.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592728; x=1698197528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5cpwCrNFCAnJpw52aH4drcADNWDED5Ud2Jf1TGVy0SQ=;
 b=k2g+g+O9/uh9wC9k1N2NOfh6krOBOAITsIR0br77WE4z9KagqkDSsRB8HPKvL/vfaX
 GDbyQPmLo81zpisGeyOzEpLNQe34jwC159LuPrShHgPIpc60XSPxZj7LGOtutoHmVPUM
 Vswkmsg4EfQTYqnQP5h+eKU5LwxrjEaL1TZDOSHsFNRFNg6CbzEgZVeZ8Sfx0zlQtbeH
 tKsBJqvKJ1JfENpd+20xxhF0Fdyw4bTwc33MeDEn0CZqtIJCsxVZhqu+DPeIACclJ1wx
 sTHNrn7qrEFdhe+Fh1tEVqhRAE6/rF/EL+3BatIr/i+xVxxlHSd7R7+g55eaPcW+0FTx
 dd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592728; x=1698197528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5cpwCrNFCAnJpw52aH4drcADNWDED5Ud2Jf1TGVy0SQ=;
 b=nNua2Ot4P4mFBkG2cO1E3cueGw/ARKbIq2CXapptTvvdCE6BBvDo34QqCRCO1J6Lxc
 LGGg6b83oZxaiNemS+peIHEYsP4LLdXGm7EiwcokEPUJERlFI4P6n586b8mk3wHRHwHn
 aox1YRfcMyu257dQjOAItUKTyrMjzbYNnQB0fZRhZxDOzz6PcAZ6KNn7g7t6CoR7koI7
 RWt01V54Zu1t3pSCFVx6+Q+bSeE8pp9sJ6L/iEwao/wMqNoayeRt1StafmAN6nW04nEv
 DGNTcc59mfKFtTR/cJONI3nRJMrf8CzSi8fXsi7UpLo5zuhHZxIIb64HjGCe6kkeHxPh
 8qow==
X-Gm-Message-State: AOJu0YzzAvV32LIcVPX1hgbU1WFi+dI6ACOy3q5kvjb4jooqwE1gYSVH
 fuYBqoNB4O0DqxLLBQZtJgvEnQ==
X-Google-Smtp-Source: AGHT+IHzLjKP2pFY3PQyz2zzbLYOoqwslCYYnFT5q8Zj/VrfyEEDjEG/VKGmf+eZEeQmtr9yU+wXiw==
X-Received: by 2002:a05:6830:25d2:b0:6b9:a795:512f with SMTP id
 d18-20020a05683025d200b006b9a795512fmr4599348otu.10.1697592728144; 
 Tue, 17 Oct 2023 18:32:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a633758000000b005b18c53d73csm533648pgn.16.2023.10.17.18.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:32:07 -0700 (PDT)
Message-ID: <d8275c6d-f16c-4317-a54b-237b0684c7d0@linaro.org>
Date: Tue, 17 Oct 2023 18:32:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/i386: accept full MemOp in gen_ext_tl
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
> Use MO_SIGN to indicate signed vs. unsigned extension, and filter out
> bits other than MO_SIGN and MO_SIZE.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 4f6f9fa7e52..d7d6c85877d 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -699,18 +699,18 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
>       tcg_gen_shli_tl(s->T0, s->T0, ot);
>   };
>   
> -static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
> +static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp ot)
>   {
> -    switch (size) {
> +    switch (ot & MO_SIZE) {
>       case MO_8:
> -        if (sign) {
> +        if (ot & MO_SIGN) {
>               tcg_gen_ext8s_tl(dst, src);
>           } else {
>               tcg_gen_ext8u_tl(dst, src);
>           }
>           return dst;
>       case MO_16:
> -        if (sign) {
> +        if (ot & MO_SIGN) {
>               tcg_gen_ext16s_tl(dst, src);
>           } else {
>               tcg_gen_ext16u_tl(dst, src);

A reminder yet again that I should make this generic -- we've several copies in the code 
base...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

