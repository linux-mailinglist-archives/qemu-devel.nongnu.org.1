Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7B71F2A2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ndp-0003Ff-1q; Thu, 01 Jun 2023 15:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ndi-0003FO-PV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ndg-0001bO-Gc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685646431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uCMbVPHDLjHcOCUlgsswdKKF0uEA/9z7MZJw+RdmqM=;
 b=CVL1UdZEmRc5jc8L9wKUtwFuOp5CGOrgpYqKTH1R6J7Q0hKWKAVOd2Bzmh+gZFA6GevBkC
 KGcvxzNXXUI0C1GVgzNhWEsPVslcPZijdFnhsTw5+JR5rM1htUr204AeIsh9FVY0mAp/CC
 lgxGhsmQlQkhunUvuP/CpHvmKSo+Dic=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-rLmged2_MWuk2K18nvEFbw-1; Thu, 01 Jun 2023 15:07:09 -0400
X-MC-Unique: rLmged2_MWuk2K18nvEFbw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f83b44939so84530766b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 12:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685646428; x=1688238428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uCMbVPHDLjHcOCUlgsswdKKF0uEA/9z7MZJw+RdmqM=;
 b=IfdI9TgxgwWH7p1AJbmt1VVibxwMZ/NXXktNVgaoUWq+3FyNSL927etbESgNZY3jpE
 z4GU9zzkmRjtHETESu02bSb0/Fi7Nw8bUkR0ZFWi9tbm25Y8y3T53UMJAwBXW3BsaFzj
 bjPCCiDLGf6aiT3linaxymdVZRPJKw7ftJr93bZSmzowwMQz1MnIOJ0oII9EI9mUCxRl
 kY6wSbXxUMHuyytycnjJJ4PyvWgDeI5pXmkTUpaSMS2Dj3qkvZK3pJBWFVwQQvD0jIbR
 OntXSCiQyrtd6jzyQYyKqOkDmB/D8ldidaRMk7AVIq2djplIfEyMrmYKHh+RL33yZxXu
 s/Bg==
X-Gm-Message-State: AC+VfDxWaq1U/BdPcXVjBenGbocikAZ8MZjWMCup7jJdOtaFLB0gJly+
 fo1SJXB6NBjIUffIMsoF4xL9Ica+g74aVEAPWXpWA4A4aGttOkRaIOOReG/lsmKDA90KZUG2Jws
 Af3CNZ39FH6bXBKQ=
X-Received: by 2002:a17:907:6d16:b0:973:cc48:f19c with SMTP id
 sa22-20020a1709076d1600b00973cc48f19cmr8409183ejc.56.1685646428588; 
 Thu, 01 Jun 2023 12:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Lfry+83JlGIt+do0P7hZQBXUxta2Y28UAPaj4zQwdnFlV6zSsAZFrOlSyA4ebUovz/ytxCw==
X-Received: by 2002:a17:907:6d16:b0:973:cc48:f19c with SMTP id
 sa22-20020a1709076d1600b00973cc48f19cmr8409169ejc.56.1685646428301; 
 Thu, 01 Jun 2023 12:07:08 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 dk5-20020a170906f0c500b00965b2d3968csm10807939ejb.84.2023.06.01.12.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 12:07:07 -0700 (PDT)
Message-ID: <1c885862-5db9-0f71-e515-40f61f6f0365@redhat.com>
Date: Thu, 1 Jun 2023 21:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/6] qtest: bump qom-test timeout to 7 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-4-berrange@redhat.com>
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
> The qom-test is periodically hitting the 5 minute timeout when running
> on the aarch64 emulator under GitLab CI. Add another 2 minutes headroom
> to the timeout to improve reliability.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6684591fcf..6943bbfdd5 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -2,7 +2,7 @@ slow_qtests = {
>     'bios-tables-test' : 120,
>     'migration-test' : 300,
>     'npcm7xx_pwm-test': 150,
> -  'qom-test' : 300,
> +  'qom-test' : 420,
>     'test-hmp' : 120,
>   }


Reviewed-by: Thomas Huth <thuth@redhat.com>


