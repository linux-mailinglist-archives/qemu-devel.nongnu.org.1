Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680E81F37E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 01:54:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIef5-0000mg-74; Wed, 27 Dec 2023 19:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIef2-0000mP-3f
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:54:08 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIef0-0000wQ-JD
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 19:54:07 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9f9689195so593291b3a.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703724845; x=1704329645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sJ4m507ajLfx8ejtxdKj/bGKEnN+ZOxzzQuW44I3TzA=;
 b=z62uBO1zx//l2OHHKtvIlSSuKvpHe2Xbhsz20zZONcEI2pBBOTlj42vonSzvn2aDSG
 D+GyUT1cYQ/BGzR7opEwnwyZ9aIzNQkwdK+Kjy+Q1860qeN1N5+GRkupC2teIU9YQlVH
 TFt8bcchlrHIZqEVREia830thAmMmdHgpjhjaoM1Ccfeu7XP/TNihDHzrQemngFPrt5P
 4CuIGUVEBPd2MwWHqrUAinZAGRVOKJgVO6TXq8GSPON2njlYFrExsigSbJbMbVRTbVYJ
 m/bgvmUY3hChx3WZOsNiYEisNb/eSu15/LhV5/PO1T5cHM/19Q1Nl6xT+Feu7A7z77Pk
 ljmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703724845; x=1704329645;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sJ4m507ajLfx8ejtxdKj/bGKEnN+ZOxzzQuW44I3TzA=;
 b=Wt2rdxb9ihDt6DUJaGUdCUn0Z8URzF7qwXkB08oy4dgqWRShnSCUAaY01/oNnktQoK
 LoFYwsnXaN5RwQF7VsapoCy/6JPwvDPqFJtfvXtAxqBg645DBj5dJa+7DWqsvbctKMUy
 E0YFutC/UPkCs3Rl4Y+wHeDeKV1D8TvSJrCE8/ako6cEfoe+7U8E6dvmSsd9iuVRaeW9
 9V9v/IZMlzmALcjf5k4EMRIxsOqDAr6HZPT7gb2R36BX8itt0ErLjJ1B4lWiXDhwaex/
 pYjzUTnosC5gGQIb8ucPVysSDhRtZJUeQ1xDlLrAVx6q4SWHFvkHonj1AhVvqnhdm2Zp
 Insw==
X-Gm-Message-State: AOJu0YwIjdyYcYY89Sdd9Ptr45TWH2haA0R+keLs3WkD6rf18D0zi5rK
 SF1Hc9zbb4jJBgrBtauBCugR4EOla5buCI99XcTXvgIdZMoKaw==
X-Google-Smtp-Source: AGHT+IGdb8mKMOofFuyfQZJ38v3RQHJgf5UG8Z+pXkTRtgG4lV1xKBZmrwWFSwvFY/ysTgST0oaCHQ==
X-Received: by 2002:a05:6a20:12c6:b0:196:4a2e:4ca1 with SMTP id
 v6-20020a056a2012c600b001964a2e4ca1mr201171pzg.22.1703724845268; 
 Wed, 27 Dec 2023 16:54:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170902969200b001d4872d9429sm1145847plp.156.2023.12.27.16.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 16:54:04 -0800 (PST)
Message-ID: <7ed61f21-7e70-4bdc-8b6e-2e02c65ba180@linaro.org>
Date: Thu, 28 Dec 2023 11:54:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/35] target/arm: Report HCR_EL2.{NV,NV1,NV2} in cpu dumps
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-34-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-34-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/18/23 22:33, Peter Maydell wrote:
> When interpreting CPU dumps where FEAT_NV and FEAT_NV2 are in use,
> it's helpful to include the values of HCR_EL2.{NV,NV1,NV2} in the CPU
> dump format, as a way of distinguishing when we are in EL1 as part of
> executing guest-EL2 and when we are just in normal EL1.
> 
> Add the bits to the end of the log line that shows PSTATE and similar
> information:
> 
> PSTATE=000003c9 ---- EL2h  BTYPE=0 NV NV2
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

