Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AAB793F27
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtky-0002zK-OJ; Wed, 06 Sep 2023 10:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtkw-0002zC-Jx
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:43:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtku-0007Yb-46
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:43:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso37060895e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694011422; x=1694616222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vCRyOi38D2uZB2/KtpV7uBHo3yV+RCaZ6F1PqdVzEm4=;
 b=Zx3g49TN/LkpvzECgTUk12+CSBQHxqCrVK6NMEHXDWaVAKqYbD/5d6A0PPFNmUNPUV
 r+b3GODWS4DpP7gok16DBCevzpD6UcyTF27LkG8SpEZ2xzd6jUo7WnAuOosFnFCFMw5f
 3y2Rqvj8mcbkiZRnqgzV+b3ObsoS0bDKFcP0FUugt59KbRpB+v6Gz6bhfqsJv9Cucm4m
 QCHzJqjyJtmIQVkqwzFRzLpJNoa/3G36Ralow4s8/3rHE+3ndf75v1Z2HOEG2mQCIJLC
 xT8TOa4fLzqHh82+q7WnN7AusjbJ84Tng9OFaHXrl+pTCW2oA5Xj6TjbZfJQF99dPtA4
 yW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011422; x=1694616222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vCRyOi38D2uZB2/KtpV7uBHo3yV+RCaZ6F1PqdVzEm4=;
 b=KRQ1wLUFZUnXmN20+pKZTA9sUhNAIur6PbkXevPCTNRaztBBQQOlXqQOD1PZh2YkAf
 S64QZgXWZOs0ws6dhKWk7hk+bNp3E7QOLgq1MQsERitl5hpG7Ee0bFoMOGbPCZHFNOrL
 aZ8zA915xbpmxxklnjCfIQlZ1DqWpXPHJre1bWR8F0YHbCjIRl6YAc7Px1Rj504vWUp+
 JQmMM51dTIa1ApHao65Sm25Tlpnj6Ypgzg8v6aV/3ba08dRWixf6AQebXbb06PdzyipF
 OkSBfkMDoXXN3EBoErRSx/EWNQXghEX3eUKq2Tbr/ZWz0JQpcH34dJwQwgoy2A6hhzM0
 Vzrg==
X-Gm-Message-State: AOJu0Yw+6tLruZ3cJVggiLFj/6fffBFDIuDHhtoJpldP+FmjA3q+sfXm
 fJ/MYlWz0k3kFcCUGupmeVob3g==
X-Google-Smtp-Source: AGHT+IGXm/N4Z45SX7xVV9T7Eph9YQNfIPeFeRb7eRcgU72dgs1qtzGESKaZcHV8APr3lsqGpQRICA==
X-Received: by 2002:a05:600c:21cd:b0:401:b76d:3b8b with SMTP id
 x13-20020a05600c21cd00b00401b76d3b8bmr2344493wmj.16.1694011422135; 
 Wed, 06 Sep 2023 07:43:42 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 s5-20020a7bc385000000b003fe61c33df5sm23214459wmj.3.2023.09.06.07.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:43:41 -0700 (PDT)
Message-ID: <d256b040-d151-05a5-2654-d3b951074984@linaro.org>
Date: Wed, 6 Sep 2023 16:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com,
 marcandre.lureau@gmail.com
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
 <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
 <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 6/9/23 16:33, Albert Esteve wrote:

>     I note you  ignored my comment regarding adding a 'Error **' argument in
>     the previous version:
>     https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/ <https://lore.kernel.org/qemu-devel/911eef0c-d04f-2fcf-e78b-2475cd7af8f0@linaro.org/>
> 
> Sorry I missed those comments somehow :/

Ah, I see.

> I'll check them and resend.

You can also object to them, explaining why this isn't really
useful, if you think so. But first read the big comment in
include/qapi/error.h.

Thanks,

Phil.


