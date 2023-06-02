Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 793EE720211
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53tg-0003W9-1y; Fri, 02 Jun 2023 08:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53tc-0003Tp-Ux
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53tb-00060j-Ep
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsWVb1ZGcI/09vf4FGjtknYZcrUYFFIi7rwA7/hVtHQ=;
 b=hud51RyXyPzBBk/k6bw28S/1T0lzkRN+GVor0I9eD/8ybBxEVR5SEBU6Yzji0i/6bUaKom
 lXEcgFI+sXd+RfJabw4Hv8I/JG+RvVU4qnDTduZXnrH/OGt3PTF/Qp6YZ2xqE69YP2+4z5
 dR10f1yT4TQ7rY1wXWm1/+LT/TN9gwk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-410hl8P9O-O6iBirjJAwkw-1; Fri, 02 Jun 2023 08:28:41 -0400
X-MC-Unique: 410hl8P9O-O6iBirjJAwkw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30c3ad3238bso941490f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708920; x=1688300920;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FsWVb1ZGcI/09vf4FGjtknYZcrUYFFIi7rwA7/hVtHQ=;
 b=NcfBeKD1xL/QlBARQkES0hsYP0i3g/RRsu9gpVBStB7VxSpC+e/vpHsxIlJfJv/y+e
 z+ozIN4FRV2H6fVP7VwxNJZRF9NX08PCWplZmEgymMFfFIh2r2FWhUlQoIZ0gMxymO39
 umN1nSMK7BOCu3K8v8A5lmCKl2jXUNIzMjDM/KcygP4yEcHwTbmPy2TstT9rYnbzx0JB
 4+id3OAKiatLPnb9Ou4oD/OSFMzqMZ73TcFV+oWR6FRInxPbKw+oztmQpUuzTaje01Wx
 rTQ7ykBoBdA3I7fPGH0qtrE7cqCtNbGJR2YvBnFtYSw9NRDTTH+Thyt61aNrTuImmuZ0
 x6QQ==
X-Gm-Message-State: AC+VfDyq7jct6f2gkYEhAsPjwvYZzUqQgSjlz+BWWa0l39K+9Dt4PynJ
 KjoqTGw0xFjochTo5iKIc8/aHtd5pHU7CcwY6EaZ48PEsxZV0uv966QZWxaoh1NSydojdJBJJ0p
 3S2Y7odjlkcoYRBJRcUX4zQM=
X-Received: by 2002:adf:e942:0:b0:309:4f23:e52d with SMTP id
 m2-20020adfe942000000b003094f23e52dmr4095964wrn.43.1685708920373; 
 Fri, 02 Jun 2023 05:28:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76D24KRmYy4bT5PpTCCtv+C5m5uhu0q3KBKLtAiJVk8BY10dskMUQRJk13uz9VLnLNrMvSIg==
X-Received: by 2002:adf:e942:0:b0:309:4f23:e52d with SMTP id
 m2-20020adfe942000000b003094f23e52dmr4095956wrn.43.1685708920124; 
 Fri, 02 Jun 2023 05:28:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b002ca864b807csm1602467wrr.0.2023.06.02.05.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:28:39 -0700 (PDT)
Message-ID: <1e5e65cd-dbc4-1922-4a74-ca8a0a3b62a6@redhat.com>
Date: Fri, 2 Jun 2023 14:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] linux-user/elfload: Introduce elf_hwcap_str() on s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-4-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601162541.689621-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 01.06.23 18:25, Ilya Leoshkevich wrote:
> It is required for implementing /proc/cpuinfo emulation.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/elfload.c | 27 +++++++++++++++++++++++++++
>   linux-user/loader.h  |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 49ec9ccc944..d80d68484b6 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1605,6 +1605,33 @@ uint32_t get_elf_hwcap(void)
>       return hwcap;
>   }
>   
> +const char *elf_hwcap_str(uint32_t bit)
> +{
> +    static const char *hwcap_str[] = {
> +        [HWCAP_S390_ESAN3]     = "esan3",
> +        [HWCAP_S390_ZARCH]     = "zarch",
> +        [HWCAP_S390_STFLE]     = "stfle",
> +        [HWCAP_S390_MSA]       = "msa",
> +        [HWCAP_S390_LDISP]     = "ldisp",
> +        [HWCAP_S390_EIMM]      = "eimm",
> +        [HWCAP_S390_DFP]       = "dfp",
> +        [HWCAP_S390_HPAGE]     = "edat",
> +        [HWCAP_S390_ETF3EH]    = "etf3eh",
> +        [HWCAP_S390_HIGH_GPRS] = "highgprs",
> +        [HWCAP_S390_TE]        = "te",
> +        [HWCAP_S390_VXRS]      = "vx",
> +        [HWCAP_S390_VXRS_BCD]  = "vxd",
> +        [HWCAP_S390_VXRS_EXT]  = "vxe",
> +        [HWCAP_S390_GS]        = "gs",
> +        [HWCAP_S390_VXRS_EXT2] = "vxe2",
> +        [HWCAP_S390_VXRS_PDE]  = "vxp",
> +        [HWCAP_S390_SORT]      = "sort",
> +        [HWCAP_S390_DFLT]      = "dflt",
> +    };
> +
> +    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
> +}
> +
>   static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
>   {
>       regs->psw.addr = infop->entry;
> diff --git a/linux-user/loader.h b/linux-user/loader.h
> index ad6ca9dbe35..59cbeacf24f 100644
> --- a/linux-user/loader.h
> +++ b/linux-user/loader.h
> @@ -58,6 +58,7 @@ extern unsigned long guest_stack_size;
>   
>   #ifdef TARGET_S390X
>   uint32_t get_elf_hwcap(void);
> +const char *elf_hwcap_str(uint32_t bit);
>   #endif
>   
>   #endif /* LINUX_USER_LOADER_H */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


