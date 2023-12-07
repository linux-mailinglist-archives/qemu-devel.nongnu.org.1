Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73635808E2F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 18:06:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBHnr-0002lG-HW; Thu, 07 Dec 2023 12:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rBHnY-0002kN-1J
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 12:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rBHnV-0001kZ-Oo
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 12:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701968662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=virVGvujPxdDPQ4D6DV19C9LWUv2t7VGmK6Uqy7k3PA=;
 b=MvjOSMBy5SeHSsu51Rtz8MJKE/cnDntsXicMMosVJ8qGwe7/VZM3U/0PAsK8dxnxiSwe51
 u0hjgf22w1qQ50D6y8XTTUm9gxzpOdu4sb2fkQJDgWR9N7t2MW0k4rJqdZS5d8z8lo8Aml
 toT6JX+WMGJOKaIqYv0gnEQJ6PTabTY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-6-ldZDRqMnS00vsCbUDpPA-1; Thu, 07 Dec 2023 12:04:20 -0500
X-MC-Unique: 6-ldZDRqMnS00vsCbUDpPA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a1cba77ef87so59692766b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701968659; x=1702573459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=virVGvujPxdDPQ4D6DV19C9LWUv2t7VGmK6Uqy7k3PA=;
 b=A8g62XA+PLjkd5Ru98UME6LY0btbwzS9YMXCVapPUchoK6alftZg/1GnLasSWJOQJj
 pFmby+923j5/0d1/i544/Qm8N2iFoizY7QEOEvUiQQTIAzaoD0m7bPBYX2CXTJqcCf7u
 3Oj8ZsH2p4DLBpr1USV3Dom7hbftpv0x9jpFhNDq7ymY1idmAC/+ncYbBXQV9bXKO/bK
 DbXXKPczWDYLfCFAL1TPPeJ3mo/n5xgU3KlJInr3JR723Bq0yiQdn5K+tU2Tgp/VbIN0
 cyoIc6jj/j00ormiKDSQj5hE1fHIm737Hct7x21QEaqQkXTrerTqLbgCSgL/bLUjyFAK
 q0rQ==
X-Gm-Message-State: AOJu0YyQ/KFDOT8/rNLgSG1Ga0RmerJWbPzKi3GQ+Uls8rv4Ur62JAz2
 JuDeVZTHfvjPjdADYcApXsCYQC0tJrR2yTH2yv/gETSfKcPRuwYZxapmzlhXAG1ummhpmSG2Qfv
 k6N+BRibsazdNB3E=
X-Received: by 2002:a17:906:9c17:b0:a19:a19b:78a2 with SMTP id
 ff23-20020a1709069c1700b00a19a19b78a2mr1296412ejc.101.1701968659068; 
 Thu, 07 Dec 2023 09:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHseUlVt+SaBAr/lHZdxstA6myqLXZLbI1JQH9f4ZNj0OqHzY20ZI8vxFBvXJw+kGBdiUUjUQ==
X-Received: by 2002:a17:906:9c17:b0:a19:a19b:78a2 with SMTP id
 ff23-20020a1709069c1700b00a19a19b78a2mr1296407ejc.101.1701968658794; 
 Thu, 07 Dec 2023 09:04:18 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 o24-20020a17090611d800b00a1d6591304esm1041971eja.133.2023.12.07.09.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 09:04:18 -0800 (PST)
Date: Thu, 7 Dec 2023 18:04:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] ICH9 root PCI hotplug
Message-ID: <20231207180416.26ee1f4b@imammedo.users.ipa.redhat.com>
In-Reply-To: <be4f338c-7b9e-4bc9-9092-01473ae24548@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
 <20231124094535-mutt-send-email-mst@kernel.org>
 <be4f338c-7b9e-4bc9-9092-01473ae24548@vates.tech>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, 29 Nov 2023 09:47:13 +0000
Thierry Escande <thierry.escande@vates.tech> wrote:

> On 24/11/2023 15:54, Michael S. Tsirkin wrote:
> > On Fri, Nov 24, 2023 at 03:01:35PM +0100, Igor Mammedov wrote:  
> >> On Wed, 15 Nov 2023 17:18:53 +0000
> >> Thierry Escande <thierry.escande@vates.tech> wrote:
> >>  
> >>> Hi,
> >>>
> >>> This series fixes acpi_hotplug_bridge accessor names, adds new accessors
> >>> for acpi-root-pci-hotplug property, and enables root PCI hotplug by
> >>> default for Q35 machine.  
> >>
> >> hotplug on Q35 hostbridge is not implemented intentionally
> >> to keep machine close to the real world.  
> >   
> >> PCIe spec 3.1a, 1.3.2.3. Root Complex Integrated Endpoint Rules
> >> "
> >> A Root Complex Integrated Endpoint may not be hot-plugged independent of the Root
> >> Complex as a whole.
> >> "
> >> )  
> > 
> > To be more precise close to native hotplug.
> > But we used ACPI for several years now and it seems to be fine.
> > Maybe it's time we lifted the limitation?  

Pardon me for being conservative, but adding ACPI PCI hotplug to
PCIe hostbridge complicates its maintenance not to mention that
on guest side it likely to cause issues as well (since it's
architecturally not possible).

I've grudgingly accepted ACPI hotplug on Q35 root-ports/bridges
(since it possible for them to support hotplug in principle
(aka guest OSes account somewhat for that)), and even that wasn't
smooth ride despite of it working on PC machine for ages.
I'd expect more issues to pop up in case of PCIe hostbridge.

This why I dislike the idea very much.

For those who are desperate there is PC machine which supports
hotplug to root bus. For Q35 one can use root-ports for that.

Anyways, it's up to you.

> And for what it's worth, lifting this limitation would allow PCIe 
> devices passthrough on Q35 VMs with Xen as such devices are hotplugged.

maybe ask Xen folks to fix their impl. and make it work with root-ports
like the rest of the world or at least provide a very good justification
why they aren't able to that.

   
> >>
> >> PS:
> >> but patch 1/4 is good cleanup, pls include Reviewed-by's and resend it
> >> as a separate patch after 8.2 has been released (so it wouldn't get lost in the traffic).
> >>  
> >>>
> >>> Thierry Escande (4):
> >>>    ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
> >>>    ich9: Renamed use_acpi_hotplug_bridge accessors
> >>>    ich9: Add accessors for acpi-root-pci-hotplug
> >>>    ich9: Enable root PCI hotplug by default
> >>>
> >>>   hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
> >>>   include/hw/acpi/ich9.h |  1 -
> >>>   2 files changed, 21 insertions(+), 3 deletions(-)
> >>>  
> >  
> 


