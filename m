Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2868A7E96D2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 08:01:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Qv3-0002ib-A8; Mon, 13 Nov 2023 01:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Quv-0002iJ-NP
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2Quu-0004Zi-2T
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 01:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699858766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UhPyJkIQck6UmTS7uABnBxJOFOH04qKEHW/7T45CqUc=;
 b=BQsYN8fY4yLwloLVh3R7Tyj+RSAt7kYcEkTVVz7tDksqy8gDnK5TPgUBYKUzoEDWHwYmml
 k1BqN254lZGWRoDXmHADG5cKtKRBDV/T8Sqe91HL77ZAyhM9XAfm143xjco4F6Lvm+WZly
 FJTbi7b/LM3ydqUUXmos11qlzHc091s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-hBrweJ8OMG6ttsUm0zNhHA-1; Mon, 13 Nov 2023 01:59:25 -0500
X-MC-Unique: hBrweJ8OMG6ttsUm0zNhHA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-66d0b251a6aso52025466d6.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 22:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699858764; x=1700463564;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhPyJkIQck6UmTS7uABnBxJOFOH04qKEHW/7T45CqUc=;
 b=DCAsxE4MH5yMrKxqaejrF6/z88RRhAxjX3O4hyDi0xqmkop+T+A1jy0V3qBUWZLnQq
 QfpIypi8xiSvbebBAD62aV/YnhYdTdn0POwNyJzDt3pI8R28zmpV86U2W8UADAzxzp4U
 xbiBrp/mWv1bwyUyEnhRW7uADoDedHJ+DHwSUJuIZ+N9M9OkVutVi1VEfAmDNmLNtyCL
 bSLwIA12IKVWe84VW4tw1Yp0aC8olc5VzxK+gBJ5IGc3c+oZBngfvg854NytZgrH9eup
 I5E3aTOjhVS2HIUR+9Hc2pSS5+zJ5t27nLQleNOMWuPFwn9+jn9HmP/jN7/edT9MDDFE
 MX8A==
X-Gm-Message-State: AOJu0YyjW6OR5Go4ZpQ2syE5Akeyjs+X736qLnnxFacs+Zf/q2uH+vOa
 1xuu/Xuy+/Rud1pD6mYuzIf7ss71Vlg9fV2SupsrAu0fsQDvAz+LOhlMEhjKaiBOb8mGhGrG0ux
 zL1m3kLZkVtAQlVM=
X-Received: by 2002:a0c:ea4b:0:b0:656:3612:7954 with SMTP id
 u11-20020a0cea4b000000b0065636127954mr7231474qvp.1.1699858764694; 
 Sun, 12 Nov 2023 22:59:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHP62dgAEQP6F8DJ5RfMT34jpj8Egba4fjqNuLEQI9YlQXqyx1cUpCzC6gMeCeYCCFMsp/K/A==
X-Received: by 2002:a0c:ea4b:0:b0:656:3612:7954 with SMTP id
 u11-20020a0cea4b000000b0065636127954mr7231469qvp.1.1699858764494; 
 Sun, 12 Nov 2023 22:59:24 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 k5-20020a05621414e500b0066d23395d27sm1851894qvw.123.2023.11.12.22.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 22:59:24 -0800 (PST)
Message-ID: <ddb3f1c5-28d1-472d-b491-703a3e1c6711@redhat.com>
Date: Mon, 13 Nov 2023 07:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/qtest: Add an API function to capture IRQ toggling
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, philmd@linaro.org
References: <20231112013801.293970-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231112013801.293970-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/11/2023 02.38, Gustavo Romero wrote:
> Currently the QTest API does not provide a function to allow capturing
> when an IRQ line is toggled (raised then lowered). Functions like
> qtest_get_irq() read the current state of the intercepted IRQ lines,
> which is already low when the function is called, since the line is
> toggled.
> 
> This commit introduces a new function, qtest_get_irq_trigger_counter(),
> which returns the number of times a given intercepted IRQ line was
> triggered (raised), hence allowing to capture when an IRQ line was
> toggled.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/qtest/libqtest.c | 12 ++++++++++++
>   tests/qtest/libqtest.h |  9 +++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index f33a210861..21891b52f1 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -82,6 +82,7 @@ struct QTestState
>       int expected_status;
>       bool big_endian;
>       bool irq_level[MAX_IRQ];
> +    uint64_t irq_trigger_counter[MAX_IRQ];
>       GString *rx;
>       QTestTransportOps ops;
>       GList *pending_events;
> @@ -498,6 +499,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
>       s->rx = g_string_new("");
>       for (i = 0; i < MAX_IRQ; i++) {
>           s->irq_level[i] = false;
> +        s->irq_trigger_counter[i] = 0;
>       }
>   
>       /*
> @@ -690,6 +692,7 @@ redo:
>   
>           if (strcmp(words[1], "raise") == 0) {
>               s->irq_level[irq] = true;
> +            s->irq_trigger_counter[irq]++;

Not sure whether you can get some "raise" events in a row without some 
"lower" events in between ... but just in case, I wonder whether it would 
make sense to check whether it is really a rising edge, i.e.:

            if (strcmp(words[1], "raise") == 0) {
                if (!s->irq_level[irq]) {
                    s->irq_trigger_counter[irq]++;
                }
                s->irq_level[irq] = true;

What do you think?

>           } else {
>               s->irq_level[irq] = false;
>           }

Anyway:
Acked-by: Thomas Huth <thuth@redhat.com>


