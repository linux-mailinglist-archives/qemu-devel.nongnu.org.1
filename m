Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FA7A1F7C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8VB-0008KB-RF; Fri, 15 Sep 2023 09:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh8V9-0008Jk-Ij
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:04:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh8V7-0002uk-W7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:04:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so22840305e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694783088; x=1695387888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0WECVfpBDqnCXAoco5E4r47dzdk3gGhiDzJr0Ee1ErQ=;
 b=rc5szWnnuX+gbddcQefM3N6I3wH8NThLdyAqzL0RNEXmKaGLLAzE/xZ2KmvpA5cDqA
 s/bzU8GBv4z4fYjUzksQYe4VEMPFJ3E7RWgreGamay5mTzV3MCq2WknaT5uApWZb3L6T
 HG3Kpos6r5NQ6qC3kfTbtmwpX3hG2DmIHVFj76NH4GZq9vZJpsFEzi6twMa+0eo0TFqD
 71ub/WAfUeLfazdqKzE64m0nXRbyNiRYWNtat0EUVWooLHo475Obmw/ZYqzQz4i7O8pG
 qZntDH2phQ5pJOP54nMTwZ66YcXI+VmAFy/hXmfsAzuznQGgjNCW8NS7eG532XOVqcSQ
 uIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694783088; x=1695387888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0WECVfpBDqnCXAoco5E4r47dzdk3gGhiDzJr0Ee1ErQ=;
 b=O14KrhfdB5tITtVbz3G2UN0fmzhw/kTIN30FqSSwPg0s7ExR9y0FRxBvZo54SciCQL
 tWwmg3SJP6iSRKkGovL7DAohxqxg8hQ5rCvBg16Ziv0maZro+sZ2mpM5K3FhGTP6swdZ
 lUEiyOn6ljYmo62c1NhEXyLsn6CwN5QU4C1hb5hna788o2S4Z3ZA8Ujy7RWJ/p8GVLI2
 36XzEed78Ndv1foIwIKOyhhXUoSEy404sqtdLoX0l4JIHEBlx+6E8vIdANgaKszKd3A/
 locwhmUFgHIu/yNcQKlranxogCpSUO5/0cmsD6HeIgE0XY4kWv88oT/6mJjx0dZra1fD
 bbRw==
X-Gm-Message-State: AOJu0YygmqnjRhXQwqj4k4pRAU5a1zxkgzFv4KOSO/KmY74jxQu4Qkd/
 VSoRk50m5v0HOokjwxgrwr0jEg==
X-Google-Smtp-Source: AGHT+IF6auDH9Q5LkyHlqa5E+S4y7GZF68t6pNPWADrbRICkcU9T+n6ZCby8hG4pCPqbrP5VVUlzlg==
X-Received: by 2002:a1c:ed19:0:b0:403:bb04:2908 with SMTP id
 l25-20020a1ced19000000b00403bb042908mr1380410wmh.23.1694783088225; 
 Fri, 15 Sep 2023 06:04:48 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 f4-20020adfdb44000000b00318147fd2d3sm4465500wrj.41.2023.09.15.06.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 06:04:47 -0700 (PDT)
Message-ID: <89f23f03-ea02-2300-89b4-12f006a4c786@linaro.org>
Date: Fri, 15 Sep 2023 15:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 npiggin@gmail.com, aik@ozlabs.ru, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20230915110507.194762-1-danielhb413@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 13:05, Daniel Henrique Barboza wrote:
> Update all relevant PowerPC entries as follows:
> 
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>    Nick has  been a solid contributor for the last couple of years and
>    has the required knowledge and motivation to drive the boat.
> 
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>    to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>    Kurz for all the years of service.
> 
> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>    KVM CPUs. Change done per his request.
> 
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>    PPC KVM CPUs. It has been a long since I last touched those areas and
>    it's not justified to be kept as maintainer in them.
> 
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>    don't have the required knowledge to justify it.
> 
> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>    better reflects the current state of the subsystem.
> 
> Acked-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   MAINTAINERS | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..c4aa1c1c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,11 +298,9 @@ F: hw/openrisc/
>   F: tests/tcg/openrisc/
>   
>   PowerPC TCG CPUs
> +M: Nicholas Piggin <npiggin@gmail.com>
>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>   R: Cédric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>

Thanks David and Greg for all you contributed so far!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


