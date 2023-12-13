Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3446811B51
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:37:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTAF-0006Mm-9r; Wed, 13 Dec 2023 12:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTA6-0006Ko-15
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:36:46 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTA2-0002eN-Mm
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:36:44 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50bf37fd2bbso9734510e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702489000; x=1703093800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4g16VwCRPEc/rQ30ZzM+BsmtfqcmUNpk5zMKKRLq1VM=;
 b=PSwBzRCv+p2MTDCB2iQ+Oor0kKClCWQAQ/t3n6JQ0T3Jia6LeGrmjZNm4NSLhtOBRx
 o6s3davejQcDQKbW/ceuyTr2Y2icgJV5w9kPdPYBUMMH7Hu6pF6ei1UGypiAS7X42mrH
 62VhXYvb4vbmw4pQ52adQ7DtQq9XZUCM0hb/2HdzwLLs9K1FzElJXkamCInCmuuD4vdz
 1T9LRSeDJKJZQZM7o7PGH2668FYxx1trgDVKKiLngJL00BTrL31i1z8mFY8ug44UE3FS
 +mbqn3kTfRwks9IRUPrDqaK/1p+zg8bGwQyWXUwtODY49FGYTxbenbluDvXvJYeKn78t
 pW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702489000; x=1703093800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4g16VwCRPEc/rQ30ZzM+BsmtfqcmUNpk5zMKKRLq1VM=;
 b=PjAhQ1nvSyz10t++s51UwjccQSY9qBp5zCpnkgvPtYyCkHWEppTA7M9k+1vYb98x9F
 kL0vHzkU4E9HAKq+35IF8iVs+lEzDpBLddoGhKDyAWu4QN6knXMXwLXdCaXdU7wBzz+J
 XHdu7JNHSNjIN1ZqpoISpT3VkvvFb29fHrx8eO1XxwmUR4Q4xqEekh7LepsZm9DhZCU5
 /TWKTfZ6fVd6Rr+pH0FZQ5XoDCafqUkv/kcgBP2IAxrbH2vhwNdN5eLgORH9GBQ4xZWP
 zRsZnFUvC+pvwDbWewPquNSMf4WmmHNatoo7ElLIy2QydUoVA5MVlPnCtnSbH3ATH1jV
 5/oQ==
X-Gm-Message-State: AOJu0Ywk54LbxhpRoN+c908cRqVqsiMXHcILPSHZxtkJ8WoCFdPsqHkP
 CC8bwRJZIm/dzQKjP0mCEka0zpL/h4jnvLo90S8nNw==
X-Google-Smtp-Source: AGHT+IEh1/YeSDPci77Roxk5QI/5aEGVH0DSuNlo5oe0V4Z7mcfJS8PeIlR9qJeWcBqRiEsAIsNphw==
X-Received: by 2002:a05:6512:4012:b0:50c:327:9932 with SMTP id
 br18-20020a056512401200b0050c03279932mr4917376lfb.107.1702489000380; 
 Wed, 13 Dec 2023 09:36:40 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 vx12-20020a170907a78c00b00a1ddb5a2f7esm8203849ejc.60.2023.12.13.09.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:36:39 -0800 (PST)
Message-ID: <37746458-0986-4e60-882d-78274413791c@linaro.org>
Date: Wed, 13 Dec 2023 18:36:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231124182615.94943-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124182615.94943-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

ping?

On 24/11/23 19:26, Philippe Mathieu-Daudé wrote:
> Since commit f7b4f61f63 ("qdev/isa: convert soundblaster") these
> fields has been converted to qdev properties, so don't need to be
> migrated:
> 
>    static Property sb16_properties[] = {
>        DEFINE_AUDIO_PROPERTIES(SB16State, card),
>        DEFINE_PROP_UINT32 ("version", SB16State, ver,  0x0405), /* 4.5 */
>        DEFINE_PROP_UINT32 ("iobase",  SB16State, port, 0x220),
>        DEFINE_PROP_UINT32 ("irq",     SB16State, irq,  5),
>        DEFINE_PROP_UINT32 ("dma",     SB16State, dma,  1),
>        DEFINE_PROP_UINT32 ("dma16",   SB16State, hdma, 5),
>        DEFINE_PROP_END_OF_LIST (),
>    };
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/sb16.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 18f6d252db..be614d7bc3 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -1325,11 +1325,11 @@ static const VMStateDescription vmstate_sb16 = {
>       .minimum_version_id = 1,
>       .post_load = sb16_post_load,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32 (irq, SB16State),
> -        VMSTATE_UINT32 (dma, SB16State),
> -        VMSTATE_UINT32 (hdma, SB16State),
> -        VMSTATE_UINT32 (port, SB16State),
> -        VMSTATE_UINT32 (ver, SB16State),
> +        VMSTATE_UNUSED(  4 /* irq */
> +                       + 4 /* dma */
> +                       + 4 /* hdma */
> +                       + 4 /* port */
> +                       + 4 /* ver */),
>           VMSTATE_INT32 (in_index, SB16State),
>           VMSTATE_INT32 (out_data_len, SB16State),
>           VMSTATE_INT32 (fmt_stereo, SB16State),


