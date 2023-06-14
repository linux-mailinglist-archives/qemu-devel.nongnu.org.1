Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD173025E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 16:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Rr1-0003Ds-BR; Wed, 14 Jun 2023 10:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Rqy-0003DP-Um
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 10:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Rqx-000583-4w
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 10:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686754326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OW6TASUDBQdQXlPpQQpErKAfpMP0CBl6nZc8IkcqeE0=;
 b=ei1OQBCjHC1tVK30JN4nJfbZ0e8A9ZdcYH5lQVVDGJStJOzza2CT6n+8/EjM+nP/4L45Av
 wvwMtZ0Zg3UkbEeU6wm/mtJi5Kpk3o9MTZDHHzxbEBHiHGtNvS5J58/UpEkNd61A7GTJgt
 1uIwujsW2G3X7LYNuXNXakTC8hqz7uw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-LSUZlFiIMS6NhE7BUFWJMA-1; Wed, 14 Jun 2023 10:52:04 -0400
X-MC-Unique: LSUZlFiIMS6NhE7BUFWJMA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-74faf5008bbso148561285a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 07:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686754324; x=1689346324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OW6TASUDBQdQXlPpQQpErKAfpMP0CBl6nZc8IkcqeE0=;
 b=H2B2aBLJiXOmwQaUdXtagSHqMWdkGjysxGKAAoEg6b3Rtf5EYJQzpfxhMf6hrIrOwQ
 lPL1MdEmsD9cPcmAcpVL+ZZT/hfVzNhveceZ1rIX8JO/GJdzlAv9WeNdlsQiJbQg+OIW
 rZZY6wbd6rBby1iN2PdFZ/lfnhL+lQVkomsIeCTGQhIJa6zfflb9hlN9EukV3NaOIRNG
 tyQpEEHPb2UCLVcKfQo9ZwqGINOEpfNiqHjAp+HevJ5/Y12aLXgcVspomO9PEBzv+ZJT
 keoPv3qzuHzCZD8ZEcPDH56/6pTlEi/0MUZLC2ZyzYpPIGvXcatjQv7v4ye3yaGac0He
 VthA==
X-Gm-Message-State: AC+VfDxOBy8c6MyLY6B6zsTlWhuvXiy0KIFbeKDyrNwJpSFM7PDQcnOy
 ToYFcmLwj6s1tDfv23cUixM4yrDrfgStdYIMI3dPdnXCY89rkyS4bXUCfFLjxnuxKYWzSZFV4xl
 QvDabLK6aoe+tXGc=
X-Received: by 2002:a05:6214:400d:b0:62e:ffc3:a9cb with SMTP id
 kd13-20020a056214400d00b0062effc3a9cbmr3084500qvb.2.1686754324241; 
 Wed, 14 Jun 2023 07:52:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63oxVhAPcCNfEbJJczcuM4xzOiA4Vk3nAP0QkLPZJymqu1cueuAouHH9u/TXZ53bAZRoTfgQ==
X-Received: by 2002:a05:6214:400d:b0:62e:ffc3:a9cb with SMTP id
 kd13-20020a056214400d00b0062effc3a9cbmr3084473qvb.2.1686754323961; 
 Wed, 14 Jun 2023 07:52:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n11-20020a0cdc8b000000b0062e167dbd0bsm262137qvk.54.2023.06.14.07.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 07:52:03 -0700 (PDT)
Date: Wed, 14 Jun 2023 10:52:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 06/20] qemu_file: total_transferred is not used anymore
Message-ID: <ZInUEU0WqmUPI0tZ@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-7-quintela@redhat.com>
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

On Tue, May 30, 2023 at 08:39:27PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index eb0497e532..6b6deea19b 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -41,9 +41,6 @@ struct QEMUFile {
>      QIOChannel *ioc;
>      bool is_writable;
>  
> -    /* The sum of bytes transferred on the wire */
> -    uint64_t total_transferred;
> -
>      int buf_index;
>      int buf_size; /* 0 when writing */
>      uint8_t buf[IO_BUF_SIZE];
> @@ -287,7 +284,6 @@ void qemu_fflush(QEMUFile *f)
>              qemu_file_set_error_obj(f, -EIO, local_error);
>          } else {
>              uint64_t size = iov_size(f->iov, f->iovcnt);
> -            f->total_transferred += size;

I think this patch is another example why I think sometimes the way patch
is split are pretty much adding more complexity on review...

Here we removed a variable operation but it seems all fine if it's not used
anywhere.  But it also means current code base (before this patch applied)
doesn't make sense already because it contains this useless addition.  So
IMHO it means some previous patch does it just wrong.

I think it means it's caused by a wrong split of patches, then each patch
stops to make much sense as a standalone one.

I can go back and try to find whatever patch on the list that will explain
this.  But it'll also go into git log.  Anyone reads this later will be
confused once again.  Even harder for them to figure out what happened.

Do you think we could reorganize the patches so each of a single patch
explains itself?

The other thing is about priority of patches - I still have ~80 patches
pending reviews on migration only.. Would you think it makes sense we pick
up important ones first and merge them with higher priority?

What I have in mind are:

  - The regression you mentioned on qemu_fflush() when ram save (I hope I
    understand the problem right, though...).

  - The slowness of migration-test.  I'm not sure whether you have anything
    better than either Dan's approach or the switchover-hold flags, I just
    think that seems more important to resolve for us upstream.  We can
    merge Dan's or mine, you can also propose something else, but IMHO that
    seems to be a higher priority?

And whatever else I haven't noticed.  I'll continue reading but I'm sure
you know the best on this..  so I'd really rely on you.

What do you think?

Thanks,

-- 
Peter Xu


