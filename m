Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784729B2AA9
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 09:46:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LNo-00009u-GW; Mon, 28 Oct 2024 04:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LNk-00009a-QV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LNi-0003KC-SZ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730105145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W9d2md+rF/DE41CkAgSmJLWRtunHWpx/LhJn21u4iQ0=;
 b=IDNx1GkesJgmeB9jIDsTlc2xPW+oYNsHN44JLWOvnuUboSL/vy4B2LR4R+cOr/V45EWvlU
 khLprZ9pOaDw8V1wndNxbzA0Fk+DvGa+rQ5sF+7CiHaPILfNrpWmxjTO1Qiwtx/eAPOgGK
 xfv/JwrPmYWMQbQAvf7S48DYi1gc644=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-T4fEIHTFOxemm0M8gLkgPA-1; Mon, 28 Oct 2024 04:45:44 -0400
X-MC-Unique: T4fEIHTFOxemm0M8gLkgPA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539e4cd976dso2208316e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 01:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730105142; x=1730709942;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9d2md+rF/DE41CkAgSmJLWRtunHWpx/LhJn21u4iQ0=;
 b=o7viXieoRiRIMkcw/uXxr+tGnyuEY9KR/WqnwphNN4ZDg3hii93WO3ImbGwgnrjl4W
 ZTbXTOQpurnhAywhKMv/ZxozjTVFDa9Ls/VzzgnYnHx4GcOEeVcL5CAfJnI663hHeyft
 eQcRTREqMlOJ+sgZnL7KHEYoqLxVnOlJltMeOvvPOzCpEzf5niVU8BGX2u/sBEEzYfEu
 667Za+2zWryiz/WOF1F43ukDXrgvKnDcOYDpXWAzGHYgb5pQwRNUeQPin9tEmBpzNdZ1
 PKytEX0Th83cRhN8dJq1slnJtZE60ZIFpy5NhxM1PvA3mKOpXRzdDMINtaVEu3X7iYzC
 jJXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS2t7OI6u8KrpuPZCZZvN0eaTjoQDZB38JMneYzztmXFUps58sfEYftjI7OgqzHs1N1LtmMXM7bz14@nongnu.org
X-Gm-Message-State: AOJu0YyHX9cf3OSNCNFSKrxJPxqzYHCIRiUejj9Vakug/u6JmTuY+mV0
 /a4nT/qbkqGTtp6lubECo3B/MyFKTi3W+rX0xtOfPox/mxsdYfOs4NPTMNCqSYNv5wpWDVK+khm
 LrHVrgCS7lTOV4lyZKVl2x3uIs+Naer5HoJOsVyqgdmxUHVre9YcqI6v4LzcQUFM=
X-Received: by 2002:a05:6512:1585:b0:539:8c02:64d5 with SMTP id
 2adb3069b0e04-53b348da77amr2558975e87.27.1730105141613; 
 Mon, 28 Oct 2024 01:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9vxRbcMZRS7XDi98pU/jnSfP14wjCsRyU1v9rHz3EborQaGOV4g6rEdani0lMCUd7BQaW+g==
X-Received: by 2002:a05:6512:1585:b0:539:8c02:64d5 with SMTP id
 2adb3069b0e04-53b348da77amr2558962e87.27.1730105141182; 
 Mon, 28 Oct 2024 01:45:41 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4318b542d3csm132084215e9.9.2024.10.28.01.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 01:45:40 -0700 (PDT)
Message-ID: <b9ca7c3e-86e6-4a25-9295-573dbacf0ce1@redhat.com>
Date: Mon, 28 Oct 2024 09:45:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/i386: Add feature dependencies for AVX10
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, xiaoyao.li@intel.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-5-tao1.su@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241028024512.156724-5-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 10/28/24 03:45, Tao Su wrote:
> Since the highest supported vector length for a processor implies that
> all lesser vector lengths are also supported, add the dependencies of
> the supported vector lengths. If all vector lengths aren't supported,
> clear AVX10 enable bit as well.
> 
> Note that the order of AVX10 related dependencies should be kept as:
>          CPUID_24_0_EBX_AVX10_128     -> CPUID_24_0_EBX_AVX10_256,
>          CPUID_24_0_EBX_AVX10_256     -> CPUID_24_0_EBX_AVX10_512,
>          CPUID_24_0_EBX_AVX10_VL_MASK -> CPUID_7_1_EDX_AVX10,

I think you need to add a set of dependencies so that avx10 cannot be 
set, unless all the older AVX features that it's composed of are 
available.  From the manual these are

AVX512F, AVX512CD, AVX512VW, AVX512DQ, AVX512_VBMI, AVX512_IFMA, 
AVX512_VNNI, AVX512_BF16, AVX512_VPOPCNTDQ, AVX512_VBMI2, VAES, GFNI,
VPCLMULQDQ, AVX512_BITALG, AVX512_FP16.

Otherwise, the changes look good.

Thanks,

Paolo


