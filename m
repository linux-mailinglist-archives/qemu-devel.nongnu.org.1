Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D7B710DAD
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BQg-0005SR-GC; Thu, 25 May 2023 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2BQe-0005S0-Lj
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2BQc-0002uH-4M
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685022893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4QV9DvqIUvBDN5BMcY0SLd9F/Q+YFFaYCC157FWUcM=;
 b=IutpBBksjl2xU5afQBhtgQ6fU1o+IROIw5Dqunf+4vMTrv3oJ/InUE+njakDjSMpGKaAeG
 UBgNPLR7FQLegjHU9B1v+a5FiO16EJ9eoNfuQn+AzUVCoToUY6oiQLbVS10C4jzDbEQ85n
 9WzFa+P1+Hb1Pc6ZooEJxi0himxzY6M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-9SgybnSaM6ak7BgsiIyhxQ-1; Thu, 25 May 2023 09:54:51 -0400
X-MC-Unique: 9SgybnSaM6ak7BgsiIyhxQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-623a54565e6so3928396d6.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685022891; x=1687614891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4QV9DvqIUvBDN5BMcY0SLd9F/Q+YFFaYCC157FWUcM=;
 b=OcAiuvgnf//1bMXrBhZZeBBwDPou8iExrQ3laH/8jF/PsazuafAvCi0Nlp2uUh7eyY
 GCEUuxJ5Gd4DfnbRT69H1ONfggCA6kDbR/Mxp0Vb8v8F7ru40+cn4gaoT/3EORADssXc
 jxsSL2XNVq1/9x7rljs/JU+XrhW44b1fqUiDst+utYPWpGCKXKP0H+CSHYHx/6wCaSMZ
 lE/fv/qDPvfDgDdeHP1DTkECg8Y14K7/MpaZRblidPz2S8zNoG0IeEcKJvanQpC3hiHG
 BOYQRkbS2n+TNrPrMmxq9pO56fPQJGpGgDiYZksvu91EwtbMpB+AalOR9C9e4XbEn3lD
 0Kkw==
X-Gm-Message-State: AC+VfDw8j6XLRaH8lw3Wt7hyHzT8KtOxlLFmO66HbgoKVoPFIfit9e9y
 iJbg9sMcAcsUrSTBvRIwX8EEruJp8oAeXUMSLIcwkXIm+Tl66ytlWwzXZKcM3bvzOj33MKoXCmY
 eIXi2H/dtmu4ug1Y=
X-Received: by 2002:a05:622a:18a3:b0:3f5:1def:67f9 with SMTP id
 v35-20020a05622a18a300b003f51def67f9mr6807905qtc.6.1685022891221; 
 Thu, 25 May 2023 06:54:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HcmYM6rU1qkG5i5T/z3lmoPSErmXdIS0U9RhKDSzBkyiNS94e6m3o5smI40/Uz3OKcuDmPg==
X-Received: by 2002:a05:622a:18a3:b0:3f5:1def:67f9 with SMTP id
 v35-20020a05622a18a300b003f51def67f9mr6807887qtc.6.1685022890927; 
 Thu, 25 May 2023 06:54:50 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 p9-20020a05622a048900b003e1cf472b17sm396002qtx.97.2023.05.25.06.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:54:50 -0700 (PDT)
Date: Thu, 25 May 2023 09:54:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH v2 1/2] exec/ram_addr: return nr of dirty pages in
 cpu_physical_memory_set_dirty_lebitmap()
Message-ID: <ZG9oqfEr8qig2QhQ@x1n>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-2-joao.m.martins@oracle.com>
 <ZG9fungk+x/F0vD+@x1n>
 <4e8a19de-f56a-0dd5-6eed-5a9d8caa270e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e8a19de-f56a-0dd5-6eed-5a9d8caa270e@oracle.com>
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

On Thu, May 25, 2023 at 02:47:26PM +0100, Joao Martins wrote:
> Yeap, Something like this?
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 8b8f271d0731..deaf746421da 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -333,6 +333,13 @@ static inline void
> cpu_physical_memory_set_dirty_range(ram_addr_t start,
>  }
> 
>  #if !defined(_WIN32)
> +
> +/*
> + * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
> + * the number of dirty pages in @bitmap passed as argument. On the other hand,
> + * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
> + * weren't set in the global migration bitmap.
> + */
>  static inline
>  uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                                                  ram_addr_t start,
> 

Good enough to me. :)  With that, feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


