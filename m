Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC2774527
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRa2-0006oc-MB; Tue, 08 Aug 2023 14:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRZz-0006oI-G0
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:37:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRZv-0002Dt-TQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:37:15 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5773459b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691519830; x=1692124630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SVhlCVc3BQ4vOKU1xOzs90AMb73nJF9hGlNFGxrCrak=;
 b=KxcX4DHBIcDAyFIuIxq7QFOyv3moo3QGPGOhHB0VxkN50k8zw1fGzwqIiekNb3k82t
 lbiIvV80tSqwdY7N3EkdmjaSEP7PY3TgrYUxHKSduZERBQjZwMQW/yzg4mqGAbsVop3G
 d4Tau5sU1Y1NFDoNDYtW+qjYtIYd6EZKqnMtq5XoHkMduJVn6LGPGxO68kbQp8XgA3nk
 ZYd5F40JAjRhajLT8f3r6mQJfg1u6iyPbJ9j8CsmwMBLngNPbRv/1wKc8fdh+hPkKhT7
 b/kcHKssrDva+nbR1MKtK3dGmbYrhlB4lwl7ldjDQrvYQp22ROzzCC1zVnNmA/ADhscl
 i8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691519830; x=1692124630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVhlCVc3BQ4vOKU1xOzs90AMb73nJF9hGlNFGxrCrak=;
 b=JkC6KB14DvGySTmB8ZE3XKdju6fF65M8XwA612EfthjfNd23UXJartavLRnLJYhMZe
 W/wQy1o6LcppyUdRBIzE32oxTpF4H6meBPsPk38l9quikBoY5KNlk1umKur9q5J/Q+fT
 EssV4fS3C94OM/2fSsu56GX2zyu0hOUlwQep8xWT06916NopsXTvuTnIXLcT7Iaksfud
 S4y9ax3oawOEsHK6R3DthXL5bpk1MFpLI0dxsbpEbk1G+3o7VgmiEgWMIAHsow4x48Ft
 Yc844nYu+AA3zEFHJfw/TagRfyLCHhJFJvoZ0BXSBk0LlSQedJK2fM9GbbU8SWWik4Yx
 HMqQ==
X-Gm-Message-State: AOJu0YxQ160XHwXIDkYhPOlTAyrFqsEFbO3OoxJaVCHMUaCjelLDHNI9
 1iMXBI5joXo2MpTWN4SiZsQukNenQdeYd5zdb/Y=
X-Google-Smtp-Source: AGHT+IHE5/88ViS+zmr8WMKKHj8EtFviktuxkjHLfU8qsSdwiw4VN1x9bziwwdm8rQN15ETlgZuRgw==
X-Received: by 2002:a05:6a00:2385:b0:686:24e1:d12e with SMTP id
 f5-20020a056a00238500b0068624e1d12emr386390pfc.30.1691519830480; 
 Tue, 08 Aug 2023 11:37:10 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 i11-20020aa787cb000000b006828ee9fa69sm8423410pfo.206.2023.08.08.11.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:37:09 -0700 (PDT)
Message-ID: <b36a2c23-ebb1-81f7-ee60-7e688aa85dd3@linaro.org>
Date: Tue, 8 Aug 2023 11:37:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 04/11] target/loongarch: Support LoongArch32 TLB entry
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-5-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-5-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/7/23 18:54, Jiajie Chen wrote:
> The TLB entry of LA32 lacks NR, NX and RPLV and they are hardwired to
> zero in LoongArch32.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  9 +++++----
>   target/loongarch/tlb_helper.c | 17 ++++++++++++-----
>   2 files changed, 17 insertions(+), 9 deletions(-)

Please retain Reviewed-by when given, as I did for v3.  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

