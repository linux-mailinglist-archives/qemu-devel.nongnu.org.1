Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42E78C520
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayhF-0006Jt-W2; Tue, 29 Aug 2023 09:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayhB-0006JR-0o
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qayh7-0003u1-5M
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693315422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5D5cutAGiZsqhSOjUndfRqcDmoqMtNse9eTkamIRC8=;
 b=cC2MY0BWHkqw0K98qz2PHl7cgGk3QphZrNVhyo1Bm2aQmGm4TSS6TWs0MPl4H2qlYkjkJG
 rFIwgmcKDsARTjdzR6wtelx2ZVy4v/ZSIHm0hVVIc9PafUT5CBYdLaarLu2FSqzXJOpZ9H
 Kvv2x2JYis+fnT2mm3nJSdHEP/dcrbo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-8NKLTEO9OWiUVnU4s-36hA-1; Tue, 29 Aug 2023 09:23:40 -0400
X-MC-Unique: 8NKLTEO9OWiUVnU4s-36hA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-500c1d15927so856339e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693315418; x=1693920218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5D5cutAGiZsqhSOjUndfRqcDmoqMtNse9eTkamIRC8=;
 b=W/16pKOAefn8LPz8GBNnAlERTO6krb5d0xwenYpzJgDe3tYcDBvT+12dbzB2beetbr
 bVd5jNjfOKyhuMn89yKvcuYTqdDRF2beHqJqvWCD0VLmR/Y1L9O+7jJwP4LisJHvinBT
 FwzMCW/CS1i1L5SNinCLNIsAo1D9pT07tYYSAuBxlZ0cvSlCjI5BkxGIYiuizL8h4dn1
 JkMlessET+s4YWO8pb9v+lJGWWgSpEgpwkWBj/QqXth2ix4M5/VIiHlmR3L7FSAIVyn0
 kdcgJ7lcDaDbxaqZG21fOhYYLfwezyR1vU25Kr8gPun0DTNtpWpX6XWABHypzElzbX5b
 rV8w==
X-Gm-Message-State: AOJu0Yy0PnghmH+aAgY15r06+hP4odfHVLaTa8rOheDnN8gu84vtbKZf
 cg46mNU0zIOwenwNyOxvljLDFcILTg0kCj+8W6hYbk26gSrejL9hTEvykOvK6E0hC5+vOaNqpge
 +FSx2h/1U4UIx9F4=
X-Received: by 2002:a19:381d:0:b0:500:96fc:129d with SMTP id
 f29-20020a19381d000000b0050096fc129dmr10627221lfa.14.1693315418456; 
 Tue, 29 Aug 2023 06:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPYfs9iGNgmbNP7LC57Zlkp6pbIuT1fvAYJlcgJFMygwmWVAVJ5BGYb9gxVzGpnCJMORlhPw==
X-Received: by 2002:a19:381d:0:b0:500:96fc:129d with SMTP id
 f29-20020a19381d000000b0050096fc129dmr10627207lfa.14.1693315418048; 
 Tue, 29 Aug 2023 06:23:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:530f:c053:4ab2:f786?
 ([2a01:e0a:9e2:9000:530f:c053:4ab2:f786])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a1c720f000000b003fed630f560sm13919579wmc.36.2023.08.29.06.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:23:37 -0700 (PDT)
Message-ID: <3e8a7edc-8527-e10c-bf2a-73e01650edd1@redhat.com>
Date: Tue, 29 Aug 2023 15:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] vfio/migration: Fail adding device with
 enable-migration=on and existing blocker
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-3-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230828151842.11303-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/28/23 17:18, Avihai Horon wrote:
> If a device with enable-migration=on is added and it causes a migration
> blocker, adding the device should fail with a proper error.
> 
> This is not the case with multiple device migration blocker when the
> blocker already exists. If the blocker already exists and a device with
> enable-migration=on is added which causes a migration blocker, adding
> the device will succeed.
> 
> Fix it by failing adding the device in such case.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> 
> Fixes: 8bbcb64a71d8 ("vfio/migration: Make VFIO migration non-experimental")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/common.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8a8d074e18..237101d038 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -394,8 +394,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>   {
>       int ret;
>   
> -    if (multiple_devices_migration_blocker ||
> -        vfio_multiple_devices_migration_is_supported()) {
> +    if (vfio_multiple_devices_migration_is_supported()) {
>           return 0;
>       }
>   
> @@ -405,6 +404,10 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>           return -EINVAL;
>       }
>   
> +    if (multiple_devices_migration_blocker) {
> +        return 0;
> +    }
> +
>       error_setg(&multiple_devices_migration_blocker,
>                  "Multiple VFIO devices migration is supported only if all of "
>                  "them support P2P migration");


