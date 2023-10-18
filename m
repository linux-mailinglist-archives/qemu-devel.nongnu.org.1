Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457B7CD357
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsyk3-0001ip-Gp; Wed, 18 Oct 2023 01:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyjz-0001iV-T5
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:05:07 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsyju-0003cL-W2
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:05:07 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so82504111fa.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 22:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697605501; x=1698210301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8H5PuQQvXrI1d+CuEbwAz8D/VlFoQM02yrWlgI0Rh8=;
 b=S2yrDvSPSRoVwnsAAgnmOlFo7OZPWr1bB8kd7ShJCgkA+OoSbRcPsU/7BrsVKMwlLM
 YdJkAvmSl3YHgz7kOM/iSl0jdMJMRZvwv6zy/bLDDRw5jQivuSGZTCRsHwZJYpkmJboD
 Sq4Awn3wRgVqb8X4Fum+X/EDSeXZ/Z9OR44hr+iHLeS5UeRnzAs8rmS9lsPgfDf07AcJ
 sU9EYswODk6Eai8yn2Qba0ivnBt1rBdkCosH3AFVxiEfrx9uBsVpwJ4PnyK0w6q8QM5E
 UkJfhrw9Uv6SOEmexyBBGxDDCyXpTsuyE88MG3gdyCKc1/RoDIUqkN87VbPiVDSoV+sO
 FiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697605501; x=1698210301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K8H5PuQQvXrI1d+CuEbwAz8D/VlFoQM02yrWlgI0Rh8=;
 b=XLcMWT5Qb2X2p5lhk5abhnK9bPb2eVkhd2koUK225lRFNNqAtbV8IFFAf+UE5D5at7
 Lue1WuXLLkQBLhvPq+gM3bmJprSjlE0aEZBBbB+DT3JfLKxa2+/BUIX2Jam7TgOxT7Qe
 pyk8TjZh4GHITmQoQjLZqeWMOS6iZg2kQU2+vHGI6B1fj8AaNh9PvTmEjA6TlyKB0Ys8
 bpL93ivAFREz9OvZ4SP2rNrD6OVT4r1aMnGZhYIfsSe4JIclO3jzJ30b0iho/gNFnLbo
 lA2BY+lrpM6HhHa/WICeDGvj5j4wfz5Nfbl5mG8hEJK728tEcQCNmB3mgKe+nP1bZro/
 AYqw==
X-Gm-Message-State: AOJu0Yzm6y1cAgFxfiofgmjNaCB4mAE5kaJtQn4nknQRES/eZibDUg4Q
 /Ht8QOf1FKCJ2ZLcewar+Gb7Rw==
X-Google-Smtp-Source: AGHT+IHuDu3zZKriGPd2n39pFM07GZWqhAFoZ9DIBU27CdFCvAAHtUht7nAnucJ80fKEeVmFKHY7Mw==
X-Received: by 2002:a2e:9c51:0:b0:2c5:1bd3:5658 with SMTP id
 t17-20020a2e9c51000000b002c51bd35658mr2814228ljj.28.1697605500868; 
 Tue, 17 Oct 2023 22:05:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c320900b004083bc9ac90sm621641wmp.24.2023.10.17.22.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 22:05:00 -0700 (PDT)
Message-ID: <9f310f21-2d8d-91f9-bb25-486fc5e943b5@linaro.org>
Date: Wed, 18 Oct 2023 07:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add hw/input/lasips2.c to the HPPA machine
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-trivial@nongnu.org
References: <20231017151933.213780-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017151933.213780-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17/10/23 17:19, Thomas Huth wrote:
> hw/input/lasips2.c and the corresponding header include/hw/input/lasips2.h
> are only used by the HPPA machine, so add them to the corresponding section
> in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


