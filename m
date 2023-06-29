Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E03742069
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElCa-0005Mc-TP; Thu, 29 Jun 2023 02:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qElCD-0005MI-8f
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qElCA-0006cJ-Ni
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688020317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A5ZaNz16mqRX7/VwBuaXW2vOxNL7wU4Q7pLqnOAmdYQ=;
 b=ey8FmWvZt3Lr7IZ7ZWE2EOLRBYSu6euU/mMvH+mFJFuglWmNZlUXNYEOxV/X9Gw3Y1clVd
 E1+04eKfy+ZBiZ9vhHan+Tp2yMN2sEZ8dn/UnVgAqtoSS5oXQ8GXCskIuYSz6Z7rxrafp1
 ZNw5evvZZdIQxrHhL0OLdyQ3z1XLFO0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-isBoMzWOMrewi0bNbchWAA-1; Thu, 29 Jun 2023 02:31:55 -0400
X-MC-Unique: isBoMzWOMrewi0bNbchWAA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb76659d54so328498e87.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 23:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688020314; x=1690612314;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5ZaNz16mqRX7/VwBuaXW2vOxNL7wU4Q7pLqnOAmdYQ=;
 b=RHHKuFkCRq7w2dXP4ICuLejSghN6s2UAP3uTabZBqdMS1bRQLu2iD7tQjAJRZsfwnx
 Rt269b03DDEnP/c2jKJmodRjKBXI4WozRC5eHXT3W3RFBcMCQe6TvS5fS9kmY9480yU8
 BrVChPbsSgmOUGi/YIUlIvCUv6rDKMMZ7Wy2aEee+b1IW23gXmAeNQMZZlhdTgnTRosU
 ukPJAWsPlCcKsyegHiQtlVQSXqysRkgmSWMjy6/PRfI6uJ+a2HdYQbJBgbspNi6kVOMx
 UiMjU+2tnJQdLMZlXN2sgFAr6ZAMSPBrgfqdJiJ4vaOecWCIKNYfsmdv2uCDV/TOFalx
 Atlw==
X-Gm-Message-State: AC+VfDyRWVdKBaA8x/yX+bDpNB3vo8r7GYG7BUiFmYWRjO9aSXRzJWwO
 sePrvlfmczL+JhiIpMsfbuusBVl+EvCT4ZEkc9ZZ/9PqFB3xdUbLVKGrEX3n6LYXrp/8xG/g31p
 wvkJ0gF8lj6ElXA0=
X-Received: by 2002:a05:6512:1184:b0:4fb:8a90:396c with SMTP id
 g4-20020a056512118400b004fb8a90396cmr3878620lfr.38.1688020314194; 
 Wed, 28 Jun 2023 23:31:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dJBKBlryGp1EXDvnD+BEGpiExMVEo9SxgTceTAiEV9VrfN5H0nr7Wnbx1nHw/9aXLA1QlSg==
X-Received: by 2002:a05:6512:1184:b0:4fb:8a90:396c with SMTP id
 g4-20020a056512118400b004fb8a90396cmr3878607lfr.38.1688020313845; 
 Wed, 28 Jun 2023 23:31:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm7483312wrv.107.2023.06.28.23.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 23:31:53 -0700 (PDT)
Message-ID: <a22e9f1b-6484-78e9-3173-77e98772ad8a@redhat.com>
Date: Thu, 29 Jun 2023 08:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_MAINTAINERS=3a_Promote_C=c3=a9dric_to_V?=
 =?UTF-8?Q?FIO_co-maintainer?=
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20230628172932.287318-1-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230628172932.287318-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/28/23 19:29, Alex Williamson wrote:
> Cédric has stepped up involvement in vfio, reviewing and managing
> patches, as well as pull requests.  This work deserves gratitude and
> punishment with a promotion to co-maintainer ;)

:)

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Acked-by: Cédric Le Goater <clg@redhat.com>


> ---
> 
> Cédric, I'd also support if you wanted to add a tree entry here.

OK. I had some habits on github. For VFIO, I might change for gitlab
where the CI runs. It can come later.

Thanks,

C.


> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e07746ac7d45..37e48c72b16a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2051,7 +2051,7 @@ F: hw/usb/dev-serial.c
>   
>   VFIO
>   M: Alex Williamson <alex.williamson@redhat.com>
> -R: Cédric Le Goater <clg@redhat.com>
> +M: Cédric Le Goater <clg@redhat.com>
>   S: Supported
>   F: hw/vfio/*
>   F: include/hw/vfio/


