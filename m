Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF89A7B5366
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIKL-0004Qu-4E; Mon, 02 Oct 2023 08:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIK7-0004Ku-Ix
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:46:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIK4-0004HT-9i
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:46:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso169480775e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696250809; x=1696855609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WykTm3KnL9X9QAdR9+EkFqurxM2QGEIQCal+gTeL7kA=;
 b=OKwoCHsOk4WkRSRmbo4vVSZT5TzJnY44cyFRJS+hoYn6krNRIJaI4cKNnOQg61AcZM
 FvafuGIyRL7b0G6pCDowgQapl6F0Kf0zo6xrSnpz378RcN2Krd+APTU22SwYwTHgLf44
 XqkgQXRlc9Fs/N3xXQcWjpI8I6El2gsjoP+CC/Ua46LR8epIRmC2KH7hhNYoEXMQTnXi
 hJK63xfemq5PfsPBs0bv0K1pymK+ASPs/SSSG/BOYHDqiSxyw/MNX5byeAjXABi4bsN/
 sPfU0faO+g8EO1LBl7P7TTbWbPVCcNbi688D2nczTec3B2F0eLGRmbEEUZjMfztcupw5
 xsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250809; x=1696855609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WykTm3KnL9X9QAdR9+EkFqurxM2QGEIQCal+gTeL7kA=;
 b=E1oatU8TUxQhgPRgurBTjIl525hszIHgvA0Vk2DYfLQ3o+5X9TeVOw37CpVmQE2U/r
 w6HJPYPQOx3Xih/ivhXcRzaAIxpNx/WKNsrR0Nn29Et3iscCStTZxYYVvflQ5IEFHP5q
 Vjbp/d3FCvvpxUx6On5NFLRQkQxE5Bx/gTEAOiE3pJrCQll88kjLeLc68gGtQh+w5b9J
 V9DKyvrtd7gXNxhbAfceLEVPo7ZRLPyqtHX7H8qbsm6preu3GUgyDqz/0VwYZjF57xqA
 t18tknv73fxY3r172EzdqYyOoy5yiTCnOwsRYXlUzOLbdv/w6PXeq+Ro4b6hzz7+fPNQ
 M4Hw==
X-Gm-Message-State: AOJu0Yw4y53U5s2ucnphd4Yn8B1fJJn6dv4gIQaoQUxJgIrN/5mJA6Vv
 PQU/PR5nnjsEXiupm8RXyQXIuQ==
X-Google-Smtp-Source: AGHT+IHOAkZwJDS2VfxSMi1TjauJ7EMjJhuBCysJFs0tmmK4WnmosUsCzVZbL5ze9/3ZaOH9W+x+2Q==
X-Received: by 2002:a5d:6950:0:b0:319:7656:3863 with SMTP id
 r16-20020a5d6950000000b0031976563863mr8906546wrw.47.1696250809492; 
 Mon, 02 Oct 2023 05:46:49 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 o22-20020a5d58d6000000b003176c6e87b1sm4715443wrf.81.2023.10.02.05.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 05:46:49 -0700 (PDT)
Message-ID: <1be9a97a-2f5d-889f-7c2c-3681dda02d00@linaro.org>
Date: Mon, 2 Oct 2023 14:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] MAINTAINERS: Adjust file list for PPC ref405ep machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231002122326.365368-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Cédric,

On 2/10/23 14:23, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce46..3f90264203cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1345,7 +1345,7 @@ PowerPC Machines
>   405 (ref405ep)
>   L: qemu-ppc@nongnu.org
>   S: Orphan
> -F: hw/ppc/ppc405_boards.c
> +F: hw/ppc/ppc405*

Do you mind adding tests/avocado/ppc_405.py?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


