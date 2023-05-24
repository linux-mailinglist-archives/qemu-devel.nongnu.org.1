Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E870EDD1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 08:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hw2-0005df-CM; Wed, 24 May 2023 02:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hvz-0005dL-6D
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:25:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1hvr-00069z-9n
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:25:18 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3094910b150so347731f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684909508; x=1687501508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgsiFLBly6/Yfq6RNZAKWG7T9U92lJDteqTAqEBt+6Y=;
 b=B3/m2FrqPNHelIMY1YyP6Ph12TUzprQtGCO7DMYMW4nvZbGEwSGeSi/p189D5LwwEg
 zZ8mmP66iRZANEe5PiMYvocfy0j4qjmtIjOX6Phbq2jSKK4Ue7RKYIITdOoReolDAUhd
 wDZqx3U2skK6eOglH2+5gXwlnlEKoE7eBK9epqmT//kUF0x/zNjtBcUhgghxnNiEGFzp
 e3TinamVXfgEm0yR7XIJSgRaswCGnOEpWGVkB8J7yduzgwuCLkVI3+l/qEhLbGvL6DdT
 FQYZN6ugJCngELOwUnzcEPbGlL4h+WIX/Yt+l0E2+Is0xrcEXWbv0NZhcmJpQVE/n1VQ
 delw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684909508; x=1687501508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgsiFLBly6/Yfq6RNZAKWG7T9U92lJDteqTAqEBt+6Y=;
 b=FklDof3wIJspelwYBqdHufPIOIWSLTl5uI0CgWJx3Gt6X79SdAYtVbkXaJIY27yCy+
 8pqWkuWFmwatcGSTc/ht6KoLFF/AzCwEGoFT0ZPsV405cxoFb3dwbjOT8IXHp8mhhkx/
 zi6r+NJlcA159QrnXGgBCFa46sRAPfavKjmepT1sp4324QbXmWR5GKPG5pjLHKXEcxdO
 0PQgAR1x0clmYQkq9zvkQyypRBFcScvzdSM1U9bZnpGcZlYqgtDkhgIU9zYfrIWZhXe+
 2UGbkeaW7hsMnHDtbNetUGBwC/diDjWXGPQXD2MyPaibiVdOeZ2K7w81jQQy47yMIL1j
 B6Hw==
X-Gm-Message-State: AC+VfDwkhAv+wczkSiV2h9eYYEkGwCnvEeXG0nQwwDsyABqYNJqLf6bM
 QavWtTOb6R1MAX1qJfHJw5q2dA==
X-Google-Smtp-Source: ACHHUZ5PIvkbhnN2jBHj7qtipCWJiVGkCYsBFoZRjUZQzNsYLfsP0z/WBiE4WC3QK2XBTd3OMFN3pQ==
X-Received: by 2002:adf:f046:0:b0:309:1071:8b2 with SMTP id
 t6-20020adff046000000b00309107108b2mr11536300wro.59.1684909508626; 
 Tue, 23 May 2023 23:25:08 -0700 (PDT)
Received: from [192.168.215.175] (35.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.35]) by smtp.gmail.com with ESMTPSA id
 u9-20020a5d5149000000b0030aa8f15c57sm1321480wrt.68.2023.05.23.23.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 23:25:08 -0700 (PDT)
Message-ID: <9742a487-3dee-a7d5-8b0e-ae57e684dd73@linaro.org>
Date: Wed, 24 May 2023 08:25:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] target/arm: Explain why we need to select ARM_V7M
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230523180525.29994-1-farosas@suse.de>
 <20230523180525.29994-2-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523180525.29994-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/5/23 20:05, Fabiano Rosas wrote:
> We currently need to select ARM_V7M unconditionally when TCG is
> present in the build because some translate.c helpers and the whole of
> m_helpers.c are not yet under CONFIG_ARM_V7M.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   target/arm/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



