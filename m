Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3916C7F76FF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:55:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6XaB-0002jH-Jy; Fri, 24 Nov 2023 09:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Xa7-0002fi-Nk
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:54:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Xa6-0004VE-87
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700837697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shRx/7FsxFJHcJIh5WYh8+A5VNEocTTLy3f+nN5Cntk=;
 b=Kv+jFCZJoicQ2Icp6cbEd3LOEZuGSGXqkYrGB7vd1Y9EMtnme7k33/YmVJOiXBH2mr9fPH
 U/Xsq6wAvF7c4qChmYAFprcNY45PStb8yClVy8yusBv/POoI1bDsprIfU+ARTqwo0JfNPY
 klIIybLMEyHBK5oYhhEicnPhh0y6KgI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-D7_e0qd4Pt6b4VrKi9epig-1; Fri, 24 Nov 2023 09:54:55 -0500
X-MC-Unique: D7_e0qd4Pt6b4VrKi9epig-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9fd0a58549bso226967766b.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 06:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700837695; x=1701442495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=shRx/7FsxFJHcJIh5WYh8+A5VNEocTTLy3f+nN5Cntk=;
 b=PWGxbG7IQ2gj5mayrcX/niF9wza0ertlERptiMj6CsDNPX+YC9H2HOYbUuZ4213mHQ
 yBdOGKguPcoF8cZP4mREVdZ8iXbBokmDzMoAJb7qyrJKMaFJ+7MAlin71fzWZaG6ckan
 ln/94PH67hHkCn1uFt6v6mDdGSHEwzpQM45Zdg2va9cc5yrkstC+WlHuIQl5/yaW6R9A
 YFMZh4IEf0mKtQxfKhra7CKhb22q6yZRHRZJdMIvdOPJQKajnuFG6tl9lAartofPQnDy
 dbcQMO4xFN1j80PYoVRwN6p26ALBlI18qANotXIpW6ae7a1sxu44IkZU0Zx/AJfjkYZm
 oVGQ==
X-Gm-Message-State: AOJu0YyDiel8J6J6776Iu02rhmmjWkmg7doV5BawJ0Uv5dMlT890fYzv
 6UOQ9hN59At/L1SvLhZoUr7K2Wm4bsgUX8h7rKHQ/l4dczgYv9eg509kttE1OZglvFA6A1NayOZ
 dEcJY4tOX4kH8Dzw=
X-Received: by 2002:a17:907:920f:b0:a02:b9c2:87bb with SMTP id
 ka15-20020a170907920f00b00a02b9c287bbmr2585603ejb.15.1700837694759; 
 Fri, 24 Nov 2023 06:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESdgsaZJypIAATbbodCXJZj6VsGrTRJrvjLXFei+9p/Nnsx5r15F0MDtHqPMh5T1cr1SVa8w==
X-Received: by 2002:a17:907:920f:b0:a02:b9c2:87bb with SMTP id
 ka15-20020a170907920f00b00a02b9c287bbmr2585590ejb.15.1700837694422; 
 Fri, 24 Nov 2023 06:54:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:176:51e5:39df:4b3f:fe7:3d4e])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a1709062b5800b009fcd13bbd72sm2143505ejg.214.2023.11.24.06.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 06:54:53 -0800 (PST)
Date: Fri, 24 Nov 2023 09:54:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thierry Escande <thierry.escande@vates.tech>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 0/4] ICH9 root PCI hotplug
Message-ID: <20231124094535-mutt-send-email-mst@kernel.org>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
 <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150135.0b99deeb@imammedo.users.ipa.redhat.com>
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

On Fri, Nov 24, 2023 at 03:01:35PM +0100, Igor Mammedov wrote:
> On Wed, 15 Nov 2023 17:18:53 +0000
> Thierry Escande <thierry.escande@vates.tech> wrote:
> 
> > Hi,
> > 
> > This series fixes acpi_hotplug_bridge accessor names, adds new accessors
> > for acpi-root-pci-hotplug property, and enables root PCI hotplug by
> > default for Q35 machine.
> 
> hotplug on Q35 hostbridge is not implemented intentionally
> to keep machine close to the real world.

> PCIe spec 3.1a, 1.3.2.3. Root Complex Integrated Endpoint Rules
> "
> A Root Complex Integrated Endpoint may not be hot-plugged independent of the Root
> Complex as a whole.
> "
> )

To be more precise close to native hotplug.
But we used ACPI for several years now and it seems to be fine.
Maybe it's time we lifted the limitation?


> 
> PS:
> but patch 1/4 is good cleanup, pls include Reviewed-by's and resend it
> as a separate patch after 8.2 has been released (so it wouldn't get lost in the traffic).
> 
> > 
> > Thierry Escande (4):
> >   ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
> >   ich9: Renamed use_acpi_hotplug_bridge accessors
> >   ich9: Add accessors for acpi-root-pci-hotplug
> >   ich9: Enable root PCI hotplug by default
> > 
> >  hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
> >  include/hw/acpi/ich9.h |  1 -
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> > 


