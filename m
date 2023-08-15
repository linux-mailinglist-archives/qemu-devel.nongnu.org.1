Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4577D5E8
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2VJ-000127-Cr; Tue, 15 Aug 2023 18:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2VG-00011M-MJ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2VE-0003El-K3
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYbfDBu5uHtaJrgqogpstQk8RLOkWNj5bcx4/PCRJVk=;
 b=dVk+uY7Vcu6+rC7pdaGdl5jPUrAKU032/FygDkH0VwgMgLcRuEmnv+olq/Jfmr2syUz8OG
 zHyN+3a501WjCpB2D4Rz99r0XtexRwkSQuN+Ay8i7TteLKYKJyvVlSnvvjP3iN3cr8MZSM
 dN1nYDgm8pA+MmOnPuwDEfNCA4X/3LU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-3guLqL6fNuKjsoqd6wvM2g-1; Tue, 15 Aug 2023 18:27:02 -0400
X-MC-Unique: 3guLqL6fNuKjsoqd6wvM2g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-642efbdc73fso12312636d6.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138421; x=1692743221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYbfDBu5uHtaJrgqogpstQk8RLOkWNj5bcx4/PCRJVk=;
 b=ZkrOQo+/A6efY6S6izlcLBmm8QaKdqt895R8OLBbjJTyJYsNOIH/hkOyThC9rlQ2fU
 IYuka0o9eBp2JiDsKoGNVXgDmxvCtZ4z/2V3giVhsTT1PgFqwh1rzfWseVv8Dhqawhn0
 MHRt4azWtUUZQXPWe6gMA3hczBFDUPvbD96/BSaAm7ovyOPYLPgkX+rsZO+bW3gyKhC9
 iHeT5NGQbtWagsfB9MNlWFEREWp5HIlnHGhJ0Jqg8bUg0SL4cBedd9aIJRBY8CtCt1X9
 UrqsmR+m24ZY4KWLJ+eoX221lcbHSMezVx9XF3MsCByCq+WD9l74PNLWoLOxBIz/gS3A
 10tA==
X-Gm-Message-State: AOJu0YxybNObUlpg9aodw0fnqeZB5f7qqWKdgcYceNhzG5Vyl9VzYE9A
 0009OD7Cev37JcErWt1XTs8B7Cgry+u1j6RraA8/ZqhtrQY4zkMik2uHBtqoHYt/QQErCOm6JwD
 +Ro9nBPkOqI1L/BXFLT55cDE=
X-Received: by 2002:a05:6214:76e:b0:635:fa38:5216 with SMTP id
 f14-20020a056214076e00b00635fa385216mr147987qvz.0.1692138420965; 
 Tue, 15 Aug 2023 15:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuT9iFtAFHDPnksH8cJHRDlrkGw10N59pIuOUNU+NYxLcL3a0vhoiXwvwW+R2NMhymeaStrA==
X-Received: by 2002:a05:6214:76e:b0:635:fa38:5216 with SMTP id
 f14-20020a056214076e00b00635fa385216mr147977qvz.0.1692138420669; 
 Tue, 15 Aug 2023 15:27:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n6-20020a0ce486000000b00636291d04adsm2080811qvl.47.2023.08.15.15.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:27:00 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:26:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 4/5] migration/ram: Return early from save_zero_page
Message-ID: <ZNv7spVAEFHpdebZ@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815143828.15436-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 15, 2023 at 11:38:27AM -0300, Fabiano Rosas wrote:
> Invert the first conditional so we return early when len == 0. This is
> merely to make the next patch easier to read.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index a10410a1a5..8ec38f69e8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1169,23 +1169,24 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss, RAMBlock *block,
>  {
>      int len = save_zero_page_to_file(pss, block, offset);
>  
> -    if (len) {
> -        stat64_add(&mig_stats.zero_pages, 1);
> -        ram_transferred_add(len);
> +    if (!len) {
> +        return -1;
> +    }
>  
> -        /*
> -         * Must let xbzrle know, otherwise a previous (now 0'd) cached
> -         * page would be stale.
> -         */
> -        if (rs->xbzrle_started) {
> -            XBZRLE_cache_lock();
> -            xbzrle_cache_zero_page(block->offset + offset);
> -            XBZRLE_cache_unlock();
> -        }
> +    stat64_add(&mig_stats.zero_pages, 1);
> +    ram_transferred_add(len);
>  
> -        return 1;
> +    /*
> +     * Must let xbzrle know, otherwise a previous (now 0'd) cached
> +     * page would be stale.
> +     */
> +    if (rs->xbzrle_started) {
> +        XBZRLE_cache_lock();
> +        xbzrle_cache_zero_page(block->offset + offset);
> +        XBZRLE_cache_unlock();
>      }
> -    return -1;
> +
> +    return 1;
>  }

Can we squash this into previous patch?

-- 
Peter Xu


