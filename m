Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99B7B2C4C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6ze-0008M3-0A; Fri, 29 Sep 2023 02:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qm6zc-0008Lf-Bb
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qm6zZ-00053t-Di
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695968928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTJXax7k6eaEa5iXZfDdTO02C9VEmGNAsuCxv14PyRA=;
 b=QxvBBpGw/bokI38SophQRD++7jh4W0GLAqfWXT+6r2VMFQxZNwEyn2j98bcbxPIH/LM8M7
 1biVOSGurBwf20KCn0Fck8RImuP9fmkszL07EMR2KJDJhrfPC3rmirnEf+cCwkGpqSyHk6
 87Vcjcx4SDr17pUty5zkH5m4uJCoOTA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-tTb0rkArPGyNnX3JjTIIqg-1; Fri, 29 Sep 2023 02:28:46 -0400
X-MC-Unique: tTb0rkArPGyNnX3JjTIIqg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65d3df97d7fso15448026d6.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 23:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695968926; x=1696573726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wTJXax7k6eaEa5iXZfDdTO02C9VEmGNAsuCxv14PyRA=;
 b=FO7S86JWh2H69pSBpK9cnPPEBF+YOtgC6cYMeIPJ8mKHyctCtp8AYHrFZm0yoyE60R
 7Mjx0A3H6JEW1DymQd8kkBDItbPtn2sgNU+4Y1popm1MyYPrQ6UWW2gWnYDZjB2i4/tl
 Tp9+4kRe9tAltXJKaOnqyIPRMDc/4ExIWItRoPorxEfFUA82fLpu+/xPpWtIChFYc6yx
 sd6k3idIxPNKWBjpFqC0nFu4CBgymRpdAxiAqPAD1qwppsoQ8rbzW8KPGUNWvtcSuhTt
 eEGlq9dNGZoy7544k2HT+1LWF2ALR+4smkkohax10Dx989jNJ8sj70Rs1FHnFGtnApVN
 NkPw==
X-Gm-Message-State: AOJu0Yx3cpgMrcfmlDlebUslcxgahoE2/rrxUOWaI5gfwHUYg28fk9C9
 UnWklzyKRhs1nFlLlBiIunDZ5mz3S5iWNFbt6aVWEMnMExzNEpCCTliwv10p58L0k1rrN473cPP
 U4lYdMAMiVynAX8A=
X-Received: by 2002:a0c:8bc9:0:b0:658:8978:44db with SMTP id
 a9-20020a0c8bc9000000b00658897844dbmr3212416qvc.1.1695968925943; 
 Thu, 28 Sep 2023 23:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcOsiB1+eMJwDEjo2jdnqXtOXKJDSNU9Yk7W+J51XnkXLJxl+tyhKIsyqZf5qrl3S6NriTww==
X-Received: by 2002:a0c:8bc9:0:b0:658:8978:44db with SMTP id
 a9-20020a0c8bc9000000b00658897844dbmr3212407qvc.1.1695968925560; 
 Thu, 28 Sep 2023 23:28:45 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 c1-20020a0ca9c1000000b006582f94af3asm7253200qvb.44.2023.09.28.23.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 23:28:44 -0700 (PDT)
Message-ID: <5311a1e5-2334-928c-b14c-6dc685d4d2ae@redhat.com>
Date: Fri, 29 Sep 2023 08:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] tests/qtest: Fix npcm7xx_timer-test.c flaky test
To: Chris Rauer <crauer@google.com>, kfting@nuvoton.com, wuhaotsh@google.com, 
 lvivier@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230929000831.691559-1-crauer@google.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230929000831.691559-1-crauer@google.com>
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

On 29/09/2023 02.08, Chris Rauer wrote:
> npcm7xx_timer-test occasionally fails due to the state of the timers
> from the previous test iteration.  Advancing the clock step after the
> reset resolves this issue.
> 
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

Thanks! I'll queue it for my next pull request.

Acked-by: Thomas Huth <thuth@redhat.com>


