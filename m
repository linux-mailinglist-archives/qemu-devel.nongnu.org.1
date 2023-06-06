Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A997244C8
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:48:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6X22-00015l-JJ; Tue, 06 Jun 2023 09:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6X20-00012W-2a
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:47:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6X1u-0000DV-0O
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:47:27 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5148f299105so12559581a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686059240; x=1688651240;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uX22wGQTarq3hyB8jiingQotPaacT1JRBeq8d/0Q2Ag=;
 b=qFOqutHVgpygBNGER/o/RItcrwQuG9fYa5uL33jqqIWS5AHjCb5U1RYLbWu/07udCO
 wK8UCAzCtZMTDre6DET1Oy6YYW/8jGDhv/wB7b5iuVEAu1IRmvpT8Ksgk9ENVwb6899b
 /4RlohxWGEKEDU9xPfsmJ1LpDd5pPh54zDLrkWohzr9Mxe7EhwWVy+SZJuXYC8ZldiOW
 /fOjlaXVFyw1Hq3l9ZRneEtIUv80+FuBVe7JPi9WEBFdhdvYUJWkIpX4p0/OlYUmj9kY
 Rp446BQ6Pm+5Y1yyOIX6faqt7FxOOfig2DuSc3XOuQTDWTyBXot/z6QkazErdw0oN/RJ
 t71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059240; x=1688651240;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uX22wGQTarq3hyB8jiingQotPaacT1JRBeq8d/0Q2Ag=;
 b=K6ZMvicmEuq8/M3ZG+WjOBsn+u5I3O0fIQGxcI9BUwZwQRLGkiryk5Us2YFqwuy8Fn
 6gMVEA89OahNP/IsrTSJrGTxXKQoWa31GT8r0tmW9l4JIl3eULkSPB+jCYrpa3QxKMm+
 DBxEoiz/YZD4F5bce/p/2jpfxLxZX+8bCz7abviIaSKQ7pR9ht+Lp3xoygXCmwMBpJTq
 BF4118e6hNFX/UVCUSTB/QDMsd9lMiZ+Fm3JjbNW9k969icd0MjvbH81ihh92PSJ3b/t
 azuH5FoiPmw71pSsyf26LmxwElUUfO5YinSwE1AbcaTV/UJ0lqwptbGLbLQvt82yVQZi
 xLwQ==
X-Gm-Message-State: AC+VfDx3Vbq6wnO/+jNRIy1BnsbMcnxAbnSTAmkPEiOQsU72Wj23SN/a
 8tXTH/JXTTVhqGn1GmUmOP7bsw==
X-Google-Smtp-Source: ACHHUZ7uiC3ZJKiBJtaD9FuRK83pwWAZ94IXev5VlD42ru8bmNspnMipHbL49DHD3QqCvxeXiIX/Gw==
X-Received: by 2002:a05:6402:184d:b0:50b:7959:8b09 with SMTP id
 v13-20020a056402184d00b0050b79598b09mr2566721edy.15.1686059240322; 
 Tue, 06 Jun 2023 06:47:20 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 q22-20020aa7d456000000b0051631518aabsm5014340edr.93.2023.06.06.06.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:47:20 -0700 (PDT)
Message-ID: <1bf47953-8589-a453-5e05-6b36b28f4fbd@linaro.org>
Date: Tue, 6 Jun 2023 15:47:18 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Please also modify hw/arm/Kconfig file so SBSA-ref will select XHCI 
instead of EHCI there.

