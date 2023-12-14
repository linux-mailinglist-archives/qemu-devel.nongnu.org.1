Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F581393F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 18:59:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDpyi-0003c5-DK; Thu, 14 Dec 2023 12:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rDpyh-0003bb-4g
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rDpyW-0000v8-RH
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702576699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e/SK9kppNh4rfjttI3fjJIY0LuS7yXh4cHWYsKkKS8g=;
 b=Zfaa7r106Pa5UleIHX0dHYSiUmGG01UtCbzAV7gJD+yk51XJ0GLn+QDXuGPbXAGpv3vvrr
 mQTwgO+EKwgAoqcD230ea+ELSNjD/X8X5FrwbsxXEnQEaPJ/Ev3pgyIkv1wM4ukWLUIGjF
 fEVxpBUJrI1EsDi0XYBI1DgaT6rGqmM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-TV7FcZOjMBWIg-XNjQbOaw-1; Thu, 14 Dec 2023 12:58:17 -0500
X-MC-Unique: TV7FcZOjMBWIg-XNjQbOaw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40c62d9bd43so4716375e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 09:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576696; x=1703181496;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/SK9kppNh4rfjttI3fjJIY0LuS7yXh4cHWYsKkKS8g=;
 b=ZMEUOLhnoDneWoKSW/hkiPLVDyfDq6tcterl+ghh/496eDMcOpl8tb7xcat2UmIoRC
 inosMO8GiYvAkFLsfxkMRT89KIJgyl4ssvmy8q4noDQGWd3nHVDVsrx2+UVN+6s7MBqn
 kF3Q7P6pmMKHtjl/38v04rV6ud05lhV6qaYx5SjhZVWykdehQr2mZesOmALTn6kvLxPX
 OGJnM0LDfNHNzoAJqzJz9bCDBcUHG6ykq0ZwYLo3aqZxR8HDar5jF0gWfDCOCGtqryXw
 ABAbmMkKFwj91M+OqgkILP+9/5PgiF4J1rlHr437nYA2O7Bm6v37S53jvao7dEefCG25
 tz8Q==
X-Gm-Message-State: AOJu0YzY5uM5mq0Jb0C4Z74tS/JtGUcrWE6pvNYqhx5AQ+9SLfmMO4Rn
 leB/gaJGI4OwvdBGQygfsdLXUPRvg7vF9fxsbPZ75hG5ontl21Z3d0q/Jdj4aoaMEfeLJHKBQv7
 0tHHym6WgaTrYoOY=
X-Received: by 2002:a05:600c:19cb:b0:40b:5e56:7b49 with SMTP id
 u11-20020a05600c19cb00b0040b5e567b49mr5406951wmq.146.1702576696548; 
 Thu, 14 Dec 2023 09:58:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFkhb/jtV3qhRXpDmbCToqaMigKcZnxOto/vkXLflwZ/JCl8/9zBOIWkbdW038gUcEvByLLw==
X-Received: by 2002:a05:600c:19cb:b0:40b:5e56:7b49 with SMTP id
 u11-20020a05600c19cb00b0040b5e567b49mr5406946wmq.146.1702576696150; 
 Thu, 14 Dec 2023 09:58:16 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-144.web.vodafone.de.
 [109.43.178.144]) by smtp.gmail.com with ESMTPSA id
 r20-20020a05600c35d400b0040b538047b4sm27969179wmq.3.2023.12.14.09.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 09:58:15 -0800 (PST)
Message-ID: <39cd7fad-395c-426d-93f4-574db241cb42@redhat.com>
Date: Thu, 14 Dec 2023 18:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20231214174354.1514320-1-clg@kaod.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231214174354.1514320-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 14/12/2023 18.43, Cédric Le Goater wrote:
> pseries machines before version 2.11 have undergone many changes to
> correct issues, mostly regarding migration compatibility. This is
> obfuscating the code uselessly and makes maintenance more difficult.
> Remove them and only keep the last version of the 2.x series, 2.12,
> still in use by old distros.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   hw/ppc/spapr.c            | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e1504024658..9ceef6ec2a8d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,13 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   
>   The Nios II architecture is orphan.
>   
> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''

The underline does not match the subtitle length... with that fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> +Older pseries machines before version 2.12 have undergone many changes
> +to correct issues, mostly regarding migration compatibility. These are
> +no longer maintained and removing them will make the code easier to
> +read and maintain. Use versions 2.12 and above as a replacement.
>   
>   Backend options
>   ---------------
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index df09aa9d6a00..5034461399d2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -5083,6 +5083,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
>       spapr_machine_2_12_class_options(mc);
>       smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_ON;
>       compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
> +    mc->deprecation_reason = "old and not maintained - use a 2.12+ version";
>   }
>   
>   DEFINE_SPAPR_MACHINE(2_11, "2.11", false);


