Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7087A696B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieIl-0007M6-03; Tue, 19 Sep 2023 13:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qieIj-0007Lx-Cg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qieIh-0006hS-Rk
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695143654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGpY+QcPACWLnhK0watP8oZU6jw5pS14cmdAkGseXSk=;
 b=gRqrn3iOq65KnBxAoBZo/hXIPWWFjSspBD1w7Wvn95x3NDzj/kbejWxxp4xvrxsMdeH/OX
 /sRxholaVd77m5b463f6rNHH4/ocxlU36hOW/3pnoV38/nfki0ZwJWEe2eMD6PmmqZYas8
 iyOElp1BWGFgrLlzbNs16xXeZUZy5uQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-IWsOqBnAPFKl09a6wY7vAw-1; Tue, 19 Sep 2023 13:14:13 -0400
X-MC-Unique: IWsOqBnAPFKl09a6wY7vAw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4122119722eso13887481cf.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695143652; x=1695748452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGpY+QcPACWLnhK0watP8oZU6jw5pS14cmdAkGseXSk=;
 b=byyL1yz/JhTTlaxCHM+L0k3QzFpQi7azZDBw6YEriNfiOJUM//LOBqrWEZ7X/RuVeO
 e6L0VBX+LXCSDDu1PYMRO1Ty72b3BKqsJLFAvUFYN3l5AGy6vLpXu9MqQQooxOl6HCK5
 kGJtv9iKPPLl8v322n8jxMcr8MBJZncPXbXQqRIbtIoUXFGOPE826U9htgol+cWhYpmF
 nJg+xhWbjjQawbWhMvI6+ihKRfRrKgmtOtVdwAZxH+2pMN2q5XJGQHeWOY+qDslu8lrE
 YfsWQ8M93q5mft3ahW7LqoK4U9WTqqko/XEgzQuRxtg5IG+SFxQuDV9KwoUHYmxY/Y0t
 Og1g==
X-Gm-Message-State: AOJu0Yx4hFGaIPcyzOqwFmNu44kqF7VDwqMuSyqYg3/pUa6JcUaEjAoa
 lkK9/1yivF9PYdvYs1mkfLtrDyoSiY1crkPHC6d6RXY54DLqdGNHux3EsTWHfrMnX8QcJMITKuR
 U/h8sPe8BSEn55Zhebv2EYUI=
X-Received: by 2002:a05:622a:1a22:b0:417:b509:bcec with SMTP id
 f34-20020a05622a1a2200b00417b509bcecmr102070qtb.2.1695143652440; 
 Tue, 19 Sep 2023 10:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhwuCyDLBZk0DfhRJcuQoE7l3/A8SWiOd+mYYm4KSAbg0ve04F/aGNShvaadzJ1+n1++URiA==
X-Received: by 2002:a05:622a:1a22:b0:417:b509:bcec with SMTP id
 f34-20020a05622a1a2200b00417b509bcecmr102054qtb.2.1695143652196; 
 Tue, 19 Sep 2023 10:14:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ig4-20020a05622a6a4400b004120ae42859sm3863939qtb.90.2023.09.19.10.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 10:14:11 -0700 (PDT)
Date: Tue, 19 Sep 2023 13:14:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 2/5] softmmu: Support concurrent bounce buffers
Message-ID: <ZQnW4e1wordu4UbM@x1n>
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
 <20230919160814.3343727-3-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919160814.3343727-3-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Sep 19, 2023 at 09:08:10AM -0700, Mattias Nissler wrote:
> @@ -3119,31 +3143,35 @@ void *address_space_map(AddressSpace *as,
>  void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
>                           bool is_write, hwaddr access_len)
>  {
> -    if (buffer != as->bounce.buffer) {
> -        MemoryRegion *mr;
> -        ram_addr_t addr1;
> +    MemoryRegion *mr;
> +    ram_addr_t addr1;
> +
> +    mr = memory_region_from_host(buffer, &addr1);
> +    if (mr == NULL) {
> +        BounceBuffer *bounce = container_of(buffer, BounceBuffer, buffer);
> +        assert(bounce->magic == BOUNCE_BUFFER_MAGIC);
>  
> -        mr = memory_region_from_host(buffer, &addr1);
> -        assert(mr != NULL);
>          if (is_write) {
> -            invalidate_and_set_dirty(mr, addr1, access_len);
> -        }
> -        if (xen_enabled()) {
> -            xen_invalidate_map_cache_entry(buffer);
> +            address_space_write(as, bounce->addr, MEMTXATTRS_UNSPECIFIED,
> +                                bounce->buffer, access_len);
>          }
> -        memory_region_unref(mr);
> +
> +        memory_region_unref(bounce->mr);
> +        qatomic_sub(&as->bounce_buffer_size, bounce->len);
> +        /* Write bounce_buffer_size before reading map_client_list. */
> +        smp_mb();
> +        address_space_notify_map_clients(as);
> +        bounce->magic = ~BOUNCE_BUFFER_MAGIC;
> +        g_free(bounce);
>          return;
>      }
> +
> +    if (xen_enabled()) {
> +        xen_invalidate_map_cache_entry(buffer);
> +    }
>      if (is_write) {
> -        address_space_write(as, as->bounce.addr, MEMTXATTRS_UNSPECIFIED,
> -                            as->bounce.buffer, access_len);
> -    }
> -    qemu_vfree(as->bounce.buffer);
> -    as->bounce.buffer = NULL;
> -    memory_region_unref(as->bounce.mr);

This line needs to be kept?

> -    /* Clear in_use before reading map_client_list.  */
> -    qatomic_set_mb(&as->bounce.in_use, false);
> -    address_space_notify_map_clients(as);
> +        invalidate_and_set_dirty(mr, addr1, access_len);
> +    }
>  }

-- 
Peter Xu


