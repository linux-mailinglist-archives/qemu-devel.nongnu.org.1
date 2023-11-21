Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD87F34E6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:24:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5USq-0007jL-Ji; Tue, 21 Nov 2023 12:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5USn-0007bU-5l
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r5USl-0005v8-Ia
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700587382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bokMPfUk8jl9OgaaGiKFlHq408lW43c1+ri6A/vsN8I=;
 b=GIT0F1BhOlIZj6qk8wiPkDP1yt286XpSTD6Pjsx8UQjg1pYM/u+wKXZR5r5c9/6kCqu6qN
 4N6YVnnBSEf76uFJV07n4CHCEkjwy+XiAPsqbW7YXwzq4X4zz9OOHsI4u+BVQywaBYLK35
 2MdcAe7W7D7zaFpXyqirCGOf2lj7xPo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-7lEpXrDnO3m_s0AGROcgZw-1; Tue, 21 Nov 2023 12:23:00 -0500
X-MC-Unique: 7lEpXrDnO3m_s0AGROcgZw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77d5f56155bso48396085a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700587380; x=1701192180;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bokMPfUk8jl9OgaaGiKFlHq408lW43c1+ri6A/vsN8I=;
 b=LmBToPp3hU9GV/0NGNHQ4bocq3NYs8oHVCRr9fLa6NeB9ESvViSqPc+4wNQxiLZxjn
 SkSbb5dXWZdY0Nf2piRQlp1jvabBmG0uuMU+2o3sUs9dSTyiU9w82ol0MNN3HOh3llAw
 WkmCOz4RecEahrB9p+IQDrJV7M1VA6ERUUgaTFCeDErRf0mTHWoOvVFZ5J8pc3pWMPyi
 sx3/0VIU0S+WPJ9YCt28MGqkLmvsRGHfMXuj0ux39VESKpu7iGF1XNW8PB69HstnKEHc
 2mkYJumF2eKO8qZtTuDYh+Hx9YXe4NqRCIFvEX2gc3hitG+l0C+UpX/eOsjtYeXXwGAy
 zI/A==
X-Gm-Message-State: AOJu0Yz73B4UNecrSsYgKVj0e3slAiE12SrceXGoaj6aOCrljzsbT6Ii
 mYUovxuJyng7CWGcz7NZ+7pDlFbVjR7doRj59sx7iaEZuU2ufvcTqkYo6MI8urMrSFvicSod3Sx
 F5lnFt1RpJUQExAc=
X-Received: by 2002:a37:de0d:0:b0:775:446b:85fa with SMTP id
 h13-20020a37de0d000000b00775446b85famr10342869qkj.3.1700587380300; 
 Tue, 21 Nov 2023 09:23:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3MlLKHQX8SpXj8QQakrKKnSaqfLLG0mqRMrYlrfrKE7el0M9KkwcYWYS9Ym66hp+Tpvf1zQ==
X-Received: by 2002:a37:de0d:0:b0:775:446b:85fa with SMTP id
 h13-20020a37de0d000000b00775446b85famr10342858qkj.3.1700587380046; 
 Tue, 21 Nov 2023 09:23:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x10-20020ae9f80a000000b00767d8e12ce3sm3772523qkh.49.2023.11.21.09.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 09:22:59 -0800 (PST)
Message-ID: <182862f2-d339-4cba-aacf-bab06868272c@redhat.com>
Date: Tue, 21 Nov 2023 18:22:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Zhenzhong

On 11/21/23 09:43, Zhenzhong Duan wrote:
> Hi,
> 
> Thanks all for giving guides and comments on previous series, this is
> the remaining part of the iommufd support.
> 
> Besides suggested changes in v6, I'd like to highlight two changes
> for final review:
> 1. Instantiate can_be_deleted callback to fix race where iommufd object
>     can be deleted before vfio device
> 2. After careful re-thinking, I'd like to follow Nicolin's suggestion in v5,
>     remove is_ioas check which indeed looks heavy just for tracepoint.
>     In fact we can get corresponding info by looking over trace context.
> 
> PATCH 1: Introduce iommufd object
> PATCH 2-9: add IOMMUFD container and cdev support
> PATCH 10-17: fd passing for cdev and linking to IOMMUFD
> PATCH 18: make VFIOContainerBase parameter const
> PATCH 19-21: Compile out for IOMMUFD for arm, s390x and x86
> PATCH 22-26: vfio device init code cleanup
> PATCH 27: add iommufd doc
> 
> 
> We have done wide test with different combinations, e.g:
> - PCI device were tested
> - FD passing and hot reset with some trick.
> - device hotplug test with legacy and iommufd backends
> - with or without vIOMMU for legacy and iommufd backends
> - divices linked to different iommufds
> - VFIO migration with a E800 net card(no dirty sync support) passthrough
> - platform, ccw and ap were only compile-tested due to environment limit
> - test mdev pass through with mtty and mix with real device and different BE
> - test iommufd object hotplug/unplug and mix with vfio device plug/unplug
> 
> Given some iommufd kernel limitations, the iommufd backend is
> not yet fully on par with the legacy backend w.r.t. features like:
> - p2p mappings (you will see related error traces)
> - dirty page sync
> - and etc.
> 
> 
> qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v7
> Based on vfio-next, commit id: c487fb8a50

The series is pushed on top of vfio-next in the vfio-8.2 tree :

   https://github.com/legoater/qemu/commits/vfio-8.2

with a little extra to deal with a PPC build failure.

Thanks,

C.



