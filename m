Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA12C705880
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz159-0006PG-If; Tue, 16 May 2023 16:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz14z-0006Lv-Kq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:15:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz14w-0001hC-Mh
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:15:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6434e65d808so15348748b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684268125; x=1686860125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ALXpJK+7DvrwDIzFYeRW/niyeZZakhY3E0cVXl3WYM=;
 b=TwFDu7rtTa6LjGV++Bmgn0r85y2wxsc/aPLH/Zpw7De2yW5hH+Lg/QO/5yERz2kUY4
 ebJvrPOFPO9yz8+fcNr8S9q3e6fCXrac1l6ohI7dA7QSg816wFMeypJ6C4MidAcnCtsT
 zZ248FZwHW6lY7ePbckCNCv835K8u3Cmvt0w2BEV7Z06OB0LDAMt0PchxgOFaQLEzBbg
 /4lzU5rLBWwoHKY0YmirOMPdiRMw7GSph1os+jWA5YXrDv+l/ywAzD+N+UR2bvA8oulL
 j4t3kbpu3WDXsoPxIlll0MkOiutVZZ4SHsccRNacd5ACaP0oyVRE+ILNYtTZ8i5K/gR4
 630Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684268125; x=1686860125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ALXpJK+7DvrwDIzFYeRW/niyeZZakhY3E0cVXl3WYM=;
 b=XArDmIkFqyN58d1WRCmB/M6jkPlEuU+hsbPu7EG8LoO37enhhg83s0KhY82jIvEBQx
 pjtAkQVHue6MU87J5pjxpe+3Skj2iOgks3N/imNm7nMMN/sLWbXU8sL4GaafdoH8NQkN
 lm50O6NjPA7bgCL5Wp9K+xKXbmVbX3jVSjGr/C0L6esWmH5F0VhgHAk9hiy4A8GlYkOn
 6cfeSGb7UmpXwyRdzlM8RZRi5z+onBuygaOQfvuZkD3ocdbrsPIQkc6SaDyu7idZacvW
 skZs3q3yUTm3mkgVOIGa6a7aJwn3ydt9TrNqupCB+zACkf5Nuu5+hb0BkA/Z9VOFLvLY
 bnMQ==
X-Gm-Message-State: AC+VfDyNiiucNIJ30Ejku/k6yScnWIzlaB+F/uIt+N2A3C+WBqKX/pVt
 UPlXChB44OCzu+3LQhHUhcdRuYl/7tutjEmwDFU=
X-Google-Smtp-Source: ACHHUZ4Ve8SjrPj1cbkCmbn54jgjwpggfpu5pCqPbikKnjRUM2L9WXbSWXX9SP/P5C9hviilOsMZkg==
X-Received: by 2002:a05:6a00:2408:b0:63f:18ae:1d5f with SMTP id
 z8-20020a056a00240800b0063f18ae1d5fmr49249310pfh.29.1684268124728; 
 Tue, 16 May 2023 13:15:24 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 x20-20020aa793b4000000b0063d2bb0d107sm13886101pff.64.2023.05.16.13.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 13:15:24 -0700 (PDT)
Message-ID: <91729126-1e70-2d80-88f4-c636199dba6a@linaro.org>
Date: Tue, 16 May 2023 13:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anders Roxell <anders.roxell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230516104420.407912-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230516104420.407912-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 03:44, Alex Bennée wrote:
> The commit b3aa2f2128 (target/arm: provide stubs for more external
> debug registers) was added to handle HyperV's unconditional usage of
> Debug Communications Channel. It turns out that Linux will similarly
> break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".
> 
> Extend the registers we RAZ/WI set to avoid this.
> 
> Cc: Anders Roxell<anders.roxell@linaro.org>
> Cc: Evgeny Iakovlev<eiakovlev@linux.microsoft.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/debug_helper.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

