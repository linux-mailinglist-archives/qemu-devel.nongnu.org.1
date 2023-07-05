Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E997487FF
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:27:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4PP-0003yV-Nl; Wed, 05 Jul 2023 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4PI-0003ry-Lx
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:27:04 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4PH-0004is-3h
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:27:04 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso103850371fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688570821; x=1691162821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IocW4CwpQNTxIBDycM4YHX89tc+iFcKux4nMChpwq/Q=;
 b=DMZOgEt0cnxUN3LNVeov94D5MG5u5lblsSuL1UfIF19rnfjdhyKnOtmFE9949dTcXQ
 RtBnBPw8PvjImYmEeuZdLo/CuIYbVCRGG4vCljEmj1T0fXtgBWswhhMJMbVQD98nOvCS
 IpXyxrK9ORCFWOco0zCYulhy1ya+LLu16aTHacI52uwTWOTrONvud1kY0A8GHVLhgZRM
 trweofOdjrDsRqdutiY3Gx6TomC/sE9f1i2eT6a+X+/sFSY8krjPQVbnYyM8xBTOhN08
 KFmE4zm1+tH0kfGuaVFbVi9IH44zcN3wLS8xl9PoL/srM/5Pd8HFyX8SWijomuYLfJK9
 bu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570821; x=1691162821;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IocW4CwpQNTxIBDycM4YHX89tc+iFcKux4nMChpwq/Q=;
 b=SjIEhyOOORbNID6Pve5snfTFt3+HVKUpOB5FzfM6/GgDHW83l2OBCf7OKxcnddhUB/
 Kref6BxsRx6jJaHoi/5mFOqiQM/alPhOnVbVqH065ZgYexlBGwupgzy1Hb5zOfdo7+RL
 YPFWRVIAkEt7lz0MqIj30WreXYACD8+wd5HD7wYgJz7qVXwx8BzA38IORnqy5H9gjJA7
 sEXAcEhuvwJ16OiOszNAKkRX+PJ+NXKOzPRTYOMcReLQx71Wy1BPQktsbCzXBQM5TaEC
 cRhCBcPsy1Cqsw6aGb0KIHybMQaKONsiMadbVTJzN5pAw6Yn5ns3+7OnvBqWPVdLLMNn
 nn/g==
X-Gm-Message-State: ABy/qLYfsmjfYO5wn40QlAvjqBNLue0t7pL5H+vVsZ0uYfwiP+YQK8Hz
 nyNkU7Q6zFn78Y6BJBIlcA/2EQ==
X-Google-Smtp-Source: APBJJlH41amlX/MBEsvKZtFXFikjMAHi8r7RgnNNnSlcpXLpumRmf9HZxLyHJn8fmsq1/OmfrG0Adg==
X-Received: by 2002:a2e:87cb:0:b0:2b6:e7b7:74b3 with SMTP id
 v11-20020a2e87cb000000b002b6e7b774b3mr7076601ljj.27.1688570821088; 
 Wed, 05 Jul 2023 08:27:01 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a2e3a14000000b002b6d9b061a7sm3103986lja.115.2023.07.05.08.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:27:00 -0700 (PDT)
Message-ID: <b7bab38b-7660-dbd4-11b7-5ef4cc7ef453@linaro.org>
Date: Wed, 5 Jul 2023 17:26:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/19] hw/timer/arm_timer: Move SP804 code around
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/4/23 16:49, Philippe Mathieu-Daudé wrote:
> Move sp804_properties[] and sp804_class_init() around
> with the rest of SP804 code code. What follows the
> "Integrator/CP timer module." is strictly ICP related.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

