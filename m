Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C697579ABFE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfp9y-0002rA-7X; Mon, 11 Sep 2023 18:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfp9v-0002qn-TE
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:13:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfp9t-0000Hl-Dj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:13:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fdd6011f2so581732b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694470408; x=1695075208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5y1Bvw5KszIoQsETH/8l/C0nn3qeJwv3lGv9Fm0Gqk=;
 b=qBiTqwyjqnYiQ0iG1h7f3mZoFrEtahNpcs7DqWfdtY5uXZzB7I0Z5qeWnxf5NZUx3M
 +pScMIH92t5XqULGCGb4ctnOQI76wUGEw/Zn0//nh43s/u3U7Rylf4b2QA4yOJeXjd2x
 ri5C/n6G8uUJYhx0ujYMh9GmkUKRbi85Xj77iGnVFudid8ODmMK2imk/q99zCz0/ngby
 jvRhYmaqxYJesP0Wp3nFkXJ2E4i60G3T6VlD+iUi+/M2J0zmcNg9Mdwebdl909QSjJs7
 whkybWIETQ+0IZIfVL86bZWE7SWG44Ka6jPImH6l6WzLAmW+9JP/CmpoK0Xj2ROudxM5
 zftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694470408; x=1695075208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T5y1Bvw5KszIoQsETH/8l/C0nn3qeJwv3lGv9Fm0Gqk=;
 b=wNNOrKRVQhBkHhZWqCgMlMIxDCwuRt5Xo+l1mVZHqLoZEh7P8n6Mxrgq4x3nDK3lnW
 96ALuZ8rsMLX91WCsMnupKSxMOWx+aVFVFv4HBDgQu/TEMvZ+sSM0F4xzDmb19wMlmSt
 G9lYC8pUPHh/P8oQcBRU7xuqkB/AmcjbXPaDD2upXYMybPZypkFrTH7/rkx9vpLGIY9n
 afv0nJEGQ8jnO3AUqAWndb7s61xaL5gNEExiSJwOB4xkRfUEL7ewv48CRy+mWInMqyVL
 dMqcZ6KxnqM7oZ05tkJDCURUA5e6EQmto/yW3oEmwsMl42MwZUIN5OxhzUZreitgmFD3
 Dj3A==
X-Gm-Message-State: AOJu0YwxZjNPr4I1vE9qx2XLrCT677FdaJZ+Iv6QMecTXK5AQFHgpxB5
 SPwltxYkUlf0j66fQje6vWaSyQ==
X-Google-Smtp-Source: AGHT+IFBBPradTHq4QAzuPp2/QfEvueyavn5tX68xDtHGyptjEfInKS6q1xlV9fPWZP4ELub/19S/w==
X-Received: by 2002:a05:6a20:4289:b0:137:2d73:707f with SMTP id
 o9-20020a056a20428900b001372d73707fmr10837977pzj.5.1694470407478; 
 Mon, 11 Sep 2023 15:13:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm6955586plk.219.2023.09.11.15.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 15:13:26 -0700 (PDT)
Message-ID: <883838ef-fd32-1c4a-831c-e39349680ae5@linaro.org>
Date: Mon, 11 Sep 2023 15:13:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 41/57] target/loongarch: Implement xvssrlrn
 xvssrarn
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-42-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-42-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> This patch includes:
> - XVSSRLRN.{B.H/H.W/W.D};
> - XVSSRARN.{B.H/H.W/W.D};
> - XVSSRLRN.{BU.H/HU.W/WU.D};
> - XVSSRARN.{BU.H/HU.W/WU.D};
> - XVSSRLRNI.{B.H/H.W/W.D/D.Q};
> - XVSSRARNI.{B.H/H.W/W.D/D.Q};
> - XVSSRLRNI.{BU.H/HU.W/WU.D/DU.Q};
> - XVSSRARNI.{BU.H/HU.W/WU.D/DU.Q}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               |  30 ++
>   target/loongarch/disas.c                    |  30 ++
>   target/loongarch/vec_helper.c               | 489 ++++++++++++--------
>   target/loongarch/insn_trans/trans_vec.c.inc |  28 ++
>   4 files changed, 378 insertions(+), 199 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

