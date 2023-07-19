Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CF759640
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6vS-0003sz-U6; Wed, 19 Jul 2023 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6vP-0003s3-S6
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM6vO-00005C-Et
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689772141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMWVWyheOhLI6PnEz3Yl+BVMujkAVZySsgmV1cWtf0k=;
 b=X+dOW/JOw5v8ZCW5uJun6rdWS/Z/RpSww2QzbXV7i48Q9i6RYL9fMBTdPk6HTV/9iyha3l
 wFKW+oh+JodtRUbuuJdGJCHXPlE3Q8A6pgQ1p4p1UddL3TeG6I6azxgTCmosqCajRqPjeJ
 kyE4DnXLE4UpAF0f+cjmIrVDkUe2fz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-soneCLBDNn6Wyhwz3uCqTg-1; Wed, 19 Jul 2023 09:09:00 -0400
X-MC-Unique: soneCLBDNn6Wyhwz3uCqTg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso3816952f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689772139; x=1692364139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMWVWyheOhLI6PnEz3Yl+BVMujkAVZySsgmV1cWtf0k=;
 b=kCETCKpWLenGD1kldEi5J1vviYKE8bia8n2qwuA+4EJ7n4ejkan76SL+Xi4/Z2d5Vz
 irYSr5fe2ZjDCSe1tfb1GKjkiINZBhU9sL/QUldIzUqXxJGTQbF9aqP4z1PA7Vh9hoCO
 KTB9duj/qAsbJxzZ1Ldc3ams8pTCwvJJ3atfTAMWWZT3ODRtTHzTh5ttKOXQm0LXXRhg
 d72pK1f2/s+cZnu0tET104QDR7jV9crHARA8WLcj0RSfRo1rYotq2d4rnoFJYh4GaQDX
 dUToEJ/wyMJvfxJuo5FJAby/FLTEBIYRryxh7l4tDAY579p3/TBLE+kDeSgnVfhqcVV5
 Y2JQ==
X-Gm-Message-State: ABy/qLYZVtuWg0Xg2gJS+pOS0QSjdh7RrMh7cy4L2iz0TjCYH/ZmsT5m
 BEobrbsp6+CDq8U/Yuam4M5mGnW5vK8vTxd0TGPcfG0u1dZ7FcKyRqXoNpxCiWbSg3lB/soZ9Pi
 J3A9lod3uVeNHwXo=
X-Received: by 2002:a5d:504e:0:b0:312:74a9:8259 with SMTP id
 h14-20020a5d504e000000b0031274a98259mr11993314wrt.71.1689772139374; 
 Wed, 19 Jul 2023 06:08:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFrX42RdwB17ZuWOKAX6jDDn63Rsoca9/6Opr8bWg8LBRky02DCPFW7aJETt3PIciwdG2oImQ==
X-Received: by 2002:a5d:504e:0:b0:312:74a9:8259 with SMTP id
 h14-20020a5d504e000000b0031274a98259mr11993302wrt.71.1689772139102; 
 Wed, 19 Jul 2023 06:08:59 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 n13-20020a5d4c4d000000b002c70ce264bfsm5371017wrt.76.2023.07.19.06.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:08:58 -0700 (PDT)
Message-ID: <b73807c7-ba19-9a22-ddf9-93b0fb2980a3@redhat.com>
Date: Wed, 19 Jul 2023 15:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/12] qtest: bump pxe-test timeout to 3 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-7-berrange@redhat.com>
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
> The pxe-test takes about 1 + 1/2 minutes in a --enable-debug
> build. Bumping to 3 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 1070c6dc64..c6da428dc5 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -4,6 +4,7 @@ slow_qtests = {
>     'npcm7xx_pwm-test': 300,
>     'qom-test' : 900,
>     'test-hmp' : 240,
> +  'pxe-test': 180,
>   }
>   
>   qtests_generic = [

Reviewed-by: Thomas Huth <thuth@redhat.com>


