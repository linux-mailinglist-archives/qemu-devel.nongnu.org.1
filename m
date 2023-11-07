Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D4C7E3462
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:54:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0D93-0007gf-KU; Mon, 06 Nov 2023 22:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0D90-0007gQ-KM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:52:50 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0D8y-000172-Oz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:52:50 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso5550264b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699329167; x=1699933967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MtStEl1Iuz0J/tzNrTPPgVDlQMwweqDZ+fQtAYmhbZQ=;
 b=ng1BvH+j3rWQR1g6TIzXynocgQGfvLS5JSf+ss9p96Eqv5UHUVCMfYlnWAt8IMY5nR
 urnrX9zlumwdjxKKrYBEV6YdJeydORQIvSGh76mOKtQmT4OpMnmQRiH8Oy4ITkl2GfDM
 z50M+kvm09m5VEb2z51V++K72GL1MxA920AfNYvpFE3UnIJQLUg/6d5B+DoFGKftRT6d
 xInGxy2RPC0oHIUGvM7bJUXe49u1tKVp60V47D12MvOe/55sQEYs+0l+z7A42VraF9Ju
 1EFqKZK2jPuYW7RZCq4n6X+MCigNaWY2lOlz1eJmmWvmHXsSTUGu4AXn2thmssb0nRps
 Pshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699329167; x=1699933967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MtStEl1Iuz0J/tzNrTPPgVDlQMwweqDZ+fQtAYmhbZQ=;
 b=nMLqr/W7jAvoiVTfbUHC++o19v9shbSWT27Wiodr77lgqMwyOch5rVJ7GiiPC3Fway
 m4i+EKoPZzo1jlp/8AzHdw5VOr1X/TUzk/WT6slofNdgNN/w4s4GXYIkaghBm0yEPyg9
 8/5zC0YKbF0e6sZY8v6wUC/4lNJFwzlpCs15yQc2O/CJRWv0l5Oej/CYbEjdzYdpsuD6
 Zz4ARVcXLdr+BOdYurdiEqY98M7oBZLudBUY9yzDkuBxALaZnB9EeNSlvN/WHUNpWVdE
 VyChvsW8JhaAkM3EAVoueHnG4LG8onni+LABotaM+7/pDXpe9yRUyfPf+jTkf85+MxXb
 TsVg==
X-Gm-Message-State: AOJu0Yz08yMafXLizI5h8gqtzbHtVKTcoExsQVLLTyISbjucRbJVc9Rd
 wna0jLvwkyVXuqM72S0/5mWNPA==
X-Google-Smtp-Source: AGHT+IEKbiF0guNoYz/HRV65i+vKEdt4OM7H3XRFHjBS6tcHG0zq757euTnegCrI6KHpS5abRvQy6w==
X-Received: by 2002:a05:6a21:7185:b0:180:def9:20e1 with SMTP id
 wq5-20020a056a21718500b00180def920e1mr29010531pzb.22.1699329166799; 
 Mon, 06 Nov 2023 19:52:46 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a170902ea8b00b001c57aac6e5esm6584517plb.23.2023.11.06.19.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 19:52:46 -0800 (PST)
Message-ID: <941e40a0-b235-4c31-8e0d-6a1ac868e72a@linaro.org>
Date: Mon, 6 Nov 2023 19:52:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] target/arm: hide the 32bit version of PAR from
 gdbstub
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106185112.2755262-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 11/6/23 10:50, Alex Bennée wrote:
> This is a slightly hacky way to avoid duplicate PAR's in the system
> register XML we send to gdb which causes an alias. However the other
> alternative would be to post process ARMCPRegInfo once all registers
> have been defined looking for textual duplicates. And that seems like
> overkill.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-4-alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5dc0d20a84..104f9378b4 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3727,7 +3727,7 @@ static const ARMCPRegInfo vapa_cp_reginfo[] = {
>         .access = PL1_RW, .resetvalue = 0,
>         .bank_fieldoffsets = { offsetoflow32(CPUARMState, cp15.par_s),
>                                offsetoflow32(CPUARMState, cp15.par_ns) },
> -      .writefn = par_write },
> +      .writefn = par_write, .type = ARM_CP_NO_GDB },
>   #ifndef CONFIG_USER_ONLY
>       /* This underdecoding is safe because the reginfo is NO_RAW. */
>       { .name = "ATS", .cp = 15, .crn = 7, .crm = 8, .opc1 = 0, .opc2 = CP_ANY,

If the implementation includes LPAE, this is an alias of the full 64-bit register (the 
"other PAR", and so type should contain ARM_CP_ALIAS.

If the implementation does not include LPAE, this should not be ARM_CP_NO_GDB because 
there is no 64-bit alternate.


r~

