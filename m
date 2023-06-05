Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDC17227C9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:46:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69rT-0005Vv-L3; Mon, 05 Jun 2023 09:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69rR-0005VQ-36
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:03:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69rP-0000DG-Gx
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 09:03:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so41488365e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685970178; x=1688562178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+yrKqgPntAWyufNw8CuYl/BeDCOpaUC7xOldtX0XrE=;
 b=mm0nIbn6XddKx/DaHD6jouJJjjWd39nkEl2ZeTVuhWshrq/lBtNpVPA3dfaL0mUY4x
 lppt1SRuYk/HRT8cBKvmSpvKvP6HQzh/xmoamiG0Vttl4LtxURoF8KYFcigIACVj7ysl
 hqIoIZLnPDkT8K4WKj8Q/CiL1kroMc5FF/eSQtIEMYPOGSKwyxOpXqm6OemJejD1XG7M
 BZe9EdH6DN/iP1FboAO5OsEuXk0ITFvAAXQsCecGiPyvl2HtIOH1clchFftmZOuML+fd
 OsABS0Jz/TL+er5t8hvUvpnfSl7Z1yXA/zaTA6Rc71uD60Le4NZk5QkKesEpN6/jDzD3
 P4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685970178; x=1688562178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+yrKqgPntAWyufNw8CuYl/BeDCOpaUC7xOldtX0XrE=;
 b=K7hUMm8vL4FzD2/NFU3L+CYRd6vQ9tdzMrKOVVovnv5TeeEj163F7xAoziTG3yfs0j
 DZXpqgnneFnIwJWUlozShKnTvdPRWyaXjq+GZhzNBZQbJS7D3bZNIsuj7qzISmrW+SQl
 CsmXEAmqxJtnFy5esJNFPLoNh0L0M1WKjzgWiNoHL6rTatpbliChPNgaP1XlwYSX35Fl
 71srdFxpYBw02fAM1f+b/mgG/hqTE1lvUKMWiUPCb+njL7v3tjCPgLv5XQV8K8zgIch9
 s/eZoucXW0LKyImc3GgTRlvvP3ALgQeCXmLsNl9rij1rx+fXJg8Ne5nsWbIi8N9eRfIH
 1AxA==
X-Gm-Message-State: AC+VfDwtRJ4LKR/l6wmbWtML20CUIF/+MKXHhaTMKFuWDdyimAzCcAE4
 NFW7jcFhsELTqViWG53ccNj1zw==
X-Google-Smtp-Source: ACHHUZ4OWtTqPqKr4VrC5Il5FHFz9hZyx6qZC/kmSEjgFC+IFDAXyV+FagW/5k9uBv2qXL3KsEaT8A==
X-Received: by 2002:a5d:58f1:0:b0:309:4123:4968 with SMTP id
 f17-20020a5d58f1000000b0030941234968mr4410689wrd.13.1685970177825; 
 Mon, 05 Jun 2023 06:02:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 y6-20020adfd086000000b0030631a599a0sm9680533wrh.24.2023.06.05.06.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:02:57 -0700 (PDT)
Message-ID: <d1dddac6-7f1e-1361-e9f3-d1668bd31eef@linaro.org>
Date: Mon, 5 Jun 2023 15:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 01/15] linux-user: Reformat syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/6/23 00:23, Richard Henderson wrote:
> Untabify and re-indent.
> We had a mix of 2, 3, 4, and 8 space indentation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 1948 ++++++++++++++++++-------------------
>   1 file changed, 974 insertions(+), 974 deletions(-)

'git-diff --ignore-all-space' -> no change.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


