Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FDE74BE96
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBe1-0003nZ-LP; Sat, 08 Jul 2023 13:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBdz-0003nA-Ap
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:22:51 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBdx-0005dV-Rm
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:22:51 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9939fbb7191so574737266b.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688836968; x=1691428968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFXhPbWy61iJtRj+ZuUvFxrT2pwdqr/OArFh6WTMQNs=;
 b=TE/JgFHvOIHB7Qwg/GSY1PUJBVFz/hcIUFfEpxorQv2okNGyu4fFqPWUJfmK9zfoCy
 1+PtO+PuiFHTpOTAdmYlPJFyzLgl/pkPdtrTDLzTShpvr00T4hV6W8f9EVUh+DUMJ9va
 l0Qa29JsNt/mq0EBfLXyxZ50cqcCIEkuE26PGllOmwqWJcm2Huby+ymysuWj+o2UAFCj
 dG4UgIEHwZI3LC250yFS+Ik3EJ7+RFeLgTe8Czy8TC6cy+nTc9LZw2OGnHNG88Hcz7q6
 rFfBfd+YLtII5RnzH1Wc5ZruGPr/dlDzrrxrI3PNVki5obXgzyPNPp344e1tL5n2IJP4
 Akdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688836968; x=1691428968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFXhPbWy61iJtRj+ZuUvFxrT2pwdqr/OArFh6WTMQNs=;
 b=iab7xgu9Y2ecojofgBN8eM8GWJThoEt9CUIzvf+psAD+q9BvpjGN8j9N1w9rhujTMi
 9sMDTyb2z1TdwD4Tjvr6sW5YFwgV2MOTXCk4LoCZ36qxLyQUjrk8bxXJVw7A276cD8S1
 bNAg131OpsRsBf7Ay4T9ncC9p7QaAcEyaSA7aC0OzvuC5XSxAnuYSDLq4Ff7UiBZ1ZEl
 CgWhV/4qjIaMZzWN+9tKOuONDzH5E/zTaesROSDO7+lD29qiofVKcHQ5nzsarN21iWQ7
 NoJ+bcrot+B6DvP1q5S5R/ZI1gw/dmeDhrC+gyzyb5wUlH+Q+lT0vpsdEHJujZW4El1b
 BJ0g==
X-Gm-Message-State: ABy/qLaSR6GmhQ4YiGUt8OgNUIZp34bcFMcTWVxl3R3Y3PXFzSanShYv
 qWSMgWUKsnATSoTQP2UhHB0Wiw==
X-Google-Smtp-Source: APBJJlHx79xtAZ25a+cBV3Yp1LTIdl2Nr9tbSu4eyf2XG7z53LaAxyqp2WgzTPMToVQtL3kO0Un1tw==
X-Received: by 2002:a17:907:86a3:b0:982:a022:a540 with SMTP id
 qa35-20020a17090786a300b00982a022a540mr12296627ejc.11.1688836968371; 
 Sat, 08 Jul 2023 10:22:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 qq28-20020a17090720dc00b0098e38d2e584sm3693408ejb.43.2023.07.08.10.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:22:48 -0700 (PDT)
Message-ID: <ba37fb19-7037-40a3-e5d7-cd6c4e041634@linaro.org>
Date: Sat, 8 Jul 2023 19:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 31/37] target/riscv: Use aesdec_IMC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-32-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AES64IM instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/crypto_helper.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


