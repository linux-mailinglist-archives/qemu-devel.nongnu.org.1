Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA57B17C6C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 07:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiXV-0007IX-Qx; Fri, 01 Aug 2025 01:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhiXS-0007Ep-8C
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 01:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhiXO-0000lN-Rn
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 01:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754026956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pXHAEqIJWKSVTo9LOlc/Y6cVjw4FKfVXBFLOyAvFc98=;
 b=BllbhpETeit8zQYQnGdSpo1Wcq6jyakiu+dKbcnrZxPT+7so+k8oKxCGuGGBShLZWR4gVO
 YNmytWkpox0FqyllYee/G/GJG6gDY8a8QqZx4n4rY8W2Vp7984z66kYT1xZm38eT6sN4bJ
 8wKF5LebCOBAHuF47PiUTAPPZch/mIg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-qwD1xyRJPLa6YXrZF5ZHyA-1; Fri, 01 Aug 2025 01:42:35 -0400
X-MC-Unique: qwD1xyRJPLa6YXrZF5ZHyA-1
X-Mimecast-MFC-AGG-ID: qwD1xyRJPLa6YXrZF5ZHyA_1754026954
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4588cfda8b6so7766505e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 22:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754026954; x=1754631754;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pXHAEqIJWKSVTo9LOlc/Y6cVjw4FKfVXBFLOyAvFc98=;
 b=j7zoKhcQhcHCdXVXTpF84k8RsWpydnWSlcaJTEdkIRPaUFzUwxd1O4EUsytLQqwocn
 N9iRtB0Mch3lVvgR1XcYT+tmhuqf9bhs4a4T8Fmw2QWyCm+dI1lsV6TaBA7UIKUnbvrf
 VPPRcOOQnutnVhMpNj3WB7gvVJUkPx0jDfu3O12itK1stHdBo2/cojA4DQ16PzLO6sIw
 PZ37rV2iflHyhaRdAIVSkQifFGSI2wZ//v/Yj4zhLo5NF8ZF0MoeagWIC06CI/ondp6R
 L4FIjBuVPqHWcEdzOoGFDTgTghNgCSR4ZEoIIdyNLOFoMt5+rm/LqUZvWj8+7/akZVqX
 kgUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpa65gw5x77wmvfnIFnm7Y/HQpxiJohA3yaxQyYiKSuQaxdkpxW/qg8gm2k5/WA9Rr6BbZqMbgpJkd@nongnu.org
X-Gm-Message-State: AOJu0YxeTDWVGFoCfpPUKF/CK+yLY/woDthxnmOGPhSlJ4oKbHhmVFmK
 Y+F04Vtjvs3j5jSE1v2HUPyJ09POXKeDPFe/gr2CiCzB5qmRwtxyV1xN6OQAohM4VNrD1DBY1QC
 QrShOwM2GQVdRdsdYAInAz1aijg8ozCKaW2zPxg0EQOFVaCwOl7OJzjG4
X-Gm-Gg: ASbGncsUEU32vSboGRjfR+b2CZe+G8XqWHVWaJRuU15qxk5g68e6tOt2EeirUGT3TTn
 t4C3RBoOrtYILAdosy6jOM744XUJxZg7HtoydJoJcquJJ/GN53ellWlOupUjPRo50M5lp8rIZr9
 gBCvHD7oE9ajImdqWER3qMPe3AH3X7McKUoeYqJcYqLJg8+N+1aluP7OaOFBZCC2JnRpnRMctYh
 Twk1QYl5mxTbYcd2cIea2r6mm5sehpU0q3urN6wXjDOkdos3QPI57dZXV6EIfxIQCZqXwBjOwSP
 KUGvVvjeC6GnkjOkGJDnT+Ux1ao+E4qCOW3Wv6hrsPkqvNyVaCU/BAKhSCZ2y2CCE80qHto7OKs
 criJMAYM=
X-Received: by 2002:a05:600c:4f4e:b0:456:13d8:d141 with SMTP id
 5b1f17b1804b1-458aa45b11bmr7196415e9.27.1754026954241; 
 Thu, 31 Jul 2025 22:42:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQDbJCx6ndABuvhly1ihx7RkoEG3splvvpF3hURqrV4jyBb0ORJTKM/mRs8vALr1gh4scFAA==
X-Received: by 2002:a05:600c:4f4e:b0:456:13d8:d141 with SMTP id
 5b1f17b1804b1-458aa45b11bmr7196245e9.27.1754026953828; 
 Thu, 31 Jul 2025 22:42:33 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45895377956sm89011865e9.10.2025.07.31.22.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 22:42:33 -0700 (PDT)
Message-ID: <8b599c19-1901-4707-a8ca-943f61c0e2f9@redhat.com>
Date: Fri, 1 Aug 2025 07:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/1/25 04:35, Zhenzhong Duan wrote:
> Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
> to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v3: add one line comment to the helper
> v2: move helper to hw/vfio/pci.[hc]
>      rename with vfio_pci_ prefix
> 
>   hw/vfio/pci.h       | 1 +
>   hw/vfio/container.c | 4 ++--
>   hw/vfio/device.c    | 2 +-
>   hw/vfio/iommufd.c   | 4 ++--
>   hw/vfio/listener.c  | 4 ++--
>   hw/vfio/pci.c       | 9 +++++++++
>   6 files changed, 17 insertions(+), 7 deletions(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




