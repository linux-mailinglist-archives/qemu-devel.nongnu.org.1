Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B97B11AE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 06:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlitj-0000My-Ne; Thu, 28 Sep 2023 00:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlitZ-0000MS-Uc
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlitV-0005xU-An
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695876296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thDvK5Hgj2T2cNkzShCy/Wh0ECz471UVKJZt73urqsQ=;
 b=Mvv57YNBTei1Edy8KSOla9zE3BfBq3ha5HTpBaq58xkrKx2SFMmJgaratipySh8gxd1dnN
 e0DuxOGjdJybym1W6qd8ONlJ2k5NGgTajbQBnYmzW7nRo2HoTeiP2DyHbPeQ9ycqc93qJx
 IyUEHJDYVY6Vds3M5DJ6cMrbcqP3MeQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WeWFEwHBNFSQGpYKr-2c6A-1; Thu, 28 Sep 2023 00:44:55 -0400
X-MC-Unique: WeWFEwHBNFSQGpYKr-2c6A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5042d5a3f13so18965010e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 21:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695876293; x=1696481093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thDvK5Hgj2T2cNkzShCy/Wh0ECz471UVKJZt73urqsQ=;
 b=TVe4pH2fsdISt38b5ov2wG7xk3TiHq4chzGGaDE5C2H07YXVFEoeC3lR4uBnNUYgh8
 UmQwtkdz6YK6FFNmk+J9gsRzLHJP8eaqXATVHcUjMk8OegcbrYbay2HV1iVMKr4f0tFA
 AGuts/v4FUrQU0YMh1X9IROGU3x6gnTG/Bg//WmacIN6cHHBGUSIYpw5CHOCtbIx8Byn
 Xo7cP5eGKUEJHCtgaDo6/rfXVEppDm9YBWH8I3tTiYO/Yh4frPh2727zct5qbTK7yQLN
 vr/FNHsYS48i2FyP3B58neGnbSbecnIKotj0XreZSXD0s5MyO2Ng1Zp+YOgn7/c3VkiM
 eRiw==
X-Gm-Message-State: AOJu0YwjAZVAMS38ridOvfHpBkuA+FORsA0VeUvsoGd11j8oMIl3HOxa
 jCOdMHnByc5jDyUpSWvF0aLPqFTmKZB4BNkc3zwUVXgWYNxeN/4CLPOK76YZO0u6j1+VvmmEM3p
 WKVo69iuKS5NJu7s=
X-Received: by 2002:a05:6512:2521:b0:4f8:6abe:5249 with SMTP id
 be33-20020a056512252100b004f86abe5249mr117474lfb.3.1695876293589; 
 Wed, 27 Sep 2023 21:44:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEekid82hzCN/dUcN+SioCdjwqKCCs/5S3+R/Hc9p6IHFAGjPRZBRUtr46Geg+AyufyGJsXww==
X-Received: by 2002:a05:6512:2521:b0:4f8:6abe:5249 with SMTP id
 be33-20020a056512252100b004f86abe5249mr117463lfb.3.1695876293240; 
 Wed, 27 Sep 2023 21:44:53 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 e9-20020a50ec89000000b0052c9f1d3cfasm9041946edr.84.2023.09.27.21.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 21:44:52 -0700 (PDT)
Message-ID: <e5ddb46e-e677-3fc8-4f32-0f59e85eb304@redhat.com>
Date: Thu, 28 Sep 2023 06:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/qtest: Fix npcm7xx_timer-test.c flaky test
Content-Language: en-US
To: Chris Rauer <crauer@google.com>, kfting@nuvoton.com, wuhaotsh@google.com, 
 lvivier@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230928034505.255480-1-crauer@google.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230928034505.255480-1-crauer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/09/2023 05.45, Chris Rauer wrote:

Could you please add a proper patch description how this is fixing the issue?

  Thanks,
   Thomas


> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1897
> Signed-off-by: Chris Rauer <crauer@google.com>
> ---
>   tests/qtest/npcm7xx_timer-test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
> index 43711049ca..58f58c2f71 100644
> --- a/tests/qtest/npcm7xx_timer-test.c
> +++ b/tests/qtest/npcm7xx_timer-test.c
> @@ -465,6 +465,7 @@ static void test_periodic_interrupt(gconstpointer test_data)
>       int i;
>   
>       tim_reset(td);
> +    clock_step_next();
>   
>       tim_write_ticr(td, count);
>       tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));


