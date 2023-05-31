Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC1B718BC5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:26:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4TJd-0002jE-8p; Wed, 31 May 2023 17:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TJa-0002iL-7O
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:25:06 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4TJY-0003hV-HM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 17:25:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6077660c6so1396925e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685568303; x=1688160303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0V54Tz/ZjKoXhw4vVemxDaVRdhdSjZge2c5T2uSCwGA=;
 b=zNmKUy0ep8K8eSMQUFIabD07EBpkV/FBHut+inZE12da39AF0XizXQv07IzPDyM9s0
 SF2KWCxrLHGkWZOOBiX3iOs0i+/CWmHNOwLsGps0cIjNbHIidANIHzO7At6xhDqsCX+0
 dypP3Zbv93IXSDAQcUEZxBhp0JJHqOm8ex2ZJJNkXjE04mu92FNBgymN8l/heDditwLg
 cjZMJa/2LGLQBeTsJFjcbX+A8yPRZQ/kdzvdHnn/85gFEzYrNQvJ/x9EyGqODjGM/kKc
 HNbVaiddKXh9VHeHDiuETXtqxaw5vCw8rymYyp8qKnrpU/eIIk4cUC94rqX7mNocGcvF
 UH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685568303; x=1688160303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0V54Tz/ZjKoXhw4vVemxDaVRdhdSjZge2c5T2uSCwGA=;
 b=KtHxJEEANZun00JXjzarXzNWMaUKuaVBiLN3HhjQQ3u9y+eSRvLeyh0vXdDt/cq8pJ
 QBLA01xQwFT3X5VH4Bs9uhMCFKoEGvSiSaBlsIyLCVp2dRdLPWF1LIE6fhrAEbiFooWk
 0DKQqC1VchEw0vHp5N347HQ0b0kIigP0Axw+hYh+FNCOEQZI81jeeZKrL10GUUM9ysph
 sW89G+BcBmn+6hxEl0yb+RZTxWclIDQK4N2hbqtSeCvIitrUpNZnqEAtqPdBbz6hiq3Y
 It+fvgvE7DcJJtblUs4R5sUa5TrvaAM6YCIeLdf23f8Qfsv5JHf53ALA6IL/JSIU5vnf
 2GyQ==
X-Gm-Message-State: AC+VfDwb9ZX4NtKOfBNV595DF+Iw4XVDd9JCskqd5LeY9X+5yX+jm3Nf
 3Jqz+OVtR8hMqaWnjZZM6VFz3w==
X-Google-Smtp-Source: ACHHUZ7ixuGWFfd8BldYPLizESY7w7jBAn7vqLt+61+kqGtm6dZqRbAjj8nXMpOSLMhYm0+bfYd6Iw==
X-Received: by 2002:a7b:c5c9:0:b0:3f6:683:628b with SMTP id
 n9-20020a7bc5c9000000b003f60683628bmr475380wmk.3.1685568302986; 
 Wed, 31 May 2023 14:25:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003f6041f5a6csm22096338wmj.12.2023.05.31.14.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 14:25:02 -0700 (PDT)
Message-ID: <b23f8e25-5810-9af2-aeb0-37a46f30ed2a@linaro.org>
Date: Wed, 31 May 2023 23:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 6/7] hw/ide/pci: Replace some magic numbers by constants
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230531211043.41724-1-shentey@gmail.com>
 <20230531211043.41724-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531211043.41724-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 23:10, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/ide/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



