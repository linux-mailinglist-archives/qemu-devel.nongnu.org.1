Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC79BB33A1
	for <lists+qemu-devel@lfdr.de>; Thu, 02 Oct 2025 10:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EpW-0004UR-9S; Thu, 02 Oct 2025 04:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4EpQ-0004Sq-MN
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4EpB-0007f3-W2
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759394277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YyDjUxGRKsPzfGAYceZ9RYEBLC/JEBT1uj2//VuWo4o=;
 b=e5gi0DIhq4HGn0c2oG5Zmv/8xwz9vywi4su2Q2r4gs0a4anA8Dpe8rLfhTdE6XlP/G0wkD
 2pf/T4OasRxlD3h2/6N169ulWDx7NTHdwlE+LGIIVdE8QkRlbFXTA0vZNnnkfy2omiJQiO
 BySnH+MhDTixO82TqHA7+DMOppViZXE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-j66YtSfzM9OgH_4EtKLIKg-1; Thu, 02 Oct 2025 04:37:56 -0400
X-MC-Unique: j66YtSfzM9OgH_4EtKLIKg-1
X-Mimecast-MFC-AGG-ID: j66YtSfzM9OgH_4EtKLIKg_1759394275
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e5bcf38dfso13880155e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394275; x=1759999075;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YyDjUxGRKsPzfGAYceZ9RYEBLC/JEBT1uj2//VuWo4o=;
 b=eVjvPjRu9b0Kl/gNbueWSuCHcvVmsYbszHLLe/awkz+ets3s9v+D1UONPqMT/qvVMG
 5FzTEDz0N8rrspzigCYOdyxh+hYpzDG4FHuHuJCzXn+m3q2x9kYR14dV9G3jJiJeRuno
 eTevVbERMmh1SKxHilYob4umZnzcl2ruyNgIh5kGE4Hc6oBZjLl26cLD/8x22/bLiTBv
 WD2QWTVznGqVhSSZ9+TR09BT/EwHx2UVd2NAtIuPGnT3nOaeEWIv+TXzXp95gWA7dRPJ
 JLuPiGNYcIB1Joabw17XULvHyPwxt5fzQykw4/TmS0VnIkUXAqQh5p0C40Tm/F5lNtz1
 wSBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0d9fDxamDTpKAAGvD/Fj9wUKLavXdHzcYxZ6GZbHjrEMIxdv/kd1K6yCOrabkqNuOb6i/jzSI7nGj@nongnu.org
X-Gm-Message-State: AOJu0YxW89Rl9bCK7yKocwDesoG9IOIFDgkktFep8YY05WEyBZXd3PNY
 366xNGzetKiKqajq0D+yLnPQmjedVbA/Kb7dDAGAu4MprTcnyiYnAudzhkb4oUEDKJL6tAqu5FR
 2Z80v8zVWgvXAtD1kwX/pH5koUSVN/ebwbfNPfrp1BqT3fTbBn+XzAw0R
X-Gm-Gg: ASbGncvlZpPk5mk90ldmjv3rI7S7YhtFy5UU5598OypSCkJigSe8eQNExnMUSHUvTbl
 jGg1rTifiBR17KiC8MXQP41J9JYv/5IlHomMViSinvw2h+R+y4bmoBTNUNFReh5zvy/fRwVrnFv
 Q+jmmtdWCqM+X9pe2/tPIfI9W+YDWUGYmMlojDo3bM7M0M92PSHqQXUMSLzJnTQ77jg9xKMjG2P
 iOD5P1MMBpMJ9JIPaU9ruiFwdwq6qfbHgB8SMd/umkvzPuXTpvOc/F7iC3EzgTnTWymt0jEnpXz
 ErfP5Rdx4/GqpFKjQo5VB8OQYFxJJ1sHJiqA0WfkJqUQHeFEUfGoRguZIcKeWP/FAjw0RVmaerq
 m88DRQ9do
X-Received: by 2002:a05:600c:b90:b0:46e:477a:f3e3 with SMTP id
 5b1f17b1804b1-46e68c035f8mr15971635e9.18.1759394274847; 
 Thu, 02 Oct 2025 01:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwkyYRxZG0Hs/i0ds7NGPuUkvnB0Qw51yDFMUWSTkR6fnrfx38zXSUxziMCY7mlOcvW8l+Rg==
X-Received: by 2002:a05:600c:b90:b0:46e:477a:f3e3 with SMTP id
 5b1f17b1804b1-46e68c035f8mr15971325e9.18.1759394274399; 
 Thu, 02 Oct 2025 01:37:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b5csm2657741f8f.5.2025.10.02.01.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:37:53 -0700 (PDT)
Message-ID: <d7733dd6-bb06-4756-b09a-4dae4c3db227@redhat.com>
Date: Thu, 2 Oct 2025 10:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] hw: Remove unnecessary 'system/ram_addr.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20251001175448.18933-1-philmd@linaro.org>
 <20251001175448.18933-7-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251001175448.18933-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/1/25 19:54, Philippe Mathieu-Daudé wrote:
> None of these files require definition exposed by "system/ram_addr.h",
> remove its inclusion.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/ppc/spapr.c                    | 1 -
>   hw/ppc/spapr_caps.c               | 1 -
>   hw/ppc/spapr_pci.c                | 1 -
>   hw/remote/memory.c                | 1 -
>   hw/remote/proxy-memory-listener.c | 1 -
>   hw/s390x/s390-virtio-ccw.c        | 1 -
>   hw/vfio/spapr.c                   | 1 -
>   hw/virtio/virtio-mem.c            | 1 -
>   8 files changed, 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 82fb23beaa8..97ab6bebd25 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -77,7 +77,6 @@
>   #include "hw/virtio/virtio-scsi.h"
>   #include "hw/virtio/vhost-scsi-common.h"
>   
> -#include "system/ram_addr.h"
>   #include "system/confidential-guest-support.h"
>   #include "hw/usb.h"
>   #include "qemu/config-file.h"
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index f2f5722d8ad..0f94c192fd4 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,7 +27,6 @@
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
>   #include "system/hw_accel.h"
> -#include "system/ram_addr.h"
>   #include "target/ppc/cpu.h"
>   #include "target/ppc/mmu-hash64.h"
>   #include "cpu-models.h"
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 1ac1185825e..f9095552e86 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -34,7 +34,6 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/ppc/spapr.h"
>   #include "hw/pci-host/spapr.h"
> -#include "system/ram_addr.h"
>   #include <libfdt.h>
>   #include "trace.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/remote/memory.c b/hw/remote/memory.c
> index 00193a552fa..8195aa5fb83 100644
> --- a/hw/remote/memory.c
> +++ b/hw/remote/memory.c
> @@ -11,7 +11,6 @@
>   #include "qemu/osdep.h"
>   
>   #include "hw/remote/memory.h"
> -#include "system/ram_addr.h"
>   #include "qapi/error.h"
>   
>   static void remote_sysmem_reset(void)
> diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
> index 30ac74961dd..e1a52d24f0b 100644
> --- a/hw/remote/proxy-memory-listener.c
> +++ b/hw/remote/proxy-memory-listener.c
> @@ -12,7 +12,6 @@
>   #include "qemu/range.h"
>   #include "system/memory.h"
>   #include "exec/cpu-common.h"
> -#include "system/ram_addr.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/remote/mpqemu-link.h"
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index d0c6e80cb05..ad2c48188a8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -13,7 +13,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "system/ram_addr.h"
>   #include "system/confidential-guest-support.h"
>   #include "hw/boards.h"
>   #include "hw/s390x/sclp.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 8d9d68da4ec..0f23681a3f9 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -17,7 +17,6 @@
>   
>   #include "hw/vfio/vfio-container-legacy.h"
>   #include "hw/hw.h"
> -#include "system/ram_addr.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "trace.h"

For vfio,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 1de2d3de521..15ba6799f22 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -25,7 +25,6 @@
>   #include "hw/virtio/virtio-mem.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> -#include "system/ram_addr.h"
>   #include "migration/misc.h"
>   #include "hw/boards.h"
>   #include "hw/qdev-properties.h"


