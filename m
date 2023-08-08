Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A04774CF2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:21:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTU8s-0003f0-Cy; Tue, 08 Aug 2023 17:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU8k-0003ej-Io
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:21:20 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU8f-0000K1-Cu
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:21:18 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1bbaa549bcbso4831087fac.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529672; x=1692134472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=titr88hnnAQ3vnL8fjJ9TdJQGaLvleTkc6NBObka6g4=;
 b=SQjMtrcu9qa/uzCjT1ItnQYDz1/MGx99lkVAryOcXhp8F+fc6Yt3NK1ua9NJMq3By1
 EgquhjwHmYbJQon4gKNxbZoB3RTEgya2hCRy3DmrVXskmAthsZkFth2q2QXrPvd7w1TD
 keD6D0NZj3SoNcr4heopwFkBv5TQjLm8L7EuISxqp+hMQTdbWqt0wiIH6bMbYzjIDEwi
 PSlnbJ0gB8kqMds7nPjV9ZR4mq0DdhAkxA495/i+NH3BvATF8DMleu49UAX1QiRnyEr0
 ntNkkGOgw5xk3zhwp+kDK2byIdI7DtQFsp6LliWmBWoHhm1cDCpaaAyaTWEiPaJn7sWm
 YuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529672; x=1692134472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=titr88hnnAQ3vnL8fjJ9TdJQGaLvleTkc6NBObka6g4=;
 b=EwMinkf6+YDXworj0VsPFIKeZ/8MTBIuH0sWu0Oj1VcVgTUAl6YjxaocZzTNAiX3Wc
 jkQU6hBdW5poAnjoMb7GM2THP+KyExgPCSFhMoh2B73CyJexUtj3WjOJ06XSxxRB2mwH
 b0yMcDJZJa6UZ77LWbAdZUwMATe+yoXxNFU3GEg3LywHvFnjgQkjCJT32Z7jgtFH89Lh
 D72iFngt9WXZoQxYh50ExTH1HBWdz6DQfzK/ZJsP1lAyyRB09+YvwvHNSHOSoRzsWv69
 DkccC1DCbVMs46/MtaD14gUTdnh9idwcjNroToA8IPYTIZs6PtODYq/kjzgHji8OuGRT
 xVBQ==
X-Gm-Message-State: AOJu0YwCeYbmTFAE7nARmffQ4YczUVnxb5zRa7QUy0NYg2g1EmhotxzE
 QJVBlvqD2G1+77lHo3aCIBUJN5hC4cYBPL3cmfs=
X-Google-Smtp-Source: AGHT+IFblJ4dHneY9+mEkTmXbwLvMZhAQMqrTWdmzG1P2HnyiYs07EMap5DQqdbf6dC0bduGAhOZSw==
X-Received: by 2002:a05:6870:f707:b0:1bb:4bad:ebce with SMTP id
 ej7-20020a056870f70700b001bb4badebcemr890132oab.27.1691529671257; 
 Tue, 08 Aug 2023 14:21:11 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a655806000000b0055c558ac4edsm6299228pgr.46.2023.08.08.14.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:21:10 -0700 (PDT)
Message-ID: <0cdea983-3f95-27e1-e101-3b778da5e02d@linaro.org>
Date: Tue, 8 Aug 2023 14:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/33] Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-7-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-7-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

