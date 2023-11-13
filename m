Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70B7E9E78
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2XmK-0001Oz-U8; Mon, 13 Nov 2023 09:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r2XmI-0001OF-Bs
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r2XmG-0005sv-87
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699885139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EPcpKTmJVzz9Ua0aei3X5567vdP+v2aBOZLO9axf1PM=;
 b=iYYlR4MkmNZKHdc12ofg3AZE27DOoVnyrL4sH7E8olzxl2Ci//+AuiIPrR8olrYw3loGmQ
 sD5+7aa346wTZCAhAiP+1iLHTJSKEYGEJgehijycpKP0GaFcMa8OrjDIb9ubBX5baCVfVR
 jaO/sC3V2c7D7b0ETOpZ7ngpmIn5iDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-BzHGw333OGy9hm-LiDUFaQ-1; Mon, 13 Nov 2023 09:18:57 -0500
X-MC-Unique: BzHGw333OGy9hm-LiDUFaQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40a4c765d3bso8853575e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 06:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699885136; x=1700489936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPcpKTmJVzz9Ua0aei3X5567vdP+v2aBOZLO9axf1PM=;
 b=hUZefN1A1vrph2FlpMbXvz7rM7MzqSWypAZW2+TMzUQLnZDvSGKwMtQjGGUW0zg10h
 JWExnbz9/23zjFSWMLhjSO1dFdOUrUCkGDjqyv7d2OB1p8NdXvtIgPxVIurpymAbaNsy
 7MNwAdlnsww0+AXuWPgLHZqug0yAT6+tvRTpwrKwEFkBA4Uh7kDgOfKgp3ykZSV2sDgf
 HkSQ7Aou0zCaRIoZTp/8UEyqUhjux4eKe/4Bhzx51qE1U9s2V+1aTzUaJ6+SETHczlDJ
 62D99OQye7c7d6Bhywc6gXZdKEfjvWpwktImdwI+Ugqb4QOQZwQuwTVm3fSs3HPhsPeH
 O5Pw==
X-Gm-Message-State: AOJu0YzL0kQ2dv1CIlFZ9DPYGsTiqOaIeWafYUxAUuJbZvwB+TkZ4udu
 Dxvm1GRvFZPzGcyjQtvIkUhPYMZS7UnFB1t+kT766mGY1Wr6Nm8Ah2QBq0nKokRJXytwCrALCb9
 7uRMO20n5xceI+4k=
X-Received: by 2002:a05:600c:3b17:b0:408:3634:b81e with SMTP id
 m23-20020a05600c3b1700b004083634b81emr5849716wms.13.1699885136330; 
 Mon, 13 Nov 2023 06:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH05zD9LoXxpO+m7IktAxsXtPfy4rJwPSyxsbpfF9Zob1TsY+uhdvKtiPIPES3kMgC9gY+bfw==
X-Received: by 2002:a05:600c:3b17:b0:408:3634:b81e with SMTP id
 m23-20020a05600c3b1700b004083634b81emr5849681wms.13.1699885135990; 
 Mon, 13 Nov 2023 06:18:55 -0800 (PST)
Received: from redhat.com ([2a06:c701:73f2:e100:f288:9238:4f0d:83ab])
 by smtp.gmail.com with ESMTPSA id
 p41-20020a05600c1da900b00406408dc788sm14151733wms.44.2023.11.13.06.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 06:18:55 -0800 (PST)
Date: Mon, 13 Nov 2023 09:18:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20231113091756-mutt-send-email-mst@kernel.org>
References: <20231107190039.19434-1-ankita@nvidia.com>
 <20231107190039.19434-3-ankita@nvidia.com>
 <20231107172318-mutt-send-email-mst@kernel.org>
 <BY5PR12MB376329341A19E4FA1B5B63FDB0AFA@BY5PR12MB3763.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB376329341A19E4FA1B5B63FDB0AFA@BY5PR12MB3763.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Nov 13, 2023 at 11:14:00AM +0000, Ankit Agrawal wrote:
> > It also looks like this support just silently fails if the device
> > string isn't the right type or isn't found.  That's not good.  Should
> > the previous patch validate the device where the Error return is more
> > readily available rather than only doing a strdup there?  Maybe then we
> > should store the object there rather than a char buffer.
> 
> AFAIU in a normal flow currently, a qemu -object is (parsed and) created much
> earlier that a -device. This complicates the situation as when the
> acpi-generic-initiator object is being created, the device is not available for
> error check. Maybe I should treat this object specially to create much later?
> 
> > Don't we also still need to enforce that the device is not hotpluggable
> > since we're tying it to this fixed ACPI object?  That was implicit when
> > previously testing for the non-hotpluggable vfio-pci device type, but
> > should rely on something like device_get_hotpluggable() now.
> 
> I think this will be similarly problematic as above due to the sequence of
> object creation.
> 
> > Also the ACPI Generic Initiator supports either a PCI or ACPI device
> > handle, where we're only adding PCI support here.  What do we want ACPI
> > device support to look like?  Is it sufficient that device= only
> > accepts a PCI device now and fails on anything else and would later be
> > updated to accept an ACPI device or should the object have different
> > entry points, ex. pci_dev = vs acpi_dev= where it might later be
> > introspected whether ACPI device support exists?
> 
> I am fine with either way. If we prefer different entry points, I can make the
> change.


Not the expert on QOM. Hope one of QOM maintainers can answer.


