Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23275963A
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6uD-0002xH-4N; Wed, 19 Jul 2023 09:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6u9-0002wn-NH
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6u5-0007Tk-MC
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689772057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWExAQHAS4+a5eAA2Q0v2pdHeTky6omShENju14r8+A=;
 b=eoTCepKu5LaoSBif3FhfYrx3hsXTYckJFKwvl6yqv7tzKH3UGeshCQRlMwFue9LI+23E1n
 F/lKpBGsI0gKqQSDHd7v8ngiSCymL6+dph6jQu7MJ65l1Rq/3b8bPKYO/jgSULOlRD8/ib
 en0jutmlIZICeD3LqpcguYIagDTYcq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-0w4_XBaEOIOYKscHo4oOZQ-1; Wed, 19 Jul 2023 09:07:35 -0400
X-MC-Unique: 0w4_XBaEOIOYKscHo4oOZQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314394a798dso360010f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689772054; x=1692364054;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWExAQHAS4+a5eAA2Q0v2pdHeTky6omShENju14r8+A=;
 b=GA8/gL3i6P7dcSO9fnpDflyHPj9Zm9LbuYcQbYtchsFAUqWHx6XbBFJFXp9KoGliCS
 Fa2hbLneZccau8PlkEpCQ2ym3PYm//JVuOozckw3MDhnnYroIhtm0Vnp5noQi4wpxu8p
 riw+8WmtOus/mxBQrFbHDXgSk/bRh6lxxRTPc/QObk0XqA53oUMTduU6WlXVe80bAJI1
 CqucB/6gWyOASvikS03XWoInDtHNK1UB3oNNSFE/u5jYrHIZwHAzxnetCZ7/6tBicd/d
 aD/6yOIU0MqkWqRBdIhEX4nETG9Fo79lAVLi06tgAo3XwdU1BsSENCsP8yjw4B3smI0v
 gdEw==
X-Gm-Message-State: ABy/qLYO/9PQSmaAGCf3hAnXvSZf67nHoKlomROu4xgxLeU7RP0/YKKe
 ST2odYDKMfZRMSNHH15XjHC68BUzDh26V1Cm6cBSu4kgHFNQmyv9GLYJheNQdesRPD6VmxYdmBW
 tV2qthD6zK2e5L7s=
X-Received: by 2002:a5d:4083:0:b0:314:323b:9d3b with SMTP id
 o3-20020a5d4083000000b00314323b9d3bmr1915139wrp.32.1689772054706; 
 Wed, 19 Jul 2023 06:07:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHH9cEIaC3EO0+8Pw+SSlSdGK7hgMvRAw+/kabwbAsG7vBUkee3muUTz7jEV2V46GRf+XtGmg==
X-Received: by 2002:a5d:4083:0:b0:314:323b:9d3b with SMTP id
 o3-20020a5d4083000000b00314323b9d3bmr1915126wrp.32.1689772054455; 
 Wed, 19 Jul 2023 06:07:34 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 q7-20020adfea07000000b003140fff4f75sm5314379wrm.17.2023.07.19.06.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:07:33 -0700 (PDT)
Message-ID: <5f9d87f3-a798-a2a5-6edc-714928e430d4@redhat.com>
Date: Wed, 19 Jul 2023 15:07:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/12] qtest: bump test-hmp timeout to 4 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-6-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 17/07/2023 20.28, Daniel P. Berrangé wrote:
> The npcm7xx_pwn-test takes just under 3 minutes in a --enable-debug

s/npcm7xx_pwn-test/test-hmp/

With that copy-n-paste error fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> build. Bumping to 4 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index e28f0925e1..1070c6dc64 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -3,7 +3,7 @@ slow_qtests = {
>     'migration-test' : 300,
>     'npcm7xx_pwm-test': 300,
>     'qom-test' : 900,
> -  'test-hmp' : 120,
> +  'test-hmp' : 240,
>   }
>   
>   qtests_generic = [


