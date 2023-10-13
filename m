Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C907A7C7D93
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:16:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBSp-0002al-D9; Fri, 13 Oct 2023 02:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qrBSj-0002Pl-4r
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qrBSg-0003Ca-GD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697177749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3UrCRGZqL9sg8OBQc4SfklVgJqCd9RjvXeHDnEPNIyg=;
 b=HfNLSZeo1DrUhiNgG5oD2Ft0fHAkVXZtDT/wlc8o0Dir4jraWITp3gYWrlUGofUdw6Ce2d
 x5aB2w9XTjgeBtfB9YNOFuqT0hJsoLJ8/o74UajIxb4ezz4HCLZRWlc4v1So1CYkW/XTxX
 DMYn2SoyFBBkD39t3FTr3crPx6LIAZ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-CXgjAMHFNEygsSDmL56I8w-1; Fri, 13 Oct 2023 02:15:32 -0400
X-MC-Unique: CXgjAMHFNEygsSDmL56I8w-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-538128e18e9so1354988a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 23:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697177731; x=1697782531;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3UrCRGZqL9sg8OBQc4SfklVgJqCd9RjvXeHDnEPNIyg=;
 b=aS1euBSXoz7HTfOZJMj1WTA/1WcShziVXamsJTnsbmKDb8SwcQvtQPC6kUOCiynRJ7
 mQT/uyQ7u9qXwUwc9Kfbm2REBAWmq4GhIE8+9jmV5mIOkrl6mCEavGgWqNQZHUtqGORU
 4M1ylmBkq3PvJ2SH5TSThWOMFexniITpJanTwWNr3UkSDDKfolGr9caiIueirX+9nH9d
 /gX1hG849KMxD/MGkB3UZiTJ3Hm5LyVEcKnAjpBAEu1SxBjCcoWavThrmW81OOyoD9+R
 kNHyEVimk6zye9aPblFiO3x9/WOeeeoNYXkrbP5rtbNDZlICgUdMEOGW6gJf0rr1YGk7
 De0w==
X-Gm-Message-State: AOJu0YygJnhg6iCv33hm7ha9Ema8ZyIqXoq00wybbcq7m9I3AXK5Zcru
 GktvNFyNqrsXfjTxGCZlPayrdC049KTYJEb+gKoXmm4+ZLVjKdp1J4rAHFzj2mh60L5Jda2dPMT
 FT+hGqAoMsUV3BA4=
X-Received: by 2002:a17:906:2210:b0:9b2:8323:d916 with SMTP id
 s16-20020a170906221000b009b28323d916mr25451902ejs.17.1697177731307; 
 Thu, 12 Oct 2023 23:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/L9YuAEhU0JTs+FJutYkU2MVqAnFJxjbTLDnxVjaZL8lAu57P/NZgDpF+T31lMyMjQwEt2g==
X-Received: by 2002:a17:906:2210:b0:9b2:8323:d916 with SMTP id
 s16-20020a170906221000b009b28323d916mr25451884ejs.17.1697177730925; 
 Thu, 12 Oct 2023 23:15:30 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 gt26-20020a170906f21a00b0099bcf9c2ec6sm11926505ejb.75.2023.10.12.23.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 23:15:30 -0700 (PDT)
Message-ID: <9f9f8a1b-f656-4cda-a1d5-b15cfb91a3fc@redhat.com>
Date: Fri, 13 Oct 2023 08:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] tests/npcm7xx_adc: Clean up global variable
 shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Tyrone Ting <kfting@nuvoton.com>, Markus Armbruster <armbru@redhat.com>
References: <20231009100251.56019-1-philmd@linaro.org>
 <20231009100251.56019-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231009100251.56019-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/10/2023 12.02, Philippe Mathieu-Daudé wrote:
> Rename the global 'adc' variable in order to avoid:
> 
>    tests/qtest/npcm7xx_adc-test.c:98:58: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static uint32_t adc_read_con(QTestState *qts, const ADC *adc)
>                                                             ^
>    tests/qtest/npcm7xx_adc-test.c:103:55: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void adc_write_con(QTestState *qts, const ADC *adc, uint32_t value)
>                                                          ^
>    tests/qtest/npcm7xx_adc-test.c:108:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static uint32_t adc_read_data(QTestState *qts, const ADC *adc)
>                                                              ^
>    tests/qtest/npcm7xx_adc-test.c:119:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void adc_qom_set(QTestState *qts, const ADC *adc,
>                                                        ^
>    tests/qtest/npcm7xx_adc-test.c:135:57: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void adc_write_input(QTestState *qts, const ADC *adc,
>                                                            ^
>    tests/qtest/npcm7xx_adc-test.c:144:56: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void adc_write_vref(QTestState *qts, const ADC *adc, uint32_t value)
>                                                           ^
>    tests/qtest/npcm7xx_adc-test.c:162:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static uint32_t adc_prescaler(QTestState *qts, const ADC *adc)
>                                                              ^
>    tests/qtest/npcm7xx_adc-test.c:175:64: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    static void adc_wait_conv_finished(QTestState *qts, const ADC *adc,
>                                                                   ^
>    tests/qtest/npcm7xx_adc-test.c:196:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:207:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:235:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:267:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:293:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:311:16: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>      const ADC *adc = adc_p;
>                 ^
>    tests/qtest/npcm7xx_adc-test.c:93:5: note: previous declaration is here
>    ADC adc = {
>        ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/npcm7xx_adc-test.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


