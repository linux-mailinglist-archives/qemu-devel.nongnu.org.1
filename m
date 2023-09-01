Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A27CA7901E9
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:07:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8X6-0000SJ-DD; Fri, 01 Sep 2023 14:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8X4-0000Rw-1n
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:06:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8X1-0005zc-OK
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:06:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf7423ef3eso17303675ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 11:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693591566; x=1694196366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WEinAZdalbirNIalG9PIhdvhm3NUCaCLglYSKJLWXcE=;
 b=fxgj/yqg69XOdEicRWq1NB8w1Wmo5cDHRP9AkP6qoHZVgm3FbvS2fS3nodt1IkJQaZ
 eRybUx7KvUWgXjWbJhadjUi1lsQJ83zkro9VHRh9UyK1Iog46FGqZYBVg7QACG7BDGkH
 U7o/0XoSoutWU9q2aNCds8cLT7otlpl7DuVjfFfDKYxeJKlKJnwTPPy0pSsBD01tSTNw
 hezhEvn98Nd834HxpZllqPiLY+Pf7YgNO/Wv0cd4b0VB62XJDoyryXSMxul1fXRe80Ss
 Wov1u3kYCuleqK3XubQBQCkFyzgXeYdbFU3ZzMAfCQ1SJ0CcQAHCB+VCHmRRF1eB5Zzx
 3Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591566; x=1694196366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEinAZdalbirNIalG9PIhdvhm3NUCaCLglYSKJLWXcE=;
 b=CZw+XmX7WkIGlSAIZLv8uaJQSMHETydYcc+bmf9BfddId4Va5wthPaB8iq5lwT7xCg
 Cv/TjKmuOxsTURHz+1b+HZphzqYJ7bYg0tz4gbb7ivIxelsDNkRtE9zw7XYSP+7uBMCv
 U0Vws1XFZINzSWoXfGvRVvhvTw+Mrw+Aj9MHgZzsue6Xly4PhUb6CfZJUj6QpPrdNBzk
 X2IcaGT5bX+IFloTYouBc7eSqbmvobjpR3pRBinHwRvFMqctN5jgyyZPE3//z5lB0oKA
 lBW1nW5HDGV9J8lM05ERFKsXtfINJedJPL9XmGPpIdzt1w/zQW/fHIUIc+vo0g5rwTaE
 s2WA==
X-Gm-Message-State: AOJu0Yyq6qmCCfM9aZ2YIZPbkj5JKzQ+LYG7lMXPpQ/imQgGQ8lCQGpy
 6g9kUzjb5MGdzdOcMvBueBK5kJHgUmv3icFB2cQ=
X-Google-Smtp-Source: AGHT+IGm2IdoAAFW4y+JsjRMJWJkjoIN3J11xtK+u4FLqyjBJWtQ4FfyS25CUL9h0LYZgZZJEhS6wQ==
X-Received: by 2002:a17:902:76c3:b0:1bc:2c83:f770 with SMTP id
 j3-20020a17090276c300b001bc2c83f770mr2932735plt.45.1693591566015; 
 Fri, 01 Sep 2023 11:06:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a1709029f8e00b001befac3b3cbsm3264769plq.290.2023.09.01.11.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 11:06:05 -0700 (PDT)
Message-ID: <8332e287-7c55-0fb5-b957-2237733c41a3@linaro.org>
Date: Fri, 1 Sep 2023 11:06:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/14] tcg/loongarch64: Lower rotli_vec to vrotri
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-15-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-15-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 9/1/23 02:31, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

