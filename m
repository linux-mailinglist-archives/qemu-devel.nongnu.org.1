Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 671447AEF27
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9Yw-0001vf-7z; Tue, 26 Sep 2023 11:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9Yh-0001uI-Aq
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9Yb-0001fq-Vi
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695740458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsBkGdWY2QjaADeU2lhQ95H9ogtMQY68ZoZKabzKHz8=;
 b=SHwdGtYopRXPz6jCsCm03+Nib3uWSRSvAwLVAJokEpEuP3A/wOWaypcwDGAu1m1zC6d5t5
 HunFiT4vYdSUtofLzwJcd7FjUMcJfJ/OqvrxY4Hc7kvmMpSgJyzPCXnwMiKbg8aJeDYVAf
 n3KrVuvND+oAg8CIE4xYwtIbSrzcPko=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-KY_5QjbaMB2sHhOXn0xYXQ-1; Tue, 26 Sep 2023 11:00:56 -0400
X-MC-Unique: KY_5QjbaMB2sHhOXn0xYXQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b04f70f98so55894336d6.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695740456; x=1696345256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fsBkGdWY2QjaADeU2lhQ95H9ogtMQY68ZoZKabzKHz8=;
 b=xRHWrE8l0FUavD+OARdxd1OrJN2qlO9Qr3aI+sm7Lge8H6cJal15l6SwtClFVby7lK
 erHyKy9N/EQUWLpoaF3RVPQsmSiH9zdNUNeloD1Bq/qqxCgt13TjpWTX24mtBjN6NKGe
 03GJM1g0OZOs0aYHAfkqkSozA+M49XKpfdQ4DZDeF7KovyIh8NGta84JsSq2EkDr8CjM
 aJ7YR506TKe6v0vkIh8PFA/VboIeW7OPPGXs5c1iptbN4DLFAs9T9ttKvIHEb2SGEjXA
 n/NiHqFXNC3JtmKqwPWibIJD48g1+MPgNPJ4ftOE8+zytnuHI+ko9EnhVg1sa4rH1TqD
 IHLA==
X-Gm-Message-State: AOJu0YwkIx7KyYZK+XgA2QrlNZCXEV7Eku2vyvxyuKtAwgdAlRrQxFjC
 HpCJoXbYwKdY75BIvHYruzv9V1HLQcd1Oe1/e1QYUHYm9WnS18RFC/KFD7GBVSngVA7KvZJ0P6V
 OGWshujTUorazAmI=
X-Received: by 2002:a05:6214:519d:b0:65a:f7b2:2057 with SMTP id
 kl29-20020a056214519d00b0065af7b22057mr2641730qvb.24.1695740456252; 
 Tue, 26 Sep 2023 08:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr1xJcj+BRR2eruWM+VO7wAGGNdWCSPHD+JrVp3DJF5ZsVNukT3nUp6K/3TWZelQmNnTf9QQ==
X-Received: by 2002:a05:6214:519d:b0:65a:f7b2:2057 with SMTP id
 kl29-20020a056214519d00b0065af7b22057mr2641700qvb.24.1695740455958; 
 Tue, 26 Sep 2023 08:00:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a0cca11000000b0065b21f1b687sm935603qvk.80.2023.09.26.08.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:00:55 -0700 (PDT)
Message-ID: <8dc93aed-d107-3514-01cb-19bba64ce7fe@redhat.com>
Date: Tue, 26 Sep 2023 17:00:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] hw/arm/smmuv3.c: Avoid shadowing variable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-4-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230922152944.3583438-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 9/22/23 17:29, Peter Maydell wrote:
> Avoid shadowing a variable in smmuv3_notify_iova():
>
> ../../hw/arm/smmuv3.c: In function ‘smmuv3_notify_iova’:
> ../../hw/arm/smmuv3.c:1043:23: warning: declaration of ‘event’ shadows a previous local [-Wshadow=local]
>  1043 |         SMMUEventInfo event = {.inval_ste_allowed = true};
>       |                       ^~~~~
> ../../hw/arm/smmuv3.c:1038:19: note: shadowed declaration is here
>  1038 |     IOMMUTLBEvent event;
>       |                   ^~~~~
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/smmuv3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 1e9be8e89af..6f2b2bd45f9 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1040,8 +1040,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>      SMMUv3State *s = sdev->smmu;
>  
>      if (!tg) {
> -        SMMUEventInfo event = {.inval_ste_allowed = true};
> -        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &event);
> +        SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
> +        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
>          SMMUTransTableInfo *tt;
>  
>          if (!cfg) {
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric


