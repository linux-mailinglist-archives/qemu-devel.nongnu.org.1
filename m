Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBC17F75E2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:03:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Wko-0007C1-U1; Fri, 24 Nov 2023 09:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Wka-0007BA-9q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6WkX-0004q1-Nr
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700834500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2j/FO2BafCuPPkClXKNog7lc9GgmdEgPIcAikNoY70A=;
 b=fn4bLXEVCvlLS5s7lXYZLDD9CAlCfZEZpMcdG5eRcDhQrZEzgGhS1ZLLmEKD9vgDwaYaaO
 TEx8Ttb+KUVNCIIE8u6Xlsvgw7+bQE3PP8cf4U5eYwgZYprf//vYlNYOC0CeOgE4qYvPwp
 7suIHxu4UohfT0JmhRjAiaoLWElVg7c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-6dhDB-dkPaeoLUvNnrR2rg-1; Fri, 24 Nov 2023 09:01:38 -0500
X-MC-Unique: 6dhDB-dkPaeoLUvNnrR2rg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54af4ac76adso450527a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 06:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700834498; x=1701439298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2j/FO2BafCuPPkClXKNog7lc9GgmdEgPIcAikNoY70A=;
 b=ANb3fipocD0GHNnRQH9wcokBXLNi+44L5+sU9GVDVapJa6zIryJAbE+pQW+X7T96JD
 m8UZM9dglDV2mI8lpf03cKkzM2FjJllY7eQgzC0TwbFa231jpSwaJQH6w6vyeimVveA6
 1Yyi5OAXwDhv66/ZAyFZtbK2gsZtpMhkWm4EJdUpybDbsVhomak8UOV93FeglH37drtR
 Ff1uPhUBjx4Ea/OZHX6M0Fhmn4TKGj4foZU3Bl7bc4RAO2Nnk4PtRXWX+Czd8Eo7yKDM
 4lVigCa59w8lamh2BV5/zDglgq7Ab4XwRjPzoXuIQqKOx4kepYvQ8m6MHTrvsr1lwdMf
 TbcQ==
X-Gm-Message-State: AOJu0Yz1fbxQcadzkT/YGljx85ePnLVI7Z3hACJmznNsWhgnUppLgeNA
 5xE1CsIbVaMGueFWLm5Tp79knnBlu2qCvuojIY59dFGL+xoxVeKzA7DryM+1NQY960zA98sKbKz
 V5Xad4AFczm1c1lo=
X-Received: by 2002:a50:cd47:0:b0:544:a26c:804c with SMTP id
 d7-20020a50cd47000000b00544a26c804cmr2598377edj.16.1700834497351; 
 Fri, 24 Nov 2023 06:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqbYzDNywa3l6cj02w3h/lNw+9ieWLnB68uwSzhZ/O2uiFwViMOapuAEBwcuVW3zDebH7uoA==
X-Received: by 2002:a50:cd47:0:b0:544:a26c:804c with SMTP id
 d7-20020a50cd47000000b00544a26c804cmr2598240edj.16.1700834496075; 
 Fri, 24 Nov 2023 06:01:36 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a056402018d00b0052ff9bae873sm1784515edv.5.2023.11.24.06.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 06:01:35 -0800 (PST)
Date: Fri, 24 Nov 2023 15:01:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] ICH9 root PCI hotplug
Message-ID: <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231115171837.18866-1-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 15 Nov 2023 17:18:53 +0000
Thierry Escande <thierry.escande@vates.tech> wrote:

> Hi,
> 
> This series fixes acpi_hotplug_bridge accessor names, adds new accessors
> for acpi-root-pci-hotplug property, and enables root PCI hotplug by
> default for Q35 machine.

hotplug on Q35 hostbridge is not implemented intentionally
to keep machine close to the real world.

PCIe spec 3.1a, 1.3.2.3. Root Complex Integrated Endpoint Rules
"
A Root Complex Integrated Endpoint may not be hot-plugged independent of the Root
Complex as a whole.
"
)

PS:
but patch 1/4 is good cleanup, pls include Reviewed-by's and resend it
as a separate patch after 8.2 has been released (so it wouldn't get lost in the traffic).

> 
> Thierry Escande (4):
>   ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
>   ich9: Renamed use_acpi_hotplug_bridge accessors
>   ich9: Add accessors for acpi-root-pci-hotplug
>   ich9: Enable root PCI hotplug by default
> 
>  hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
>  include/hw/acpi/ich9.h |  1 -
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 


