Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB60A3E53E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 20:41:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlCP0-00026s-R2; Thu, 20 Feb 2025 14:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tlCOy-00024K-8j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:40:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tlCOw-00058G-5h
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740080399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xCmbmGEnPivhT04E5H1R7HKWMm3JkdNClqaUPWHdI2s=;
 b=P0LEic0p1hjFw3DkzM4SUjMvE7/M/A6HTV/0CKo9aP76y9uwvGSkYUU3aix25SXD6TZ/E+
 xOa/tGMDQmYkxKk8K9vbGpYGCOymCvr4uxV9CZuRDtnC8wF+RKUQ1DT2+io35YcoxkHEai
 jkI1z+goeufxJI4tRgMpdoJy2U/0C/A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-q6Xfil-QM1uTiX7xoEtw4A-1; Thu, 20 Feb 2025 14:39:58 -0500
X-MC-Unique: q6Xfil-QM1uTiX7xoEtw4A-1
X-Mimecast-MFC-AGG-ID: q6Xfil-QM1uTiX7xoEtw4A_1740080397
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2cefb154so1119844f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 11:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740080397; x=1740685197;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xCmbmGEnPivhT04E5H1R7HKWMm3JkdNClqaUPWHdI2s=;
 b=rIDcEXawJQk0plVNqhIYaQwm+i3xTsNDzGymOG2JjNbHNvVO17aNYMfwyrUNYrdOX+
 O+1kAY3Ie8rYrKLeZlXxzwQ8QInHFvsyaG1XK76xRNYh5BnbXKXeWmi4dz1FiAhHoNN1
 FkDGIsY2QkJmq1rXj8g3/+LmQyZjZCQ/V/oHLYeUKnjRM9hG+UdrwOUs+OF6zrQGKD+m
 qeE1pBNFZw1VWVGCBvuano4FRHYZzeWMeZhju7Umxxa+U+wuBhzqsoUxfeqfdzIUnpxi
 FHjfac5PUZLIYXUbSKYI5U5YVQlrpD8DcXtYjw31AtmCQbjU7dbZ4gsXfZKiJbV9RLhJ
 Nklg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX72otz5WBZMETnfz/cYJSl2lYEXAJicI3267LOR01eAcjScCv1XPSdLViy4vDKkivJsSFdHg3iZU4Q@nongnu.org
X-Gm-Message-State: AOJu0YybaegOXKikbDLwd3G+b2difmGAfaeQukYxRpIINpfrQiQHWlWn
 rlBFU4snajohWeH41V8sYGAxnUEH8cKqAtE9LXFgewQxACRcRtyBRrJfje8s09CVPTs4D2+Tl4R
 fs9mzFxwQjShmxdqFqTEdQfXCLrp3vwDDfY8+fpoLTa8f35eHai2Y
X-Gm-Gg: ASbGncs0rSNQzXnCKRXhH/XYP7FuMe4fKgVqb9PO5nN5BC3PX5O0wA4p+181B/d+kU4
 G1ZqUoGeftQVh+XIPOHhPm+5cCfK1XnH6S2HbY8cVHCro1LlfrvfD24CvOH+8J1/vscS/5Uef2Q
 6buKoLWVYUSwGqcg3q1TdTggUGUHeE7C1hk9BslimgQDyutbS7yTK1p76JNO7K7UP6B2ury4zU5
 Q5WSu+Nh3JndLEugGLD/LJsv/4dlXcIUigxsaWt6RjYoFXG72qfeHmYMA7l5dg/4LGSS7Pq/fcp
 a2H5vSdRgksFc960ha0tNMytILrFJXaS9ODFTdjE0wzrcGilyrzKGWXaEsBuTeXVEAwP2D4Fsxi
 d2L62IcWOdwnxnmn4CuzZ9TQMmzcsTQ==
X-Received: by 2002:a5d:6d07:0:b0:38d:dc57:855d with SMTP id
 ffacd0b85a97d-38f6f0b0129mr544465f8f.35.1740080397115; 
 Thu, 20 Feb 2025 11:39:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKbeHhwcwohivideRNFnZxEqSMXbhBgWzcrF1rSLQXCp4yeKMAwN2Eq6db6ITy/WR7fXwZYA==
X-Received: by 2002:a5d:6d07:0:b0:38d:dc57:855d with SMTP id
 ffacd0b85a97d-38f6f0b0129mr544446f8f.35.1740080396700; 
 Thu, 20 Feb 2025 11:39:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5?
 (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de.
 [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5923sm21604078f8f.74.2025.02.20.11.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 11:39:55 -0800 (PST)
Message-ID: <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
Date: Thu, 20 Feb 2025 20:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, philmd@linaro.org,
 peterx@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 Chenyi Qiang <chenyi.qiang@intel.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250220161320.518450-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 20.02.25 17:13, Jean-Philippe Brucker wrote:
> For Arm CCA we'd like the guest_memfd discard notifier to call the IOMMU
> notifiers and create e.g. VFIO mappings. The default VFIO discard
> notifier isn't sufficient for CCA because the DMA addresses need a
> translation (even without vIOMMU).
> 
> At the moment:
> * guest_memfd_state_change() calls the populate() notifier
> * the populate notifier() calls IOMMU notifiers
> * the IOMMU notifier handler calls memory_get_xlat_addr() to get a VA
> * it calls ram_discard_manager_is_populated() which fails.
> 
> guest_memfd_state_change() only changes the section's state after
> calling the populate() notifier. We can't easily invert the order of
> operation because it uses the old state bitmap to know which pages need
> the populate() notifier.

I assume we talk about this code: [1]

[1] https://lkml.kernel.org/r/20250217081833.21568-1-chenyi.qiang@intel.com


+static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t offset,
+                                         uint64_t size, bool shared_to_private)
+{
+    int block_size = memory_attribute_manager_get_block_size(mgr);
+    int ret = 0;
+
+    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
+        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
+                     __func__, offset, size);
+        return -1;
+    }
+
+    if ((shared_to_private && memory_attribute_is_range_discarded(mgr, offset, size)) ||
+        (!shared_to_private && memory_attribute_is_range_populated(mgr, offset, size))) {
+        return 0;
+    }
+
+    if (shared_to_private) {
+        memory_attribute_notify_discard(mgr, offset, size);
+    } else {
+        ret = memory_attribute_notify_populate(mgr, offset, size);
+    }
+
+    if (!ret) {
+        unsigned long first_bit = offset / block_size;
+        unsigned long nbits = size / block_size;
+
+        g_assert((first_bit + nbits) <= mgr->bitmap_size);
+
+        if (shared_to_private) {
+            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+        } else {
+            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
+        }
+
+        return 0;
+    }
+
+    return ret;
+}

Then, in memory_attribute_notify_populate(), we walk the bitmap again.

Why?

We just checked that it's all in the expected state, no?


virtio-mem doesn't handle it that way, so I'm curious why we would have to do it here?


> 
> For now add a flag to the IOMMU notifier to tell memory_get_xlat_addr()
> that we're aware of the RAM discard manager state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> 
> Definitely not the prettiest hack, any idea how to do this cleanly?
> ---
>   include/exec/memory.h | 5 +++++
>   system/memory.c       | 3 ++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9f73b59867..6fcd98fe58 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -116,6 +116,11 @@ typedef enum {
>       IOMMU_RO   = 1,
>       IOMMU_WO   = 2,
>       IOMMU_RW   = 3,
> +    /*
> +     * Allow mapping a discarded page, because we're in the process of
> +     * populating it.
> +     */
> +    IOMMU_POPULATING = 4,
>   } IOMMUAccessFlags;
>   
>   #define IOMMU_ACCESS_FLAG(r, w) (((r) ? IOMMU_RO : 0) | ((w) ? IOMMU_WO : 0))
> diff --git a/system/memory.c b/system/memory.c
> index 4c829793a0..8e884f9c15 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2221,7 +2221,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>            * Disallow that. vmstate priorities make sure any RamDiscardManager
>            * were already restored before IOMMUs are restored.
>            */
> -        if (!ram_discard_manager_is_populated(rdm, &tmp)) {
> +        if (!(iotlb->perm & IOMMU_POPULATING) &&
> +            !ram_discard_manager_is_populated(rdm, &tmp)) {
>               error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
>                            " via virtio-mem): %" HWADDR_PRIx "",
>                            iotlb->translated_addr);


-- 
Cheers,

David / dhildenb


