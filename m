Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDDE835E9F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:50:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqvf-00077R-0m; Mon, 22 Jan 2024 04:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRqvc-000772-85
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rRqva-0003Is-GW
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705916953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iKQvIFS5HsdljQSzMH3UEUiJF4234I9kU4i+tkw/iF0=;
 b=ZJgyh3kYsUhQvyT5332fJkNd7p6iKAF8IZ/5Gg2ATLM8fHNkoOWfvtIlL1f3P5m1g0mjsZ
 y9mSEcYZGbrHr8+pT0CIstiNm37KQbDNS0WrmC0SaN5zwPezg54Kvm394Wmda+b5cwrwgJ
 7VtumY4a20UL2wSNtWE6mCUlYiqzK9Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-DbnDmUbNMF2cFDxm45MUbQ-1; Mon, 22 Jan 2024 04:49:09 -0500
X-MC-Unique: DbnDmUbNMF2cFDxm45MUbQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5ceac510f8cso405331a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705916948; x=1706521748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKQvIFS5HsdljQSzMH3UEUiJF4234I9kU4i+tkw/iF0=;
 b=bjSrj56fffugYrcqOam0K39uhtN8r/GLMMDt66gecF/sNVbqkto5sl8ivM1Hx47Kny
 blkuJhOSeh6skPGne6ftcOG2KQ8w13Bmm8NHWUQCljCgDM93HySejUooepdz2vZgvGcD
 4TxK8GiX4TGlZg3b1BW9MMpvuobqHWEnTrTEF9jh/X7voGwf3yrlEYwc7fkRax7Dsw0s
 1rAqUqzt300ffShedkXe1CbruvAFjiJvy3C6y8QO7MrzkFKWwAZ2P/x9SBKdNmHm+gCR
 QphN/wJgmac0DroqJmjLGylfW5kVf94k8e9+8fUZDu0ONMzYO4TthSWRXtFWHuT0yeLO
 11tA==
X-Gm-Message-State: AOJu0YwEd1Yc0hJCdNKACesvrTzvuKEvrvkHBP1EQo1lnRBBaOPWFlqA
 ZRqhumOQeNRZ6TBcZdsnhVjDJBzxTSgBiDTXQng9waHNcmvkRECVSvoxKBQg/+bkrX5WaOmIdlW
 qiaFkjpn5MZhAj5CoExP4uj1P+u4AtlR60Hu+BNloy0p9kmOdSm4X
X-Received: by 2002:a17:90a:f196:b0:290:3e14:5670 with SMTP id
 bv22-20020a17090af19600b002903e145670mr4987450pjb.3.1705916948650; 
 Mon, 22 Jan 2024 01:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr48gi7YeSTfBspR3YKH2D7XqeDhKTjM7mxrwR3Ptq11cgYPtklBlC0Cx5o/cRBLjIZBZOhA==
X-Received: by 2002:a17:90a:f196:b0:290:3e14:5670 with SMTP id
 bv22-20020a17090af19600b002903e145670mr4987443pjb.3.1705916948311; 
 Mon, 22 Jan 2024 01:49:08 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 dj11-20020a17090ad2cb00b0029051dad730sm6573850pjb.26.2024.01.22.01.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 01:49:08 -0800 (PST)
Date: Mon, 22 Jan 2024 17:49:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/5] migration: Fix use-after-free of migration state
 object
Message-ID: <Za46DZfpCGe9rdLs@x1n>
References: <20240119233922.32588-1-farosas@suse.de>
 <20240119233922.32588-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240119233922.32588-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 19, 2024 at 08:39:18PM -0300, Fabiano Rosas wrote:
> We're currently allowing the process_incoming_migration_bh bottom-half
> to run without holding a reference to the 'current_migration' object,
> which leads to a segmentation fault if the BH is still live after
> migration_shutdown() has dropped the last reference to
> current_migration.
> 
> In my system the bug manifests as migrate_multifd() returning true
> when it shouldn't and multifd_load_shutdown() calling
> multifd_recv_terminate_threads() which crashes due to an uninitialized
> multifd_recv_state.
> 
> Fix the issue by holding a reference to the object when scheduling the
> BH and dropping it before returning from the BH. The same is already
> done for the cleanup_bh at migrate_fd_cleanup_schedule().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 219447dea1..cf17b68e57 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -648,6 +648,7 @@ static void process_incoming_migration_bh(void *opaque)
>                        MIGRATION_STATUS_COMPLETED);
>      qemu_bh_delete(mis->bh);
>      migration_incoming_state_destroy();
> +    object_unref(OBJECT(migrate_get_current()));
>  }
>  
>  static void coroutine_fn
> @@ -713,6 +714,7 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
> +    object_ref(OBJECT(migrate_get_current()));
>      qemu_bh_schedule(mis->bh);
>      return;
>  fail:
> -- 
> 2.35.3
> 

I know I missed something, but I'd better ask: use-after-free needs to
happen only after migration_shutdown() / qemu_cleanup(), am I right?

If so, shouldn't qemu_main_loop() already returned?  Then how could any BH
keep running (including migration's) without qemu_main_loop()?

-- 
Peter Xu


