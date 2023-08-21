Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2127823FF
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:50:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyjX-0003Ko-Ut; Mon, 21 Aug 2023 02:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyjV-0003KY-UY
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:49:49 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXyjT-0003mK-L9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:49:49 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so1047902e87.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692600585; x=1693205385;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4N4IR7UeEMfsezGw3Hc0LU7jF9MgI/HHqYhlp7YhBc=;
 b=iDW3fuc94nPdxW/Kf0p5udJXj6HbTl0rWXyJTR3XMNYoxmOR927y5FAP71LEz463J1
 ofMnDLXv4q3/IO7DSFQDls2DVWs+PZvTLjC33Xgrq+bZPrGah+af/HE/k40eMAlO4OjT
 NFv1yt0TRbkUBzb+z940aYHBx8gbkMep3bRhMi2QCuxjHmoXICfOLrS9aBxsyg8DWqlO
 0sVhoqgw08RFc5ypEhj9JKHYqoeM71qzpH5i7UJlhxrWehn5I8Kez9CyKoAdu9Fj9puA
 HDKxOIOGSNJlxRWJ5le5shmgzqmCZtvoDcsfohegTMbu2MuRz6FCzeRmW1QoS2SXF3oV
 JoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692600585; x=1693205385;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4N4IR7UeEMfsezGw3Hc0LU7jF9MgI/HHqYhlp7YhBc=;
 b=mE8JH6RWLX9hnPrnDWTVeDr/pT2lJNouxc3a2+FtjRl+lJsLH814IeCl+ad0YZWLOr
 8Dm3s1kvFYCHeyvYyTrRRQULwwp66honszLx2B9agL7ULLhecmGFQ9VN1rMltogR4CWr
 HOQKT6Gcd2EAIeSmB6DSgvJfuHyWNngcT++XiJzNA627S2BLxj/v7MKjZ4tSC/greOY+
 oP6q5jgFa9aiV8igKovyhewMuStQwkgQGQapwLCtdyqyJtIw86+yQMGUSa35LQi5pmuM
 /0pCAlfSGP6bY4CYW2Us3cO9IFAzDCFabLRsGzMduqyryVkXSijY7r6gPm3IeFMBljCq
 tKfQ==
X-Gm-Message-State: AOJu0YxkLi8ajOkBl8nMi1rcT+pOvz6CuSErI414ar2kQRPxo6xjU19D
 Oyilbt1KT4OGIyR5cyV08Skaqg==
X-Google-Smtp-Source: AGHT+IGcdbu8cQ6YL8ralxwDYdWBQcA1suQ1sAmlz5ReVUEOITnWEVYj+ts02fjAonwRkET1SE7Lug==
X-Received: by 2002:a05:6512:454:b0:4fb:9497:b2a5 with SMTP id
 y20-20020a056512045400b004fb9497b2a5mr3254602lfk.21.1692600585331; 
 Sun, 20 Aug 2023 23:49:45 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c231000b003fc00212c1esm11632555wmo.28.2023.08.20.23.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 23:49:44 -0700 (PDT)
Message-ID: <790a6a7d-42dc-bb02-ae5a-d608a22934fa@linaro.org>
Date: Mon, 21 Aug 2023 08:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 19/33] linux-user: Split out mmap_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230818171227.141728-1-richard.henderson@linaro.org>
 <20230818171227.141728-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818171227.141728-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 18/8/23 19:12, Richard Henderson wrote:
> Use a subroutine instead of a goto within target_mmap__locked.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 69 +++++++++++++++++++++++++++--------------------
>   1 file changed, 40 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


