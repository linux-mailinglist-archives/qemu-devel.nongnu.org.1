Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F99B9379
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 15:41:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6sp2-00071r-RY; Fri, 01 Nov 2024 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6soz-00070g-By
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6sox-0003m3-CB
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730472013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZGDqW+o/Z7FaihRreacNefs5L8Botht0/gATr5AZig=;
 b=I4Pl/myV78RCTAxurjeupdRl28fJsNXwyUpmhbShSLhumAbZweiVBIqkLwZNuSzaaMA9xz
 NwdqDSOaP47gIvq958K2sAf9tB1/ZyvOhl+i0U4tlihUlmJDtwalQ12MyjUzW9HjV2e2Tk
 OlepEfGc8e/e7cg14Ff25iirNW5qfec=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-5mxuPhyEMr67Tb5_3UjWAA-1; Fri, 01 Nov 2024 10:39:03 -0400
X-MC-Unique: 5mxuPhyEMr67Tb5_3UjWAA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbf59c1b3cso31819626d6.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 07:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730471943; x=1731076743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZGDqW+o/Z7FaihRreacNefs5L8Botht0/gATr5AZig=;
 b=OceWbBBGQBe4WPFSBJhhCBuNT29dOSdJRKAXNdrcGKZMjt+Bt8GbEePt7IoQg47mQ7
 9YBhAdXrz1bupN4sTB3FYmjDASYqVpSYbl54SgKX2FVv+9dzduBXYfINj4u2UWrepR8T
 r2FbqNqhf6uhHE2HQuPNXPT3k3Gwp7PcE+U4AXh8TNieKVjhHiQfQDml9/Z5dVPazMnd
 +cgkJXIbEsnYIuSsb72pxK0zyKWgSoxfj5O2MWBScyu4QaPhAfsklhO/SB7tH/fY25Gt
 13DjxpMugIPoTaXVNc76YJ2CNllfFIwZBttMMHaxZuWbgvVHYNVgks91u2yPLHKbsEA/
 QxMw==
X-Gm-Message-State: AOJu0YzfnF2c5nnk3HnsDDT/4Yza1d6PbOaulHzzASNNgVPGNa/DjtG8
 oIj0qswJUoPncfIVnJyIZlIwugHsWXcpsEd6tALwdrfZW9MM2Lo7+7RlMuz8Hw2cgZVGgWQfZg7
 GqIRUvyKYnfQjRSCFtGXfm03w1gY8+ggoa5r6QuJcoyzRjYkdP+KC
X-Received: by 2002:ac8:7d8a:0:b0:460:e63c:8f6d with SMTP id
 d75a77b69052e-461717901ebmr127106441cf.39.1730471943238; 
 Fri, 01 Nov 2024 07:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk6MqK8jNasAPMyOIxxSur9JZvQQIiUNLxKx11aw3IDIUxEU4qRaRUyyLBjSD/Z93K8oFouw==
X-Received: by 2002:ac8:7d8a:0:b0:460:e63c:8f6d with SMTP id
 d75a77b69052e-461717901ebmr127106121cf.39.1730471942921; 
 Fri, 01 Nov 2024 07:39:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0a179fsm19093061cf.26.2024.11.01.07.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 07:39:02 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:39:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 4/5] migration: refactor ram_save_target_page functions
Message-ID: <ZyToBbvfWkIZ_40W@x1n>
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-5-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029150908.1136894-5-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 29, 2024 at 08:39:07PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Refactor ram_save_target_page legacy and multifd
> functions into one. Other than simplifying it,
> it avoids reinitialization of the 'migration_ops'
> object, when migration moves from multifd to postcopy
> phase.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/ram.c | 54 ++++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 326ce7eb79..f9a6395d00 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1985,18 +1985,36 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
>  }
>  
>  /**
> - * ram_save_target_page_legacy: save one target page
> + * ram_save_target_page_common:
> + * send one target page to multifd workers OR save one target page.
>   *
> - * Returns the number of pages written
> + * Multifd mode: returns 1 if the page was queued, -1 otherwise.
> + *
> + * Non-multifd mode: returns the number of pages written
>   *
>   * @rs: current RAM state
>   * @pss: data about the page we want to send
>   */
> -static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
> +static int ram_save_target_page_common(RAMState *rs, PageSearchStatus *pss)
>  {
>      ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>  
> +    if (migrate_multifd()) {
> +        RAMBlock *block = pss->block;
> +        /*
> +         * While using multifd live migration, we still need to handle zero
> +         * page checking on the migration main thread.
> +         */
> +        if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> +            if (save_zero_page(rs, pss, offset)) {

There's one more save_zero_page() below.  Please consider properly merging
them.

> +                return 1;
> +            }
> +        }
> +
> +        return ram_save_multifd_page(block, offset);
> +    }
> +
>      if (control_save_page(pss, offset, &res)) {
>          return res;
>      }
> @@ -2008,32 +2026,6 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
>      return ram_save_page(rs, pss);
>  }
>  
> -/**
> - * ram_save_target_page_multifd: send one target page to multifd workers
> - *
> - * Returns 1 if the page was queued, -1 otherwise.
> - *
> - * @rs: current RAM state
> - * @pss: data about the page we want to send
> - */
> -static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
> -{
> -    RAMBlock *block = pss->block;
> -    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> -
> -    /*
> -     * While using multifd live migration, we still need to handle zero
> -     * page checking on the migration main thread.
> -     */
> -    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> -        if (save_zero_page(rs, pss, offset)) {
> -            return 1;
> -        }
> -    }
> -
> -    return ram_save_multifd_page(block, offset);
> -}
> -
>  /* Should be called before sending a host page */
>  static void pss_host_page_prepare(PageSearchStatus *pss)
>  {
> @@ -3055,12 +3047,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      }
>  
>      migration_ops = g_malloc0(sizeof(MigrationOps));
> +    migration_ops->ram_save_target_page = ram_save_target_page_common;

If we want to merge the hooks, we should drop the hook in one shot, then
call the new function directly.

>  
>      if (migrate_multifd()) {
>          multifd_ram_save_setup();
> -        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
> -    } else {
> -        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
>      }
>  
>      bql_unlock();
> -- 
> 2.47.0
> 

-- 
Peter Xu


