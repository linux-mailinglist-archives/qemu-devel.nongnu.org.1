Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627477FB5D4
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:31:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uR1-0003jt-BO; Tue, 28 Nov 2023 04:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uQy-0003jM-9o
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:31:13 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uQv-000117-VJ
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:31:12 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54bb260100eso354475a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701163868; x=1701768668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Svy5cZsWqt/aCpwc6dh9SFoxobLMcvkgoTmp1ZdyvkI=;
 b=GMoXx9lltWlWsxHrduxLSvRh4i6BsvttqcwU9eiLnS1aS3xid6jlXyJMd/tODoyzku
 fkVAeXRhudyxmj+vmaga4WvTR7Q73+QLV5S1zxd/o4v3KE735SAhHTmXy+zEbsmN8CZ+
 DGz+74EJhLsLZGj5jnsmDW7Ic5kEm/YuHeB/ITZlaFdoCD4RNf9HRlHdIwVwFcS6QLuz
 oWAWZ+fClS2cOOUHtmTrdl+DbRBOkqlh8A5gxMDLzBun/X5k2UXD1/YHL4GDNrt3M/Rd
 EjBztR3YElupb9I7cXLevQgCvJ5JhZS7dyl03+eDoeoXmyFQiQFmWbld65Y9DBFsPWsb
 CuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701163868; x=1701768668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Svy5cZsWqt/aCpwc6dh9SFoxobLMcvkgoTmp1ZdyvkI=;
 b=jE6VWwK3KjMXm8vJPVJAkNHnnbh1E9oM12kjXoE27Je/VhtHjoruZjCLUSXyLGYGE8
 Cgsg9uadfMPG7RTEy01cEZ9XdJhQ4yEz7be43yLy2xuutFwJfee1V2aEuhn8PkFhlZEe
 Et3jtJ2cd1aETwZhc0yWSfMZGxsyxgc3uaC+C7memRQtVK6/pbNGxy04p5K7Tm1PByg0
 LkLKL46Sdo1xerWq6XDp1XAeqj5+OW2Ctl/LzYzW7d8jV6/kQPh6BRIPKKfO3iuBStzC
 PMyFpWzl9NuJ53kch2Fg8ki/NIfHivsGUbPrG0KO+3tJQe4U7xPLB1S4Cq1hNDpktWE4
 6mdQ==
X-Gm-Message-State: AOJu0Yz24csjvwfGZUiZNvrC08XWgT9h64MFT91ic5492d9kajSU1yJZ
 VBXGNVI+AmSM/JwA7PREFiVyQA==
X-Google-Smtp-Source: AGHT+IFqUsDF+RVlE2BX6Askw8qiiNL1dI9AH+T0oIUMAtfpQmZf7W3jypqkw/ODV/G7VCXK3skYJg==
X-Received: by 2002:a17:906:6c9a:b0:a11:d39e:8c6f with SMTP id
 s26-20020a1709066c9a00b00a11d39e8c6fmr2754961ejr.54.1701163868206; 
 Tue, 28 Nov 2023 01:31:08 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 bw24-20020a170906c1d800b009fc24437439sm6580993ejb.158.2023.11.28.01.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:31:07 -0800 (PST)
Message-ID: <44b6f4f2-0d30-45bd-8ee4-b481aa1b2943@linaro.org>
Date: Tue, 28 Nov 2023 10:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] hw/arm: Check CPU type in machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, richard.henderson@linaro.org,
 quic_llindhol@quicinc.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231126231210.112820-1-gshan@redhat.com>
 <20231126231210.112820-8-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231126231210.112820-8-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/11/23 00:12, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can
> be validated in machine_run_board_init(). We needn't to do it by
> ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/bananapi_m2u.c   | 12 ++++++------
>   hw/arm/cubieboard.c     | 12 ++++++------
>   hw/arm/mps2-tz.c        | 26 ++++++++++++++++++++------
>   hw/arm/mps2.c           | 26 ++++++++++++++++++++------
>   hw/arm/msf2-som.c       | 12 ++++++------
>   hw/arm/musca.c          | 12 +++++-------
>   hw/arm/npcm7xx_boards.c | 12 +++++-------
>   hw/arm/orangepi.c       | 12 ++++++------
>   8 files changed, 74 insertions(+), 50 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


