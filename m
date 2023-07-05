Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2311748EFA
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH9Dk-00040j-2K; Wed, 05 Jul 2023 16:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH9DV-0003x8-Ji
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:35:19 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH9DU-00062A-1q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:35:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991ef0b464cso222376166b.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688589310; x=1691181310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aoavj10agISuxA7H9qqy+vGkR7hN/BR039AWfsJatbE=;
 b=bBoJzud1IGcvRNtdIfAusM+c/E7LQxnWOXJ0hEMyTf5MQP6CCrlsMidI1n9EZTF6YG
 twL+M2IMSrDwlgcwlg1lWq1ssb0E+cGLiEsS3x9C9/ZBtxGg1cCPFfzYvGR5g3zuGx3n
 IUa/e9rlMa+G4I43jnDD+qQAeOzeQ+AovRuz6k64tmlm6LjtmbCiltNS8MELfJHi/mmy
 LSOE/BJWgVk8UaVCEnqjgQgAobxTfitHZlkO/pAywfsoWDkSujN0XJ7q5/l9lxSIgDrx
 n7lRkUd9kXiyuxDSjwL28inxvgwn3QcdoDqUcZU6iYcdLwiDmRecgmMYkdn3UEeeiNBs
 xTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688589310; x=1691181310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aoavj10agISuxA7H9qqy+vGkR7hN/BR039AWfsJatbE=;
 b=ib/J98mrpcXQPrVLss/yQrK+NJ5DBoo7nnM5N5qAyCbRuGs62ol4AHjN642I3hyJCo
 jKb1lEi407W4fqWClgL+bASySWR6JCULO+L71VZ3l8Q7cje/9Q6PumwFli0Zo/GK3mrE
 Wy3Tj0pF9/CFer/wWsPWI34J4/T6+39IqlktesejEMmKrYEKGYah7+x0SbRDZST19e4D
 p3qU3Zu5tZWWaUUopf40TjpRr52sdAdfNBngej5CaUFRDz4WV7DKF/NdNmQmay2OZ4y6
 JVJcJP3RqYuQrh40IhNINlIlNzae6HPxRjtqfWf4cQ/fryrC2SP6hpBvP9aMkZ8ugk2E
 eYzw==
X-Gm-Message-State: ABy/qLYxH81v91yz9KLvuc+uVVC+89QQYbWFQmt7QEhzmv7yq3+cDZ5k
 Oj22TOnnvRBLOloTViHflR70OQ==
X-Google-Smtp-Source: APBJJlFelVMXf/izjWVyUOzK90Kr7Uml77rlE/Yef6SQwRKSpv57UkJzpLnEwmtPwvd1gExAoge8Xw==
X-Received: by 2002:a17:906:1041:b0:992:8d96:4de3 with SMTP id
 j1-20020a170906104100b009928d964de3mr200237ejj.24.1688589310223; 
 Wed, 05 Jul 2023 13:35:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1709060e0900b0098de7d28c34sm14849803eji.193.2023.07.05.13.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 13:35:09 -0700 (PDT)
Message-ID: <413a30a2-c050-7587-8c0e-a6d89c8b7ab3@linaro.org>
Date: Wed, 5 Jul 2023 22:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20230705141205.525776-1-kkostiuk@redhat.com>
 <20230705141205.525776-2-kkostiuk@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705141205.525776-2-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

Hi Konstantin,

On 5/7/23 16:12, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/vss-debug.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>   create mode 100644 qga/vss-win32/vss-debug.h


> +#define PRINT_DEBUG(fmt, ...) {                                               \
> +    char user_sting[512] = { 0 };                                             \
> +    char full_string[640] = { 0 };                                            \
> +    snprintf(user_sting, 512, fmt, ## __VA_ARGS__);                           \
> +    snprintf(full_string, 640, QGA_PROVIDER_NAME"[%lu]: %s %s\n",             \
> +        GetCurrentThreadId(), __func__, user_sting);                          \
> +    OutputDebugString(full_string);                                           \
> +    fprintf(stderr, "%s", full_string);                                       \
> +}

Why not simply use a plain function?

> +#define PRINT_DEBUG_BEGIN PRINT_DEBUG("begin")
> +#define PRINT_DEBUG_END PRINT_DEBUG("end")
> +
> +#endif


