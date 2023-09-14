Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F307A0A7C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgovQ-0002iR-ER; Thu, 14 Sep 2023 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgovI-0002gy-3w
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgovF-00041J-3Q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694707827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYnwQm6o9VtmknL+4X1Q0U1hzeJNypIOW9L9vbJFV4I=;
 b=b3H8WtTfkSRzmiJeiAHfYKzrRjTAPxrEWR6WVBpHKCwH0tQX4g2GhlGBYAGezrOiuCLjL4
 cf1ZrsbZ5t0agugvO1eGPyKOzVwugmseMv4SsSm2YEB3h5npO0oX9XSrkbDNIIdAqFj+CF
 8eZOfuwu9py7s2/AFKDjGpScdQBvydA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-oxWaYRB6PACQSVK1AKgdTg-1; Thu, 14 Sep 2023 12:10:24 -0400
X-MC-Unique: oxWaYRB6PACQSVK1AKgdTg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40474e7323dso3966705e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694707823; x=1695312623;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYnwQm6o9VtmknL+4X1Q0U1hzeJNypIOW9L9vbJFV4I=;
 b=XN6xzmyGr/1Pa1sI2ab9hR7A2TCkY7Gw1DZS9MqD4su64WhYqnjJE5ED43WrBiq1eC
 75DJ4cyrPO6cRszg7auJmwiogfkPPueaxcdVKz2nBbq17REv7cQR1Ke09kxNY6gic/mc
 UFMEJWx657mSJVO3cdJxhO5tUw8ejaefJzYwf5x4DwGscOnugVVyr4BDUPj2BH4chQmg
 X1RdnvjBxGf2VrRDajjy+VAfHVArMrm0py3UTZ+e06IW/0j0fzGPCqOJB+0P1QvwVCfm
 lKNaOp1YY3OA4xhiIvsso18oIPoxPopZ1o5U0axsUqViV+OFH8EGjmO6iqjUSaGzfWI1
 ZDQg==
X-Gm-Message-State: AOJu0YzoaGh9jffEeA2r6U81fEIMDymdBSaCsEDxWwwUlnZcGr46a46u
 2upjLJ+13+2IH7EP6feFiBZEHH1rXfaXNsfOuj+GH5dU5yT+R2IP33vQDpNzOt306HW4aysXofZ
 yEFDKq8Mo1puZqsrpieQGhc0gyA==
X-Received: by 2002:a05:600c:2159:b0:402:f503:6d1b with SMTP id
 v25-20020a05600c215900b00402f5036d1bmr5146670wml.0.1694707823352; 
 Thu, 14 Sep 2023 09:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN1NGFsNxrjeQxPKrRgJbnercpXgb/HtPnO9vDxCtWCvr34Tn0hFTfKyXq7B2C0toIa0/TxA==
X-Received: by 2002:a05:600c:2159:b0:402:f503:6d1b with SMTP id
 v25-20020a05600c215900b00402f5036d1bmr5146658wml.0.1694707823079; 
 Thu, 14 Sep 2023 09:10:23 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 l12-20020a1ced0c000000b003fed4fa0c19sm5208550wmh.5.2023.09.14.09.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 09:10:22 -0700 (PDT)
Message-ID: <00b3aa99-8ad6-27e2-2002-208805ee0196@redhat.com>
Date: Thu, 14 Sep 2023 18:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/9] tests: update Debian images to Bookworm
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230914155422.426639-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 14/09/2023 17.54, Alex Bennée wrote:
> Bookworm has been out a while now. Time to update our containers to
> the current stable. This requires the latest lcitool repo so update
> the sub-module too.
> 
> For some reason the MIPs containers won't build so skip those for now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .../dockerfiles/debian-amd64-cross.docker      | 10 +++-------
>   tests/docker/dockerfiles/debian-amd64.docker   | 10 +++-------
>   .../dockerfiles/debian-arm64-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-armel-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-armhf-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-ppc64el-cross.docker    | 10 +++-------
>   .../dockerfiles/debian-s390x-cross.docker      | 10 +++-------
>   tests/docker/dockerfiles/ubuntu2004.docker     |  2 +-
>   tests/docker/dockerfiles/ubuntu2204.docker     |  2 +-
>   tests/lcitool/libvirt-ci                       |  2 +-
>   tests/lcitool/refresh                          | 18 +++++++++---------
>   11 files changed, 33 insertions(+), 61 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



