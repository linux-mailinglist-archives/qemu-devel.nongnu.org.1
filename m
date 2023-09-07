Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5379725C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 14:36:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEEl-00085P-TP; Thu, 07 Sep 2023 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEEi-00085H-Ev
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:35:52 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeEEg-0002Ul-3l
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 08:35:52 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so107694166b.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694090144; x=1694694944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PoBujJ/iXdoCMge3j3UDXvjqLVzFDD0TrTUoS71ns7E=;
 b=IvRBa3K+Rtgc1vxeuGYGe2535BUJ2NC8hVygfoL742JegKJMxfVgQKUZ5USxb7Xzdv
 QpaJwgYl5uH/W7kwzbvk5QLqofP20iIKkSrKbXQVL5AhKJu84rzEXd5fCwZFoKpBIV6C
 lfxS2j7SiTgKauW+8bljZRe75biYURN/4Pw6KPPM9YoQPF1hEr39ZDXTMkTXhr/1gv0+
 zvjeQkNqVXCEuun0bZ0dInI6A+2BqdHwkv8ZuZI8o+Rie6Z2hhTULexLx20MUxiKXLas
 Ctlk0U3cq+SQ17HTgpR3nuQrsLm5KIcvBhbZTKtftFdDr3o5wEx1zxjKJJ/ztwvJ8WbB
 Mn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694090144; x=1694694944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PoBujJ/iXdoCMge3j3UDXvjqLVzFDD0TrTUoS71ns7E=;
 b=FC78A+DcDL9QbiGemN1/2d+BJxyWB5gvcEtLvaM13Ihl+MX39LsHoYgDf8eZ7O2soL
 hvNrgibwg2rDKyck65uoJRb2lfCvMaZGhnujVdNcyhq6CgAdclWXkIf5VEyhtq6hupA/
 /r03Is8oY2e4HgJ5W27DOQqjCWJp8AThl66m5YuWmUhJKKKGdI6r2vL5gWRLFbAwRBNB
 smhY/J+3UrMQ3NqpvUOEqCtrOyilTDIYQb/+Iw4ASjhiaeKIAO4sRawwk3boVs2WguON
 +h85h+I1U28cgogULgNPnR9a576ntBYnOSyiOoJ6uZCjIfFkBPV/xMimlAbz9FJ/26wy
 Mp7w==
X-Gm-Message-State: AOJu0YyGz1ako+1qQr3Dkp0cClf9JN3DmfyHOhLVegBG0bkQuMpIVuTl
 FJEBYkpzRdy69z5/S1ThG6tNRQ==
X-Google-Smtp-Source: AGHT+IEJBc6bLzdKEt+8aczqpH1jETGPkzQbTVPi0fsfGDqj+OEEylRFztpb+wnefd0GKDO7f4ukhA==
X-Received: by 2002:a17:906:739e:b0:99c:6692:7f76 with SMTP id
 f30-20020a170906739e00b0099c66927f76mr4999604ejl.16.1694090143746; 
 Thu, 07 Sep 2023 05:35:43 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 f27-20020a170906391b00b0099cd1c0cb21sm10222882eje.129.2023.09.07.05.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 05:35:43 -0700 (PDT)
Message-ID: <f1694c9b-75ed-a8a3-6a05-91f796dfcf2b@linaro.org>
Date: Thu, 7 Sep 2023 14:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/3] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 7/9/23 13:35, Jonathan Cameron wrote:
> As an encoded version of these key configuration parameters is available
> in a register, provide functions to extract it again so as to avoid
> the need for duplicating the storage.
> 
> Whilst here update the _enc() function to include additional values
> as defined in the CXL 3.0 specification. Whilst they are not
> currently used in the emulation, they may be in future and it is
> easier to compare with the specification if all values are covered.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Thanks to Philippe Mathieu-Daudé
>   - Expand both enc() and dec() functions to include full set of values
>     defined in CXL r3.0
>   - Pushed implementation down into the .c file.
> ---
>   include/hw/cxl/cxl_component.h |  2 ++
>   hw/cxl/cxl-component-utils.c   | 59 ++++++++++++++++++++++++++++++----
>   2 files changed, 55 insertions(+), 6 deletions(-)

Hoping the values match the "CXL r3.0 Section 8.2.4.19.1 CXL
HDM Decoder Capability Register":

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


