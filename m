Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC9720D82
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5HTT-0002i8-G1; Fri, 02 Jun 2023 22:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HTP-0002dL-5M
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:58:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5HTN-0004yd-J3
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:58:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso24668695ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685761112; x=1688353112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kNrsoRKbastUWJLLGXL+8YUI563RvAXBaXvWZyu4W9o=;
 b=T+gcJAN+LtReWhZhYfv4LnhiESYzoNMi0MZubc49ef2D+SE/tvs87KAxtUUN2HRBit
 h14DQlhHHsWlSyt+SqAd5cKlq/2BG6NZAlr06b8X9Ngfr1JCwVJ+egK228XjDit7yamW
 Fk6B+MggRVcxiyj7CzteL7Exj0pbR63057yPXhlwl4yNmQ59LFUR8usD6xTqvtk+9alK
 Tp5weCsgALos9Pre/19Q0umW2rTLRjXtRtRO3lLFMEafbXaeRK7ThjuAkoiyNwkgdTJi
 zSLpPU0Go1R7T2fPd7um9gwbqa3dwdStIRz9+5AGHZyjl1FcUdTjcVL67P8Lb6KRnmqW
 YV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685761112; x=1688353112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kNrsoRKbastUWJLLGXL+8YUI563RvAXBaXvWZyu4W9o=;
 b=iSWhYRsOelYkwcjSG6l5RActEb9FVvM2qyXD41WFjsZWSeMgIcV3Rf11PcqUakE//U
 7j5ssyKCz03IzIDZBhlcADnDVW76k57S/eXGSrWUEW2bnsJlc+xz+NzZvWVu//yGwD96
 JXPrwW7DWGWOiNhjXKLQO93s/sXCKh8awW8+JRHn/dn6wgQe+dfmIga8wqAqli7cHGtT
 roLID26hL2LIr00QnNknPFntY6qc+ObDa85NOaUi0rmEtADAesh+L5YFo0NcsQErbH98
 IpeP5xaDvVtyKsPXUas3fEvJuIsmUz2+BZ21E9/EkA3EsIuBYuD5XVmN0RJHeoLXZ+SB
 xYPQ==
X-Gm-Message-State: AC+VfDyQm9WoGSoAMu/cGJ302N0zHOFY2eInt/XaKW9Bop6i4QGg6Vsn
 kVZR3XO1QRtkVyj6BkPdU152nKOd+BlMn9MSKzM=
X-Google-Smtp-Source: ACHHUZ4MPfGCvcrirWoIlp/DqYXfyFYbySea+tMvbmohVLs4XVvyMKdLatnhiyeYb2nBOh7bxvIaxQ==
X-Received: by 2002:a17:903:247:b0:1b0:3f89:9836 with SMTP id
 j7-20020a170903024700b001b03f899836mr1863378plh.22.1685761112184; 
 Fri, 02 Jun 2023 19:58:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a170902d48b00b0019e60c645b1sm1999282plg.305.2023.06.02.19.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 19:58:31 -0700 (PDT)
Message-ID: <995af08d-239a-f563-5da1-c2c245639d86@linaro.org>
Date: Fri, 2 Jun 2023 19:58:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, Robbin Ehn <rehn@rivosinc.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-riscv@nongnu.org
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <20230602-86a3d8d9fad1fb3464d28702@orel>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602-86a3d8d9fad1fb3464d28702@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 07:02, Andrew Jones wrote:
>> +struct riscv_hwprobe {
>> +    int64_t  key;
>> +    uint64_t value;
>> +};
> 
> The above is all uapi so Linux's arch/riscv/include/uapi/asm/hwprobe.h
> should be picked up on Linux header update. You'll need to modify the
> script, scripts/update-linux-headers.sh, to do that by adding a new
> riscv-specific block. Hacking this by importing the header file manually
> is fine for an RFC, but that should be a separate patch or part of the
> syscall define hack patch. And hack patches should be clearly tagged as
> "NOT FOR MERGE".


Not true.  linux-user/ never looks at linux-headers/.


r~

