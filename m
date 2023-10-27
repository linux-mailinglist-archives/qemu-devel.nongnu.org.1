Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F057D9285
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:45:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIT5-00072f-OI; Fri, 27 Oct 2023 04:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwISt-0006qx-5w
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:45:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwISr-00023F-7h
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:45:10 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso14208535e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 01:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698396306; x=1699001106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ItqT5r2iOVvGgoN0QA6Y9XgFg1+cfQVUsfc30W8vlNE=;
 b=dVBQ8x7LyhZj0JOJcijPEZ604+A5qyR6HqDIyqJKkBz8zcDVEGbmtbhAPGWrrLrqZ7
 F12SzDIdnhTNkiQHKUDgz6ZCuPYEr9nllES1PxeVgaKCjoPBFniPdLeGvz1kgzDTdadu
 stNQ8pN4OMPUs/0V2zP5SoVq2ZTjTD8/WJZF0muMs7TqDoqsMQ0kJALUeMJebv+ifenS
 QL87noq1H2iaxSM14pLpsfxL0lciMipm6IigpnmNxTC0mhFsMt9nS/WmpLvHoPZRqOH9
 m110D/QC2BUHvQg7IdpcDbtrtNS/0DP6N4uMDXTG9sn2DAsW9hbSZlm3Ar4YeDC5ZT2E
 Tm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698396306; x=1699001106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ItqT5r2iOVvGgoN0QA6Y9XgFg1+cfQVUsfc30W8vlNE=;
 b=kaRNdfgk43b2vK50EzAbTnEp9dQwLGb0PmJnMfwlXsU5Qeax3ILzOZGd5IV8yKPhUI
 0I5ksE8cqNPr40gr5wXKdQa9GNIwwRAAphihJWTQMawaH+tMWaDp+xBlyDd+sTXzKbxi
 B41bkldI1tluUzDoigQ5lY4D8SN1mh5VFpc1GWt5LlzafijD+uNIpBbrt1XCOyU1RLPe
 EP3KwCiITJEfTXkL2sgAK8sGC9ZDQ7caUgE9txs14C6S0OS2armEKTH0nkPvZVcR4PKZ
 mMzuIj6cY8uZCoUorGoGFoT7c/+SA1RzOHFT+tUAbfRMFvvtPXwP1WO8J2dj1TveMeRY
 kFzQ==
X-Gm-Message-State: AOJu0YzPGlN6AClsjdcbYBcnUG18SXnMgMb5HJuxBzdxquBdu/Rl9VtP
 CniTS79LeNTHoYuDmxLZFZcP9Q==
X-Google-Smtp-Source: AGHT+IF147qQVo7AiFUQMKuEsGBjK7y6qvU+ZEoyyM7GkINSFjdwSvpLKO2CaAjSnycoK+KJscg9lw==
X-Received: by 2002:a05:600c:259:b0:407:5a7d:45a8 with SMTP id
 25-20020a05600c025900b004075a7d45a8mr1930581wmj.31.1698396305873; 
 Fri, 27 Oct 2023 01:45:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 q26-20020a05600c331a00b00406447b798bsm4498768wmp.37.2023.10.27.01.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:45:05 -0700 (PDT)
Message-ID: <a452a7d5-1d75-622f-bb32-df3ce1b10f5b@linaro.org>
Date: Fri, 27 Oct 2023 10:45:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Make sure that gicv3_internal.h is covered, 
 too
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-trivial@nongnu.org
References: <20231027060709.242388-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231027060709.242388-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 27/10/23 08:07, Thomas Huth wrote:
> gic_internal.h is already covered by the "ARM cores" section.
> Let's adapt the entry with a wildcard to cover gicv3_internal.h, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


