Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B936D81A5E3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 18:03:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzwL-0002k7-PC; Wed, 20 Dec 2023 12:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rFzwJ-0002jI-HV
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rFzwH-0004iL-5w
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 12:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703091655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XgX3Rf4sz5ywh+qXmYlDf6NYOAg7lm+f4m7Yn3NAwHc=;
 b=ZIuBpo/0iKbZb8a0RMARL1W5a1XQpSuhMqm5Apb6ljDcZFIfqlX+VC9H5JKceUG4s/K41U
 8A9AE6ivU7RjbDSTx8D3iW3gvps7OYFnHc7I+kvqTPqdOcHRRFSk4xPQ7B3chlJSShOJXr
 DgaguirijRs/vrDXPrjZTUiHHjUeKHU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-8RwM03RAN56YtjrhtJelJg-1; Wed, 20 Dec 2023 12:00:54 -0500
X-MC-Unique: 8RwM03RAN56YtjrhtJelJg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d38c09797so3944595e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 09:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703091652; x=1703696452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XgX3Rf4sz5ywh+qXmYlDf6NYOAg7lm+f4m7Yn3NAwHc=;
 b=nlBv5vtktMCKWXlTM1eWc0CeAQsy3yTM86ZpQsWwXfJ9EitJsA16Kru8lz5S9BeUjS
 VCIQl1liQc0R6LLds4qeMCkAcmnbjun+kKeHTSyZa6FoICJsBdKIAvQaZmLUcaCDkufp
 RMTv1PxR1E8OoKMDDe0kLIhY2kWHzAB1Uo+JU6Rfu6Ky5fDz8vHypaucNHxgLyXQSJAS
 Gb1bkhoQ2n+4Rnm5QxGQtfPv98pIBcxV96hVU41a4fhmnaiQENaW/d7Mrzr7zB+sZqjm
 GDt/1MJthASlhWNA8K8LXPetl8oxR3od1x5d/NofNhfJCwRVovmn0lTN0zzjhuFhXs97
 4g6A==
X-Gm-Message-State: AOJu0YzcQGNHrARuJe2sdypGVtriGmbzsqcxbUkfZeQRek2qrFEoO9nu
 GKIi+NMDg1z1EibCdpcWmHhi9g9oETdra+RDWoVRuDqUKMZZsHHKIjb14zXQubxP9LwJD40wdfQ
 4FlJZjH4MvlMqfM+pwnrXFnoNvb1JET8jRiAioNrpSmMrdk4Q5jItWPUnIhg6qrhmydRt
X-Received: by 2002:a05:600c:4f05:b0:40b:5e59:ccdb with SMTP id
 l5-20020a05600c4f0500b0040b5e59ccdbmr11794361wmq.188.1703091652283; 
 Wed, 20 Dec 2023 09:00:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGsQ0PAbErWYx5/yqzd+s/ExXixuwMKJi/Swzt2BhmTtfDQyqrk0K9phmZh2b+M9LHpdnOqg==
X-Received: by 2002:a05:600c:4f05:b0:40b:5e59:ccdb with SMTP id
 l5-20020a05600c4f0500b0040b5e59ccdbmr11794335wmq.188.1703091651819; 
 Wed, 20 Dec 2023 09:00:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 be8-20020a05600c1e8800b0040b397787d3sm8439587wmb.24.2023.12.20.09.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 09:00:49 -0800 (PST)
Message-ID: <13b401e7-bb3b-48f8-8e52-5e47c1fd07a0@redhat.com>
Date: Wed, 20 Dec 2023 18:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v2 00/10] vfio: Introduce a VFIOIOMMUClass
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231219065825.613767-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231219065825.613767-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

On 12/19/23 07:58, Cédric Le Goater wrote:
> Hello,
> 
> The VFIO object hierarchy has some constraints because each VFIO type
> has a dual nature: a VFIO nature for passthrough support and a bus
> nature (PCI, AP, CCW, Platform) for its initial presentation. It
> seemed the best approach made because multi-inheritance is not
> feasible with QOM and both aspect of the VFIO object, passthrough and
> bus, require state. A QOM interface in that case is not sufficient.
> 
> One aspect of passthrough is interaction with the IOMMU. IOMMUFD
> support was recently added and for this purpose, we introduced an
> IOMMU backend framework simply based on a VFIOIOMMUOps struct. We
> didn't want to use QOM again because it would have exposed the various
> lowlevel backend objects to the QEMU machine and human interface which
> felt unnecessary at the time.
> 
> The changes of this series introduce a VFIO_IOMMU QOM interface and
> its VFIOIOMMUClass to replace the current VFIOIOMMUOps. This provides
> better code abstraction for the type1 and sPAPR IOMMU backends and
> allows us to improve the vfio_connect_container() implementation.
> Also, QOM interfaces are not exposed at the QEMU interface level. Most
> important, we can now avoid compiling the sPAPR IOMMU support on
> targets not needing it. This saves some text in QEMU.


Applied to vfio-next.

Thanks,

C.




