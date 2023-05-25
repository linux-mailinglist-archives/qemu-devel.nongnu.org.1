Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A824710D19
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AqI-0006GL-Oi; Thu, 25 May 2023 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Apm-0006Bw-Oz
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Apk-0001sw-SF
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685020606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM5rlLtJ/0QXnaVNMQmQjrSM0Q0FUOpg26BMdMnGjSk=;
 b=TyAu1SaEvBAHvlwHA09IhmW7h7tQ7dRFrUdjA6EItuLLc4+V7bYwmB5UM9Wd+w/gi4WLHe
 GywSzOUzBumHLpccgZflyuxnTq7mIOyNSlDrBO9Dgf2pFAmkIu/HFpM/0Rv68ZzAQmbcAR
 beG/cOP2wZuy9JB+ohwqEUK2sfoRsC8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-8M5kWWwwNXactKDqbxM88Q-1; Thu, 25 May 2023 09:16:45 -0400
X-MC-Unique: 8M5kWWwwNXactKDqbxM88Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f6b1853e80so2607741cf.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020605; x=1687612605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HM5rlLtJ/0QXnaVNMQmQjrSM0Q0FUOpg26BMdMnGjSk=;
 b=QMK9IQ9Jgue0oELlQIgM8a/YgaDafiJpH6EiUupg4wkjH0/RpcvQWx+sjDop3///R+
 cGtPjo/MBgJO17IpUGwStk91zx3jXOmSg0850hGlwNuNl1/v35YOtXRI+GgagZP9qZX2
 QzwddxO11rLJVb2BRZ3mZ11eDLs7Jkq4MsSgQVVS0gqhN7MGRy0Zi/BTrXlcECvOryuF
 4Z5ATjF35ZCcPF0fXv+zzu0qhnmkxsyllKlALPH26OvI1IreT8gtnR03Ytf3On/65qCF
 fyEy7ETyUZo+cUFnbusI+m1Dzkr8i4WLOS/IUbFXBz8sX0W4fBORUjipdIqhfubeGfDD
 rGdA==
X-Gm-Message-State: AC+VfDyfmYZ8lVil91lp5pmp2TDdkTaJua4IOsqL+VL/zDJec86ZatDq
 PEScjCO38e93QCKNtQ098vx3QPj6kdrL5dvDwJ6XRN5iBUlKiNLOdFcPUdWIoBaqwg2E3iktTfr
 DDAKXT+mQMeouf7g=
X-Received: by 2002:a05:622a:302:b0:3f6:a7ad:9eef with SMTP id
 q2-20020a05622a030200b003f6a7ad9eefmr20844472qtw.1.1685020604832; 
 Thu, 25 May 2023 06:16:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5m2WW9fsQEByHwUH95BTRNUgm/AU9PYkMyOA1GPWgIEOYr9p5BK0O6/UZstr+7v3YYqX+j9w==
X-Received: by 2002:a05:622a:302:b0:3f6:a7ad:9eef with SMTP id
 q2-20020a05622a030200b003f6a7ad9eefmr20844450qtw.1.1685020604515; 
 Thu, 25 May 2023 06:16:44 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 a2-20020ac844a2000000b003f4e18bfa06sm381176qto.60.2023.05.25.06.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:16:43 -0700 (PDT)
Date: Thu, 25 May 2023 09:16:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v2 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Message-ID: <ZG9fungk+x/F0vD+@x1n>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-2-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525114321.71066-2-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 25, 2023 at 12:43:20PM +0100, Joao Martins wrote:
> In preparation for including the number of dirty pages in the
> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in
> cpu_physical_memory_set_dirty_lebitmap() similar to
> cpu_physical_memory_sync_dirty_bitmap().

The patch itself looks good to me, but it's slightly different from sync
version because that was only for MIGRATION bitmap, meanwhile it counts
newly dirtied ones (so exclude already dirtied ones even if re-dirtied in
the MIGRATION bitmap), while this one counts any dirty bits in *bitmap.

Shall we perhaps state it somewhere explicitly?  A comment for retval might
be suitable above the function?

Thanks,

> 
> To avoid counting twice when GLOBAL_DIRTY_RATE is enabled, stash the
> number of bits set per bitmap quad in a variable (@nbits) and reuse it
> there.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/exec/ram_addr.h | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index f4fb6a211175..8b8f271d0731 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -333,14 +333,16 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
>  }
>  
>  #if !defined(_WIN32)
> -static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> -                                                          ram_addr_t start,
> -                                                          ram_addr_t pages)
> +static inline
> +uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
> +                                                ram_addr_t start,
> +                                                ram_addr_t pages)
>  {
>      unsigned long i, j;
> -    unsigned long page_number, c;
> +    unsigned long page_number, c, nbits;
>      hwaddr addr;
>      ram_addr_t ram_addr;
> +    uint64_t num_dirty = 0;
>      unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
>      unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> @@ -368,6 +370,7 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                  if (bitmap[k]) {
>                      unsigned long temp = leul_to_cpu(bitmap[k]);
>  
> +                    nbits = ctpopl(temp);
>                      qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
>  
>                      if (global_dirty_tracking) {
> @@ -376,10 +379,12 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                                  temp);
>                          if (unlikely(
>                              global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
> -                            total_dirty_pages += ctpopl(temp);
> +                            total_dirty_pages += nbits;
>                          }
>                      }
>  
> +                    num_dirty += nbits;
> +
>                      if (tcg_enabled()) {
>                          qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>                                     temp);
> @@ -408,9 +413,11 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>          for (i = 0; i < len; i++) {
>              if (bitmap[i] != 0) {
>                  c = leul_to_cpu(bitmap[i]);
> +                nbits = ctpopl(c);
>                  if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
> -                    total_dirty_pages += ctpopl(c);
> +                    total_dirty_pages += nbits;
>                  }
> +                num_dirty += nbits;
>                  do {
>                      j = ctzl(c);
>                      c &= ~(1ul << j);
> @@ -423,6 +430,8 @@ static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>              }
>          }
>      }
> +
> +    return num_dirty;
>  }
>  #endif /* not _WIN32 */
>  
> -- 
> 2.31.1
> 

-- 
Peter Xu


