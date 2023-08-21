Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8B7824E6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzha-0000Pw-GO; Mon, 21 Aug 2023 03:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzhR-0000P7-Ey
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:51:47 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzhO-0001XO-CW
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:51:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee51329feso9170035e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692604300; x=1693209100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQmrHD9DunACno9hxbZA6KKKHGVfttjihnQS3Wbq2EU=;
 b=kFT+p45d/VUk3yvBCjnWksAPUeJwPFgmJFOHexRFIfhLd8lw24RK6shr4k6ijQhjSP
 9xkS4Nb3D+8ZTsDECq3NlGzufPTl7Fbi7IiFRS4w9kG0OiSL+KutUrSeSaG/mYEgSMbF
 sN2XwYI52h/t+B3dw85dmYw5vd46rfIMzxlTXWUbzKViEibi4GXUgdQGNMmDXsmjVRdU
 2NqAz+1zcwsmCv89s92WOp1kF9msQ4Gwnaor321cMjTfgJB0E+HAUgTpI3B8wx5G9sli
 cSWvgWOWkzmeDCdn0gnwgo7phu+uCmI927Dq+7FonKsEtgPzALlkdoPnlPjB9tujHdnf
 isiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604300; x=1693209100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQmrHD9DunACno9hxbZA6KKKHGVfttjihnQS3Wbq2EU=;
 b=btVjMR2ggOQpP/LjV6mJpW29XXHf+IDrAFi8GM4ZNxM5Om1OI+jocNQf/zg4/9Zp/Z
 Be+P2xiasy81n48UrWk5XeOI7UFuFgirz6vRExf3zlv1eqz4W97JeaeEoM41TSHeG7dz
 dDulMpPETaUjE6E9B446Zw7tKmJ4dwhHjtBPvYkM12gi/KdyTiicxCJeVud9eFZr0r3d
 +qlvyoohsojWgSF2luRLJQq+4Oy7/UP0+F1tBmB9ik0sbeqlGbMkneVPel0IZ/ZfKqtM
 jUqqH13da164Gh50O1qznJB3+TF9tf2l5xSUlkbhZAKHsKW44eKljVZVVctjK3LbeYbg
 N9qw==
X-Gm-Message-State: AOJu0YzF41YwzQGVuKTsCELXGT3Z9K8fRCEJrajMBgC3jFOMz1lOpJhe
 VIOAEsHeF9V4QdESSUubLif5NQ==
X-Google-Smtp-Source: AGHT+IHXsUQt1rRCKq1Ml+QSuOx4/LAe/kM9OwEyeCQjDVtVsXVqoFeH2HFLG15m0GOL93OR5QAIXg==
X-Received: by 2002:a05:600c:418b:b0:3fa:88b4:bff3 with SMTP id
 p11-20020a05600c418b00b003fa88b4bff3mr4379648wmh.11.1692604300693; 
 Mon, 21 Aug 2023 00:51:40 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 c15-20020a05600c0acf00b003fee849df23sm6185435wmr.22.2023.08.21.00.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:51:40 -0700 (PDT)
Message-ID: <dfc061c0-ae85-2cb6-744a-38f03071b7c5@linaro.org>
Date: Mon, 21 Aug 2023 09:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 06/18] target/arm: Use clmul_16* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routines for 16-bit carry-less multiply.
> Remove our local version of pmull_w.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_internal.h |  6 ------
>   target/arm/tcg/mve_helper.c   |  8 ++------
>   target/arm/tcg/vec_helper.c   | 13 -------------
>   3 files changed, 2 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


