Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BC7F16A7
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:03:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55oE-0003HX-IL; Mon, 20 Nov 2023 10:03:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55oC-0003Gx-DP
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:03:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r55oA-0006X6-Se
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:03:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-548ce28fd23so1094764a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492608; x=1701097408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgriH655Wf/0zFwhs81egghS9sZrTZkWoX9+rnFEfLM=;
 b=NoTswNEybeZWPjU1+zxsHiYWareuea1pMQnYvGYW6LPd3BDC/ZMmCXEuRRNh54xCo0
 mamoPM5W8FMLyfUFhEB/LO594S8tWsiZ+rvqEES8vk6AlPDDWXWplD3gi47KXeFhX9eF
 Q/4Y081Nizfvf+dPJj12MbpWNToLmxHGj1s1rVg//hJlhhqXjAlwu5ZrtODwxz5r7B/I
 iejjr+iwHE6CV0txx8SJftJdIsIu0rS1PSLdHzXu6O4mmyp1tkSLRJ6+TECO9/444HFB
 z7XDZXl0l4pAz2jX8PGcaIu2SCA55PiJu4Sqy8arV/zF5K+Ftj22ukOkEl/OlzfIV4cS
 LFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492608; x=1701097408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgriH655Wf/0zFwhs81egghS9sZrTZkWoX9+rnFEfLM=;
 b=Q48fcIGnfhqG+x+SChBigu/1gz6XqyXIrIFqjBoCe8RY3m6Yzx2KCChldOhIN+Ur4f
 bJhkfJPpSTykSxEcoG4jzcym2uexuEhTTIw4p8uJbItcR5rfqNzGKgxrVqL5Z31qi263
 rdTZ6iGAb3CgUcMNdpGy9UTrSIqn63pFNQRRlIkT7KUEfM1B5YHmizaky9LN0958aVzU
 URwvLYYUjKCpuEOrSQ+YscGVS0WCvVqMt+BLo/yfQkQAP43bBP7f2FT5LupZxNnJBK3T
 HfDr3GsIWFChsC4CVZi/AF84hWeouG6IeUqVWTLz3zxzK017uovEUVbgfB3bJ3D1sqtH
 zing==
X-Gm-Message-State: AOJu0YyXO6H98l2/ZyFlEuEuqOuKpm21ZYmtfT4ktlpOd4bABeeH1odY
 MKzlkRJvgvt2vqRenbEBK/Ex0Td4qKFsOHprZdM=
X-Google-Smtp-Source: AGHT+IEEdXZjaxxYvsfLtfE3H+8Oh5IndqhrU1+XPy5I9oy0WYZ0BTohsV629Y2KAKn3h2tKfWMsdQ==
X-Received: by 2002:aa7:ca42:0:b0:542:d3e4:729e with SMTP id
 j2-20020aa7ca42000000b00542d3e4729emr6191796edt.1.1700492607967; 
 Mon, 20 Nov 2023 07:03:27 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 u24-20020aa7d998000000b00548b55f5ffdsm1262339eds.16.2023.11.20.07.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 07:03:27 -0800 (PST)
Message-ID: <40ea3e77-e906-49c3-b256-e7ae7f262b67@linaro.org>
Date: Mon, 20 Nov 2023 16:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] backends/cryptodev: Do not ignore
 throttle/backends Errors
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org
References: <20231120145835.92030-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231120145835.92030-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/11/23 15:58, Philippe Mathieu-Daudé wrote:
> Both cryptodev_backend_set_throttle() and CryptoDevBackendClass::init()
> can set their Error** argument. Do not ignore them, return early on
> failure.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e7a775fd9f ("cryptodev: Account statistics")
> Fixes: 2580b452ff ("cryptodev: support QoS")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/cryptodev.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index e5006bd215..c0b2abc943 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -398,6 +398,7 @@ static void cryptodev_backend_set_ops(Object *obj, Visitor *v,
>   static void
>   cryptodev_backend_complete(UserCreatable *uc, Error **errp)
>   {
> +    ERRP_GUARD();
>       CryptoDevBackend *backend = CRYPTODEV_BACKEND(uc);
>       CryptoDevBackendClass *bc = CRYPTODEV_BACKEND_GET_CLASS(uc);
>       uint32_t services;
> @@ -406,11 +407,20 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
>       QTAILQ_INIT(&backend->opinfos);
>       value = backend->tc.buckets[THROTTLE_OPS_TOTAL].avg;
>       cryptodev_backend_set_throttle(backend, THROTTLE_OPS_TOTAL, value, errp);
> +    if (!errp) {

Posted too quick, sorry. V2 coming...
> +        return;
> +    }

