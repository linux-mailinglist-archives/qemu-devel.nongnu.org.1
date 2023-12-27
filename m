Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12181F249
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:03:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIbyc-0002lM-JF; Wed, 27 Dec 2023 17:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIbya-0002kH-Bx
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:02:08 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIbyY-0000s4-On
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:02:08 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-594e9135d82so206622eaf.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703714525; x=1704319325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yscp4jcaTD6tmP/0JCbdjVsrp6AOQnxr2GwE6hAn3A0=;
 b=eU3vmya5YxB46q8qJxEvi1CBZbVe85Yu/1mqrDmLhbFsZ5YvuDSyTg7tm1JCAAbdxj
 o+wqbD9NhoWxsghi5CwCgWi04AoNn3/LN3VaUDFOWEm7zcj7RrXsQVwiGXsjrgK3m0Sy
 +GrpISbi7xRmVCktY+XK0w0I3DlkgRA6IS5c0z9tzBfWPMxn967rr8AX5KxjAH5msCwu
 MmzyY5tq01PHDlfpS78qoPBmJNLCp6unGu+SxbuMp84dXH1pbFxZU+2oOzPIf+d/DD1Y
 KsbGAXzafx0IO6tu+Xrd3GrsFhyBvSsTkKPzfSvRx/DhdWqqEFhdzFJG9cRLolfuZTbw
 MMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703714525; x=1704319325;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yscp4jcaTD6tmP/0JCbdjVsrp6AOQnxr2GwE6hAn3A0=;
 b=EoUlVPsorlzQYd10NF6eXNgOMn15Ult00udGU0sP8qre6FMz1/sEDGq/nb2KxIT25/
 419GTwH03NKnT0rkNfL4YMRYoBWOCzjR47OHtNwA1LrlQqBucDCUlSiMp8uT5d4biAsa
 a34LtBK/uek0kGOGb7IncFXeDDSK/aM8GDUwLIveqt96E9eMx4ojjbm9q6i6HsbFIdr3
 r9A3OsowoZb+OHEPkNRzXWSuGqTCMTyUKT/GmHkj2aSnx3O6aqDH15BSbD0PRwc0mrXG
 ZHDTHzL4t7YY7xPK9ic9pTDFIGI0zT7PwtQfHAQPLPhQhYmhy3rw8a8fGwkj/IU6abpQ
 MTDg==
X-Gm-Message-State: AOJu0YxnTwkmyKawFWGWLkL0E3SYzRoHW0XM2i/IRzH0TuQX0jEWqaoB
 kFaI00G6NvY1kyS0XOzpUEQ+nxUL4P4lPQ==
X-Google-Smtp-Source: AGHT+IEcVFD08qHUY3HRGIQHCCHo/S7X+ZB5tjSdkA9EvkfBBYQI+FgKYLPuWVshIGDxU9267MasVg==
X-Received: by 2002:a05:6359:6207:b0:170:17ea:f4d4 with SMTP id
 sc7-20020a056359620700b0017017eaf4d4mr4959341rwb.33.1703714525223; 
 Wed, 27 Dec 2023 14:02:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a63510e000000b005cdb499acd0sm11770874pgb.42.2023.12.27.14.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:02:04 -0800 (PST)
Message-ID: <7982b2af-cb6e-4e88-ac9b-6939d2bbce3b@linaro.org>
Date: Thu, 28 Dec 2023 09:01:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/35] target/arm: Implement HCR_EL2.AT handling
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> The FEAT_NV HCR_EL2.AT bit enables trapping of some address
> translation instructions from EL1 to EL2.  Implement this behaviour.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

