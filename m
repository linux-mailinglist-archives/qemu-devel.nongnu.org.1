Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962AE7CA385
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:07:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJZD-0007Rn-FP; Mon, 16 Oct 2023 05:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJYx-0007Mq-Rs
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:07:00 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJYp-0004Ll-At
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:06:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32da4ffd7e5so930779f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447209; x=1698052009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O2V9hpjQiKiHVOCG7nYioqSFTs/DcxhCPNGy30xR+r4=;
 b=rK/Qe1lficQ3AoIjOTiV6B0dFklCLJQkO/yaDAszJB6YWn0PsaPhvTkJiSbj+/7YaJ
 Ny/NbvdCfO0ymECnZMO0TJ+8GMqbAGrnh8Y5X+vEPEQIMyCuhn0dH90/S0VTJSMj8zrm
 k0vUDXYW5TV+D1VL5guEm1WiOEt7SuxPHp4vCqJP3BFuOZj6ljX+WVlypW2+IcK22jvQ
 z4CBae8ELaQ4VHmOSGdR8jmLQHjAmMQJnWICugwZwJbLxSkLEIDcmRTAMW2vyAMHvudj
 cr+9j5imsURz+ckHjjrDaJdf8CjTy1Yx5mnJ+PHhXIx7XHQ2RA82EBkgD2lFNehdrrmJ
 qT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447209; x=1698052009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O2V9hpjQiKiHVOCG7nYioqSFTs/DcxhCPNGy30xR+r4=;
 b=opwnT2+pqio9usXL4u5xjGlNXufa2Tf+zYzhVFgAtP7oVH9LllggHQ7hI17mZSB+sS
 EAgRI9VDLXpn0xsDxVDriZDPvGm8267BHJfdmoDhcdMb6vKy+m8IdZtofmhqwvCPVvtE
 gvjG89pVlnKCVGCHIGZAIpB5XXk+J9M6mLScUXedChKXKw6zlSwktD7S0/V4mZf30cOn
 lITl9/Qr7M4ZcIP1hfswSRq9io/9Q5nk86wakpSku7gqZz0a9dzANOaw8sPyJC9Fw0I4
 O+T2PEZRzZyPQPvTguyF6MuXyPDKqwI31dg+2tLZkOxuIviWeRp6fFupTvgKA/mHB5b5
 Vojg==
X-Gm-Message-State: AOJu0YzG9D5ZeMOFZ6WAcpG1i30HhdZgQzX0MVKzRc8btIIS02q90EVb
 ncpGpSJAax/KlcSS6KkJsHdgsQ0fG02Ai0Hge4Q=
X-Google-Smtp-Source: AGHT+IE7maFOZ772/eoaAkvqy9hUoMueb3TEMSp+DoRkVTaxW3hKzQQjiUdRi7LFGvp6ma+d5ZhLDw==
X-Received: by 2002:adf:efd0:0:b0:32d:a89f:ad4 with SMTP id
 i16-20020adfefd0000000b0032da89f0ad4mr3631451wrp.32.1697447209510; 
 Mon, 16 Oct 2023 02:06:49 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a5d4c52000000b003197869bcd7sm2679271wrt.13.2023.10.16.02.06.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:06:49 -0700 (PDT)
Message-ID: <b48f35cb-8adf-eb4b-3dce-687565d4889d@linaro.org>
Date: Mon, 16 Oct 2023 11:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/mips/malta: Use sdram_type enum from
 'hw/i2c/smbus_eeprom.h'
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard
 <cminyard@mvista.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20231009092127.49778-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009092127.49778-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 9/10/23 11:21, Philippe Mathieu-Daudé wrote:
> Since commit 93198b6cad ("i2c: Split smbus into parts") the SDRAM
> types are enumerated as sdram_type in "hw/i2c/smbus_eeprom.h".
> 
> Using the enum removes this global shadow warning:
> 
>    hw/mips/malta.c:209:12: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>        enum { SDR = 0x4, DDR2 = 0x8 } type;
>               ^
>    include/hw/i2c/smbus_eeprom.h:33:19: note: previous declaration is here
>    enum sdram_type { SDR = 0x4, DDR = 0x7, DDR2 = 0x8 };
>                      ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/malta.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued to mips-next.


