Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2007AB8FF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:19:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkjv-0001s0-49; Fri, 22 Sep 2023 14:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkjs-0001rm-LO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:18:53 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkjr-0000Bd-4F
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:18:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-403012f27e3so27487935e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695406729; x=1696011529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZWLMDab9q3zmBzIv5sbkPtk3nhjOQvcYwmXlb2FAok=;
 b=PPetdWbMf+QtRtAC+lI27i6V7HLWVUh08ubC85n/t/xv0zE6ruDBeXcNzs3P08yNq1
 OyfhvWPChPpFnbWdNjHrPDonbEMO39i2doi3d6nClOmvnt717ksQhYS0EGc/lWyC1xME
 Oxol11rGPiw1Y6f11iY29XafKmwND0moZke2qdDfCBR//PJhwtmHjXksaxgbSTPwe+ES
 lg93hdpIzM45QRe+n8Ns8KrAyuMk49ySozu8jKBkXOxFmI8ibwZm1GYSvqTz11LrtARg
 Vq/p3sxa5s8LPU41pZRbflzQ5OjXZIKj47rtIkkPdJfOcuwtPlEkPTOLAJejnrFfLkDt
 bctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406729; x=1696011529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZWLMDab9q3zmBzIv5sbkPtk3nhjOQvcYwmXlb2FAok=;
 b=BL8K/DqXYmz9ndHWBpRm01rOkllAkfLkrUNfNhDy5qgkPLWOXoWZ8BkdXgfW6dK2kG
 xF3ZIj8rhWwd3Zb8vNApts6+6UT+Yoh3V+mnkS7I7fEvhDRdVZy4yazjjKpdnctkmpnq
 wACUjJC1sdctw7JLcSqlWifM8CiMmdp8lj7a8/QkR+rRj5O4ZqJ4m8sT85O83RV5vG+e
 MrNPhyi2rDOSrL7VesxSbsDk943OMtvn49+Em1Mov5WSwKgksJoCmBA5FRUa1W4WqK42
 kZs3tESg7PdvPeruZef8llUTdx4OOrxYJ0ianuvyN4+9/tmQczKtqA1Myt2O/ZegPnci
 +sHw==
X-Gm-Message-State: AOJu0YxEWpWVsM3FhLqs+LMbumsl5ZFNCcYHY2Vr7O5Tj2mFt5REDKNw
 jlo+RDO+yjsjucd5VXuYUBhyEA==
X-Google-Smtp-Source: AGHT+IHZtM8eitbl00NjouxZJ8UOXkT5dAs25oZTzI9qliNkm6r3fd3WeIX05K0T6CTZEF1wHKM6cw==
X-Received: by 2002:a7b:c456:0:b0:402:e68f:8898 with SMTP id
 l22-20020a7bc456000000b00402e68f8898mr162842wmi.0.1695406729370; 
 Fri, 22 Sep 2023 11:18:49 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 t1-20020a1c7701000000b003fe23b10fdfsm8149196wmi.36.2023.09.22.11.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:18:48 -0700 (PDT)
Message-ID: <f599d892-e790-ac2a-939a-95f7ec3b8e9d@linaro.org>
Date: Fri, 22 Sep 2023 20:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] tests/qtest/m48t59-test: Silence compiler warning with
 -Wshadow
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
References: <20230922163742.149444-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922163742.149444-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 22/9/23 18:37, Thomas Huth wrote:
> When compiling this file with -Wshadow=local , we get:
> 
> ../tests/qtest/m48t59-test.c: In function ‘bcd_check_time’:
> ../tests/qtest/m48t59-test.c:195:17: warning: declaration of ‘s’
>   shadows a previous local [-Wshadow=local]
>    195 |         long t, s;
>        |                 ^
> ../tests/qtest/m48t59-test.c:158:17: note: shadowed declaration is here
>    158 |     QTestState *s = m48t59_qtest_start();
>        |                 ^
> 
> Rename the QTestState variable to "qts" which is the common
> naming for such a variable in other tests.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/m48t59-test.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


