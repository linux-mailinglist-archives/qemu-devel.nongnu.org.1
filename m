Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6575970F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7Kq-0003aM-1W; Wed, 19 Jul 2023 09:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7Kg-0003W0-Pb
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7Kf-00024T-9J
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmfLof4hkZInWsFq1Sc9Uu54h/4rP7r4z9gaA7w6s5w=;
 b=KD5RwzT7i94IcccZ7jPuzTdNYuGiz2+l9wHd5hJa1bRHy3JGGN6XJic/jNF0tRxLmPPXnu
 YcrvyHU98xF3B/aV9yEEEKL292vT64yzdPIS7n1A7jCwytrDyKHHmsg17//uSkxZXaVGjA
 xLq/BpaKH0USqFfMW+aYT24oxpLjkN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-1UItkt3yNei9Thffp5SQDQ-1; Wed, 19 Jul 2023 09:35:05 -0400
X-MC-Unique: 1UItkt3yNei9Thffp5SQDQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3faabd8fd33so37295335e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773704; x=1692365704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmfLof4hkZInWsFq1Sc9Uu54h/4rP7r4z9gaA7w6s5w=;
 b=JzfzGG1c70drf/7XQoI6HtmUTUuzjV0zL6EiA2QY9YgztxUNvAmUQiw8ZQDPglPZne
 AZb5VG9aElssNf+j0+tb4rOALWLoNHizAdMriU3AsdpL3WBqA313ZuEIl1IHhSiMqUen
 XzMwRocrh726Y6kkN+kogMXm0aJo+5ouiZWNydHaxvvMb28sg4MeCecOX7lf6n6Tbws+
 kocbqQpx4iim9+oljbfuiytlb0XDezBRA9ipITCt5cwctJrefUOcGX6zGfmJsS4w2TEA
 89Z/azWHSUXx3M8d5P53YEdiPDzDlJOI2AUCrBBeSQZauirqnozoUGXIFY1tfSyDq6RW
 tOBA==
X-Gm-Message-State: ABy/qLZxrybnKEbNyPdvwP/rc9d3YVpMZPnSnaNs9YMgBTaeWLDCqOHN
 WuyGANqg36dCqqHIahL50K47iqz1W2edPMjJ/GEmK2uF3W0koM7u/JdgtrhpiY79Z18cZzE5J+L
 0MLs/UhTA6zlHoBg=
X-Received: by 2002:a05:600c:22d2:b0:3fb:5dad:1392 with SMTP id
 18-20020a05600c22d200b003fb5dad1392mr2030264wmg.17.1689773704696; 
 Wed, 19 Jul 2023 06:35:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHbQrq9ObB1wlACvtFA/UcPtrc11olAZBvh9fHG8mO4xgkPZf3vmIjlgUkMH94mcLTTnGRShQ==
X-Received: by 2002:a05:600c:22d2:b0:3fb:5dad:1392 with SMTP id
 18-20020a05600c22d200b003fb5dad1392mr2030245wmg.17.1689773704430; 
 Wed, 19 Jul 2023 06:35:04 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 f14-20020a7bcd0e000000b003fc01f7b415sm1728251wmj.39.2023.07.19.06.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:35:03 -0700 (PDT)
Message-ID: <9deaed7a-4930-8802-f9f6-b047e5c975fe@redhat.com>
Date: Wed, 19 Jul 2023 15:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 10/12] qtest: bump aspeed_smc-test timeout to 4 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-11-berrange@redhat.com>
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
> On a reasonably old laptop this test takes 2 minutes 20 seconds with the
> arm emulator. Raising the timeout to 4 minutes gives greater headroom for
> slowdown.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 3df9a51b03..25732a1cdb 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,4 +1,5 @@
>   slow_qtests = {
> +  'aspeed_smc-test': 240,
>     'bios-tables-test' : 120,
>     'migration-test' : 300,
>     'npcm7xx_pwm-test': 300,

Reviewed-by: Thomas Huth <thuth@redhat.com>


