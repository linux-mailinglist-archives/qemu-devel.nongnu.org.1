Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68764799136
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 22:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeiMe-0003JW-RD; Fri, 08 Sep 2023 16:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiMP-0003Bu-4P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:45:49 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qeiMN-0005Jv-2a
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 16:45:48 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-64bd231c95cso13688776d6.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 13:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694205946; x=1694810746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pEjfTff5Thjz0cGlkvjaiLwfcba1q6PPgBDqP7jNrYM=;
 b=knVxjvxLxIJrXtuyhqYp0f1coCKJcGIkzi5yWZIo/PjVrpQuZNyyeZnXm0zemPExjg
 MsO6s5zAgarB49Lo+N76HMSjVvH9907Co2daqaPG1JHb0iz/8jdgIwMbF3CD2CHzPMss
 gByiT9w2M5SGlaDFSZcJRCOu/weHAXm5YabYb1ArpFUG/JsbGIcea3B/EIsECsdCGePI
 Jt0rUCf453wNFM0NwLUYi55fz1a96bziP32T+nzJyAJQSNCTN3CgYJy2LDeVpjU7UyTa
 ZC2f+SptaCQTGuBCejXIqDg6/ggNN1SrAwWjv8AyWh0hOsuF2AZ3e8UbV5ttDt7cVC6C
 mMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694205946; x=1694810746;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pEjfTff5Thjz0cGlkvjaiLwfcba1q6PPgBDqP7jNrYM=;
 b=T7sQZD68EYIRc5IE43dpVHuwyuQlvsFMgDYx8uIe+fjgQ6sL8wEnS4ytO4nvpcQta7
 Y5TSfnSAsVrYjd6wf7O4LS1vFd1Yv2x5EiCyS+RkMf0xrIjtlYUTelhfWfnzTjki8u3d
 y+Q6luvfFA7W2PYeblzoHxvveAc5vJmgrmnNXnDOtqjdDDUm0tQ2eihc951l3GRTel0A
 VW9Xzwj02AtjS/LKGTqmsVt2rtvX6d9+qWLduxo2wLvhdddFHPupBwM4C+lQLbwV+T0j
 HxOBJAE0CULc+mA7gBA+hOXDxnqsGVmjthMXDW4qrktDyLdGRpk2o9YrLDS1CVwu3vSL
 n+3w==
X-Gm-Message-State: AOJu0Yz3HbXum2srQDS2NzVGY0gIc03cfQspAd/muULGGEJUcg3SSLWj
 8dhAiUi7KNr3MVWYvAwCzZdSxVi7I43+Wz2/A7A=
X-Google-Smtp-Source: AGHT+IFHFip05T9lua1ZTc3klYviH6DR8T72J8ihe2Q7pkTspcVnRRfluLD94U9C96thNhKBFVZj0g==
X-Received: by 2002:a05:6870:310e:b0:1d5:3389:8a01 with SMTP id
 v14-20020a056870310e00b001d533898a01mr4116515oaa.34.1694205932214; 
 Fri, 08 Sep 2023 13:45:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a63b207000000b0055386b1415dsm1540971pge.51.2023.09.08.13.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 13:45:31 -0700 (PDT)
Message-ID: <4411fac5-ad3e-bd0d-8e80-6c1e9acfa859@linaro.org>
Date: Fri, 8 Sep 2023 13:45:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/14] target/arm: Define syndrome function for MOPS
 exceptions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230907160340.260094-1-peter.maydell@linaro.org>
 <20230907160340.260094-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907160340.260094-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

On 9/7/23 09:03, Peter Maydell wrote:
> The FEAT_MOPS memory operations can raise a Memory Copy or Memory Set
> exception if a copy or set instruction is executed when the CPU
> register state is not correct for that instruction. Define the
> usual syn_* function that constructs the syndrome register value
> for these exceptions.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/syndrome.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

