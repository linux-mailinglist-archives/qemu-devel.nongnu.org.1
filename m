Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DD7596AB
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7CA-00005J-ET; Wed, 19 Jul 2023 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7C8-00004t-1B
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7C6-00068E-Dr
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRxlv17H+oFq7GOleiLTfxDntbQp2BN5OTiZ0/JA6+Q=;
 b=Yv+FPyFVDZGHYyXu6+JOk3WmaQaHMS6StVgMakHxohOacTWy7v+m8bgYXYOkZomcz1iit+
 MKRSLU3Nx9F839u6QwG6lMlHh0s5O15UfeVR3HXIWVL6IBvsOMJKjIDAnPJTFXzIZRd2Ez
 Ec+frwBZucH4dV464XdXeOnVhmtSilE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--YqA29rzNR-oPa1llpbnPw-1; Wed, 19 Jul 2023 09:26:16 -0400
X-MC-Unique: -YqA29rzNR-oPa1llpbnPw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635e664d2f8so58977186d6.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773176; x=1692365176;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aRxlv17H+oFq7GOleiLTfxDntbQp2BN5OTiZ0/JA6+Q=;
 b=QN9IKFEAMqpdroXomkO2RgPiCeIQ9vvG64f8RpJ0adAHI2K/hKRncTo08BwIopQF+m
 7dVYrQzqU/idf+uvnQAmKMRw2C4zNw/OKoJZKrG3llArauqOQ591U7P1MD+Opd87Fz1m
 wkhgI2mHzQoPqsNwSJCmQ8rMHwoEB4FcVBC6yw0Dc9jfP4vrMVHwec9Ekm80HDkMcvLM
 Acw56yVhJnpeAzGBXFRYCTUxH2a3obKHHr94tPsivXEisQMoDhoUepuJBCvyB0yNaJpS
 PrqTOxnHZRj0MuI7Ft6byuSuWfXdFDFgZ3iXpYqMy7q5l1scsGQeYW3xqHW3F3PZCj0Q
 bC1w==
X-Gm-Message-State: ABy/qLblZlRvRP7IU91B681tJY1LHiX8f19Y+m8vR5w5OD0S2nvInER9
 kA/l4k8xEGg/9ITuqlsUfQwtu7n0/aXqxL0wx8HYUy7/Mt0nNUIPOcoOvnGgOGHlOAI7AhXgCUK
 lX9Moi1bQ9q3xnBQ=
X-Received: by 2002:a05:6214:3d9d:b0:635:e56e:ccf1 with SMTP id
 om29-20020a0562143d9d00b00635e56eccf1mr5291815qvb.46.1689773175898; 
 Wed, 19 Jul 2023 06:26:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnqCDu11ybJlPfyQXtZmvu7+7tjSOzkpOEDcFNA0/kfbh7hbWYbU+BdKLPxttD+2PoMY5/wQ==
X-Received: by 2002:a05:6214:3d9d:b0:635:e56e:ccf1 with SMTP id
 om29-20020a0562143d9d00b00635e56eccf1mr5291802qvb.46.1689773175653; 
 Wed, 19 Jul 2023 06:26:15 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 m18-20020ae9e712000000b0076825e43d98sm1254057qka.125.2023.07.19.06.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:26:15 -0700 (PDT)
Message-ID: <94fd6765-112d-70cc-b8c6-d4556bdce376@redhat.com>
Date: Wed, 19 Jul 2023 15:26:11 +0200
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

By the way, pxe-test uses the boot_sector_test() function, and that already 
uses a timeout of 600 seconds ... so we maybe should use the same (or even 
slightly higher) timeout value here?

  Thomas



