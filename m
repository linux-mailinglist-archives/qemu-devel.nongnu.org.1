Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768871F2B2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nhw-0005tX-Mc; Thu, 01 Jun 2023 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nho-0005t2-1k
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nhm-0002Hz-J1
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685646681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htfVThOobiE3lXPxK6mWgJs5cEhwYUpEUfr+NTWYROw=;
 b=eBchvQvKeTp5hEDWOgGQBuNln/vFk2o2TJ7qr/3+6zMs5BxXuuG4BelawkxKme49tI10Sn
 EskjbBmoGjdB1mYlsZMYkuhItYE5/d1Oq68nCp5yMd6zrPnGlhmkyvCojTNSgvjRtP7Z8o
 tbwwStBAmLS8XO+pyT3o17tBzgIHI7Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-i5FyqQ6UN3-ssy_U4ULXDw-1; Thu, 01 Jun 2023 15:08:51 -0400
X-MC-Unique: i5FyqQ6UN3-ssy_U4ULXDw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edc7ab63ccso1403983e87.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 12:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685646456; x=1688238456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=htfVThOobiE3lXPxK6mWgJs5cEhwYUpEUfr+NTWYROw=;
 b=W2NhaCWNLu7zNm2GfTebTSMWKaFZXvqATjC/vFUBEbSrrlwdrUVVeDhtu7Hbct1GNE
 aylFNjHvg7x2rRT58MZrcBO1qMsvhGMr4eZoElHWhDIqkideORjnbJxnJEU5mevYYQ4N
 fbdevTUDsSFwP+3Ho6pec5uzgrmlPvN36yF29XuauwKQ1WWiC0CbDtzewbA4ZJd1ohXK
 zUiSh08PQ3ySyUThXmVluPT1vtFo3AAi4ZAUO6+XbgF2a11zqhAMcJas9ofzhe48sjIK
 FvYyTgQ9ya8kWMB9CmkTkUtpLbOdgr9GUbmaNKs0M+rdUQcvsJzE8wUjQ/lMeL6HGlj+
 vaEQ==
X-Gm-Message-State: AC+VfDzbqBXaYJmWpK6/G2WR7rz4QFazHVFptLon5MPdVYIFssiqlDV4
 B9UozRryK4R40JhE707kaYsdrl8XpAsQYoa9O4TE19xUD4t4N/PN7JiC648eipmDJWlAuyBUPc+
 O3aqaEPzUGT8PVyY=
X-Received: by 2002:ac2:519c:0:b0:4f4:d45d:1616 with SMTP id
 u28-20020ac2519c000000b004f4d45d1616mr553234lfi.67.1685646456543; 
 Thu, 01 Jun 2023 12:07:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Jkm7CX+fvc/+tUkWjiJQ95VV3fFxk37WeSYVINjs7kFKm+q4H9/u5VL4s7gz1bxIQbmKDnw==
X-Received: by 2002:ac2:519c:0:b0:4f4:d45d:1616 with SMTP id
 u28-20020ac2519c000000b004f4d45d1616mr553218lfi.67.1685646456188; 
 Thu, 01 Jun 2023 12:07:36 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 k10-20020aa7c04a000000b00514aef7daacsm4068819edo.76.2023.06.01.12.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 12:07:35 -0700 (PDT)
Message-ID: <19868d4c-a9e8-bc93-64df-f1993d39a901@redhat.com>
Date: Thu, 1 Jun 2023 21:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/6] qtest: bump aspeed_smc-test timeout to 2 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
> On a reasonably modern laptop this test takes 40 seconds with the arm
> emulator. Raising the timeout to 2 minutes gives greater headroom for
> slowdown under GitLab CI.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6943bbfdd5..d9fa30edbc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,4 +1,5 @@
>   slow_qtests = {
> +  'aspeed_smc-test': 120,
>     'bios-tables-test' : 120,
>     'migration-test' : 300,
>     'npcm7xx_pwm-test': 150,

Reviewed-by: Thomas Huth <thuth@redhat.com>


