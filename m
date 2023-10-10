Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489067C4103
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJB2-0008VM-GU; Tue, 10 Oct 2023 16:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJB0-0008TX-4w
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqJAu-0001UO-73
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696969071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nwil/0PLqUyad1yR6SpPq39Hjfgu8WvxDeXrMnAs0y4=;
 b=Xh1lFyidM9tYbz8JW0HPuDB4rMLMOvUOfLnejTOCEvsRTWe7voy4pZJEzy6FmGyszGQbYL
 golqX494w3qNIbS2Vp7gtXqx9qsRcfSMwkgYKrdtZLGMSoJ9XUPjtbwItACQEjYC0l/B87
 80XPnqciFRVpLrQ/3fSj0hB3PAZgm8U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-cJUQf8-xP0efvR874oYbGg-1; Tue, 10 Oct 2023 16:17:44 -0400
X-MC-Unique: cJUQf8-xP0efvR874oYbGg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-419719b700aso12914061cf.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 13:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696969064; x=1697573864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nwil/0PLqUyad1yR6SpPq39Hjfgu8WvxDeXrMnAs0y4=;
 b=Hos3TeInlEi4BcWcqkacZxuThEyYCcOONXyGsIhJewwPtPpnJu+pIj0YsKIBHVRlFb
 EVETu367uzeqMCbk2jE0jI4Vl7vcZP6DVAghlUxlqFVmXP/Z1vLXsfO93Gf+lcAZumZ9
 qaMxdU24Oa3yPFPgqqa9lGeyas5LuLrll5ZsimErBsMS+1xX/Dl+7T0ekxw3qFb2vxMx
 6AsyWMxb1MhHqvODvF3baN/unalID9aYYXEyK6sNQl+cj7qv2pD/odNLUyWvz8mQdCJv
 gU1dcCfuQBZI7c7Y7rJkEhWjAcZZOYgmdIodzvBPcL2PctqE7acb7nprAkNsBhF3kbWk
 j+xA==
X-Gm-Message-State: AOJu0YzS+f9qvoFt0our/VbuV20MxzQginITb7EuWiBMlluT44EqPLDW
 p3c+ZrUkxh8VYTMnashLr1w9YBjM3URxYFB7qebh2AhcHRrnuYhD43WK6zU5FYsfYXxF8Ndstgc
 2TwRy/Q++KTmF0dM=
X-Received: by 2002:a05:6214:519b:b0:65d:482:9989 with SMTP id
 kl27-20020a056214519b00b0065d04829989mr20743016qvb.5.1696969064372; 
 Tue, 10 Oct 2023 13:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdM0ecf6id8/A5Be3xzJk7ytWQkJPMUqnz8YsRlRU0bc3G8ZxvyrihAtsBVVAKx2hr+A3wWQ==
X-Received: by 2002:a05:6214:519b:b0:65d:482:9989 with SMTP id
 kl27-20020a056214519b00b0065d04829989mr20743005qvb.5.1696969064103; 
 Tue, 10 Oct 2023 13:17:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d19-20020a0ce453000000b00655d6d31470sm5051522qvm.43.2023.10.10.13.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 13:17:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:17:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: quintela@redhat.com, leobras@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
Message-ID: <ZSWxZgq82NBD3Zwe@x1n>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-3-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230922065625.21848-3-elena.ufimtseva@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 21, 2023 at 11:56:23PM -0700, Elena Ufimtseva wrote:
> In migration rate limiting atomic operations are used
> to read the rate limit variables and transferred bytes and
> they are expensive. Check first if rate_limit_max is equal
> to RATE_LIMIT_DISABLED and return false immediately if so.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial comment:

> ---
>  migration/migration-stats.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration-stats.c b/migration/migration-stats.c
> index 095d6d75bb..abc31483d5 100644
> --- a/migration/migration-stats.c
> +++ b/migration/migration-stats.c
> @@ -24,14 +24,14 @@ bool migration_rate_exceeded(QEMUFile *f)
>          return true;
>      }
>  
> -    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
> -    uint64_t rate_limit_current = migration_transferred_bytes(f);
> -    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
>      uint64_t rate_limit_max = stat64_get(&mig_stats.rate_limit_max);

Side note: since we have a helper, this can be migration_rate_get() too.

> -
>      if (rate_limit_max == RATE_LIMIT_DISABLED) {
>          return false;
>      }

empty line would be nice.

> +    uint64_t rate_limit_start = stat64_get(&mig_stats.rate_limit_start);
> +    uint64_t rate_limit_current = migration_transferred_bytes(f);
> +    uint64_t rate_limit_used = rate_limit_current - rate_limit_start;
> +
>      if (rate_limit_max > 0 && rate_limit_used > rate_limit_max) {
>          return true;
>      }
> -- 
> 2.34.1
> 
> 

-- 
Peter Xu


