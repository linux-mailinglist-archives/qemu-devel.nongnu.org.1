Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C3D759690
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM78a-000784-Ea; Wed, 19 Jul 2023 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM78X-00076E-OC
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM78W-000504-4J
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 09:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689772955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgivhBW1M2GzeYWk5RgklllArlTb4pqO+AThbXP3M8Y=;
 b=Ulk7fImTyFrHuHlH/Lvbo3A+jsJWFfrLJbA+gPooZ0LJ7bIKAoP604L9JA7XzbAByyclIR
 Km7GdKBXAku3pMo5FRSfCyIzchIb2DAn1oqTsr/XlVWz2o2hiL0qlSvKqidaXsubhhAOg0
 cp6ufpTe0GVy7IBT/2ZGozxC/uSPOQ4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-3z5GpmVJP9yYFyUab1KFXA-1; Wed, 19 Jul 2023 09:22:33 -0400
X-MC-Unique: 3z5GpmVJP9yYFyUab1KFXA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb9c4b7020so6174989e87.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689772952; x=1692364952;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tgivhBW1M2GzeYWk5RgklllArlTb4pqO+AThbXP3M8Y=;
 b=b4UFFo+nqlpzxanMhuBjlNlHZ7cEdip8eA9wNmv96+ioupsO1gG/wLHxqiTXWUN3G8
 WGYVqOjGkX/wYVCv3kKm0ZY3Orpfa1dMVtG1zDdgTFXZ45Wz7st9mG+OZe+FeC0TgT62
 FrICN00uNFDOsHWMEHK/7xv3tdSIyYZ3hPP0dBovizjFTVovGActWXtFs3iPMYG922L4
 t4VKHwUfUnqR6e8+sKzqrZ9kd3hLnFuyB9tLCxY5PYsHmq1/MT8cR4DzGZCIkXwUA6HA
 o6a0vQ7aGd/YqkV40YCg9Wb3BX7gns3rESgsnlVOldJ9YuhJ1Npn7FZX6s1sOeXwC36w
 NRtQ==
X-Gm-Message-State: ABy/qLZ7ao7xi9P2srGRkybHSv+4w8/RduHBRHYIIuj0WTkIEZgc0KNj
 bt3Nb/VrfTmrDsc6qZ+Hv0zZdawVuKJsd/58m+C0RC0+g+b+ZV23FggsFHKdjrcvkFeweM0Pj7T
 h9WMOBRgbHnxalI8=
X-Received: by 2002:a05:6512:2522:b0:4fd:d6cb:1d86 with SMTP id
 be34-20020a056512252200b004fdd6cb1d86mr1446549lfb.44.1689772952108; 
 Wed, 19 Jul 2023 06:22:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGO/pjRqi2w6gbP5W6SI3StUWxBlvYcbgWIIT+G1Bso/BHK9W9X3JROK8VW8YqYnlFyw0IqlA==
X-Received: by 2002:a05:6512:2522:b0:4fd:d6cb:1d86 with SMTP id
 be34-20020a056512252200b004fdd6cb1d86mr1446537lfb.44.1689772951813; 
 Wed, 19 Jul 2023 06:22:31 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 m3-20020adfe0c3000000b003143cb109d5sm5390194wri.14.2023.07.19.06.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 06:22:31 -0700 (PDT)
Message-ID: <7fd24e86-46ae-28d1-912a-eb7a42ea6493@redhat.com>
Date: Wed, 19 Jul 2023 15:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230717182859.707658-1-berrange@redhat.com>
 <20230717182859.707658-8-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 07/12] qtest: bump prom-env-test timeout to 3 minutes
In-Reply-To: <20230717182859.707658-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
> The prom-env-test takes about 1 + 1/2 minutes in a --enable-debug
> build. Bumping to 3 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c6da428dc5..095c98820e 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -5,6 +5,7 @@ slow_qtests = {
>     'qom-test' : 900,
>     'test-hmp' : 240,
>     'pxe-test': 180,
> +  'prom-env-test': 180,
>   }
>   
>   qtests_generic = [

I tested your patches, and initially, everything looked good now. But this 
prom-env-test them reminded me that we run some additional tests in the 
"SPEED=slow" mode ... I guess we have to take these into consideration, too?

I now did a "configure --enable-debug" build and then ran:

  make -j$(nproc) check-qtest-ppc64 SPEED=slow

and indeed, this prom-env-test is now timing out there. Also the 
device-introspect-test was timing out in SPEED=slow mode. Should we bump the 
timeout for those, or could this maybe be handled via the TIMEOUT_MULTIPLIER 
in the final patch?

  Thomas


