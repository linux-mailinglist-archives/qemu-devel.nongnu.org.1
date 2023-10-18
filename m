Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF67CDC9E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:06:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6F7-0001yN-3b; Wed, 18 Oct 2023 09:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6F4-0001wF-I7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:05:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6F2-0007fs-Pq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:05:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso10668980a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634339; x=1698239139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2FVEUw7KfkBYV0yc0+PIqfcxykuRA7HXBZWEjvJKfO8=;
 b=AGZr175+itHZnQ6i5YdPAg0qhwPst9REiYwyGclbRtoGOrPzlPd7Mh3tmfYi66f95K
 5YNU6YFtxb05oPC9UiLOOwl//hc8jaNY1HNbZqudtnoCTQ/N8X4Y8u8HH3p4DfQxy6gq
 ECxKTjENFR4/E0BwNkAnVhj3DpoRZZjIIyo3TT+5w3dS96oSHTXht0PsNCvPmX30Ppct
 0loRUbscnT69nGiF1mB5Dwoez9sbf8DGSE5ndsQ9y6fIQEc5XoeABz5qFXj5rcaMrW/9
 ARxIfM2zXleFFz0MSQwEa8x/6Aa1NXPCFfGvAdaVDuIuGGdvz1TIyuG898SZNqYd456+
 CNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634339; x=1698239139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2FVEUw7KfkBYV0yc0+PIqfcxykuRA7HXBZWEjvJKfO8=;
 b=OcMRZNy+fAu0wK4xieTPJCJ6A8Emcl65lszPUAZeZ/8iG4TfR3RmAqhbF/smgY/+Y6
 b+Z70fCvddW400hApqage1uOMhUVG710TNoMlOdlXHbAmxiJSPVg1GDX9TVEau9bc8kF
 CaTSTPzhpyUAt1chEC7ZhJVJLRuGp0nm1go6y8lZcLCS/0UhRMEm0HG824NswOAHI7b2
 FRQchkwEn48j1LJYCCdwsh8wltDrOJFxf6Ynl6o9QiXzkNHIUS88/fN0fPIS/hBdxJR1
 ZEbjWKE2Yl4xAFLNbP9n6R83rr43f88yOKJBMSXQjIq6TI5SjiShYOkr8LEs1B4KRMAd
 M6SQ==
X-Gm-Message-State: AOJu0YyTbeG4fMfARypgA95A/X75oyewCp8uaWXWQRFJbex5XA7aMGyh
 g5aKgMyZeQQZ0xZAI8EpnhGrVQ==
X-Google-Smtp-Source: AGHT+IGRY8/YNz8jfAMJYLwe4xbQutn7OqK2O5YzmUq0YHdzaKrNpJhGD1RV0n1V4yvnZSYXK8TNhQ==
X-Received: by 2002:a05:6402:40ce:b0:53d:d8ad:4d46 with SMTP id
 z14-20020a05640240ce00b0053dd8ad4d46mr4937506edb.36.1697634338804; 
 Wed, 18 Oct 2023 06:05:38 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 b42-20020a509f2d000000b0053e43492ef1sm2845752edf.65.2023.10.18.06.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:05:38 -0700 (PDT)
Message-ID: <7e8c556e-7afe-bb09-03bc-d9a0c7a56ce7@linaro.org>
Date: Wed, 18 Oct 2023 15:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add include/hw/openrisc/ to the OpenRISC
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stafford Horne <shorne@gmail.com>
Cc: qemu-trivial@nongnu.org, Jia Liu <proljc@gmail.com>
References: <20231017154242.234133-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017154242.234133-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 17/10/23 17:42, Thomas Huth wrote:
> hw/openrisc/ is already listed here, so we should mention
> the folder for the headers here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


