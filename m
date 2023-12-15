Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DB3814535
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:11:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE5AG-0007J0-MK; Fri, 15 Dec 2023 05:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1rE5AD-0007Dm-FY; Fri, 15 Dec 2023 05:11:25 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1rE5AA-0000Ig-K1; Fri, 15 Dec 2023 05:11:24 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b86f3cdca0so423323b6e.3; 
 Fri, 15 Dec 2023 02:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702635080; x=1703239880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fWhQUscuAymJIhY8Rb83R2iKrlj5Jv2iDu22zrRU/3w=;
 b=W1k/YwMnTMUI3rZ3/ZVxP0uEHqzI/ASHdErMIy4Dsx+m45Ay6/L+RFCJc4fgHdcCS7
 6ARdDyA5KTrH35DnzS3vZuwUhRLrCcRQzwGvHzb4RZQGYy+p0FaEFEccErzM2204nNos
 iPyec2ffQeKRS3dxtdfbRmRn+hyPq3jmGRKZ4UgQgl9UZhd+K/ZIyw7QPlY/nw7xZpQ0
 PNp8Wztto1oUUvH3jWfd4dQ5U5VH2+iTIPkxB7LnkMkqaRfMlyZsiCfx4j4stuTdY4WC
 I77/GfxC1+Y8eTCLmfhzawMNSJiGPQitRJnFVMISSbUemYW5JccQXsmv42S9fRZCckcc
 Vxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702635080; x=1703239880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWhQUscuAymJIhY8Rb83R2iKrlj5Jv2iDu22zrRU/3w=;
 b=E5zRIHY5/2OcD/HwifrvScb36uT/NVC0PNea+bQXi8Wq1nrcnfba8a+vKuwZROOoYb
 3545rFojaF6v9UMSbWaUp0gMGzVfVfT2cu9pHrD/arB6YGWWKqHWf1NL1IQrq9GC5j4b
 FC0g+uZ9uOIuMdVve/aQR70F0ga4gdjvILiHqVp+csGChD1QSq7yqlb1GO3i4kq6L9je
 b13jPE2NAMD1o2iHv+0B6+XO7P1P8PAJRIQziFqMxI/jfZQQsQSnoMk7ZR0HQ4qP8Qvx
 bTfosxukuX52dWmwNrcgxxvGsVySJP1lGaQgJ8NFYydNBa2SktmH19d0rj0JeC2P/VS7
 JGgA==
X-Gm-Message-State: AOJu0YzfGzkZwTtcWn7rnmmoiDJosiAUbXrNEQUxcBnXMDbVawyYWIq/
 M8V5D+3gk3dsgw6zAFwS834=
X-Google-Smtp-Source: AGHT+IFr9lAuy3UDqs/JWc3ZlWSP9s8GgWdGyJebBdazW9/gDgCfiWBTPMgb+qFz79X2uhcpfs5tBg==
X-Received: by 2002:a05:6358:5e08:b0:172:b6ac:7f87 with SMTP id
 q8-20020a0563585e0800b00172b6ac7f87mr184251rwn.25.1702635080168; 
 Fri, 15 Dec 2023 02:11:20 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a056a001ad000b006cedd530420sm12660389pfv.52.2023.12.15.02.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 02:11:19 -0800 (PST)
Message-ID: <ab5e0141-872f-4e79-8621-4fea4ddfcaf4@gmail.com>
Date: Fri, 15 Dec 2023 07:11:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spapr: Tag pseries-2.1 - 2.11 machines as deprecated
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
References: <20231214181723.1520854-1-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231214181723.1520854-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 12/14/23 15:17, Cédric Le Goater wrote:
> pseries machines before version 2.11 have undergone many changes to
> correct issues, mostly regarding migration compatibility. This is
> obfuscating the code uselessly and makes maintenance more difficult.
> Remove them and only keep the last version of the 2.x series, 2.12,
> still in use by old distros.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   docs/about/deprecated.rst | 7 +++++++
>   hw/ppc/spapr.c            | 1 +
>   2 files changed, 8 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e1504024658..c0e22b2b568f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,13 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   
>   The Nios II architecture is orphan.
>   
> +``pseries-2.1`` up to ``pseries-2.11`` (since 9.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
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

