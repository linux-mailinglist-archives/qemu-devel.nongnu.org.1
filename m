Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2C7CF46A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:50:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPeN-0007Wu-CM; Thu, 19 Oct 2023 05:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPeL-0007Wi-9m
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:49:05 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPeJ-0004jK-Qz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:49:05 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so97690251fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697708942; x=1698313742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F8dJprYjAVYtACxJJpDlR13K2te6/IFiqx7NrkJ99cI=;
 b=b3zT//rgOc5vZWw8K7sDe4eO3tn8qKG0zmPQhy5DIRnPKLDwfMQWPMEjkUSdW2h/7j
 4ODbAaas9oS/AcUV2spTB0Pp3mcDC8cE6Y7Tfkf8I/RmZ0UdIXf4Zpd9bWIOANE4zBbM
 29FT7BsIYNZNR76JOr/Aa19zZyqjelUOSimGe3RFLiXBLjMDnTkGlXONJCnuUAX9aGiP
 zx/7PPr5cseYGl7gseFLkI2FfWT4phM5BvjahGRlth5hNM1TJLANJHCSciArOwQSvUzH
 FdNUlpW4qdgktVP8frkURMdlnpRnHqYdbIDO6R3q0R56qG/xvs/5Jy0j6yAoFHo5ftP4
 zKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708942; x=1698313742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F8dJprYjAVYtACxJJpDlR13K2te6/IFiqx7NrkJ99cI=;
 b=fbUIwQAUdSIJOvOV139y6h9qpmGFn5ONM9/illYCpebWi8HotLqvTOX0ClSB9ofew/
 3naj1N3aY1FPEwbjuNBMlXALbmtJIZhcl8fIYca5+yeOn6i+rJK2ipMUYv34tUETwtrU
 lDwWOEz9hIOmMHGiU6Rj61L5hsGQfafpuHHccWXs+4DRttBOU2x7jYTlsQlp7eKYoYJ4
 wBYB3AzR+FKZjcGOrOWka8HZrAZved7W0PWm9FABCpFkOGD8tImF47ARUfuAt8GblVp/
 abj2YupSQ1DmFQ0zcvPW95bHQAHB6ZiKsrwKLfTdmPmVNCo0139Y7NXQeqk1m4jb+dk3
 psAw==
X-Gm-Message-State: AOJu0Yyih5/KnqPSeGDyprcVreEC6rZ5MI2fRcsP4zORCFPedcLu2s3m
 vVYxSx6KDxCWiuP2OOkvaT8CBA==
X-Google-Smtp-Source: AGHT+IElSrB6cQy9ewSl691LnCrBVSXgjgGyfd0depHqqdzm+YjmROLoato8pWoXAifugCPUi3LB/g==
X-Received: by 2002:a2e:9b0a:0:b0:2c4:feef:852 with SMTP id
 u10-20020a2e9b0a000000b002c4feef0852mr924447lji.32.1697708941987; 
 Thu, 19 Oct 2023 02:49:01 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 w13-20020a05600c474d00b004067e905f44sm4087003wmo.9.2023.10.19.02.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:49:01 -0700 (PDT)
Message-ID: <c956c061-36dd-ed32-a3e9-b6a26bdf4073@linaro.org>
Date: Thu, 19 Oct 2023 11:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 27/61] linux-user/hppa: Fixes for TARGET_ABI32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
 <20231018215135.1561375-28-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018215135.1561375-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 18/10/23 23:51, Richard Henderson wrote:
> Avoid target_ulong and use abi_* types.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/hppa/signal.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


