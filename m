Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F447CA168
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsIm9-0003qf-LN; Mon, 16 Oct 2023 04:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIm2-0003os-Vk
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIm0-00056Z-9b
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697444183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7FVTY+3OYjHvUbI7FgXvGMTj3pmeYSn0jJke60c35g=;
 b=a5/A5WM740yi4pmQeP8bQmuqtDrLW9IWclll0hX2PEIOQpTJsdxgnxTfj4VrVnijo+3I37
 mTunvg2nTIoEJV+tgjwW9IeV4UcOwuzNXNACVlk1hF0vgXXhfsuxskqlk7qh5t/8HvJgjP
 1e5ImSoBSuoYMq3+cSs1P0rMSeykJ+w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-eLNCpDAQMzml7JwAhOSsPQ-1; Mon, 16 Oct 2023 04:16:21 -0400
X-MC-Unique: eLNCpDAQMzml7JwAhOSsPQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d24cdf232so37259476d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697444181; x=1698048981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N7FVTY+3OYjHvUbI7FgXvGMTj3pmeYSn0jJke60c35g=;
 b=lcgX6c0i+pgqlkTj9SexGK/72Ttp81Ua4j1+6MbIMEfnKAwyP+q6Et54jYEySsIzPX
 5qnVIGDkGPh6nQx+sBgmVas8piSC8ipMa/GrLCy2TbNN5pL/f8+iteN+F+EFi+Jp5ajd
 P1FvL2dAgoY1fbgTn2T63IICmEqcDJ5YhVU8dSpis6YS50CMxUwJGp/4mba7kKf1W0o+
 xN8ZZqHiex0oYZ3cK8L8YxnN35tpm0hFouKDHNxGbUjyISzzSZNEwx1kQ3PIXshqVQti
 eXZpXn148wGVqPVjZqzMCyVWmXDFoHR1s6b7yIN+N/Su3n488nZ25oSZdlVD8sw7wMB1
 6qhQ==
X-Gm-Message-State: AOJu0YwSJgOSLRNlWchj7GnXUKxMHlp8353xaRLwFHhPKBiI2yUEHf/U
 YVmf+D7TSMtmgXAWzLbihhrHR2rP0OJewqPnyUDppFW8ooLYVnrAVOrwWbotW8spOMkHpINwtBW
 nbEv1hyA96DwsxI8=
X-Received: by 2002:a05:6214:27c5:b0:66d:2b1b:acfa with SMTP id
 ge5-20020a05621427c500b0066d2b1bacfamr10227618qvb.50.1697444181326; 
 Mon, 16 Oct 2023 01:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhUqMgDxfSlrHw1v0XiPmQuUJ1IXVfWox5hw4Z7nG4FAiCwUTKFMMl2JeqE+AM2a/vz/IsWQ==
X-Received: by 2002:a05:6214:27c5:b0:66d:2b1b:acfa with SMTP id
 ge5-20020a05621427c500b0066d2b1bacfamr10227610qvb.50.1697444181126; 
 Mon, 16 Oct 2023 01:16:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 df11-20020a056214080b00b0066d1b4ce863sm3238315qvb.31.2023.10.16.01.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:16:20 -0700 (PDT)
Message-ID: <c789290c-d4cc-45a6-be79-c51f4e3e788f@redhat.com>
Date: Mon, 16 Oct 2023 10:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/11] ppc/spapr: change pseries machine default to
 POWER10 CPU
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-11-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20231010075238.95646-11-npiggin@gmail.com>
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
> POWER10 is the latest pseries CPU.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/ppc/spapr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d4230d3647..9d3475d64b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4661,7 +4661,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>   
>       smc->dr_lmb_enabled = true;
>       smc->update_dt_enabled = true;
> -    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>       mc->has_hotpluggable_cpus = true;
>       mc->nvdimm_supported = true;
>       smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;


