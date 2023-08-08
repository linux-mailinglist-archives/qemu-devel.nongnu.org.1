Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E368774D27
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUQ5-0006b6-0R; Tue, 08 Aug 2023 17:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUQ3-0006ax-Ir
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:39:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUPz-00031v-IU
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:39:11 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b8b2b60731so39054675ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530745; x=1692135545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvKvIg1wigHcVWqPW4YvOyctL2gIq0VzeC1Z3MC+MLs=;
 b=xC9u/o5gbCCAt50Ld96htNwToN5QeM1mhp0xWGPkiwxqENA9LgspdN+X4UqYiEElqJ
 xqaGMBhdkC5JP5yrkaSpJna2c5oUvIRDRLDdvqFhcRBRQ1lPaY1fD77PDy2TQB7axekc
 zeXejlx/X4GuYLAiw4XZouZ0vu3mXC4dhJpoa4xMA/5LY1vDuaPBvT+O/t++me/hNiOr
 l7dirM2MHnuM30AYgI3XOBNJveGq3tPhEGfl30Fwzu9Dq8E6YAIMmbV1/rl/+LKnScoG
 1ep2iLIIZ6FYnsjT2/Oq3SMC94VdK3iVoB4Zr9gIphuBBqD2Z1i/pO1QbnvE53cgdFka
 n6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530745; x=1692135545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvKvIg1wigHcVWqPW4YvOyctL2gIq0VzeC1Z3MC+MLs=;
 b=D99Rj0s3uVywOGpZKDT6fEi0OO7LpPDjNyixdmxg5DbiI3pchMQVk5ELduByk5Zb+M
 5MKpcU9eJ0LRwPccOUZ17Ro+TM7/MYc5YU4erFPOD6jmH1uVCfqDf8FSeoqFR74oKsDK
 8SbsOKBhf21M4w31YrHVRmoDwMnl+X08hwobW4IYq01o3w3FiHMKDyb3caBrWJ1ANLJr
 5hPCzEVLwbjeiXgmYRfx2gYO5I2Ah23TvRxf8DJS3JYbgbORClKDC8A3VBsjT8zdLlF7
 fkGmApcp27fsq9gmMtvU4HD4wCC1PJmGTHX1PtVECxHhyPvmYs529FnBGw6juB+RQius
 OHeQ==
X-Gm-Message-State: AOJu0YzKzAX9BG5c1B07waIMRE+TD7COLIpqMktBDszk6KGTpUTcwvT2
 BVislaJxUyANqEzmKiyD1sHeGA==
X-Google-Smtp-Source: AGHT+IGMgegX9uozWH0ZPDIQfHOcZJ9VXTrjGXsF9vLVbD8oXT3f/9jdMUCMvKy8QRZgQnLJJ4VbwA==
X-Received: by 2002:a17:902:b946:b0:1bc:6ca3:efde with SMTP id
 h6-20020a170902b94600b001bc6ca3efdemr829591pls.65.1691530745286; 
 Tue, 08 Aug 2023 14:39:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 y22-20020a1709027c9600b001b86492d724sm9479666pll.223.2023.08.08.14.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:39:04 -0700 (PDT)
Message-ID: <9e972ae4-34f4-6924-3b7e-13d5112ed399@linaro.org>
Date: Tue, 8 Aug 2023 14:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/33] Implement host-target convertion functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-17-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-17-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Implement the stat converstion functions:
> target_to_host_fcntl_cmd
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-stat.c | 71 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)

Which host / guest pairs have varying fcntl constants?
I thought freebsd had these standardized...


r~

