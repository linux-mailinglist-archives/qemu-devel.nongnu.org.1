Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BACF8330B0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:10:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQx3V-0006K2-6N; Fri, 19 Jan 2024 17:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx3R-0006I5-IH
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:09:37 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx3O-0004BB-9j
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:09:36 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-337b583453bso1190539f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705702172; x=1706306972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2kWvwYum0VJeUadMbcb0UAEo5a7kX9/EZDRsw8Xkk9I=;
 b=Yvn7ksCEJ852n4pQ82kH4PeXBGfk9XRBkJNWp/+7Hf5B8l89pBuR0UVa/cdbRNiHaC
 RHh1luh0kLfAqU2ArMxnaHHXebcQapEnat9ldg4FbHR0hzO1BATlkd5D2TldwTDGkiO6
 wkoQI6OnclO1GH8mK/Dk6QcU+o1BMBpYBfhUGZrCX5bcqNswmZUNq9Ol5qATawHnsfNC
 YV1NSRPiI4t/pjI6kXitk9zjbPE3qnxN+mzHQMD9K1kMwv9UxmIpQaydlMjcglg7h52Z
 lrOvCjdcgrNPF2svfjGMAa22jdJDyhfG+ioHHyfTsZSkfOBzJvhTEICIgjQIf4NuV2Gm
 R59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705702172; x=1706306972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2kWvwYum0VJeUadMbcb0UAEo5a7kX9/EZDRsw8Xkk9I=;
 b=dGrsBU6aqFal0bsUbL6uIcv/Dqj17c9QCnSlxsF1WkGla1U//sqhmZqMCz+5YoZ1vK
 JjLEDI/D4eAOJ0HndTfSj0xPLMCHgfFkCkJaovr+m0dqle88W73apQ2cI0PYWgt7pmiU
 ouF9QzA5nlQWMbLwDlvmCMCf1W0d4kAvhbfkn9hynPrQg6uNudgxswyABQlaCr6relwc
 zZ1cFgSZyL0Zo95NL49xwW5y0jgT3TH/p8oN4sVjaSW4nYI+tM7BNCdk6PT9y103g7ZN
 uxdeEY8ZnlsFBUhI/v+23GfzQVL5zh1TnMZQ2RDWgH9ERi5TmPZz9KI7OlsYEvjb/TMG
 /hAg==
X-Gm-Message-State: AOJu0YxWqt1Y2SnVTdaTVNTi3WpOKYpIOfalo/nOhi0IdEiWRqdEsCv9
 RNd/rgUeaOaN+weya3hKqihvLg5EVuV6nPsH02Pb4waxJIoJL4lRheNjkZnnwECDNm2SN2SA5A8
 B
X-Google-Smtp-Source: AGHT+IFD5V+u0iFuL7FlxxmIx7JPNCFWntR5H31Kd7BIxUUn1FZq6Z0lVx4d1D0ESmTxO63svhWipA==
X-Received: by 2002:a7b:cbc7:0:b0:40e:4919:e2f0 with SMTP id
 n7-20020a7bcbc7000000b0040e4919e2f0mr164859wmi.232.1705702172645; 
 Fri, 19 Jan 2024 14:09:32 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a05600c350600b0040c6d559490sm30475433wmq.3.2024.01.19.14.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 14:09:32 -0800 (PST)
Message-ID: <15d41678-1b41-4d26-a029-bc8bcdf1d933@linaro.org>
Date: Fri, 19 Jan 2024 23:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] tcg/aarch64: Support TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 10/1/24 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-con-set.h |  5 +--
>   tcg/aarch64/tcg-target-con-str.h |  1 +
>   tcg/aarch64/tcg-target.h         |  2 +-
>   tcg/aarch64/tcg-target.c.inc     | 56 ++++++++++++++++++++++----------
>   4 files changed, 44 insertions(+), 20 deletions(-)

To the best of my Aarch64 knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


