Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C8720212
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53tr-0003pF-Lp; Fri, 02 Jun 2023 08:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53tp-0003om-QC
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53to-0003lX-CD
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685708872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoRVPfTiNv08ULufoGAqjAsoSKqERDWrDeIOzqqJ9I0=;
 b=gBiBqhSWiaDom/TI1Nd6+9zNzI2mzlbwdRxhLgRKZRklMcmOKc3NCXftKRNxq5OHDWHtej
 0pvaNDd+gZiUezYowU+kQOAlOweM6Hyr7T9MLl2aXCl1uDSYFDLs6498Bidhg9vBV4GUdg
 jYbKSBLL4VnN5CFGsrOVp/bZjqq7xAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EV09joEuPm62JBgxCdoZrw-1; Fri, 02 Jun 2023 08:27:50 -0400
X-MC-Unique: EV09joEuPm62JBgxCdoZrw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f608ea691fso11485085e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708869; x=1688300869;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QoRVPfTiNv08ULufoGAqjAsoSKqERDWrDeIOzqqJ9I0=;
 b=NmDPtbb8sFV5IFSW430msploTrPnScu/p1oR57D/A/+yhH5aIuvkf2lJxWbH08bo2b
 PGV95X7gXlNp+pDqQsSq3TTy/XUSPEd8IgMzCTb9NnP6uNSPi2hsV1BLQ3V6CUGSzXq8
 FtVvB7XNCCcaHre3qYezh2doxnnyHQ7KMuWSwB2LbLprrWwsRiP2cKFySAOjN/WQGNjM
 TBFswfVYQBw4f9Oj/YMILIhp+rSzEI2DumDSGawpu3U/zwcR1ShrFWdaG08ogfJb8X7J
 SSaEfXOlNBkSbpDgKqSLKfGmvKkCWgRAryaLYHOVPqwUSYc1LqQ0ZTZsyw9xBcsM1idN
 Ktvg==
X-Gm-Message-State: AC+VfDzys/MnUZU9Qa+3WC9Jzf/fFRyTsBp4WBliAGSnuz+dF0UAQZ6K
 tLfAEj6W0ry5eVcS4eBddxBh5dlvdrBFmUERaTyPnyglyk5oFSqsRtP3/JeIqDNEVKbz1Kn0LYE
 1g0/Sf7qDuwKtQcM=
X-Received: by 2002:a05:600c:3793:b0:3f6:455:de09 with SMTP id
 o19-20020a05600c379300b003f60455de09mr1638974wmr.39.1685708869574; 
 Fri, 02 Jun 2023 05:27:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5n+Y0k/q+/KEXa94P06mwu9qhKHwz/YyrmTN9BclH0HN00aDGN7M435BYlb86GrswOXetbhA==
X-Received: by 2002:a05:600c:3793:b0:3f6:455:de09 with SMTP id
 o19-20020a05600c379300b003f60455de09mr1638962wmr.39.1685708869218; 
 Fri, 02 Jun 2023 05:27:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a1c4c06000000b003f42ceb3bf4sm1818812wmf.32.2023.06.02.05.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:27:48 -0700 (PDT)
Message-ID: <b7c69701-9043-536b-21ed-69636fbce02d@redhat.com>
Date: Fri, 2 Jun 2023 14:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] linux-user/elfload: Expose get_elf_hwcap() on s390x
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601162541.689621-3-iii@linux.ibm.com>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
>   linux-user/elfload.c | 2 +-
>   linux-user/loader.h  | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 418ad92598c..49ec9ccc944 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1583,7 +1583,7 @@ static inline void init_thread(struct target_pt_regs *regs,
>   #define GET_FEATURE(_feat, _hwcap) \
>       do { if (s390_has_feat(_feat)) { hwcap |= _hwcap; } } while (0)
>   
> -static uint32_t get_elf_hwcap(void)
> +uint32_t get_elf_hwcap(void)
>   {
>       /*
>        * Let's assume we always have esan3 and zarch.
> diff --git a/linux-user/loader.h b/linux-user/loader.h
> index f375ee0679b..ad6ca9dbe35 100644
> --- a/linux-user/loader.h
> +++ b/linux-user/loader.h
> @@ -56,4 +56,8 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src,
>   
>   extern unsigned long guest_stack_size;
>   
> +#ifdef TARGET_S390X
> +uint32_t get_elf_hwcap(void);
> +#endif
> +
>   #endif /* LINUX_USER_LOADER_H */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


