Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BB182B406
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyoB-0000HA-9r; Thu, 11 Jan 2024 12:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNyo2-0000Ew-0C
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rNyo0-0007RR-HT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704993923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTPLA7LGtirftjHdMoRZrguOQoottX+qmjNSXM+yWAg=;
 b=DcLFEdt1cifjpMR3Qtx8bk7W3IwDs0265sS7kdsyBGSbwIqKipeGj73232qKarR5eAlVeh
 2/hYbHUsnWg5F9N4C9ErmrzCZ0HRXFLvN1x8OotCqPIUaltmF+DcQIsvcQl6OayDshVG4x
 QBu8demADFVCQhzSn7iENUzsRgqr6A8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-QGRYQlMoPFapF2dPAoopPA-1; Thu, 11 Jan 2024 12:25:22 -0500
X-MC-Unique: QGRYQlMoPFapF2dPAoopPA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d3fa2e42cdso34744215ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 09:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704993921; x=1705598721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTPLA7LGtirftjHdMoRZrguOQoottX+qmjNSXM+yWAg=;
 b=DJCwvx7WZWrH24eHdMMPjFiLq8+z4XkpNfqJ7wQE0gO5sxHvTwTsptBG3yXRj+Ugzl
 DxEeTmK787Jbms8eQWnS/Ua4x7Ly193H/tOkzJ/WTdhA318fqec5Rz4CAQ3Xs7AeLclW
 JEXFOXCfwXgMI+idfY0GSxD8FMWaB5WN9SD45/MvrT6hCXFvXp+UImCsXU2ZfjEb4v0l
 +oE2YEHVCTOufeYxWUkZ8JO+H/wwvBmf4xYzSv2L/2HhBNDp+bgI2GmF3BM17+PLoLkZ
 vfXWrd/JVDv5s9JYKWJ68H/EhEtzFkVgDNGOlgeuJ9vEKPasL57r+qNFUf4Q9EyUYD9T
 9JAw==
X-Gm-Message-State: AOJu0YyZa9zYthzmatXcK1d6aw7fOIBGcrAuRikM9/Hl4hDrWS0xUIrE
 eVtSosIRMDRWqN1ZZ8lMflYoii/NFc7ZKYrRZkX3SWrbChrDqR2BBQjA3N+yorwQz5Q6g/1BYep
 ZFTWyvfRHnjUiskhgCBXfijU=
X-Received: by 2002:a17:903:248a:b0:1d4:26fb:c1d6 with SMTP id
 p10-20020a170903248a00b001d426fbc1d6mr57359plw.69.1704993921481; 
 Thu, 11 Jan 2024 09:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTk5xuRFfHMQt8V8FlflhKsHpfSSBkxK/pPsHeF3DXILwq6VZjJBqoJaiwgDLrSOkuVV6Dmw==
X-Received: by 2002:a17:903:248a:b0:1d4:26fb:c1d6 with SMTP id
 p10-20020a170903248a00b001d426fbc1d6mr57346plw.69.1704993921201; 
 Thu, 11 Jan 2024 09:25:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 mm4-20020a1709030a0400b001d05456394csm1414675plb.28.2024.01.11.09.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 09:25:20 -0800 (PST)
Message-ID: <de5e8506-705d-4fb8-929d-fcc042eec9dc@redhat.com>
Date: Thu, 11 Jan 2024 18:25:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs/about: Deprecate the old "power5+" and "power7+"
 CPU names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-3-thuth@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240111164652.908182-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/11/24 17:46, Thomas Huth wrote:
> For consistency we should drop the names with a "+" in it in the
> long run.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e15040246..7fdd2239b4 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -245,6 +245,15 @@ Nios II CPU (since 8.2)
>   The Nios II architecture is orphan. The ``nios2`` guest CPU support is
>   deprecated and will be removed in a future version of QEMU.
>   
> +``power5+`` and ``power7+`` CPU names (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The character "+" in device (and thus also CPU) names is not allowed
> +in the QEMU object model anymore. ``power5+``, ``power5+_v2.1``,
> +``power7+`` and ``power7+_v2.1`` are currently still supported via
> +an alias, but for consistency these will get removed in a future
> +release, too. Use ``power5plus_v2.1`` and ``power7plus_v2.1`` instead.
> +
>   
>   System emulator machines
>   ------------------------


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



