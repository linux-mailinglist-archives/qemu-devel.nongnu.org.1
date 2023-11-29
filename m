Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 481667FDA89
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:55:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8LxR-00071R-I0; Wed, 29 Nov 2023 09:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r8LxP-00071B-KE
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:54:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r8LxO-0007CA-1O
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701269668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iwKuOdVlxbXkpX/UhIPBt4wbrz6KW/6ZKuWs65LzSI=;
 b=cE5ZynQdn9ryIFaN5hhV1/bml8CgC5963gMKQboKqn0wD0SxE0/aiRUmDP+n3m8dvhd6zE
 y299PDQcP8VLVqpXQ8tM5hr9aMlbrTH18YwTeDYNrAu/ech11MB9GbrMBkOXKJ6QHnmClX
 oc+wqxGyILtgdyAfosjFsFl/qSV83qs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-wk_yVqp8NeS6nQNzawZTag-1; Wed, 29 Nov 2023 09:54:27 -0500
X-MC-Unique: wk_yVqp8NeS6nQNzawZTag-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a04b426b3c0so151356766b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269665; x=1701874465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iwKuOdVlxbXkpX/UhIPBt4wbrz6KW/6ZKuWs65LzSI=;
 b=pAvVJjUALRF1hNZKG0+i1RhAQC82z6W9K0lvyCUrwPPvL0EMPgbYDDeyIm7+OovQsB
 0tXzJl8YbuVfbjHHTFhJKVybnhMLWgbYM32Pb8+b8cw+Gw8KoS5lEFX8KLvDdhTtcm/b
 jFPT5urgUip41m5zSrtsbMlkiehtRoqHXbcrgx+KIcsSMSo1sU9BhOEEByAr54Hkqtjx
 UVP86bUryOrkr0X3wDK8XxSs5NItEFP3yEsaFXJvNE84fL9e6x/JppY5oVTWJLIx9xla
 oP7dUi9skOF374GfzZMzbRXmjeShKAyvLO037kZGQOlZbqepzu41UFLkRA0sOKj72iUV
 ea9Q==
X-Gm-Message-State: AOJu0Yxv03vjRkuEnRVoARbij2fscPmyIFiRoE50vTHyKwBU6Vniyngw
 wWB6OzGotraWH/cBB8vwU2CPS+3mnJ05BZP4rmUCv2I9R4ngPsP/4jYnrYfwh7asmFn5bXotKNX
 DWXh+NqEkn6cUZSwlbhG6uac=
X-Received: by 2002:a17:906:15:b0:9f2:859f:713e with SMTP id
 21-20020a170906001500b009f2859f713emr14972582eja.3.1701269665740; 
 Wed, 29 Nov 2023 06:54:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1BSpRCWdSnUaN1u4Q0zV0pKjPzqjOyFsEF8f+kskFtV1gx1RRlw6dYqFcfxVOJ2ibKaMXeQ==
X-Received: by 2002:a17:906:15:b0:9f2:859f:713e with SMTP id
 21-20020a170906001500b009f2859f713emr14972568eja.3.1701269665468; 
 Wed, 29 Nov 2023 06:54:25 -0800 (PST)
Received: from redhat.com ([2.55.57.48]) by smtp.gmail.com with ESMTPSA id
 ck16-20020a170906c45000b00a0029289961sm7957928ejb.190.2023.11.29.06.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 06:54:24 -0800 (PST)
Date: Wed, 29 Nov 2023 09:54:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thierry Escande <thierry.escande@vates.tech>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] ICH9 root PCI hotplug
Message-ID: <20231129095400-mutt-send-email-mst@kernel.org>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
 <20231124094535-mutt-send-email-mst@kernel.org>
 <be4f338c-7b9e-4bc9-9092-01473ae24548@vates.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be4f338c-7b9e-4bc9-9092-01473ae24548@vates.tech>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Nov 29, 2023 at 09:47:13AM +0000, Thierry Escande wrote:
> On 24/11/2023 15:54, Michael S. Tsirkin wrote:
> > On Fri, Nov 24, 2023 at 03:01:35PM +0100, Igor Mammedov wrote:
> > > On Wed, 15 Nov 2023 17:18:53 +0000
> > > Thierry Escande <thierry.escande@vates.tech> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > This series fixes acpi_hotplug_bridge accessor names, adds new accessors
> > > > for acpi-root-pci-hotplug property, and enables root PCI hotplug by
> > > > default for Q35 machine.
> > > 
> > > hotplug on Q35 hostbridge is not implemented intentionally
> > > to keep machine close to the real world.
> > 
> > > PCIe spec 3.1a, 1.3.2.3. Root Complex Integrated Endpoint Rules
> > > "
> > > A Root Complex Integrated Endpoint may not be hot-plugged independent of the Root
> > > Complex as a whole.
> > > "
> > > )
> > 
> > To be more precise close to native hotplug.
> > But we used ACPI for several years now and it seems to be fine.
> > Maybe it's time we lifted the limitation?
> 
> And for what it's worth, lifting this limitation would allow PCIe devices
> passthrough on Q35 VMs with Xen as such devices are hotplugged.


More motivation in the commit log would be a good idea here.

> > 
> > 
> > > 
> > > PS:
> > > but patch 1/4 is good cleanup, pls include Reviewed-by's and resend it
> > > as a separate patch after 8.2 has been released (so it wouldn't get lost in the traffic).
> > > 
> > > > 
> > > > Thierry Escande (4):
> > > >    ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
> > > >    ich9: Renamed use_acpi_hotplug_bridge accessors
> > > >    ich9: Add accessors for acpi-root-pci-hotplug
> > > >    ich9: Enable root PCI hotplug by default
> > > > 
> > > >   hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
> > > >   include/hw/acpi/ich9.h |  1 -
> > > >   2 files changed, 21 insertions(+), 3 deletions(-)
> > > > 
> > 


