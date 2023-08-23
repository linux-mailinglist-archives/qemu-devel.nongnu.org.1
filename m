Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1643A785318
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjbR-0002Hy-0a; Wed, 23 Aug 2023 04:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjbP-0002Hq-0z
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjbN-0007iF-M9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692780753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1ipnaV6B46oY4s1mdc/zta/Cvb2h98wYyZrtANwKN8=;
 b=Mj/fqS7owlpxiJU5ePTVLaP/oRQp1WxUMVrmFS1ElhrP75kkiqz1OZWvA74C+N5vnTf3Se
 iPfIwSSsNzNrhoYjrL1uf6+X90krN63v41vytGOP0BeBeGUthZP8tupq24eTaCc66hLHAP
 KWq5nnN4LpfO55hcB6mHludW4peFWrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-01EDxhapP6mAIstORpRFdg-1; Wed, 23 Aug 2023 04:52:30 -0400
X-MC-Unique: 01EDxhapP6mAIstORpRFdg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so970705e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692780749; x=1693385549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X1ipnaV6B46oY4s1mdc/zta/Cvb2h98wYyZrtANwKN8=;
 b=EqdsWpTbl4THSRVrSX2BmbDMEGw5ERzjDxNIOADskgKZ8I5TuTzfbl2xemSsAMddUv
 18dZN1Nrv50fcKFUM7M7898BXKMI/P9K7RGQdUri4biUiRIc2LeHdzrJJ6tEKtHgYf1S
 86hGAPQrhJ+qIGOXlTxeoFsJoRiN/EutWrX2jDwZmqLjOFLxNT7YbR2rRjkOvDqSfBQK
 fEEWsc+w0/TdbMluJt3erHQyDVlysUhImCruW5iJGso/s7YfDCesNsG+Dsj6FjClOfwr
 S1wYUiszdB3oxnOe7xTLjQA1QTGJlu6GCJzbWWbm10VGvoRZQf9G0zLcbI0gm7mg8gly
 L3rg==
X-Gm-Message-State: AOJu0YwsEj+kFWdpZUWsoiR212N8lDd60Lc4roipzCD+1RC6zhFuH3Oo
 OTZSxLbseT92QVheTqn2P5qJ1o+IuP5ECQVGBYS7RVriyQYCivsTGTZHO2WIetapNIq7vN4pym9
 qDYSKsa/xo4uemQQ=
X-Received: by 2002:a1c:4c15:0:b0:3fe:179a:9ee2 with SMTP id
 z21-20020a1c4c15000000b003fe179a9ee2mr9327682wmf.0.1692780749187; 
 Wed, 23 Aug 2023 01:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu0urjmDmLf/3zx1EHK3peXqvJPyLE95QVWeOhfmFmvCkfvsi2pQho00LosbaiXp48D6dIQw==
X-Received: by 2002:a1c:4c15:0:b0:3fe:179a:9ee2 with SMTP id
 z21-20020a1c4c15000000b003fe179a9ee2mr9327664wmf.0.1692780748854; 
 Wed, 23 Aug 2023 01:52:28 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 m25-20020a7bcb99000000b003fee7b67f67sm12919823wmi.31.2023.08.23.01.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:52:28 -0700 (PDT)
Message-ID: <738543ed-6e22-8a7a-37f9-7c27c0d63925@redhat.com>
Date: Wed, 23 Aug 2023 10:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] hw/misc/i2c-echo: add copyright/license note
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
 <20230823-i2c-echo-fixes-v1-1-ccc05a6028f0@samsung.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230823-i2c-echo-fixes-v1-1-ccc05a6028f0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 23/08/2023 10.14, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add missing copyright and license notice. Also add a short description
> of the device.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/misc/i2c-echo.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> index 5705ab5d7349..5ae3d0817ead 100644
> --- a/hw/misc/i2c-echo.c
> +++ b/hw/misc/i2c-echo.c
> @@ -1,3 +1,13 @@
> +/*
> + * Example I2C device using asynchronous I2C send.
> + *
> + * Copyright (C) 2023 Samsung Electronics Co., Ltd. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.

That means GPL-2.0-only ? Please change this into GPL-2.0-or-later instead 
if possible, since according our main "LICENSE" file:

"As of July 2013, contributions under version 2 of the GNU General Public 
License (and no later version) are only accepted for the following files or 
directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*"

While you're at it, I'd also appreciate a SPDX-License-Identifier line here.

  Thanks,
   Thomas



