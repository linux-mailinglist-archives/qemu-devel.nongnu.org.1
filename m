Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E87D32D1
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qut1S-0004fp-Aw; Mon, 23 Oct 2023 07:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qut1Q-0004fX-KP
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qut1O-0001h4-Vp
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RLbIz15Lk3jA4p1mCz/7i8PWTEyET+2IVNLkCOpjosM=;
 b=IZStOtaPFcUQ7TY3q3OUEn6zUlueOJMUltBRE+mSXJVr9iJbsn2Rh5aqFZ9odTkiao79k5
 jT9JjkzreEUccucurLwF412uU+IorNSWyLJT5nsce9d1rtHxsee+La1ysHj7CC0Lvzbs1K
 kLdYRG+tGenIQ2DoUFixhCTt508HqUY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-14jjzwRJNBGhjFzBzYFzbw-1; Mon, 23 Oct 2023 07:22:55 -0400
X-MC-Unique: 14jjzwRJNBGhjFzBzYFzbw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d8d17dcbaso1501445f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060174; x=1698664974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLbIz15Lk3jA4p1mCz/7i8PWTEyET+2IVNLkCOpjosM=;
 b=n3Kb6PaCCSHshTzW11xsZV/61DR1QjHSaGmaXfXJ8syYz5oWQ3bw3ARlxHzM2f3tYA
 v8SqJ3cYUWgeZBWeJChOo0DaRiO2nLM8b3940P4RG+EE7uiJrhPsKudW30L4bijDnbVM
 Rj3OQssxRa0fmLxk+nlbd+kpHLQvvCDTLvYg520yhPjYzTe9Z2gAWy/N4ZnZTXA81Go5
 CFax4Df0oTY4q2xmqYp81QcLSLBTRrePuU5oouSM182HRCKa1ZCGz8d9hovmoI97ixUg
 VKv0vNuDKuyi4qrEX50JJ2zYIagqTwZaifLqNZ7qFRMte1cnMcIDxpKROKmnRm+QL70F
 Ozxw==
X-Gm-Message-State: AOJu0YzfOw5XACrP8XpzpLkEWG1e1NpQyahunSnBd31I1mrFjktgz0nS
 fMfPGmOX78rzGUwXt1NP/n3NWHC3tglZDGBhcOMHZ3aJx5JvTRO2df/Tro2lEjt3akN+SBYBApR
 GnL0UyCc0XQCszp8=
X-Received: by 2002:adf:f286:0:b0:32d:a7d0:247a with SMTP id
 k6-20020adff286000000b0032da7d0247amr6038325wro.48.1698060174546; 
 Mon, 23 Oct 2023 04:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKkE6lFw8QU3bRCvChuSx52X0uCD9T5CJHmd0j/jg6MZLu77xy9fcos/O7rYGpTpRZ91HQpg==
X-Received: by 2002:adf:f286:0:b0:32d:a7d0:247a with SMTP id
 k6-20020adff286000000b0032da7d0247amr6038314wro.48.1698060174183; 
 Mon, 23 Oct 2023 04:22:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b003140f47224csm7513566wrx.15.2023.10.23.04.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:22:53 -0700 (PDT)
Date: Mon, 23 Oct 2023 07:22:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Mario Casquero <mcasquer@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH v1] virtio-mem: fix division by zero in
 virtio_mem_activate_memslots_to_plug()
Message-ID: <20231023072237-mutt-send-email-mst@kernel.org>
References: <20231023111341.219317-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023111341.219317-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 23, 2023 at 01:13:41PM +0200, David Hildenbrand wrote:
> When running with "dynamic-memslots=off", we enter
> virtio_mem_activate_memslots_to_plug() to return immediately again
> because "vmem->dynamic_memslots == false". However, the compiler might
> not optimize out calculating start_idx+end_idx, where we divide by
> vmem->memslot_size. In such a configuration, the memslot size is 0 and
> we'll get a division by zero:
> 
>     (qemu) qom-set vmem0 requested-size 3G
>     (qemu) q35.sh: line 38: 622940 Floating point exception(core dumped)
> 
> The same is true for virtio_mem_deactivate_unplugged_memslots(), however
> we never really reach that code without a prior
> virtio_mem_activate_memslots_to_plug() call.
> 
> Let's fix it by simply calling these functions only with
> "dynamic-memslots=on".
> 
> This was found when using a debug build of QEMU.
> 
> Reprted-by: Mario Casquero <mcasquer@redhat.com>
> Fixes: 177f9b1ee464 ("virtio-mem: Expose device memory dynamically via multiple memslots if enabled")
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/virtio/virtio-mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 9dc3c61b5a..be4b0b364f 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -525,9 +525,7 @@ static void virtio_mem_activate_memslots_to_plug(VirtIOMEM *vmem,
>                                   vmem->memslot_size;
>      unsigned int idx;
>  
> -    if (!vmem->dynamic_memslots) {
> -        return;
> -    }
> +    assert(vmem->dynamic_memslots);
>  
>      /* Activate all involved memslots in a single transaction. */
>      memory_region_transaction_begin();
> @@ -547,9 +545,7 @@ static void virtio_mem_deactivate_unplugged_memslots(VirtIOMEM *vmem,
>                                   vmem->memslot_size;
>      unsigned int idx;
>  
> -    if (!vmem->dynamic_memslots) {
> -        return;
> -    }
> +    assert(vmem->dynamic_memslots);
>  
>      /* Deactivate all memslots with unplugged blocks in a single transaction. */
>      memory_region_transaction_begin();
> @@ -598,7 +594,9 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>          virtio_mem_notify_unplug(vmem, offset, size);
>          virtio_mem_set_range_unplugged(vmem, start_gpa, size);
>          /* Deactivate completely unplugged memslots after updating the state. */
> -        virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
> +        }
>          return 0;
>      }
>  
> @@ -635,9 +633,11 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>           * blocks we are plugging here. The following notification will inform
>           * registered listeners about the blocks we're plugging.
>           */
> -        virtio_mem_activate_memslots_to_plug(vmem, offset, size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_activate_memslots_to_plug(vmem, offset, size);
> +        }
>          ret = virtio_mem_notify_plug(vmem, offset, size);
> -        if (ret) {
> +        if (ret && vmem->dynamic_memslots) {
>              virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
>          }
>      }
> @@ -749,7 +749,9 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
>          notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
>  
>          /* Deactivate all memslots after updating the state. */
> -        virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
> +        if (vmem->dynamic_memslots) {
> +            virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
> +        }
>      }
>  
>      trace_virtio_mem_unplugged_all();
> -- 
> 2.41.0


