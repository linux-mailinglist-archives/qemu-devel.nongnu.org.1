Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9E3827640
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:24:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtLm-0007Ow-Lo; Mon, 08 Jan 2024 12:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rMtLk-0007Ol-97
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rMtLi-0003Ib-PP
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704734620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hahGXRxkLrozGpwrGqjUGJ4WyqzqTZVDuDXmgbXbemQ=;
 b=QNBxb3rzMFCRCnnMXIB+UNjMJHz9Mshrm5O79CHNGrn3581Ft4vhWtxwqm9Nzv09UC/Iu6
 p/Wv/k/c01ezw9kZP25rh6PbUXYYZvunFlvD/7Aok3z7BhbU1TyY8f4r9bZhuK+nGYqzw/
 /K+QNi7C6mgTP8mEwtfFqxFfel/jvgk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Mvg5IvpCNjCB0zHnbGJs9w-1; Mon, 08 Jan 2024 12:23:39 -0500
X-MC-Unique: Mvg5IvpCNjCB0zHnbGJs9w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67f9895f046so38558226d6.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734619; x=1705339419;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hahGXRxkLrozGpwrGqjUGJ4WyqzqTZVDuDXmgbXbemQ=;
 b=xLBIWC5Ykw+yALttBFbD/8z3tu5friwkIUPWwAKloJLnelpsej8Cw/tWXmGXMhgyUu
 aflNpXRzkpcdSLBBsPlLkgbWWDubbkCxGTZc24j3OsFS/p0IIfCqxRY5BULdBXNCd0Hv
 820/ogTlJGDjR8AmlQsgS95F+t2NOw5qOl24etym4SKZbGSwy5ShCAP9VWSu1zoRSfmj
 vaVGd965tCmIdMrySqGgXc/lwpn7pRsGHoddImeosKEhiIxCN4nZ2TJFee5cMQsbgfFK
 RSuJnVDJ7s7sOqr/cwrB/+GUQ2zfI5/8jc4TOJiX5Dx3bJfizg/Z8XJuwc76+OPUKxHS
 R0hQ==
X-Gm-Message-State: AOJu0YxSA3YWK9rHRt+0OErzEkl4GCxZnJi08KJf83ZhrIaDJcsYvHsm
 V4yJF8MQ4RIrC9TIuhtooWvakzfngzQeR+TRv47TJjrW58zmaKiKdMIw8fnfVRifAPUGF+vqpdy
 BmK8KC3+In8OgoA8shVlkAWM=
X-Received: by 2002:ad4:4ea2:0:b0:67f:4881:1ad7 with SMTP id
 ed2-20020ad44ea2000000b0067f48811ad7mr5493333qvb.107.1704734619164; 
 Mon, 08 Jan 2024 09:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+J+6qINwoAL+Y8rk/VcfKaMdH1caMbeH5LmOfzUYgKYf3z4yujJa8s2Raee2e+3uleeZvng==
X-Received: by 2002:ad4:4ea2:0:b0:67f:4881:1ad7 with SMTP id
 ed2-20020ad44ea2000000b0067f48811ad7mr5493317qvb.107.1704734618758; 
 Mon, 08 Jan 2024 09:23:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a0cfb4c000000b00680d237295fsm128341qvq.127.2024.01.08.09.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 09:23:37 -0800 (PST)
Message-ID: <bf61c659-3d7a-4e58-88ea-661a4a956cd2@redhat.com>
Date: Mon, 8 Jan 2024 18:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/block: Deprecate the TC58128 block device
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, devel@lists.libvirt.org, qemu-block@nongnu.org
References: <20240108171523.2487291-1-sam@rfc1149.net>
 <20240108171523.2487291-3-sam@rfc1149.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240108171523.2487291-3-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/8/24 18:15, Samuel Tardieu wrote:
> The 16MiB flash device is only used by the deprecated shix machine.
> Its code it old and unmaintained, and has never been adapted to the
> QOM architecture. It still contains debug statements and uses global
> variables. It is time to deprecate it.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/about/deprecated.rst | 2 +-
>   hw/block/tc58128.c        | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e6a12c9077..15e39f8bbb 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -273,7 +273,7 @@ The Nios II architecture is orphan.
>   ''''''''''''''''''''
>   
>   The machine is no longer in existence and has been long unmaintained
> -in QEMU.
> +in QEMU. This also holds for the TC51828 16MiB flash that it uses.
>   
>   Backend options
>   ---------------
> diff --git a/hw/block/tc58128.c b/hw/block/tc58128.c
> index d350126b27..354c13ccf0 100644
> --- a/hw/block/tc58128.c
> +++ b/hw/block/tc58128.c
> @@ -202,6 +202,7 @@ static sh7750_io_device tc58128 = {
>   
>   int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2)
>   {
> +    warn_report_once("The TC58128 flash device is deprecated - use a newer component");
>       init_dev(&tc58128_devs[0], zone1);
>       init_dev(&tc58128_devs[1], zone2);
>       return sh7750_register_io_device(s, &tc58128);


