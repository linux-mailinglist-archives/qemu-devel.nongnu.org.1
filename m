Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813317222C8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66zj-00033e-Ct; Mon, 05 Jun 2023 05:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q66zh-00033S-RM
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:59:21 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q66zg-00087u-8o
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:59:21 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f6170b1486so3154180e87.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685959158; x=1688551158;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bjMRNC2yotteCj6C50qyqJLR6Xov9v2hEUZoCrJ8ANo=;
 b=wcdyl2RrpO8r6jHKKS0zIZRE7gSWYLoyID8aTWTabpcAUCOMHrdA2dHUwtaQhvhzJr
 eBSiWSb2ZCGJzANUJzLEe45J97TH1fJ/RqCsqDkT1CA5K5HeHi88HuJRK2gO3GKe/HLa
 AnEO1nfq+ZHiqjNeYtMYaYcmuV2/bdIfvCsAkWV9WZwZpIvdEuoFXYBnEGn7T8x8TMqF
 +PXy5R0MybQMlfFCa+LDjt3uE56qtqYP3ANK/AgGE5juwJUYadnxITYjKQixQ/Q1S0nG
 Z/02U7Ppw41VdR2YuuilVsO8OSbMdhurA6ysXADiTcyZ4AOyvZTs6XsnDkFZyCcwYWOL
 ddOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685959158; x=1688551158;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bjMRNC2yotteCj6C50qyqJLR6Xov9v2hEUZoCrJ8ANo=;
 b=k64aHZTm441LXDeEQaQDGYp7CYiO93A9Ailh693RAuyHPck+jJ4DSPaXOEtxwaW20H
 UWBf1t2bVZSiwZnCms+HC3nS3/B2OhGsCKbqMFg6mWd30/75sH9ZqFknFn3S0fg8UFsc
 DqaACFfYmGGs++y4/wN9277Jm80EMEIDdSqQSkzkxguFpikdZqjkvSvcxYB5vZUUyIOq
 70pAicSlHRa8Ufv4dxHQ0vVPFSipqfsFTqIuWHd6TdrKgENm/BUtjtZ7z4HlWJsGTqEX
 hUZB2jpQxNIaG+N838wPj/SlGqlPjlX1ddWyjCJJVtyA5/GEPa0+HLllI/oh9pP0eNuf
 jF/g==
X-Gm-Message-State: AC+VfDy2qYebwsJoCjkIVIw9B3QG0AfYUINaJ3OmJLBEeLOUJO6VZeJ0
 ZuUcbkH6f/whHly6QkKzj3hyYw==
X-Google-Smtp-Source: ACHHUZ5mygVgzBnB5L9ihLjYQWZTi0ua4lvYSd8E/ej/bpo6Jc3Cy3eumEIv+a83TsIHXEBG7Dh+rg==
X-Received: by 2002:ac2:4ace:0:b0:4f3:78dd:8e0b with SMTP id
 m14-20020ac24ace000000b004f378dd8e0bmr3041088lfp.32.1685959157746; 
 Mon, 05 Jun 2023 02:59:17 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056512014800b004f3b319ed4bsm1077689lfo.120.2023.06.05.02.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 02:59:17 -0700 (PDT)
Message-ID: <101d301d-d413-288e-9318-d0a226ea8715@linaro.org>
Date: Mon, 5 Jun 2023 11:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
References: <20230605095536.117384-1-wangyuquan1236@phytium.com.cn>
 <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12f.google.com
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

W dniu 5.06.2023 o 11:55, Yuquan Wang pisze:
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses XHCI to provide a usb controller with 64-bit
> DMA capablity instead of EHCI.
> 
> Signed-off-by: Yuquan Wang<wangyuquan1236@phytium.com.cn>

Can you share firmware side so it can be tested?

The more I deal with EDK2 the more I understand why people go U-Boot.

