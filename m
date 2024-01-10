Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25D8299F6
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:58:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNXDQ-0000Ae-09; Wed, 10 Jan 2024 06:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNXCv-00005l-Ol
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:57:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNXCu-0001sX-16
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:57:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e43fb2659so35482585e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 03:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704887833; x=1705492633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GXlImAB9RzSyZJAsyx6tNS2Cai8oqPlw9CPpszy2ykk=;
 b=tibDpEryMNUSd42S8JC8MUgGU3w4KzAlhMxTPgnd5yOsekpt9bvYrHqs3HEnvY53Y7
 v9/AzFoivcag+Jy5Rk+e8VsQr89BRKUNKppfXGrtyjA4j3A5/ZVwAal+3i+ebBfNnhsa
 SmgTJfxBYRU2XauoYEG3eEWLNHCpBFmeMzN6HmqQv4IXnXYg2m4G+ziGjx8zoEezhBS3
 AAaJ7sYEXh3JeagduoVt4koQf7zuCk2qIYRv+L+LVRe6YdibeFfVTjPGvY8nyDZHzLxV
 kCcjyy0wuYZV9edTwCQsVTNQ2MOzGJpBzA3WBm0NvLnRYqO0GZo2qtjIh8jyjM+Wvcw7
 8TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704887833; x=1705492633;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXlImAB9RzSyZJAsyx6tNS2Cai8oqPlw9CPpszy2ykk=;
 b=pE4Idrz1HGoFNfb9bNAyEvCQycK0KruS9QXoxa6zRXA7fPn1kog6DSuVV5Q+NojKfS
 AOXyerNTsXA0l/Os4qP3HbnlmjImMpU4/VqkChmimH6cV2JDLKHDWlBWGlFn8VG6a3Nh
 4hixk2DbR6gE8/K8V50f7aX5JjBTaMvbf0kP2q73G80Oz1YbdfV+AUTw9tT7Q9YpSN8H
 Ahi16NkGY3ElhBh91D0lXtVT/Rsd0l8eOmm69NlXhhsRHtzq8h31K/bB2vQ0QUENWrN7
 RN5FNheZhhvHmip/U1RicKgnIaGJ2zH8ey85mLbi7cZShnfWwxC1YVlIseJH8eWtB28y
 Hifg==
X-Gm-Message-State: AOJu0YzS0z+bq5idtYWXfKeddHQ7mC69t3r0EJszJ5poJL6JuGOWepOH
 1xtmPkNNirvrU4sXBX9azstMiL9kYY9M4mAuyiF03KyRqFI=
X-Google-Smtp-Source: AGHT+IGjQGOxdMFvoWbQlpmcbGk2gvq3SZLcfayqxwX16f206nvY99MhrOgT+lkAuHtK11Ltjmv9Cg==
X-Received: by 2002:a05:600c:3b15:b0:40d:763c:e7d6 with SMTP id
 m21-20020a05600c3b1500b0040d763ce7d6mr566010wms.175.1704887833482; 
 Wed, 10 Jan 2024 03:57:13 -0800 (PST)
Received: from [192.168.1.102] ([176.167.134.179])
 by smtp.gmail.com with ESMTPSA id
 fs23-20020a05600c3f9700b0040c11fbe581sm2002808wmb.27.2024.01.10.03.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 03:57:13 -0800 (PST)
Message-ID: <29d2d67f-504f-451d-919c-fe2b2dd5c696@linaro.org>
Date: Wed, 10 Jan 2024 12:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io: add trace event when cancelling TLS handshake
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240110111615.28004-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110111615.28004-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 10/1/24 12:16, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   io/channel-tls.c | 1 +
>   io/trace-events  | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



