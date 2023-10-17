Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B987CC932
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnLG-0001CD-Fv; Tue, 17 Oct 2023 12:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qsnL8-0001Bj-DZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qsnL6-0007X1-Jo
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697561679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93+EZ9iT/5J5h5rDgQuIvUUaXCtYiQfX6XQBSJugr1Y=;
 b=i1WadqlrazdH1Skvr64BEKGrTCbeV+zpFdamIBO98lVD0k8jIHQ9tu6ARFK3gd0CJzYV9m
 HSEek4jkOeSBlLP8aXmPgQxCMktnmQg9/Ue/IuCnnS7PJZVlTvqatxwfnUvwa5dw8dfAJP
 dI1e8TO3Qw8cJoKfmFr8ahDCnmML5xY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-nlNS7snkOg2gJCxHguFpRQ-1; Tue, 17 Oct 2023 12:54:23 -0400
X-MC-Unique: nlNS7snkOg2gJCxHguFpRQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b2e21c06f9so711023b6e.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 09:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697561662; x=1698166462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93+EZ9iT/5J5h5rDgQuIvUUaXCtYiQfX6XQBSJugr1Y=;
 b=TIlIIjXiVje5Jrxk7eodZI4+IW3Wr7BiAM12c76OX4MVSRcSid7Af70qTvVduUgOVC
 D2h2xxV9fd3J2lx6DbiGYlyEGzODKWXHaTJsj+3sTbQddT5XkQ1UV1qn0F0sqFLdf6KT
 yqbHdGXl4/B5JqzwenImX89RSdIvZp0I+HK1zRh2rI7DY8Ap7GW7yPXMR0lwyCKT677p
 q77WNSuqnl3Tt52QbEwXOYOtRtW5Io57li6bAoputln7p3fliGaJEb03u2mvF4QfSr7o
 z58bznDPFZllJrEJ8Jd1baDHHIWFI6AkEbHV/Pluh6IgV4yH+4Czqthrb5inTAUSMpyv
 vKwQ==
X-Gm-Message-State: AOJu0YzfgcAoWH3Oo43qQw7kl63JVvATPHDNJtilP74bzgrplR+9TbMw
 7+/tCPDaVaYt2+QHV+67eYy+PGTgpY8eCuE1+ZTfppBfib135s2N6uPskJdK0ANhtWxzgg/2lb2
 jhqxZ40KooAkGVfM=
X-Received: by 2002:a05:6808:218d:b0:3a7:44da:d5e6 with SMTP id
 be13-20020a056808218d00b003a744dad5e6mr3899165oib.38.1697561662453; 
 Tue, 17 Oct 2023 09:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw/+fJ/KhFV8m5WYyP12jZXbrowA2hD4ZgxvyB4cOH2oRkISVbXHPiskZXvaRdXUAZTBhBXA==
X-Received: by 2002:a05:6808:218d:b0:3a7:44da:d5e6 with SMTP id
 be13-20020a056808218d00b003a744dad5e6mr3899132oib.38.1697561662202; 
 Tue, 17 Oct 2023 09:54:22 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 az8-20020a056638418800b00454df11c71csm590032jab.97.2023.10.17.09.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 09:54:21 -0700 (PDT)
Date: Tue, 17 Oct 2023 10:54:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "Jonathan.Cameron@huawei.com"
 <Jonathan.Cameron@huawei.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, libvir-list@redhat.com,
 Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Message-ID: <20231017105419.1469e5c9.alex.williamson@redhat.com>
In-Reply-To: <20231017152830.GC3952@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009151611.02175567.alex.williamson@redhat.com>
 <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20231017092116.09ad2737.alex.williamson@redhat.com>
 <20231017152830.GC3952@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 17 Oct 2023 12:28:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Oct 17, 2023 at 09:21:16AM -0600, Alex Williamson wrote:
> 
> > Do we therefore need some programatic means for the kernel driver to
> > expose the node configuration to userspace?  What interfaces would
> > libvirt like to see here?  Is there an opportunity that this could
> > begin to define flavors or profiles for variant devices like we have
> > types for mdev devices where the node configuration would be
> > encompassed in a device profile?   
> 
> I don't think we should shift this mess into the kernel..
> 
> We have a wide range of things now that the orchestration must do in
> order to prepare that are fairly device specific. I understand in K8S
> configurations the preference is using operators (aka user space
> drivers) to trigger these things.
> 
> Supplying a few extra qemu command line options seems minor compared
> to all the profile and provisioning work that has to happen for other
> device types.

This seems to be a growing problem for things like mlx5-vfio-pci where
there's non-trivial device configuration necessary to enable migration
support.  It's not super clear to me how those devices are actually
expected to be used in practice with that configuration burden.

Are we simply saying here that it's implicit knowledge that the
orchestration must posses that when assigning devices exactly matching
10de:2342 or 10de:2345 when bound to the nvgrace-gpu-vfio-pci driver
that 8 additional NUMA nodes should be added to the VM and an ACPI
generic initiator object created linking those additional nodes to the
assigned GPU?

Is libvirt ok with that specification or are we simply going to bubble
this up as a user problem? Thanks,

Alex


