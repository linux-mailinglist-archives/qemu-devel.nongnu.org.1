Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E0759695
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7AH-0007nk-3A; Wed, 19 Jul 2023 09:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7AF-0007nY-PK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM7AE-0005VP-A6
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689773061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qEGCoReLe5UmfN2nGURXH3pVa2VvN0nQrZJGWZ0FtU=;
 b=aGJNzsj7xrYKdYXOfTMSXzcYOqFHaOX4KoEjUr6SfbLS+ceCO+GEHzs0yOrRZv4kA//UBp
 n/GyLqjXtfgfi3lqGKi2lxpOgpjUL3y42g7LxR9tiXIvnbRJFohknjD0Wzmi8YcQjmItdI
 fSp3hitSI6Pu3UUfrCn5O8nxhB4ZV44=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-l_WlkVVvN5uDY6znLI10Qw-1; Wed, 19 Jul 2023 09:24:20 -0400
X-MC-Unique: l_WlkVVvN5uDY6znLI10Qw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso3968197f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689773059; x=1692365059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qEGCoReLe5UmfN2nGURXH3pVa2VvN0nQrZJGWZ0FtU=;
 b=OHowHL+fioqgN+BWT/n6zevAYnR9L3BlM0+RnVP4g6AafkpDcUJ0ALnVGtSmiACc5z
 iJwzlmXWk9QRSeyemSUPX7Skep6O/wY6PEN4uCC3UYLCLisb3jH9DUYfQB4zpNJ/wqEJ
 PMlM2HpeEbNWWK00yrKBCtS2rvkOh3t6ixjmnV0JniMlOHo8R2meMQACWbLgJLZ4JQ4y
 tU6nuoelu8L4W8HjIeNqV8AzSPeWbrKvGMyCXOzkWLnq6TmQQcIvt5xjyyowGrnkkDPd
 2FkfQVpR4I575w2beENHnrFPvyNhcFmr6E4VeJBSU9W2peuGGmnJgowj4CXkGHzNWSwX
 uzew==
X-Gm-Message-State: ABy/qLalnJ1/puh0vpYqUJuZlH7bS8S4Mc998OxeJMz39Nc9Z2IdhXM0
 +WtuRU8r2uUN2fNsIEg0bL8CsjGovOVttr+vKZMYYukZUQeTcv2btVySYG9nAeZX2X6ohI3tZez
 ztgJjuPpZ1bEofcc=
X-Received: by 2002:adf:ee45:0:b0:313:ef08:c83b with SMTP id
 w5-20020adfee45000000b00313ef08c83bmr4037696wro.56.1689773059167; 
 Wed, 19 Jul 2023 06:24:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcqDII350v1/wUNK2DCyZz6Cw9W330qnRKYqRtIMTbyQ1i9cxrk+V0mQl23zvazdDSq+F7kQ==
X-Received: by 2002:adf:ee45:0:b0:313:ef08:c83b with SMTP id
 w5-20020adfee45000000b00313ef08c83bmr4037674wro.56.1689773058878; 
 Wed, 19 Jul 2023 06:24:18 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 m5-20020adfe945000000b0031434cebcd8sm5392260wrn.33.2023.07.19.06.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:24:18 -0700 (PDT)
Message-ID: <0e2eae70-9859-92b4-ad5e-81c5a804beb2@redhat.com>
Date: Wed, 19 Jul 2023 15:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/12] qtest: bump boot-serial-test timeout to 3 minutes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-9-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230717182859.707658-9-berrange@redhat.com>
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
> The boot-serial-test takes about 1 + 1/2 minutes in a --enable-debug
> build. Bumping to 3 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 095c98820e..9e4f5e0ecc 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -6,6 +6,7 @@ slow_qtests = {
>     'test-hmp' : 240,
>     'pxe-test': 180,
>     'prom-env-test': 180,
> +  'boot-serial-test': 180,
>   }
>   
>   qtests_generic = [

Reviewed-by: Thomas Huth <thuth@redhat.com>


