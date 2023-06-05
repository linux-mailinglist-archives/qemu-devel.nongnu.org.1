Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCD72249F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:32:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68RJ-0003T7-Ir; Mon, 05 Jun 2023 07:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68R6-0003SQ-HM
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68R5-000825-11
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685964701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1+ZeGzD33URf2KI5q0S+2Pl1YJLfIIv4rJmm9gfA34=;
 b=J/P2TFwtJqCKfSKh+J/jS5156clHWEQAcSKhAcodwXmvKWz/CTyjLQ5ZiNeBK1lyndLK8Y
 n/6NTVhX/fUz4/dolaMEbDneeg1rfLiYo2HORjMxYxp81r9OKo0D3s1AVOYNrKMVD6bGwQ
 apXEC7QNDeE/Mq7aJSexcoGCKj/AGrg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-egBc_XWdPCaYgKOmXKpKUg-1; Mon, 05 Jun 2023 07:31:40 -0400
X-MC-Unique: egBc_XWdPCaYgKOmXKpKUg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso135070f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 04:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685964699; x=1688556699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1+ZeGzD33URf2KI5q0S+2Pl1YJLfIIv4rJmm9gfA34=;
 b=NA1EqosbNI6aS1QNAW5CEfpZQlXYDX/9+7m308eTPOLgpsOAy3vAObpgcGlRZ2FCgK
 ckL19tfzSmhqDZDXrQLvrX8mhhCVnRncEervALFgQhJNiFQJWEe48489qcuoPCXHUo3f
 bCRbA3tfXOg+WgTFFr1u84ep4F2r/vkGPpuh4wVysP5wlz2XsXA5OI7TSJdqgDp39nM6
 7iyxO+YhjQ/l+1IxZTmyuS65LQXNsIWTn0Clur+/S/PwABaZniDbyJY+ZzXiSCJk5ofd
 2h72ME3cw3oC3qB6Q1WxPI+MZ2FMWvX3JmzVLi/vYi900yjR5+ZzLj1QjyoieKBOSsHa
 EOlA==
X-Gm-Message-State: AC+VfDzziw3aqETpd9vRF76Iqtt+/XOqhdo02HnSHv+RFl/V+yrkfkvN
 oBShOGaLrn5aHiOq9jRVrIZVscVIa1FnAk9Q0LErrUtOGCqDuVFwK3q+mTT5vd2ZUsC7u1vKIzW
 bOlbqUq2NgDfj/wE=
X-Received: by 2002:adf:cf03:0:b0:30a:e643:2517 with SMTP id
 o3-20020adfcf03000000b0030ae6432517mr4471056wrj.21.1685964699449; 
 Mon, 05 Jun 2023 04:31:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Mqofh0KUBdCgh4cXm5ukoGmQBNshWje+rA3mc3V0Prhk4NhR5CT/YOFqjzLLWYyGLg3Gu2A==
X-Received: by 2002:adf:cf03:0:b0:30a:e643:2517 with SMTP id
 o3-20020adfcf03000000b0030ae6432517mr4471049wrj.21.1685964699191; 
 Mon, 05 Jun 2023 04:31:39 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 u4-20020a7bc044000000b003f70a7b4537sm14058793wmc.36.2023.06.05.04.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:31:38 -0700 (PDT)
Message-ID: <ed2dd8de-a5e0-1a60-88b6-a15f65c20960@redhat.com>
Date: Mon, 5 Jun 2023 13:31:36 +0200
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

I gave it a try in the CI and this one was failing for me:

  https://gitlab.com/thuth/qemu/-/jobs/4412460476

Looking at an earlier run, it needed 146 seconds to finish:

  https://gitlab.com/thuth/qemu/-/jobs/4411373417#L4954

  Thomas


