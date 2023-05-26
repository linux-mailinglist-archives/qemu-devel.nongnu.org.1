Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0582712301
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TOq-00022l-84; Fri, 26 May 2023 05:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TOn-00022Z-0C
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:06:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TOl-0000El-3Y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:06:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6e4554453so3480385e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685091968; x=1687683968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2yBSdFvCfahuTVCBlaD6I1eemS7XAMgV+6qm1mZzhA=;
 b=Uotv4n8DLi2mC2TljBEJeEZA049doxJpy2rh90lDP7n0RWd5V5YRjTz9P5Mlylw8RC
 KyhS4I2xmJSgXeI9oweBJQiv560ccFT4yUhKITy2HToW8JVtY2E+B6ROjLWzIms4jOp5
 Ik5juS/n3OtQhQ3xtmzMvFfdVKgf1PFxq8ODtgVc9F4A6cLxaeTwLD2KiLJT54uUAI+T
 eFynJqQuXexedpzpoOQuecbJZqwdpxqXmXcG/sYWGTEFd4XbWUr45HiddB/mkzWNxBKt
 ncgHDXjyQ62RpfKaqGwsRq72D9fZ+dlg7EQhUp1A5Fit1vk7aRFMwHtXaoxJ8u6DJbkS
 iuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685091968; x=1687683968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2yBSdFvCfahuTVCBlaD6I1eemS7XAMgV+6qm1mZzhA=;
 b=eGOjGtOtdHMFkPNAgweVMR8NM0RTAHF9rfkvMByH8jNFh64+qR+opKdvSc3vS4/LHi
 MONnN+TJgHCb9AT1jR1l5xclgDVEMzjlh8uPVFueP8c4Ll1AbDVyGPNAvjRL66nCEkfs
 2bi/IZ/jYme3InPwsRYkCj8A4t29fccvn/MHqeJo0+aDVJ0xpgpdLL1whchuEAX8u64t
 FFWZDepR6y5phI/3kOFQg6+zkrNK9rFah6mu5hYi40XZT6QwRc1GGrHpCFo7vmWxkf1j
 Eky1LbbxFrB1R+9q5SKh6hD+/ch7wvywfpeZq8//IGSkWDtI44SCsLVzRYAyH01w9iUK
 6HBQ==
X-Gm-Message-State: AC+VfDxRGuENoydp/EruvVHQ5iryQARMvcbTN4//R8Th9OpVxruRlxdM
 M6Lfiz/YIugJasHApDPZ8DnWVg==
X-Google-Smtp-Source: ACHHUZ6F/IJJuMjeu3c4R7YV9VmjEEsmaYBMemfWA4FZoT+mZG4Wrhg3eKdbrLq5FULjgVtfRKKyyw==
X-Received: by 2002:a1c:7911:0:b0:3f6:e79:3a7b with SMTP id
 l17-20020a1c7911000000b003f60e793a7bmr1064768wme.19.1685091968479; 
 Fri, 26 May 2023 02:06:08 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c0b4600b003f4fe09aa43sm8342355wmr.8.2023.05.26.02.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:06:08 -0700 (PDT)
Message-ID: <9012ee2b-9a35-84b7-d5ff-6bc726a57383@linaro.org>
Date: Fri, 26 May 2023 11:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] tests/decode: Convert tests to meson
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
References: <20230526021228.1777917-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230526021228.1777917-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/5/23 04:12, Richard Henderson wrote:

> Richard Henderson (4):
>    decodetree: Add --test-for-error
>    decodetree: Fix recursion in prop_format and build_tree
>    decodetree: Diagnose empty pattern group
>    tests/decode: Convert tests to meson

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



