Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BCA7DE264
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:31:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyCEv-0002KE-Lq; Wed, 01 Nov 2023 10:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyCEk-0002Jm-N7
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyCEj-0001YN-93
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698849022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x35l4fYXVQgNst9kIHk732d7Ok3OR3+/LPDmEqx9RNA=;
 b=TrGyl/rUjxJ528ifG/Y6W4NgfpJXIxAE5YNCsblEoDgTgUc1BVSQ5uICKizx1LzM2GHfy3
 fWAf14Er6w9gGk5gYpz7gCOG4XT+eYs0tP6ZnDT1hQXkfBQ0mpDlDfn7ZZGaVH36dnZnt0
 u4y/YRKDVQfZzmjCJ1+whhV7z5OdTyA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-FxcYL2c4N3WcewrKrY6Szw-1; Wed, 01 Nov 2023 10:30:19 -0400
X-MC-Unique: FxcYL2c4N3WcewrKrY6Szw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7789a2b35f1so91403785a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698849019; x=1699453819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x35l4fYXVQgNst9kIHk732d7Ok3OR3+/LPDmEqx9RNA=;
 b=v7jhhQkadC/w0w0y+hY5DzrPAJW4tq0Jb+Uyk2897MIEdZpfOVuO45cQf8+sI2PU6Y
 pDiUML9ubHBo5eTaM9Ri0R9KFHv3Iy+jnYniikvntk7i1g9/mJWWgv00Q34XVAyU3IcR
 Q/Bv1o3gIPm+oHzR9HZjkYS8kGF0hcaNv1nvqA2kvuLZVH+R0wGnrFPRNKmu6D576Zfx
 ly282UMnDP4/4wf1YysReuCWP6wdx4OpUIaKBE71rfNoRQ7F/hQO2P6rp/jrjQjjSmmk
 7eHEcgANe5BJaBAZpRWIvcEsco1vVX4ffM12vW4fd+NT8YO/bycQXIOl+76576NFAiUc
 uoNw==
X-Gm-Message-State: AOJu0YxPm+HpsApc+VBo3aFVQXyEEhc2MhNM1ZMP/liuETMadkVQ1RqD
 fRapsa9DYLDOVu3DzQDHD46ybyyxBD/SznSnl/mCnru1/VZ5K937WVdDXndL3jRKyYVX3oqAtt0
 kv2oBrCWYitviQz8=
X-Received: by 2002:a05:620a:640a:b0:773:b634:b05a with SMTP id
 pz10-20020a05620a640a00b00773b634b05amr16304776qkn.2.1698849019238; 
 Wed, 01 Nov 2023 07:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1Y1lSNcTWebwgyG4XPficmq/LsGMjBO2ZZ041FkVmtLjitqzwZvuZS31/VHABE3vQvJ3f5w==
X-Received: by 2002:a05:620a:640a:b0:773:b634:b05a with SMTP id
 pz10-20020a05620a640a00b00773b634b05amr16304756qkn.2.1698849018952; 
 Wed, 01 Nov 2023 07:30:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bp8-20020a05620a458800b0076cbcf8ad3bsm1458291qkb.55.2023.11.01.07.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:30:18 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:29:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 23/29] migration/ram: Add a wrapper for fixed-ram
 shadow bitmap
Message-ID: <ZUJg30op1uqsMAA0@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-24-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-24-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Oct 23, 2023 at 05:36:02PM -0300, Fabiano Rosas wrote:
> We'll need to set the shadow_bmap bits from outside ram.c soon and
> TARGET_PAGE_BITS is poisoned, so add a wrapper to it.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Merge this into existing patch to add ram.c usage?

> ---
>  migration/ram.c | 5 +++++
>  migration/ram.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index cea6971ab2..8e34c1b597 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3160,6 +3160,11 @@ static void ram_save_shadow_bmap(QEMUFile *f)
>      }
>  }
>  
> +void ramblock_set_shadow_bmap_atomic(RAMBlock *block, ram_addr_t offset)
> +{
> +    set_bit_atomic(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
> +}
> +
>  /**
>   * ram_save_iterate: iterative stage for migration
>   *
> diff --git a/migration/ram.h b/migration/ram.h
> index 145c915ca7..1acadffb06 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -75,6 +75,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
>  bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
>  void postcopy_preempt_shutdown_file(MigrationState *s);
>  void *postcopy_preempt_thread(void *opaque);
> +void ramblock_set_shadow_bmap_atomic(RAMBlock *block, ram_addr_t offset);
>  
>  /* ram cache */
>  int colo_init_ram_cache(void);
> -- 
> 2.35.3
> 

-- 
Peter Xu


