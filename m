Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A711682763E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:24:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtLg-0007OJ-BV; Mon, 08 Jan 2024 12:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rMtLa-0007Nj-6P
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rMtLY-0003Fs-N0
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704734610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dCzweWXCNkvPTlglDpJkLtTanWzSTabbPn8PwAytw4=;
 b=Ajf4bkMh05EWw6OtAcYo8kIcD7nAuYdqzNrXJMuo84N8XGQ86wJyPPSUaGtqyyqHoVjTMk
 /PhtlAmdkQye3Ij4keMH2pBtwm3fsRycHesBjxyLOWH83fmGkAIYimLIh1dckb/hGlOB0y
 mGmjYEA/l2bg92HlS92B6n57GP0fME4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-wp5GbuCAMlu4z5HOHcWF_g-1; Mon, 08 Jan 2024 12:23:29 -0500
X-MC-Unique: wp5GbuCAMlu4z5HOHcWF_g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6800714a149so47843776d6.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704734609; x=1705339409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8dCzweWXCNkvPTlglDpJkLtTanWzSTabbPn8PwAytw4=;
 b=L4i9yI/FpiL8NsdrLNh3td97EaBS0xIvLfrmqgc1Qwqs7rs7MGobJfG6N95QnaVE6r
 zW69rtdCNuW2STBA7Ae1QsdToUla1h04W7Mx9bKXuEETDIyNy9DwNUU9Nuo7z6T0G5LC
 imyaVqSEcjOXmQG6smS9OeeO7i+NfVuFP56lM7SiE1KwHOkz0Z4x07DUC7AY1gl9wolV
 7LI/7oIVjIfWOkLl0zO8nHQsG9Q3It6Vilcq1Jfm6s2hkMy8sP0Q0o9o5J3KR8xeSj/J
 EyC7nKRE8NtTcKxCVbwGNoWMqmIY5wKZi6qr5VxOYbrVd+MwDnl1EX5Xa0BlXQbI3GwK
 a2HQ==
X-Gm-Message-State: AOJu0YwRYvkAsrgNAEwlvh/TTpoMbdunuKufPITDuxA3+q3RJpTbnUo3
 lox0Ha0mLP1VeKONppqkyF5Xrsb/V+pZceaNkxVF38wXkm/ZI8mUj/tNzUp1mQNM63Ve8e6niWz
 mlN7HnVjAHdTW1n9pPU1SfB8=
X-Received: by 2002:ad4:5ca6:0:b0:680:b276:6102 with SMTP id
 q6-20020ad45ca6000000b00680b2766102mr5474366qvh.117.1704734608860; 
 Mon, 08 Jan 2024 09:23:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvYPVsvJa+QLTUr3yFRUXsl181D8iXuTECHj4ZHExMlTGqWUCQBCjhwC/wCzE3APk+Drv0BQ==
X-Received: by 2002:ad4:5ca6:0:b0:680:b276:6102 with SMTP id
 q6-20020ad45ca6000000b00680b2766102mr5474354qvh.117.1704734608638; 
 Mon, 08 Jan 2024 09:23:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a0cfb4c000000b00680d237295fsm128341qvq.127.2024.01.08.09.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 09:23:28 -0800 (PST)
Message-ID: <a303772d-e363-4803-8c37-a57fdacf3051@redhat.com>
Date: Mon, 8 Jan 2024 18:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/sh4: Deprecate the shix machine
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, devel@lists.libvirt.org, qemu-block@nongnu.org
References: <20240108171523.2487291-1-sam@rfc1149.net>
 <20240108171523.2487291-2-sam@rfc1149.net>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240108171523.2487291-2-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> The shix machine has been designed and used at Télécom Paris from 2003
> to 2010. It had been added to QEMU in 2005 and has not been maintained
> since. Since nobody is using the physical board anymore nor interested
> in maintaining the QEMU port, it is time to deprecate it.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   docs/about/deprecated.rst | 5 +++++
>   hw/sh4/shix.c             | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e15040246..e6a12c9077 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,11 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   
>   The Nios II architecture is orphan.
>   
> +``shix`` (since 9.0)
> +''''''''''''''''''''
> +
> +The machine is no longer in existence and has been long unmaintained
> +in QEMU.
>   
>   Backend options
>   ---------------
> diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
> index aa812512f0..58530b8ede 100644
> --- a/hw/sh4/shix.c
> +++ b/hw/sh4/shix.c
> @@ -80,6 +80,7 @@ static void shix_machine_init(MachineClass *mc)
>       mc->init = shix_init;
>       mc->is_default = true;
>       mc->default_cpu_type = TYPE_SH7750R_CPU;
> +    mc->deprecation_reason = "old and unmaintained - use a newer machine instead";
>   }
>   
>   DEFINE_MACHINE("shix", shix_machine_init)


