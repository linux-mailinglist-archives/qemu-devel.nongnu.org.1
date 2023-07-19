Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25239759639
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6sq-0001xr-NC; Wed, 19 Jul 2023 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6sm-0001x8-VK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6sk-0005hr-Cs
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689771976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dv7ndBrgc6EjwEAqQrMnXnmkpmEHdBv1/Ar22AddpjQ=;
 b=h5G+bhzIKSwZHDLga9ZW8XIHUSB/161vDW9mYcWtkh/8aPp/0+H3uRnyI6Us3pQ4kUxHTp
 pqo7DUcB6Oe1vgjfxSEEfLjBLueXWKOtpTy4ySYfepmHNi5NrJ6Vj250SvRtGAeckcViQf
 r/CGpYydKmmkgYkUFMe4zVp/0BnRlO4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-BSlhf0L3PMiPvAtpyFSXjA-1; Wed, 19 Jul 2023 09:06:15 -0400
X-MC-Unique: BSlhf0L3PMiPvAtpyFSXjA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fc08035926so3421605e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689771974; x=1692363974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dv7ndBrgc6EjwEAqQrMnXnmkpmEHdBv1/Ar22AddpjQ=;
 b=bZmrEneifLUSW9tfTvJioXFABV5jFyPDuEe4R9B3T5kqc4EAaV/CO3G74/ql8ogi05
 Y3OrtHaU3YwfML5+S0kcw3gOwRemjgm9juMsFPrB0mXxJjhbvFxAX50xuXG/DjO3An5r
 r8pw2ko59K8vG8wL90kcFo5FvSWQ+RMEcQe8gUOmu51nLZrDsXuNRXjPOilI3VMSSc7f
 vW3CM+Ik5NEDGr9+ty/1cianfIZX68dqRXOjXiyCqXz2liJMbBwNZK7WPqKo3aaWmekI
 ZaRR3ZmmlxsxyR+MJYzMqOKHXJg9WtoeX5cubPM4WpRKIIVmp+Kh9MqXTENM/csm8dCV
 jU4A==
X-Gm-Message-State: ABy/qLZLmuQt8CkOlTSfNhbucZalfTLkOQuidtT/qOIhoWeUfIY4yZTZ
 yC64iRns6Pn8SIESUOYvt/0CZSsLdK2NGCrDrqcovKHOoR2IK3oP/x2cFskyA/y2I6xVZJ0jtdo
 8pbFMJ406KmDHbw4=
X-Received: by 2002:a1c:7413:0:b0:3fb:b18a:f32d with SMTP id
 p19-20020a1c7413000000b003fbb18af32dmr1896151wmc.17.1689771974070; 
 Wed, 19 Jul 2023 06:06:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIl1kqUumqEMWDTWjn9TSL7Kj3yt0P8KadXAKwnVECaSCHZGkdrpf0hoBYDynAtIdo9dgbjw==
X-Received: by 2002:a1c:7413:0:b0:3fb:b18a:f32d with SMTP id
 p19-20020a1c7413000000b003fbb18af32dmr1896141wmc.17.1689771973814; 
 Wed, 19 Jul 2023 06:06:13 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 s18-20020a5d4ed2000000b003143853590csm5328396wrv.104.2023.07.19.06.06.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:06:13 -0700 (PDT)
Message-ID: <67db8111-8e86-0b63-e3a3-8e89a0862a61@redhat.com>
Date: Wed, 19 Jul 2023 15:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/12] qtest: bump npcm7xx_pwn-test timeout to 5 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm <qemu-arm@nongnu.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-5-berrange@redhat.com>
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

On 17/07/2023 20.28, Daniel P. Berrangé wrote:
> The npcm7xx_pwn-test takes 3 & 1/2 minutes in a --enable-debug build.
> Bumping to 5 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ecbf515d50..e28f0925e1 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,7 +1,7 @@
>   slow_qtests = {
>     'bios-tables-test' : 120,
>     'migration-test' : 300,
> -  'npcm7xx_pwm-test': 150,
> +  'npcm7xx_pwm-test': 300,
>     'qom-test' : 900,
>     'test-hmp' : 120,
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>

(we should maybe still have a look at this test later to see why it is so 
slow, though)


