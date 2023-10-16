Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124067C9FDF
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHNE-0000wg-0I; Mon, 16 Oct 2023 02:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHNB-0000wX-1a
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:46:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHN8-0007ec-PZ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:46:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so40426075e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438795; x=1698043595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RMwhouC39etd1I7l4Mn/F84Dl85xSOzVKwshVRx+jRc=;
 b=q/sAPjhpuMGezGvNIlCWoCvEeocDmDDQTPAU2kOSzCwXN/WW0ZCRfVUhoR4dI0tNnT
 KIkR64YR9t9FfaEXJargzdKE4nOsTZ7NNxECarhKMYR65PlYErW7RlIaqGxVUBlFlZL2
 VjJebo9UCo1UvI7JHGwX3nANDvQOW9dGiyRfP9KL61b0rT2WMANWLFM+IyL+rr9IqVJW
 /GxWiInd6BdssvSMNbFuraHMIIOhpqVwff1gpNDqorv9/lf8w3foNJaKTj32eJbz7uIs
 mMQszbnnnFClfabn7DMvb2QouzfYhEyI2RaDrERDZF+ofpoH92igjrtdFkPT/6eycFTh
 C2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438795; x=1698043595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMwhouC39etd1I7l4Mn/F84Dl85xSOzVKwshVRx+jRc=;
 b=l4CI8sBQVEWWVvTh3LrpoKA01AulJex6bmIbidyJbLtIBQkPzLeltIiaQ7DUpRIl2P
 61+kuIJZC6gS+IAO7rk5fS/FIkK8GEHimQOlgWAC/pJUQX8wnZaJdNuKuPp+6z9BYHUF
 rS/Q98+B/64Ijp1M27eNorupkCgH7Wi/JKQ/6yn7bt43rJ4mNrdxrK+eMsk2YUpo53Bc
 WN3vhptu5D107jQtz597cTEykV7ox/e4cd5twOem7YfXMEzI+79kn70QZ/qVaQ5CEasE
 HpCNG2z1iZKMt2DJ8R3EqTOe4/Dg0uCnceWla40YTYmOOlqaEMMohe78QEuoXsG8Tmeq
 WMTw==
X-Gm-Message-State: AOJu0YykLiF3mfL4xtHrvNKc2IMnHVG0RqdFPohX2FmUcOOFgl2aCEiL
 RJ60PuE+DF+u8n4JRROcARNpKw==
X-Google-Smtp-Source: AGHT+IHBFRUXwv5d7cR9NmZPjyN9KReagq4tNqZO9P8+XD/VnICoIlPJuxbQYUEUWcbrH4nqY8iusg==
X-Received: by 2002:a05:600c:2116:b0:405:4743:de12 with SMTP id
 u22-20020a05600c211600b004054743de12mr28716030wml.21.1697438795550; 
 Sun, 15 Oct 2023 23:46:35 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 az42-20020a05600c602a00b004063ea92492sm6255344wmb.22.2023.10.15.23.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 23:46:35 -0700 (PDT)
Message-ID: <e290034c-c533-650f-7031-e60e92c3536b@linaro.org>
Date: Mon, 16 Oct 2023 08:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 01/85] target/sparc: Set TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20231013212846.165724-1-richard.henderson@linaro.org>
 <20231013212846.165724-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013212846.165724-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 23:27, Richard Henderson wrote:
> Always use TSO, per the Oracle 2015 manual.
> This is slightly less restrictive than the TCG_MO_ALL default,
> and happens to match the i386 model, which will eliminate a few
> extra barriers on that host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


