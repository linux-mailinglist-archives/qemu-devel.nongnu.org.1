Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28176BEED
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQwWa-000570-IJ; Tue, 01 Aug 2023 17:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwWX-00056n-JW
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:03:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwWW-0007SF-2V
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:03:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe1d462762so25668595e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690923797; x=1691528597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AeiuAKt3nJIVaz6X1CzTv/pto7tzOJ16lysTN5v1bYE=;
 b=ur4jruQfsYHhQNinaZomMyIN4xzxkfN6+RsMXtN1KsTw0m/MbOrTSjQmss0hvspvzn
 IkBV2FZe4q2nwkYc6RD8IlzQ01dSxrp6zj+qo+OSvLvRdnbgqnx6NFI8cCGoxv50Fbin
 q8FuyFJIaomteiScZ6CzO/dS0f8dkwWEDw/XRxAcKCLGcsUDhevgv4RISfF5aZy1rnJx
 MQODB2bNjWef6q0WUUZyqTU1D3Q1RjSo48dqVDYFVLuu2Q/OwlH9VTL8melHfcTOHmhS
 4aZA+rxVHIIye5tjtT0LvDgcMpQKpFsnkHAHOX/lKpsWNY2zUjFG55wb0IKkxh7xa9mo
 1xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690923797; x=1691528597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AeiuAKt3nJIVaz6X1CzTv/pto7tzOJ16lysTN5v1bYE=;
 b=W1f2vbgk9M5+/wDhIlk5nVyxrBt+BDB2+Y1Z2byVD51OLX7z/zrE9e6jDyXeg8Bw0I
 i+wPicKQS5K8cVwlHjRzgYDlUflAUlhg/OCi0EPeCPtfm8rDmzucHVeEjYCE5kDUW11g
 iCdPlR44esd+oA5kPqYpl7yPvoijFa/VvwlT3ONC3IZjDyEm1ZMsWx6hwiEq1UcJhC4g
 X1X9oNjLKDISupKz/Yt4qlcv6cu9ell5WmIsF+KL5mSTzkeF0sIxXasm8SwvBvsnDQCv
 eSp0GhCD4bKp+68H1160k8LLidbgDsrck9iqpFRz27TLpuVHm5PoUmNxq4Y/kIcbcaZR
 Iv7w==
X-Gm-Message-State: ABy/qLbboVOGW5JNeNOMJ2abEknd6m0UUPAqC8KnuA4aLs1LZoCe/4/+
 nUPsJ0gh3nr7skWyaqgL3Sxzaw==
X-Google-Smtp-Source: APBJJlHf9hPRLr0nRfAHFho2H/wxn0Wu5dqP62oSSZF0X8k5x0+3vxUTFH6mko8/5b/15eG8wcCPeQ==
X-Received: by 2002:adf:f681:0:b0:313:ef08:c83b with SMTP id
 v1-20020adff681000000b00313ef08c83bmr3067871wrp.56.1690923796951; 
 Tue, 01 Aug 2023 14:03:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a5d4b4a000000b003176c6e87b1sm16693823wrs.81.2023.08.01.14.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:03:16 -0700 (PDT)
Message-ID: <892a9975-1901-862d-4766-bd76fbb5d7cc@linaro.org>
Date: Tue, 1 Aug 2023 23:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] hw/ufs: fix compilation warnings
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230727233405.35937-1-mike.maslenkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

Hi Mike,

On 28/7/23 01:34, Mike Maslenkin wrote:
> This patchset contains a trivial compilation fixes for UFS support
> applied to block-next tree.

Since the series isn't merged, it would be clearer to send
a v9 of "hw/ufs: Add Universal Flash Storage (UFS) support"
with the fixes squashed in (there is still time).

Regards,

Phil.

