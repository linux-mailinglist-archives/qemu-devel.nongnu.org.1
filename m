Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3507BEF94F
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Oct 2025 09:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjyV-0002xZ-2U; Mon, 20 Oct 2025 03:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjyQ-0002vK-EH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vAjyN-0005Ph-Cg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760943986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ai/yShZHk+riMx1f0kiK5SfADJKfTagkY4WhzydwFgQ=;
 b=UAd+V81IzcLGCw2woRHL/W9OP+d0skREVOQMowxsqJnzZME1vCjyZvgaifB1T5vv5gnUfG
 L1Suh6bZm/tmd0BDqQEmCxA/9UQ247I/Ze3fcsMZFuKjZkrae/FgFqa7yX8GsPK4zvRFi+
 ftV6WGvqYiesT9GvrZc7rNtOgj4QE1c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-eKosTEdrM2mwX9cBt056vg-1; Mon, 20 Oct 2025 03:06:24 -0400
X-MC-Unique: eKosTEdrM2mwX9cBt056vg-1
X-Mimecast-MFC-AGG-ID: eKosTEdrM2mwX9cBt056vg_1760943983
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so4902562f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 00:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760943983; x=1761548783;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ai/yShZHk+riMx1f0kiK5SfADJKfTagkY4WhzydwFgQ=;
 b=Deigj5+5yFALjwIa1Ig5QkHx/IyB9mPMfsOhzxYR9ETRV0zo/PW7D7jdGNkmqf7MpF
 lxHphcAlPTFsmEya299AaYUwqRdveuFE8yGW8jUmsHgTcZVQK0CjQuh9bD6lrzfr8NDJ
 xtplMEydi51OjAF02ZgZ0GxuCyCbGg0uaYVu2CuQA9oNhhc/Vb1EFbN+UB9Ve+U4zK0I
 TOc1o6nz2BK65EYsxrY78Ue47ZBUYPC8PX15scG/daM+P5cQL1KO8Q6hovkOLMw76bH3
 FktCuFtcxOIPzbHoSCBCGj7+AVUKyVSD+Dl1PwF7ng8FX6sgGMj8KZB1NW9mGKujEMS2
 cQtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdHorFlEGBIeF3LqrkOXDCWzTNbBCq6vD5lDrlZo2W3RSM4lpv1IpbAzJ8fL8/eyz4Bkeg97EixA2p@nongnu.org
X-Gm-Message-State: AOJu0YzkCIf6+53cP2rYuBWh60Xfx0G6NwYGbsaiv8L15euiiNvzkTIm
 ftf1N9O3WBg7r0eCnMGqsYSrWJKLMEodjcVROJWlvA8zzXArz2C6Mkn3ddt2wkSzBNQLGol5ttA
 ATSoeWHEZIkXgLdDlJ80S4u/sVOJD5JhrLUsud07X7U47oXaGQywbmyzH
X-Gm-Gg: ASbGncvLTaP+fcVcccJ4onhjKOZNfDP3A9Pgk7VBnqF0MY913fteocI0om/E7Z5i3Fx
 Icd1ZX0cCNWM5bCLk3re3StoQ/0N+Se+iVL4flveojyS6haJhyLSz7+Dw91PllJn39XAY7vGbDa
 hfBTyBPlal7gydHjTtnL4Y4octMyZSjpEh33/F82iDnzQW41C+mKG7mbLxHhFf4JgZqtOANfVRZ
 YXB9nZOwWSZexwyaTQMa5L53u2zC8pWHlh1qadD7vZ2nuB0mcIOeS/pOpq4Q9f4SbT0AnDbgEiU
 Tw5rOs0Q2B18zwsuV5exnwueZmGXMpu+NDdJjfcofU07E7RxiXzDhtQ4po4w09/a44nB4OftPU+
 mxEDxcJrKx+pntddmB3TBHVRoyvHHgtzW25IDPQ==
X-Received: by 2002:a5d:5f82:0:b0:425:86c8:c4ff with SMTP id
 ffacd0b85a97d-42704d90011mr9083425f8f.22.1760943983479; 
 Mon, 20 Oct 2025 00:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVx+rbEQKUHyPWHklCaY9m9OAPQ+RL83zDTlfQQcJlZOPYwhT5E3sgegEEm3VnGB7kvWnQig==
X-Received: by 2002:a5d:5f82:0:b0:425:86c8:c4ff with SMTP id
 ffacd0b85a97d-42704d90011mr9083404f8f.22.1760943983100; 
 Mon, 20 Oct 2025 00:06:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f88sm13302461f8f.7.2025.10.20.00.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:06:22 -0700 (PDT)
Message-ID: <62f6fa9d-bd5f-4f63-ad76-f5856bfd8468@redhat.com>
Date: Mon, 20 Oct 2025 09:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, avihaih@nvidia.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-7-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251017082234.517827-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Clément, Yi Liu,

On 10/17/25 10:22, Zhenzhong Duan wrote:
> If a VFIO device in guest switches from IOMMU domain to block domain,
> vtd_address_space_unmap() is called to unmap whole address space.
> 
> If that happens during migration, migration fails with legacy VFIO
> backend as below:
> 
> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))
> 
> Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
> 4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
> ioctl fails.
> 
> Fix it by iterating over DMAMap list to unmap each range with active mapping
> when migration is active. If migration is not active, unmapping the whole
> address space in one go is optimal.
> 
> There is no such limitation with iommufd backend, but it's still not optimal
> to allocate large bitmap, e.g., there may be large hole between IOVA ranges,
> allocating large bitmap and dirty tracking on the hole is time consuming and
> useless work.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 

Could you ack this change please ?

Thanks,

C.



