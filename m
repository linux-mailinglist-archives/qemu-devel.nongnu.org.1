Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FB781A30
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 16:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXN6R-0006hj-E4; Sat, 19 Aug 2023 10:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN6Q-0006h7-2w
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:38:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXN6N-0004JT-UA
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 10:38:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6889288a31fso1270779b3a.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692455934; x=1693060734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dvMf54WFT6PaJaC8LPMX01s8V/iipw2pX61xnDCJasU=;
 b=JCX2IUfpC4MBshKPrykrSIKGfdHviQs+ahRl1tedieKrCgN3HkUEYl0qBpXn5oR/e/
 tqiQjlyg2Ntb+MgJGVgyQQDGeZ1wu2bco3yxhuIanpi4uJ0YceSi4dokriul3dxk/XKL
 FrSe67TuOfKOaJkkUo7wzGOcOEP245o7GFusU3k0hXUVg9hBMCeC4q4/fhXbONtDUdp2
 LjL1fX4+3LsqTnmL0sWefs3N40KkSDnEMiaXCzHLkYZ05hyH6AIlFGyGf/WKhWqeMVOy
 XO9CmknQJJ+VSu++hMwW5bm7J9fjjVFodUjA2urupRSa9jHQS05BBPICdq5eX2+BLr5F
 2geQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692455934; x=1693060734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dvMf54WFT6PaJaC8LPMX01s8V/iipw2pX61xnDCJasU=;
 b=b25OXX0eOhu5RnOoj/zPm+I/RwBU6g5/7cbm4Yrl5L1TZGNgAqpEJS9fe3FSsTOWoH
 cq9oFWpEdM0oRemxuFwsWb14KtQDx1oArmGhemejr1913OtMZ0Gzl5TBfBK/jprFezSE
 MXlYjE+sq6cuiUXhL7y7dVapgHL3A1s8EO9E14oCKVCvM7r2CMbEhephdkL4ysSBxeEf
 eEpKUDb4vrGSu8LbM3hMMG6pZ2RMQWnv/eVpu86a3CTwRCtgvVUL5uJXoEJbBnR/m/BZ
 MgZC1y/ZeCULaOveOj8qPagQC0PVq8F2wuCCOzaDb0+BKkcspb8jWH0iI+7ov2px/tDA
 QuwQ==
X-Gm-Message-State: AOJu0Yz1I8cYG39SJEYnRUeiKz6O13Haa2JZkwr+uqBW+M5sYbBOydzt
 b+Oj38jn2tFmIaSRrzDw0+QqDg==
X-Google-Smtp-Source: AGHT+IF5Td2+dHcTnkT1Dh/UcwjAMiJqChyyIt5UCALrBchzD8iGfcMBkXlplYg/FIQxxv0gIQkhkQ==
X-Received: by 2002:a05:6a20:938d:b0:135:bf8d:b758 with SMTP id
 x13-20020a056a20938d00b00135bf8db758mr3347357pzh.16.1692455934264; 
 Sat, 19 Aug 2023 07:38:54 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:d058:ace4:c86a:5384?
 ([2602:47:d483:7301:d058:ace4:c86a:5384])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a63b246000000b005579f12a238sm3457704pgo.86.2023.08.19.07.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 07:38:53 -0700 (PDT)
Message-ID: <aebc2d63-514f-aa2a-0a9c-4e46753b76f8@linaro.org>
Date: Sat, 19 Aug 2023 07:38:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/22] Implement struct target_shmid_ds
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-3-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-3-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

