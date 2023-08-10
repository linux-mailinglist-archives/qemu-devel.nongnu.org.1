Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAE777ECA
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:08:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU99G-0002yt-9j; Thu, 10 Aug 2023 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU99D-0002xp-PN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:08:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU99C-0006Yh-3J
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:08:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso10066145ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691687309; x=1692292109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2tiTK8ShdSEvcy2YLmekvQATEtwugllbbTpIbnRq3Y=;
 b=XQZg+G8vyHX9x67QHIhW6cqv2s6eISiJvGkwsB9yJ2a0X4HiSktOpD3IXRz12dB2Ob
 nOI0zFCAPvm8H1lFvt4lSx4vDo/N5AqNzdWWdnSwVoDA6GkrKedN6We2d9E91WqIGuha
 zevQkJnITn69i2MeYMe5AJrmxpg3hl+JerbHMNCtReoN7QE/fbCQgVLv3VTfTbtyZS6Q
 pMSf4t6uYyOrf0wZdJx/TnbsZoIRLYIqtGNMm31UUkc2T2xfny8wgt8QJLxJz7nL4bKM
 kxsGKAUq3DA2w0JZTrdi/sjBrtcm84Z5cdG/6/7f31ea/cvgIQt5cQe+ZOHStQkhdfFj
 N+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691687309; x=1692292109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2tiTK8ShdSEvcy2YLmekvQATEtwugllbbTpIbnRq3Y=;
 b=Wc6V3bVwCKL4o3JVg/Sn84tZluhfN09VxJUOfuXvRWAby6+wvgtG65jjj5xkrErK1g
 dPntyPa9MRncWabSIe8m4Hr4X7d25ZqA5Gd2tNMMhmIsealOQjy4scp0g8fKUsJwXDy4
 2TwrABEGyferOTC/CjtXpzicNRXgNLNphNtE3oYr6vR1tOKrWv9KOt1Aee6KUetNhIcr
 eqWJzm0sAscwaU707V2NgF+UIiITA4+uvYQExgbyDyFn0KGGBwyRgmbYNYdkY6BaM+QL
 VkhAQSuQbuAvP89uAFaD2jMQqlOOiOCpu+yRlrN0Y28+NhGV4SLypTE3hV6nrjDseeH/
 wh4A==
X-Gm-Message-State: AOJu0YxfBI4YZpQcwnLn7AFJqFTWT0//ThHJrJqbRyw6MrmmzUTi3SnV
 ZNCVDEevp3IklNPwzSh2lGAaZA==
X-Google-Smtp-Source: AGHT+IH/+htUrMjIai+o1C86lI2M0kpD6ffvqWy8yt1pcyI17vGdDUxkXvADFxtnJ5oA+TyuYYeaYQ==
X-Received: by 2002:a17:902:7d92:b0:1b8:6cae:3570 with SMTP id
 a18-20020a1709027d9200b001b86cae3570mr2564262plm.11.1691687308795; 
 Thu, 10 Aug 2023 10:08:28 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170902728c00b001bbaf09ce15sm2024261pll.152.2023.08.10.10.08.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 10:08:28 -0700 (PDT)
Message-ID: <d4593d2a-e0f2-4421-2451-e46017ca492a@linaro.org>
Date: Thu, 10 Aug 2023 10:08:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] tests/tcg: ensure system-mode gdb tests start stopped
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810153640.1879717-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 08:36, Alex Bennée wrote:
> Without -S we run into potential races with tests starting before the
> gdbstub attaches. We don't need to worry about user-mode as enabling
> the gdbstub implies we wait for the initial connection.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/guest-debug/run-test.py | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

