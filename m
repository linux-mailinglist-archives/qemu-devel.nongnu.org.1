Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E02768B01
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 07:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQLHb-0006bG-D3; Mon, 31 Jul 2023 01:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQLHZ-0006ag-3j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 01:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQLHX-0001DK-No
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 01:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690780642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AoEIa1w1zIcR6B8FEKUW0i3H3J9XH95FNC9IRDhPOWY=;
 b=bVRg1Zvge8OvAjnIOwvFc7b6jQTqpIx1EKK5NYBBoVnFX8reOwWb6Em+ApGmGyGsOxF6gp
 jTb3a8SYmZugXgYXLiUTnbg8sizS8mZdkLWsPNrW+Zg3A9ePTTfmAB3cBl4Ois0fubPU90
 VwAyMXGDIe6AbQYnKtGg+9t0ebTMuQc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-GdcGjfq_NomYd4v_Dd8zWQ-1; Mon, 31 Jul 2023 01:17:20 -0400
X-MC-Unique: GdcGjfq_NomYd4v_Dd8zWQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63cf3d966e1so53758686d6.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 22:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690780639; x=1691385439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AoEIa1w1zIcR6B8FEKUW0i3H3J9XH95FNC9IRDhPOWY=;
 b=YES+ymJHM7dv8evdSR595CUF8sMHAMS3WiNTzyi7R0PtPNvcg2rsOsget2InuGCvkJ
 RfkhjFFCik6Exy3EIfDb5rO6uCnZkWbYWxaWrHvxOdAQEeKC1GwN5s9MnPq4M1CmT53D
 wMb4yP6nLthobSZPdYwiFOqDZ4Gmf9VIImCCVaBRo15m+2TOJdA6GWLxpctLqkqhbZYb
 VfZG5WcLM9fwTbLpPIRK5Psld5UiCP9QLJTyu2GQdu92AcVuDDoCLh2KnrfIExPiIKG0
 3fxxV2RFGQCAivVyM6euA+lUWlRHQIT2PX8OvxR/QHe3r7oSQ8KPTPOxW3MSgfUxiQWm
 t6lQ==
X-Gm-Message-State: ABy/qLasWDQsQdLOdv+gg3sFY5o6OCxG5F4H+xgeivpdDDytY1WoDSKs
 4QnZ7GhaSgdlyzz4Xq3jSX+0kcheZeeKLQv8dFt9NfR8TjF+XI7FNqX3MRUkSSnZIeNizcRUZg5
 /Oxi+6QXwDtgQ/LI=
X-Received: by 2002:a0c:f002:0:b0:62d:ef66:ff1c with SMTP id
 z2-20020a0cf002000000b0062def66ff1cmr10288676qvk.24.1690780639697; 
 Sun, 30 Jul 2023 22:17:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHi31sVSzBqz3muq3q71lLItG7Tzwj32WVzA1NU+rODwYdCX8T+XPVY7/u6rS/AhLeVW60riQ==
X-Received: by 2002:a0c:f002:0:b0:62d:ef66:ff1c with SMTP id
 z2-20020a0cf002000000b0062def66ff1cmr10288668qvk.24.1690780639488; 
 Sun, 30 Jul 2023 22:17:19 -0700 (PDT)
Received: from [192.168.8.105] (tmo-080-212.customers.d1-online.com.
 [80.187.80.212]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05620a149500b00767e62bcf0csm2994759qkj.65.2023.07.30.22.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 22:17:19 -0700 (PDT)
Message-ID: <2ec3f8f8-7c6e-f3d1-dbb2-f0700b606603@redhat.com>
Date: Mon, 31 Jul 2023 07:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 6/6] qtest: microbit-test: add tests for nRF51 DETECT
Content-Language: en-US
To: Chris Laplante <chris@laplante.io>, qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20230728160324.1159090-1-chris@laplante.io>
 <20230728160324.1159090-7-chris@laplante.io>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230728160324.1159090-7-chris@laplante.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/07/2023 18.05, Chris Laplante wrote:
> Exercise the DETECT mechanism of the GPIO peripheral.
> 
> Signed-off-by: Chris Laplante <chris@laplante.io>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/microbit-test.c | 42 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
> index 6022a92b6a..8f87810cd5 100644
> --- a/tests/qtest/microbit-test.c
> +++ b/tests/qtest/microbit-test.c
> @@ -393,6 +393,47 @@ static void test_nrf51_gpio(void)
>       qtest_quit(qts);
>   }
>   
> +static void test_nrf51_gpio_detect(void) {
> +    QTestState *qts = qtest_init("-M microbit");
> +    int i;
> +
> +    // Connect input buffer on pins 1-7, configure SENSE for high level

QEMU coding style says that // comments should be avoided. See 
docs/devel/style.rst , section "Comment style". Please use /* ... */ 
comments instead.

  Thanks,
   Thomas


