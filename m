Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8F873F860
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4id-0001Gg-F4; Tue, 27 Jun 2023 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4iW-0001Br-5m
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:10:32 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4iU-0002vc-JK
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:10:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-98e109525d6so504042066b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687857029; x=1690449029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+iBqFf5SCCJQRtHPLyhXKRNyUdaT1rIOoyalzfHYpno=;
 b=JPBLxftocUV+/woWQdT7+BTbrbYMXuMiGUQrORsR0sdtuCBaaW1cns/PnOpXweVeWM
 Y0tBLa0Ok9OnHnmxNw7yFbuuIfS+xCphCRuKI/UW+VYxnIfwKmzWrpEPcz+dCM0N9Z/+
 BtJt+Iboc/egjRV/Y68qiKm10YyNyhccH5OWEgY5u7589loyCQ+5L9h4KiJm1OhpfAAW
 d0dSK5S3LcZoF6AwNjIzUI+L2TVTcX8jHN739flGEQ+gj4lW6lBdYNiE31PG5uNUqjKN
 JMoyjDFCeEkkgT0JjiOi4LuwBsiP2melBfPGc9Q5xsvCRkXpRw9NUC5busgcQfM9ttrO
 aJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857029; x=1690449029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+iBqFf5SCCJQRtHPLyhXKRNyUdaT1rIOoyalzfHYpno=;
 b=hnXdlpTMHEhj5XFXUvBoi7Inr4Sbc4RZAiFFMCn83r20xHuSuLn/503WBFgU7AzAPT
 pUDK4SLliT/VC/Fc1Co+RdT0n5EyLFbmmFgpdM+m+bQWSO0cdDPO0xHIuKw/TyJCOkU3
 0+6Bqqdp90nmpPQkWKf9fz07pldF8JfLDaR55pO+6NJuLNZPwq/06LIrGP9YmgnW6Ypy
 fkYockoZIvfrAfPK+n68eL3CZxWwrJMoNHjZ1cNv3iM/zrX7lx6NfS6yFod0XfaBc8vx
 CSTDqOftMCzTE5NnL58tOuajlxNhStCQPB3uslU+T8crw2KLBQQp8wGhe2p+S9urzVA/
 nibg==
X-Gm-Message-State: AC+VfDz1qaBc7Bsn+tVYXNwNTg3q4hzelw0QbqL9YYmNXj2yHn5S9yoE
 kbS89MQh+284kS5ncq+gkA3fVgR+mNOADt7zrrI=
X-Google-Smtp-Source: ACHHUZ4Syl9lZeM+Owrdzmke1aXHHNMoGWa0Qh/Lwr31+ctMFu7gVnGB3FqdQ2ORT1r740M+RCv0mg==
X-Received: by 2002:a17:907:7ba5:b0:982:4b35:c0b6 with SMTP id
 ne37-20020a1709077ba500b009824b35c0b6mr31007458ejc.1.1687857028992; 
 Tue, 27 Jun 2023 02:10:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 gg18-20020a170906e29200b0098d2d219649sm4337965ejb.174.2023.06.27.02.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:10:28 -0700 (PDT)
Message-ID: <ff76c3a3-b5e3-fdae-bdbc-eca0bef5090f@linaro.org>
Date: Tue, 27 Jun 2023 11:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/8] target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 21/6/23 20:06, Richard Henderson wrote:
> After the register window unwind, this is for a plain indirect
> branch with no further side effects.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


