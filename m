Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35EA64331
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 08:17:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4iH-000829-Rk; Mon, 17 Mar 2025 03:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4hi-0007zh-FX
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tu4hc-0003oQ-2D
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 03:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742195736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S+OgSwcTaBYzIEdrOOultqxAYZ4eYWQxoRCjUBP5Tc0=;
 b=Iz+TEoaF5yK/Yn7gvYEhBzjLiKQ53Imy2FF1YWJ3ejK1WagEC2xYpGuKlsFRsAxcQ7b3Ww
 MkimU4PK11/8pQqhLEjCAger1jfj+XvldizkOOY1Q+TYir+OujPhXwujuw9UhjPC6pbc1R
 7lh6DJRQ+1j5n91QJwdIu+YK6C3QF1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-FHvsuDFTP_Kx5I3yDIejWQ-1; Mon, 17 Mar 2025 03:15:35 -0400
X-MC-Unique: FHvsuDFTP_Kx5I3yDIejWQ-1
X-Mimecast-MFC-AGG-ID: FHvsuDFTP_Kx5I3yDIejWQ_1742195734
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c747c72so8146615e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 00:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742195734; x=1742800534;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+OgSwcTaBYzIEdrOOultqxAYZ4eYWQxoRCjUBP5Tc0=;
 b=cUFhSr6ON7C4NVVqCaMHsApfakDex3hS0ceGYtjWbiNaVobUJ5hD1fqWVPnlDgJ9lc
 ft7gbnobimjsR+4fgF/3IvjRdD5PI9DkUCvgXZYWVFq9S6Lj4Uke7F2MVC5eyngFtw1C
 kZcXjtk+d9mNd0a2XouDcpurkfRG9sSBpHAONezd29QTG8NMkp3xJ4xKqad7BOdhbVZ/
 EwWSIaXsWPo8c158SclTmXisu31sv8sUidtOGdwPRS9SOwLDKyEfmt5puvItS78L7zbY
 w4qp3f9drqzYXTjFH0ghuTsMN0hFv9lobUIrNgfWq2iLS3/vdUwxxkA+q985qpgNtvH/
 72Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx7DJrSUTULpl5veUYq+Qor1AEJmR4Msin6yy8HuPpvCi5TBBb986nVlJAO5cK2QlMRA4mJGIS3EDv@nongnu.org
X-Gm-Message-State: AOJu0YwajwYOogQILp8aJR1QaQ4j4T61bRidT0zaqC1xnDobxLQMcYyY
 Y0yXvoY3zaKkqKLPOywiTiupsmE3dEXIZpMaAQgZnuzx1JXqjUR2RtE6278fTk0Pw9QntSWNGJt
 ZC362CoWUc5i2URETgLS5/t4t8870TQC0yZt9bjQf8fXubXSDBQfW
X-Gm-Gg: ASbGncvXVxaNyg4ECTE53Gyx+H2IkTsz9Y0EyaLmgSDjwFcRmq6HZnd5LhwGNIjIKFB
 Z4DiuU9Ij2p1eaozbxm1tdSl1dV4EQUV0ndM8zVUCY5848THXruFX3c1pUI3yEEwSVpxzHBegtP
 r+aYM0iLxOCt/2UYYcPsCm8PkQOxav++8T0M4P7BUhao1utXhgWsA2860McufttEHKDwhfTQexl
 z6V9GdfjExW34Ew9qrB9KE5YyJ2A1ptDJn89XLNJ4vfXPZgoAgZ5Qly80W5yj5EewRPTPy+KKk1
 gSGqbN8/Wh7J55bxsAx0Z4TUD08Dcrwy2Yysa+1rTY8egElkdXDalg==
X-Received: by 2002:a05:600c:4446:b0:43c:fd2b:823a with SMTP id
 5b1f17b1804b1-43d1eccbfc0mr113120095e9.24.1742195733931; 
 Mon, 17 Mar 2025 00:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm9CIqAH5GzvzUH9drBR2FjoHyX8tuj/vpd8xeyzSKTomoqTJR11sNVO/xgeFrN1jfPDcIOw==
X-Received: by 2002:a05:600c:4446:b0:43c:fd2b:823a with SMTP id
 5b1f17b1804b1-43d1eccbfc0mr113119805e9.24.1742195733460; 
 Mon, 17 Mar 2025 00:15:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df385bsm13892387f8f.4.2025.03.17.00.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 00:15:33 -0700 (PDT)
Message-ID: <b527124d-b772-459d-8167-b5ac41862aef@redhat.com>
Date: Mon, 17 Mar 2025 08:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] pnv/xive: Fix possible undefined shift error in group
 size calculation
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250317052339.1108322-1-npiggin@gmail.com>
 <20250317052339.1108322-3-npiggin@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250317052339.1108322-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/17/25 06:23, Nicholas Piggin wrote:
> Coverity discovered a potential shift overflow in group size calculation
> in the case of a guest error. Add checks and logs to ensure a issues are
> caught.
> 
> Make the group and crowd error checking code more similar to one another
> while here.
> 
> Resolves: Coverity CID 1593724
> Fixes: 9cb7f6ebed60 ("ppc/xive2: Support group-matching when looking for target")
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c  | 27 ++++++++++++++++++++++++---
>   hw/intc/xive2.c | 19 ++++++++++++++-----
>   2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index e86f2749328..3eb28c2265d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1662,12 +1662,20 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
>        * (starting with the least significant bits) in the NVP index
>        * gives the size of the group.
>        */
> -    return 1 << (ctz32(~nvp_index) + 1);
> +    int first_zero = cto32(nvp_index);
> +    if (first_zero >= 31) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
> +                                       nvp_index);
> +        return 0;
> +    }
> +
> +    return 1U << (first_zero + 1);
>   }
>   
>   static uint8_t xive_get_group_level(bool crowd, bool ignore,
>                                       uint32_t nvp_blk, uint32_t nvp_index)
>   {
> +    int first_zero;
>       uint8_t level;
>   
>       if (!ignore) {
> @@ -1675,12 +1683,25 @@ static uint8_t xive_get_group_level(bool crowd, bool ignore,
>           return 0;
>       }
>   
> -    level = (ctz32(~nvp_index) + 1) & 0b1111;
> +    first_zero = cto32(nvp_index);
> +    if (first_zero >= 31) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group index 0x%08x",
> +                                       nvp_index);
> +        return 0;
> +    }
> +
> +    level = (first_zero + 1) & 0b1111;
>       if (crowd) {
>           uint32_t blk;
>   
>           /* crowd level is bit position of first 0 from the right in nvp_blk */
> -        blk = ctz32(~nvp_blk) + 1;
> +        first_zero = cto32(nvp_blk);
> +        if (first_zero >= 31) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd block 0x%08x",
> +                                           nvp_blk);
> +            return 0;
> +        }
> +        blk = first_zero + 1;
>   
>           /*
>            * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index f8ef6154878..311b42e15d3 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1153,13 +1153,15 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
>   
>   static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
>   {
> -    uint8_t size, block_mask = 0b1111;
> +    uint8_t block_mask = 0b1111;
>   
>       /* 3 supported crowd sizes: 2, 4, 16 */
>       if (crowd) {
> -        size = xive_get_vpgroup_size(nvt_blk);
> -        if (size == 8) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of 8n");
> +        uint32_t size = xive_get_vpgroup_size(nvt_blk);
> +
> +        if (size != 2 && size != 4 && size != 16) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of %d",
> +                                           size);
>               return block_mask;
>           }
>           block_mask &= ~(size - 1);
> @@ -1172,7 +1174,14 @@ static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ignore)
>       uint32_t index_mask = 0xFFFFFF; /* 24 bits */
>   
>       if (cam_ignore) {
> -        index_mask &= ~(xive_get_vpgroup_size(nvt_index) - 1);
> +        uint32_t size = xive_get_vpgroup_size(nvt_index);
> +
> +        if (size < 2) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid group size of %d",
> +                                           size);
> +            return index_mask;
> +        }
> +        index_mask &= ~(size - 1);
>       }
>       return index_mask;
>   }


