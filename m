Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1319973693A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYZ4-0002U3-D2; Tue, 20 Jun 2023 06:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYZ2-0002TZ-G7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:26:20 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYZ0-0001IP-Qn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:26:20 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9887ebe16d0so329588766b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256777; x=1689848777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nwdDszDlzLCLFatPsRx58PbO78B5B1qE3QUyEDNKFD0=;
 b=ZQ8I/5+k7IfdAmu3rdQv6yqqufznqgtKOHmjiPi5SoV/n/bE5oCTxvwmo3y7IClZga
 DrF7456xqoh2LhERZbaUC270Mn0PedMOZ/RJBA0xdtDWr2Z8Tdk+tazr0/NDMp1ntvlK
 Ij3reOkfbYp5hvXgshe6pU2xXTM/t0Zwfhz9iLiOg+89PZjCFZ7w1796tlULYTqTmrua
 eo0gXaQoKtzdN91DN3KEauvhi0IMxp8IcEFnYSkZ3M06LvDpAmRQa32BcRdtukOG9rg0
 MekrSn2iS9k5aOjm+s6G9DxFytOJNz9x2HHLYyqQ8wknsD4gSnh0ldKH+Kc26Cm2Dqg5
 HzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256777; x=1689848777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwdDszDlzLCLFatPsRx58PbO78B5B1qE3QUyEDNKFD0=;
 b=gbvGNHo8i99/MRJW0JagJjGoltYfx7DXXcPsGpzq8ZL843Q13swowBkjg/JtkPFo6w
 5+DWxzLkSOdZFbpZh8NwbAsK7M7d9b+9n0QiFrDOF3vbS8gJXapzPxFZdcPZypYxKdxN
 XfWnSGc2mdf502IA9lyb05lCNehHgWIaw+lH6/9G6UiBQoL8Y6t2E2v7G+tLOO1RCSxS
 +jFNqTN2NcbaHqJhtDcABMdrSV+mkxuSF7NcOIAn/IHobHyGSiLEpQfEMZ0BWE9zMsyn
 rb2cMMBYJfzzcK+JdS8TLLQxIRKuto/P6ZcRf9NLd+rSJ1TZyzY6Ysob+SiHXw+XqGe1
 vPWw==
X-Gm-Message-State: AC+VfDx66Mp+5sOpcPxqab37W+kDdwzlwa4iYVH6mFLdfnO50OftCw1Q
 MDzX/yaRqBb1CzBLUKW0foQ9Ew==
X-Google-Smtp-Source: ACHHUZ4vCrJk5Qt5W4I3HSegn+qQw6ifpJKYwpWnZE+HLG+B1O1IW+qHiaMyAwDvMSmmegjuUBoRiw==
X-Received: by 2002:a17:907:9306:b0:97f:3d6f:93b8 with SMTP id
 bu6-20020a170907930600b0097f3d6f93b8mr11107399ejc.43.1687256777231; 
 Tue, 20 Jun 2023 03:26:17 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a170906b31600b00982c0ac984asm1123276ejz.176.2023.06.20.03.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:26:16 -0700 (PDT)
Message-ID: <aae59859-81a3-c719-b111-d8588e90f723@linaro.org>
Date: Tue, 20 Jun 2023 12:26:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 16/34] target/arm/tcg: Extract generic vector helpers
 to translate-gvec.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> Extract 1600 lines from the big enough translate.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate-gvec.c | 1644 +++++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c      | 1630 ------------------------------
>   target/arm/tcg/meson.build      |    1 +
>   3 files changed, 1645 insertions(+), 1630 deletions(-)
>   create mode 100644 target/arm/tcg/translate-gvec.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

