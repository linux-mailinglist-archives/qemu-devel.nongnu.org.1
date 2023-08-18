Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FFE780F44
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:34:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1Uc-0001oF-D5; Fri, 18 Aug 2023 11:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1UW-0001ny-RH
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:34:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX1UU-0005Ro-NA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:34:24 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso6078055ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692372860; x=1692977660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kYlX4YIwkx7g4Hg1yA7+S3PLMAU+BoreQfaFuWGAq6s=;
 b=h9jjGGyXUoZjqTG2/kdaRDEswYsbsatm+fNYATIX+Yq5TWn0SrIW4TQ4lTsM+7HC1w
 neKDGVB7RnZ2kdg1Jsp3DB8Wm+gbQEXcydniRS+8hH9PKV0OPAlXBPNt+g3sP1+HTidu
 8sx3ZwIbNHXWKxmr6ZLGffeOAgfEUEKcbIS49gHXUN+XRdwiF1XU/9EqevfVP6s+JR8q
 N+xNANlpZat0ka77IuY/l8DhOQh9O3PFTIyg0WT9kWAumgA/ihnMoutVh/955cbVxGrR
 Qd0UVdnS6wJybIld/bINJGosh3LNK+3gAXynINaPv1Jhxi/M6YfiqaIhp3WGLyIX1aj5
 rQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692372860; x=1692977660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYlX4YIwkx7g4Hg1yA7+S3PLMAU+BoreQfaFuWGAq6s=;
 b=Vj7dRtEinWIQgn7rQUo5a9wKh2Zt5vj10V0/QX93nBBl/xd2mx6I3NMIQFEMftHoXF
 EmsgM18ctoACnbVHNMVEHpCTMUU8UbmOEATg/YRngTVYEyUllTQ38q3wX9RVSYE43mHm
 czzHyvEOo8VqWfXdaT6XaLnshpPYioMLI/lkAwsTF/DLjAa9+jJwhjLhR/Uq697P5B8R
 NBipZderjq69bly+0EfKdFpIsST13+ofuTWNLjnFSAQVPRVe/aL5e9rWX3Lk10l09rU/
 OXRu5BTXSl+DBYxGWPWtxZDHUh+ZnA6u8NrdNL3h9/dW2RT62xhIgWsyc1oimhmigSlz
 fBOQ==
X-Gm-Message-State: AOJu0YycueHi/ud6DuCA4mLjOxYA3GdSIY8fZt7RCB4ySBJOoT9ajTJs
 L0cEX8xBmXhu1lHw4yoQqsnPkQ==
X-Google-Smtp-Source: AGHT+IGO5avNrMFNxpAGgil0o8VL4/w9TTeVGU7a3y2Tc3ttkyXJwkE4UBv3BqebNj352qtubl92bQ==
X-Received: by 2002:a17:903:2587:b0:1bc:2f17:c628 with SMTP id
 jb7-20020a170903258700b001bc2f17c628mr2931039plb.56.1692372860631; 
 Fri, 18 Aug 2023 08:34:20 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a170902d35300b001b89891bfc4sm1908971plk.199.2023.08.18.08.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 08:34:20 -0700 (PDT)
Message-ID: <aacadd15-3d21-9f41-18b6-72f7bb481c27@linaro.org>
Date: Fri, 18 Aug 2023 08:34:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/18] target/loongarch: Add avail_LAM to check atomic
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: c@jia.je, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-17-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230817093121.1053890-17-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/17/23 02:31, Song Gao wrote:
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   .../loongarch/insn_trans/trans_atomic.c.inc   | 72 +++++++++----------
>   target/loongarch/translate.h                  |  1 +
>   2 files changed, 37 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

