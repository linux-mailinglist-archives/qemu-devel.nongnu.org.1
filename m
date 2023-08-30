Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4893778D528
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIeJ-0004jY-Qd; Wed, 30 Aug 2023 06:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbIeH-0004fr-Ac
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbIeF-0005P3-96
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693392126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=My0TBAxPur5NsJmw3r+uWE7vBfNZdRJ5mQ+ti+7wjAg=;
 b=Jcm3jDavLobHWlM3Jws49SSS/X+0o+4jNf5EY3niEq2UNxUiurCpCt+xf4jk0Ff8wM62Wj
 kz4i81swAIu48NruVSNW3Kqeih/1ueZ30iLMcYIhYrV8XgveRTcJBKIwDP+phVmh/WJhCk
 FziKC6s8woAHOL7+ny/iOph/FDgwEO0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-37pRpcDeMwmy5Tj-H8d0cQ-1; Wed, 30 Aug 2023 06:42:05 -0400
X-MC-Unique: 37pRpcDeMwmy5Tj-H8d0cQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso37927435e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693392124; x=1693996924;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=My0TBAxPur5NsJmw3r+uWE7vBfNZdRJ5mQ+ti+7wjAg=;
 b=FPO9b5nrLSclDj1UvRo4A0yD17gOoRZ5qkZ6OC9J3WDy+EGM19ImrBaWafc7scvLEw
 U+6iTxN8ikCwI/vNYRM/i1Bnt2T1eKPXkC73kTFtbgYZrhG0w7YwmckXjNHNB0Udb/D0
 BYP5Cwj+Q/HY2eEJas3aC6BkgCClUpdjG9OG7+a8ole4asylmof7vhvVd9PlXDbmgS6e
 B6hZRXt7k5uRVAR36fuVgoNumWMl9yAbCnJq7NyM06yYZjR5w1v4ZfAvGIpOclxJ++oO
 r19Ipaz+mY1TdZxm0ZWv5De4JT8rXy3sDAs4DLg20oZ5UPL4o8NloMgZONwOKa+RYYxX
 2hUw==
X-Gm-Message-State: AOJu0YxS+FEN1eoORgOOmEwd+WLCkFMTKiudI7zS9nb740Q0YcvX14TW
 qZIH8L0J6FaLYfoAARMXkYFb87klcWZmKXojM/qDY47YRLxsBkar5rVONLEEIV8la56JYF7gmC0
 DG61WG3iE2igI1cg=
X-Received: by 2002:a1c:7718:0:b0:3fe:d7c8:e0d with SMTP id
 t24-20020a1c7718000000b003fed7c80e0dmr1703389wmi.34.1693392124213; 
 Wed, 30 Aug 2023 03:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnYysdBYiyNicoLVWwtlT0wmvtVYv2H9srpRFV2pabF0hJg4fvLrF3c4THz+KueXp5R/Jbcg==
X-Received: by 2002:a1c:7718:0:b0:3fe:d7c8:e0d with SMTP id
 t24-20020a1c7718000000b003fed7c80e0dmr1703379wmi.34.1693392123907; 
 Wed, 30 Aug 2023 03:42:03 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-145.web.vodafone.de.
 [109.43.179.145]) by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c215300b003fef3180e7asm1856919wml.44.2023.08.30.03.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 03:42:03 -0700 (PDT)
Message-ID: <9467859d-cdc1-307f-bb48-43a390499518@redhat.com>
Date: Wed, 30 Aug 2023 12:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] meson: test for CONFIG_TCG in config_all
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230830095347.132485-1-pbonzini@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230830095347.132485-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 30/08/2023 11.53, Paolo Bonzini wrote:
> CONFIG_TCG is not included in *-config-devices.h, so the test is
> always failing.
> 
> Fixes: 74884cb1a6d ("qtest/meson.build: check CONFIG_TCG for boot-serial-test in qtests_ppc", 2022-03-14)
> Fixes: 44d827ea69e ("qtest/meson.build: check CONFIG_TCG for prom-env-test in qtests_ppc", 2022-03-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index df63909ee51..c0751ef7c35 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -155,8 +155,8 @@ qtests_ppc = \
>     qtests_filter + \
>     (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
>     (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
> -  (config_all_devices.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                      \
> -  (config_all_devices.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                   \
> +  (config_all.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
> +  (config_all.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
>     ['boot-order-test']

D'oh!

Reviewed-by: Thomas Huth <thuth@redhat.com>


