Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F37E1678
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzk0H-0004tG-Jw; Sun, 05 Nov 2023 15:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzk0F-0004sy-Jh
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:45:51 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzk0E-0007jn-3p
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:45:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc3542e328so24399395ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699217148; x=1699821948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aON9PUnPNCBPHUWAXq3+fkXVrOGocjWXKgYi+lkpAFc=;
 b=xcbGi9phAoWhcie1XdEhBw9vbPh+lRrKntL1IupVq63WyQL2pk1YpPxyN6BzRAS4Oo
 NT/Mihkfh6uKDDfWZ4Tpy002vkeeD4AIF+Xq675T4sKlidP8H+8SuLcZJ5oPfUdWN4AH
 BfZDW/+lCNuN2u4BOrd7ojkMM46ny5gk06AXe/XupcXOaTPZt2N5KW7kPlDlCsH/Wf03
 eLmM6JmBbo9vxOEd+OCH+XSBz+2E6FrsK+wX0xIcx0pLdO+wwDgC6QlpvoNOqBRHJiah
 1h5in7A4+krtRYRFDYaFhKFPOZ9xtee/LWgqv51tME/m6+SjqoT3ojb9fUiJr2C+w9wz
 lRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699217148; x=1699821948;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aON9PUnPNCBPHUWAXq3+fkXVrOGocjWXKgYi+lkpAFc=;
 b=oy1QFUAiFcVfCl4imdaJMVDjYF2nLZma0DGKXAWmOZ/8NkhMf0NKrU6X4aEhHmwbFe
 GYdpdE+WIntcFyixjbGyjCJNhXOHF3KTYNS3Mz1Xd23zAl2dJky4rK2VHMR2EmXJebns
 eLIVUI+mznPDgG+nCiUjnKFT6/OLy2c33n9gfZUDtv65iCQapYBUbb6r8jqHnXLXrUZj
 EMZx0PLclOn/0E3haHM/BG1Q30ZkS6xNnGHfHso+dNB/RZFEx12uj4Fkl90Vum0t5bmY
 zT0Vgywi+TxE+2a8mII/vXRD5OR6CFoQt8tgyZtYCHP1/DCfAXSzAZOAtY+eE3WV5Xkk
 urcA==
X-Gm-Message-State: AOJu0Yyu9Bj5P7Ki2gq2GgSUSwWj0pT1dRf23kcJ6qjpKAJaT12A0E9l
 zYwcb0XtSj9PKX8MsTEJ2TwU2Q==
X-Google-Smtp-Source: AGHT+IGC2UM1af6L5P4T0fMlGS+yC0rpNvhVH3AtMDXcIvslGbXx7azGjRkFsLnPmyLsRjRoCHBlPw==
X-Received: by 2002:a17:902:ecd2:b0:1cc:6dfa:ca55 with SMTP id
 a18-20020a170902ecd200b001cc6dfaca55mr17131276plh.25.1699217147936; 
 Sun, 05 Nov 2023 12:45:47 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a1709028f9400b001c9b5b63e36sm4514319plo.32.2023.11.05.12.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 12:45:47 -0800 (PST)
Message-ID: <5ed73ae2-5e38-44fc-a575-82149e9685bc@linaro.org>
Date: Sun, 5 Nov 2023 12:45:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/29] gdb-xml: fix duplicate register in arm-neon.xml
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
 <20231103195956.1998255-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231103195956.1998255-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 11/3/23 12:59, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdb-xml/arm-neon.xml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdb-xml/arm-neon.xml b/gdb-xml/arm-neon.xml
> index 9dce0a996f..d61f6b8549 100644
> --- a/gdb-xml/arm-neon.xml
> +++ b/gdb-xml/arm-neon.xml
> @@ -76,7 +76,7 @@
>     <reg name="q8" bitsize="128" type="neon_q"/>
>     <reg name="q9" bitsize="128" type="neon_q"/>
>     <reg name="q10" bitsize="128" type="neon_q"/>
> -  <reg name="q10" bitsize="128" type="neon_q"/>
> +  <reg name="q11" bitsize="128" type="neon_q"/>
>     <reg name="q12" bitsize="128" type="neon_q"/>
>     <reg name="q13" bitsize="128" type="neon_q"/>
>     <reg name="q14" bitsize="128" type="neon_q"/>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

