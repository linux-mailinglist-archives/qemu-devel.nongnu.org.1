Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC071F235
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nD1-0003m2-GY; Thu, 01 Jun 2023 14:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nCv-0003ja-3T
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4nCt-0004FT-MH
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 14:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685644770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrlLR3PP0yuj9PWaAl1L/c7JPYV2x9MBgXmt0LtV6w0=;
 b=dyqYXlBqwy81uBZWRpZ43BF4vymkYTshO/IiU7g+V98q7ysIdIh4vtLCFrk17IO5BwUULz
 6JD37tj/W+qqRynX2Waq1GUtIDvLvkG/j7jrlBpoihHL+jsLSc0suvjs2xs6IGKKeX4Hw5
 mGHxGymdxpxs5UPXOQGXyzp5/afy70g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-NuIiDQr8Ox-sxKJ1IiHawQ-1; Thu, 01 Jun 2023 14:39:28 -0400
X-MC-Unique: NuIiDQr8Ox-sxKJ1IiHawQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so82893966b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 11:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685644767; x=1688236767;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MrlLR3PP0yuj9PWaAl1L/c7JPYV2x9MBgXmt0LtV6w0=;
 b=RV6n8fh54ibyWQaLYLlik+sAWqFcZcmnE8QCL2RsZnLYwL1yLBEkiY1DO2lOEO1rmD
 4J3SpmRQbEqZL3dgnNCqO/OBWmDv7YgpFXHWOZSa68ks7ARlA/AmCfNYZGKFw0YDR180
 UABzk4x7Vw5VcJNbCljZsO/ZcqnlrN8n72SjwBxWLGkbvch24NUvPRH5IXtKMhgyw6ix
 y5CFJYoiKn0KwPe4urVEOr3pfxesYkBQ7mhZM2+xa+1eLJ/Z1YzdRVq0dj1IGU7hHe/Q
 JuRYdzpqFnABCw4HS+fE8XL33LnOKI9+54CweFsNYhqvGNUZO04oOmWxLOhy58ysffL8
 IkBA==
X-Gm-Message-State: AC+VfDwPq6I9U2R0KH3Q1biEyeSEAF6oeci+gZO5SChLWZt2M+cl0se4
 9iRkxWDwRy/Ia/TZs8CVhRN/HX4CHhF2NUVKT3QqmYakR1z/wWYibOsmaZ3iP612U0Nz3vLq/2U
 G2ZWkuVTG9Zab51c=
X-Received: by 2002:a17:907:9811:b0:96f:dd14:f749 with SMTP id
 ji17-20020a170907981100b0096fdd14f749mr9447563ejc.23.1685644767057; 
 Thu, 01 Jun 2023 11:39:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rTtw/yG0nnMzSohIRhJ0hDY0pjMfg9uMuuGCyG3LB0R+23ls7xRrw5K0ptlWdYg6tKMLcDA==
X-Received: by 2002:a17:907:9811:b0:96f:dd14:f749 with SMTP id
 ji17-20020a170907981100b0096fdd14f749mr9447558ejc.23.1685644766778; 
 Thu, 01 Jun 2023 11:39:26 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 bx16-20020a170906a1d000b0096607baaf19sm10859918ejb.101.2023.06.01.11.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 11:39:26 -0700 (PDT)
Message-ID: <ac346371-8609-e093-1254-278989161e9c@redhat.com>
Date: Thu, 1 Jun 2023 20:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] qtest: bump migration-test timeout to 5 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601163123.1805282-3-berrange@redhat.com>
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
> The migration test should take between 1 min 30 and 2 mins on reasonably
> modern hardware. The test is not especially compute bound, rather its
> running time is dominated by the guest RAM size relative to the
> bandwidth cap, which forces each iteration to take at least 30 seconds.
> None the less under high load conditions with multiple QEMU processes
> spawned and competing with other parallel tests, the worst case running
> time might be somewhat extended. Bumping the timeout to 5 minutes gives
> us good headroom, while still catching stuck tests relatively quickly.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 18d046b53c..6684591fcf 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,6 +1,6 @@
>   slow_qtests = {
>     'bios-tables-test' : 120,
> -  'migration-test' : 150,
> +  'migration-test' : 300,
>     'npcm7xx_pwm-test': 150,
>     'qom-test' : 300,
>     'test-hmp' : 120,

Reviewed-by: Thomas Huth <thuth@redhat.com>


