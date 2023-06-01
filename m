Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BFF71F234
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nCG-0003an-Ui; Thu, 01 Jun 2023 14:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nCD-0003aL-Rt
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nCB-0004AX-SE
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685644726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rr+2B5MJSKEvWi3aaQoIDE5EZsXPwAZHA+Gzm/wj84A=;
 b=Sw1kVu9/4MCbOeMbp1ni0TL+lGTQ8s8qakCMHFIcrcg1G9CGAK+8Pntzgm77GKKJ6osdzu
 IHulbNvWFyYvnwyp3UUbByVVaBcLRq1pNuvfnqP/1Ll2z+ZQlroR5+F55fu2yhRr9ZaMNE
 t8nwYLo89TDxsRZJ85a9NikRZRb2/fs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-kVgbpk64M36wT_zChk-aLw-1; Thu, 01 Jun 2023 14:38:45 -0400
X-MC-Unique: kVgbpk64M36wT_zChk-aLw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af1ed9514bso10572981fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 11:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685644723; x=1688236723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rr+2B5MJSKEvWi3aaQoIDE5EZsXPwAZHA+Gzm/wj84A=;
 b=hizO/sP2srLzNELodvDhuzH3+VKn8DO/aj1BHoINqdidlbu/Yv4f9SjGEM+Fwy+9qt
 2MnFKgiSQ79nYMqhiyxeA5WhlEvTlJrQhPKrtDnlZfTF0JpyxTUngEm69CIIdQl4T++2
 zxlw3kpr6GQNf1NK5c/Mt6Ga/W+aJsfmScoRb1XcSZYI2KKn/2qD9t/shRHL9BF7g6Uw
 /1HGZew6a2txLFCmEcd+bIdqpCiIM0Y5pKIHrCYJjDX+0xYMT26uF+kNPq4lrCJelMp/
 18/tIBgQ3FuKeICV9FsfcXVtwIcBqT8bam0OPonpbPUwElrpkfqC+gavlR6m/sznGowy
 I37Q==
X-Gm-Message-State: AC+VfDyqtW8xRiJqvcWQf6hTu549+7SXrBJVrgiDaCtQcHNkFMBwIGbr
 I5ar0ht6UxGg1mUtD6FxUN9UVqQ+lzs2l/+ZS4ksi3Nn4dH2Xh0MI9zXihGKw+v0s+VR2vVk1Ek
 cdPaICMwnLhq8dNk=
X-Received: by 2002:a2e:9d03:0:b0:2af:b4b:8583 with SMTP id
 t3-20020a2e9d03000000b002af0b4b8583mr182560lji.15.1685644723610; 
 Thu, 01 Jun 2023 11:38:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GoLwK3XxPPFh3vUJEEDPhJM7g2ZC516T9/iByghaHiIGV54L6hBB7tmBQ0FbDPDdaTQJs9A==
X-Received: by 2002:a2e:9d03:0:b0:2af:b4b:8583 with SMTP id
 t3-20020a2e9d03000000b002af0b4b8583mr182546lji.15.1685644723231; 
 Thu, 01 Jun 2023 11:38:43 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 j6-20020aa7c0c6000000b00514b2a9ce60sm3609016edp.81.2023.06.01.11.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 11:38:42 -0700 (PDT)
Message-ID: <d27a47d6-9ec0-fc70-b7fd-761521d7fa86@redhat.com>
Date: Thu, 1 Jun 2023 20:38:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] qtest: bump min meson timeout to 60 seconds
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01/06/2023 18.31, Daniel P. Berrangé wrote:
> Even some of the relatively fast qtests can sometimes hit the 30 second
> timeout in GitLab CI under high parallelism/load conditions. Bump the
> min to 60 seconds to give a higher margin for reliability.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 087f2dc9d7..18d046b53c 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,12 +1,7 @@
>   slow_qtests = {
> -  'ahci-test' : 60,
>     'bios-tables-test' : 120,
> -  'boot-serial-test' : 60,
>     'migration-test' : 150,
>     'npcm7xx_pwm-test': 150,
> -  'prom-env-test' : 60,
> -  'pxe-test' : 60,
> -  'qos-test' : 60,
>     'qom-test' : 300,
>     'test-hmp' : 120,
>   }
> @@ -373,8 +368,8 @@ foreach dir : target_dirs
>            env: qtest_env,
>            args: ['--tap', '-k'],
>            protocol: 'tap',
> -         timeout: slow_qtests.get(test, 30),
> -         priority: slow_qtests.get(test, 30),
> +         timeout: slow_qtests.get(test, 60),
> +         priority: slow_qtests.get(test, 60),
>            suite: ['qtest', 'qtest-' + target_base])
>     endforeach
>   endforeach

Reviewed-by: Thomas Huth <thuth@redhat.com>


