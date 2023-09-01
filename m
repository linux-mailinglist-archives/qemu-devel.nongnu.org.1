Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38767901B6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8QU-0001ov-7I; Fri, 01 Sep 2023 13:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8QR-0001ol-SU
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:59:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8QP-0004Nz-NR
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:59:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf5c314a57so17502905ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693591156; x=1694195956; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0+ZcBCVLACLxdwp+PxExHwKJolB/cwxh7+KzhS90VaM=;
 b=ESK1CQgj9dcPoqbmLxqfUYdpoaMxQ7T75SNStaN2RVXHvYiX6bBLScZtT4/3ucT69A
 LENbZLiIbGgoYouOmgzXCQIvLGudJ1zT2wYpc+ePpmf6hC0XxzvrIPj81likPph0zdzp
 LdltS1lX3wNOCTtilFf6cjxuqHLCMIjI6duGOV9rqPZbhmI5R5obfk3OIM0dBES+hzh5
 OqMWbs4zkWhVdeK7If20tQN+q3vakkaZPMpekOy2RxC1X3NMSp++fjdrIBl6Fq7+2Mfu
 nO0UsTePNLoP1TQC+g9I5k69AM7huH3mo2p9HP7ApzSE8GMTbFheM9fgE3JsjDqR9cn+
 mygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591156; x=1694195956;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+ZcBCVLACLxdwp+PxExHwKJolB/cwxh7+KzhS90VaM=;
 b=a97I5FrthMv9EPkQvY5FZh7vhahjR8zXj/v++TdPd1AQar66EaOBCk1xhzDgoTN+gl
 jitbFTYnHkQibo2KmK4TxhEvh73Q9VtdNxp3s0YjGuyzYWf4DrIhIErKQh253SvaD8cP
 JfQj/rY+HJ2t+pMkbZkxQ6Y1EiIY/r9z+U+X67o7iB+k19pn67e/5MP0RIrJYNncPz2G
 Ws/hniv1BEf223Qwn/LS3CQwP6gfmSo7oqsgq/gLI8i6lQ7gZkWffU9JBTvbVFYbw+49
 sIfAMK0hy72OT6a9yOmYrpN6NB+Tti90DvzceAar/PuvGs2xdFPtYg+LRhSTKo2p+8kf
 +iAQ==
X-Gm-Message-State: AOJu0YzF2BRKoSq/UYmsKX5ozPzFOC7NTPdsf8E5HFRQ0WpkxUZa038y
 e2OTP/dpNf3ZvoSmVP6Nt6hHLA==
X-Google-Smtp-Source: AGHT+IGxSw2Gdwpiqw1XuGVmgxkqm6Ce1oKfHRVPxtcAAcQoJidq8RRknd9kBbczM+FHBQCtbM+JMA==
X-Received: by 2002:a17:902:7c98:b0:1c1:fe97:bf28 with SMTP id
 y24-20020a1709027c9800b001c1fe97bf28mr3070266pll.31.1693591156311; 
 Fri, 01 Sep 2023 10:59:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a170902f7cb00b001ab2b4105ddsm3249678plw.60.2023.09.01.10.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 10:59:15 -0700 (PDT)
Message-ID: <030cb393-2084-7844-4992-68088177ae33@linaro.org>
Date: Fri, 1 Sep 2023 10:59:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/14] tcg/loongarch64: Lower vector bitwise operations
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-6-c@jia.je>
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

On 9/1/23 02:30, Jiajie Chen wrote:
> Lower the following ops:
> 
> - and_vec
> - andc_vec
> - or_vec
> - orc_vec
> - xor_vec
> - nor_vec
> - not_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  2 ++
>   tcg/loongarch64/tcg-target.c.inc     | 44 ++++++++++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h         |  8 ++---
>   3 files changed, 50 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

