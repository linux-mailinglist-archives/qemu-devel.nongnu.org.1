Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AF736867
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBY2c-0000YV-Ag; Tue, 20 Jun 2023 05:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY2a-0000YD-LR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:52:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBY2Y-00018b-Sa
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:52:48 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-988a2715b8cso386349666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687254765; x=1689846765;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fSAA2jv6zhu6v8eWxhBgRRuyPoyaMMXmJW5emtHojRI=;
 b=OOFiIiGlcCSwWOoOK9GQPjGTYvoXSkts/6+pcvdCmp6mrvCOCNOKMgfzKDKO4flR3s
 VdAbb9komZphjBQYutrqs6CdpmwgeeivA2S85dQv6wTkknmJ+OeCM6E7IP5v2pCSKerO
 XeoMFbQ77RNaOj3VwueMN4894kG/Vqz1Ye/JtS8/Mr7RlPoWD36WiY4R/SNzCAtWgF9B
 oFU4hZWkdSemJI6E5WpLTHza/Yp0LFa+f3TyGA/FSbKLBRRdHDFS4oouhQ5NmNbvF/cN
 Es21iiARWlUipUN+x74ZEv72BggovZYGiHUA9NRaKkZzleQdMN4p7XxRcoNiLO/DGEbu
 /oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687254765; x=1689846765;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSAA2jv6zhu6v8eWxhBgRRuyPoyaMMXmJW5emtHojRI=;
 b=MYLld54UaVFvG/zT7lb8L31B/djacOJpayiJQ7mqd6Al9IbqLsO3MnldC0OF64qHXJ
 +T00iIqXdrib3SegQGPygSoZBnKHVyxwXGNEuQyLPqqxdSiw7lY1qxeyifEfvPa/h/IR
 YuwgHViC/vlZxW2BAuzRtlwEkuv0/Bhn3EdHnxCnTZbL+aE3talAsbrMC4ffGg9v7QAE
 sWkU4XFC/gs/RC5qMUa8keJp+uBqcXgtHBP8WFHCAXPCrZWDU0Cc1tLal488T63B0JWV
 E5bAhK+CpzX6YS7HuXawXgslOnJu/ildnMGiWRvYxXcbve/NXXfeF3LV48SR36KgLvBU
 7pSA==
X-Gm-Message-State: AC+VfDzXFTt0xeJcWJfjxva6uNG+x6WoKjjdT+RSRaja2r0aD+W5vpCS
 E4qPOPQhLqD+AHtUedKTbPxFlKw4ligecZbtkKKvC3KG
X-Google-Smtp-Source: ACHHUZ7TXUwzLTgTxshjkKzOxj7TpPgunjnmQABSxz1/GMmbknmDhF1n/oxZ8kpdG6/ThSX2nFPwIw==
X-Received: by 2002:a17:906:6a0f:b0:988:686a:233 with SMTP id
 qw15-20020a1709066a0f00b00988686a0233mr6712569ejc.13.1687254764963; 
 Tue, 20 Jun 2023 02:52:44 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 y19-20020aa7c253000000b005148e981bd3sm888744edo.12.2023.06.20.02.52.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:52:44 -0700 (PDT)
Message-ID: <9153371d-be7d-f906-9b42-2a814d29e1f3@linaro.org>
Date: Tue, 20 Jun 2023 11:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/16] tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230620082611.770620-1-richard.henderson@linaro.org>
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

On 6/20/23 10:25, Richard Henderson wrote:
> The following changes since commit 48ab886d3da4f3ab94f79f6c0f8b4535b446bbfd:
> 
>    Merge tag 'pull-target-arm-20230619' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-06-19 16:32:25 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230620
> 
> for you to fetch changes up to d7ee93e24359703debf4137f4cc632563aa4e8d1:
> 
>    cputlb: Restrict SavedIOTLB to system emulation (2023-06-20 10:02:14 +0200)
> 
> ----------------------------------------------------------------
> tcg: Define _CALL_AIX for clang on ppc64
> accel/tcg: Build fix for macos catalina
> accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
> accel/tcg: Restrict SavedIOTLB to system emulation
> accel/tcg: Use generic 'helper-proto-common.h' header
> plugins: Remove unused 'exec/helper-proto.h' header
> *: Check for CONFIG_USER_ONLY instead of CONFIG_SOFTMMU

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


