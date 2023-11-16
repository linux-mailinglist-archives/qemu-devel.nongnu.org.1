Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856447EDD7B
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3YVS-000216-2y; Thu, 16 Nov 2023 04:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3YVH-00020y-7p
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3YVF-0002IL-SQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700126257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctLVbBf7QG+IIwsOSmxbyNZelJIppbU/7V8HBCuimqs=;
 b=TRo2jLT3Ew+qqSjFlGbvxX9BfS7OqBFRiuf6uMZaT8FJwNOK868Yp1KFCzjNTlsfJRMF7p
 8EL/bfmKhKKN/F4B/2jtopXPiXs9Y1yWdBLBb+0Sexxw3FCCZ2ejOb7Y3MTdES7JvYVh1/
 JaWgWufz+TC9Z8zEHfpGWUQgqfEoLZI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-MCx1TrIQMNGDlYzEhQxSLw-1; Thu, 16 Nov 2023 04:17:35 -0500
X-MC-Unique: MCx1TrIQMNGDlYzEhQxSLw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-670237ba89aso12511216d6.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 01:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700126255; x=1700731055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctLVbBf7QG+IIwsOSmxbyNZelJIppbU/7V8HBCuimqs=;
 b=Sao1fXo47f9f97fDg9v9vqWGkUxnOeWi/ezVndL4Or16WVnHGtnv8CfdofnQAq5NNA
 3Gw96QiyYeC3ddaAPX+YOgmx04Ylq4Spm0QcafCIKeSyv+kwqEqqI0rEGZmbosgFcKnt
 nDVsobp+0ahAk9CRiDVLFP7pmzj/yJ0PvRiLQat7BIN8+95eVv9eju4F9nitRM0O0R7d
 tq0GlwSKpvV0Y5drNfaXyW0/EKLvsSxc15km3L8LDfTAogehTqhkL4m9yxrccHGVVtV2
 PWxkY9kitrDxrtXHskEFWaYDxlbrMHkZtf7vk3vAgCtU19rrRZ58JZs16FJeTMOb0obp
 1tFQ==
X-Gm-Message-State: AOJu0Yzwo7/qDLFjByvONXGiUMfH8+gPbEg7NRaHl7s4ISgNv4ehN51G
 woCQ7zMbGYnpEBvT4ibiXJ02fYwvpXSryRBnz3az3DAL8PIlovGsbd/mq97NQVeYpwAa15G19we
 8VTjBifw2yGJiqt4=
X-Received: by 2002:a0c:c212:0:b0:66c:eef9:4154 with SMTP id
 l18-20020a0cc212000000b0066ceef94154mr1680267qvh.23.1700126254970; 
 Thu, 16 Nov 2023 01:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9TC2MhIi7vsFB5OGLeM+Jx2m6tKfXxWWi3ce+Zn8QuYulMZPzN+y5l40EgPeVBYzmClI5IA==
X-Received: by 2002:a0c:c212:0:b0:66c:eef9:4154 with SMTP id
 l18-20020a0cc212000000b0066ceef94154mr1680244qvh.23.1700126254763; 
 Thu, 16 Nov 2023 01:17:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p11-20020ad451cb000000b0066d04196c3dsm1240544qvq.49.2023.11.16.01.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 01:17:34 -0800 (PST)
Message-ID: <d0af6110-8b2b-4daf-83d4-dc5374cd14a3@redhat.com>
Date: Thu, 16 Nov 2023 10:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/21] hw/i386: Activate IOMMUFD for q35 machines
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-22-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 11:09, Zhenzhong Duan wrote:
> From: Cédric Le Goater <clg@redhat.com>
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 55850791df..a1846be6f7 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -95,6 +95,7 @@ config Q35
>      imply E1000E_PCI_EXPRESS
>      imply VMPORT
>      imply VMMOUSE
> +    imply IOMMUFD
>      select PC_PCI
>      select PC_ACPI
>      select PCI_EXPRESS_Q35
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric


