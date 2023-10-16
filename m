Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5062A7CA169
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsIlr-0003mL-9J; Mon, 16 Oct 2023 04:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIlh-0003m9-AM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIlf-00054N-Pg
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697444163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqPN3DviVZcrqGYKQe+I/H0Ogfry1bQz8a5p64cM/Ak=;
 b=fBp6Se0DppqaMrO343CpvGtqssiCqoEJZwoW8YfpiX3b5eHJWhdpHzMODSB6uEDKBBzdw0
 1STC/gPoSVI7vR0YYO+nujNqY7TvzLyX6LBj3R3LC7F7elrwk2qJdP1Z0PBe8aiaueUIog
 stQV923u5J0DvA89YzNphRk0oC52eJo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-8p4bkbg2M8C09yv_-B85mA-1; Mon, 16 Oct 2023 04:15:51 -0400
X-MC-Unique: 8p4bkbg2M8C09yv_-B85mA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77586b4ae08so811137285a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697444151; x=1698048951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqPN3DviVZcrqGYKQe+I/H0Ogfry1bQz8a5p64cM/Ak=;
 b=wAKz5+8cHAbhbx7hWImKP3ZFc2CPS6H58gciFpod7+Z6TXMtSV0c3ZwsVzMyNoC93h
 bofdTX3Kf0mZoDvij1cvCkXgfb99nObM644s/pns6PIZf5pN38hkRNt01pfHWftb5npU
 Ri5wy3w0QSsf58cXS7VFZZNl6eliBDEplrIJI01MZBUkvzJwcbA0+cMymGD3s8tP3pSu
 gUeX3kO2/HpMh7CxRPWD3zHdLJJICGt7NE4IPqCEXB60H/r1NjlykaCHTuSNQzl+E3M5
 xqLEHs+rXCKXPIapE0+5diWvNh2Mv13cROPFIy5TFW4ZB++Qscge45X7f1I+zZ0S+3LO
 6mAQ==
X-Gm-Message-State: AOJu0Yx/h2OQ/O2wtA0RovN9Pbq3QR80aLM+1Vtc9XP00WRqTVu11G0L
 ZB4jmt98CZQR20KIB/FTIyiai2kULI0K69mAWTb41EnsRo4Fw3ZxgYF3LXCb2cpA3RmKIvXxSaS
 zC1w/VXhmHEdIooI=
X-Received: by 2002:a05:620a:4514:b0:767:c30:517 with SMTP id
 t20-20020a05620a451400b007670c300517mr9750083qkp.3.1697444151266; 
 Mon, 16 Oct 2023 01:15:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0btGBfU4r/lEpDdZipgtQU4du8FocxHaC6QggGDlOANUWTIPtPqpPp5kEw7YOhaJcLQU2vA==
X-Received: by 2002:a05:620a:4514:b0:767:c30:517 with SMTP id
 t20-20020a05620a451400b007670c300517mr9750066qkp.3.1697444151016; 
 Mon, 16 Oct 2023 01:15:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 df11-20020a056214080b00b0066d1b4ce863sm3238315qvb.31.2023.10.16.01.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:15:50 -0700 (PDT)
Message-ID: <6255b221-1116-40d7-8f99-97aceb1dca57@redhat.com>
Date: Mon, 16 Oct 2023 10:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/11] ppc/pnv: Change powernv default to powernv10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-12-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010075238.95646-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/10/23 09:52, Nicholas Piggin wrote:
> POWER10 is the latest IBM Power machine. Although it is not offered in
> "OPAL mode" (i.e., powernv configuration), so there is a case that it
> should remain at powernv9, most of the development work is going into
> powernv10 at the moment.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

I think we would update skiboot to v7.1 also.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   hw/ppc/pnv.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index eb54f93986..f3dad5ae05 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2195,8 +2195,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>   
>       xfc->match_nvt = pnv_match_nvt;
>   
> -    mc->alias = "powernv";
> -
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->dt_power_mgt = pnv_dt_power_mgt;
> @@ -2220,6 +2218,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>       mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>   
> +    mc->alias = "powernv";
> +
>       pmc->compat = compat;
>       pmc->compat_size = sizeof(compat);
>       pmc->dt_power_mgt = pnv_dt_power_mgt;


