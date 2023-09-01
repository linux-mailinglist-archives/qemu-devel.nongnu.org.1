Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE9790123
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7bG-0003B8-7t; Fri, 01 Sep 2023 13:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7b8-0002uK-4i
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:06:18 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc7ar-0002Wx-Us
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:06:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso15875855ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693587960; x=1694192760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/nN2+PGq87VL0Iw2Hfe2k2TzWyBtgJtLOZDPA/2pB0=;
 b=izDYVs9K8qWy9b9PQ4c4ggPz3zsW6X4UllVM/g8S4CBciYE97MhIn0nYBLq+CSyVRT
 k9dhZI6lsAO/KedoQb0w6uSQa2p2CCcyanP18iHv8nmUVrJVGh28GHlpmO+iJrLmm3bP
 SeBifXVtyvI974enhaGygFcz1MK4S4py167qRA3xSYnsvmWMYET/RKHhpedaWdEhQNfe
 TUr48SPyXAtS3Ts1lLSx6mI+eRN+ckiQj0pGGfSlnolZWjCpzHFGu0TPsMPEQwWHjM0L
 p7rCImz9thX40GhFE9PS/D5l37YkFY5LGeGGJJVC3sXxeso04jbvfx0ikxrmKPFHjGxO
 h6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693587960; x=1694192760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/nN2+PGq87VL0Iw2Hfe2k2TzWyBtgJtLOZDPA/2pB0=;
 b=Lhuyo93hvk3BwcBa9G5gtzlKNnvILDKJfzCoVkS106nAUXcjfGLgZTOej4nKbUWcSC
 BP1zc2yqcY82CAEfg3IIe7veO0WWgpZYaCxYe2k0MX+tCW0Ep3eX02OEp2qsdvD6+rRu
 5knqT475voQkKiEgFjGpr8ZVBxqhBoXBeN29MLMroJ75XCDrku0ure6L3He48TijnKmC
 0awhy8okzjanw2hfRPOM1tI/2SeHkA96uPRocsAiAZkaEfTDIo7NZpoZjiCHcURR6zOO
 ppw/guZiofLm5whEst5/Mc+mwm1D9Wc0kLm2z0BjpOUbYRQBVp0vIZ76w5ruQqpYUUz0
 +tQQ==
X-Gm-Message-State: AOJu0YzUp5fafmDAxX67gB72H+lVrEbRAqlqrx2LHFGRf67tQjCYM60x
 Qe+UZ6FfAkD5I/7jBWDuLb/ZZ7RTo24lWgKpJwA=
X-Google-Smtp-Source: AGHT+IEXEbZaj82lTCvEXhGaDJCD3ywn024MV8ZGsp36+bdaYrV9e8PKBpwAp6kgGOVL97H16aL8DA==
X-Received: by 2002:a17:902:e54e:b0:1bd:a0cd:1860 with SMTP id
 n14-20020a170902e54e00b001bda0cd1860mr3441292plf.64.1693587959908; 
 Fri, 01 Sep 2023 10:05:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170902c18c00b001b694140d96sm3224863pld.170.2023.09.01.10.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:05:59 -0700 (PDT)
Message-ID: <2b0440e0-47b0-3f2d-0b21-fbf64bde0c06@linaro.org>
Date: Fri, 1 Sep 2023 10:05:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/14] tcg/loongarch64: Lower basic tcg vec ops to LSX
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-3-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-3-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/23 02:30, Jiajie Chen wrote:
> LSX support on host cpu is detected via hwcap.
> 
> Lower the following ops to LSX:
> 
> - dup_vec
> - dupi_vec
> - dupm_vec
> - ld_vec
> - st_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |   2 +
>   tcg/loongarch64/tcg-target-con-str.h |   1 +
>   tcg/loongarch64/tcg-target.c.inc     | 219 ++++++++++++++++++++++++++-
>   tcg/loongarch64/tcg-target.h         |  38 ++++-
>   tcg/loongarch64/tcg-target.opc.h     |  12 ++
>   5 files changed, 270 insertions(+), 2 deletions(-)
>   create mode 100644 tcg/loongarch64/tcg-target.opc.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

