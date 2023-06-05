Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D17722EA2
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 20:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Er2-0006pn-9h; Mon, 05 Jun 2023 14:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Er0-0006pa-83
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Eqy-0007AZ-OQ
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 14:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685989370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TgWcl9bwuyNhqF6kn48uVWfcQzd8pk38Eepntxfuu9c=;
 b=AeYaK8G9iBYCF6TLzEgN3a0+UQSttQDTN37/dLEPqq5S9GgGa24PDlzgX722tExMQdetSZ
 xWH72j/lFd4UzcTk9uAnmws0ZwNm/wz0Onr7Ctjk46LihcCq3oNSGXXs/zBE7Ix6w92KkC
 NDCNhwEJwrl1P/Ofips8Zk6KpOlNqgY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-nnwnLt7sPpm5uQuln87TqA-1; Mon, 05 Jun 2023 14:22:49 -0400
X-MC-Unique: nnwnLt7sPpm5uQuln87TqA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-626380298d3so9255376d6.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 11:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685989369; x=1688581369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgWcl9bwuyNhqF6kn48uVWfcQzd8pk38Eepntxfuu9c=;
 b=FxkKFYJRGw13l5s56KHbgNKTpBL8BdRwVLJFrxPYD5VTOQnatiVzTKNpn9dW5XaE4i
 pnM9Ejo0UVco07GSFwsy9ppJqB/VBubr/ptHpzyCGkMQQtO3k6j3cVbM3oktKFT73P9N
 ggZpStxzd5o4K9urPEplh9nHRTHRPgMNFAY/J05aEbONjJH5f9/LEkdTu1smnJKrlQ3e
 ++/TWDNw6PHyvZDAmniesgNK9Y93Fa4iwkBBMb5p05JQQyD6VzpuWNl0tl7ehL5EBrau
 lGeRSJz7wvo8YXKBOkWUqcoXmzAGlfJWY7fexWBQk9HEugTvNL8wVQWPbbpL6PJYWIhI
 GDEA==
X-Gm-Message-State: AC+VfDwbHQpzVp86bNE6W9XY8967LdVE8i3IGH9pLA2EXun3ETzurFPT
 37EflIQ4mZna4Oq5UiLOpoSEy3Yx7c9LB/82drPRWTnUa+HiNMuXdhr00+zWzalAmMxMYcFfTqF
 Kfp3ObdGXM78gkT0=
X-Received: by 2002:ad4:5966:0:b0:61b:76dd:b643 with SMTP id
 eq6-20020ad45966000000b0061b76ddb643mr19633339qvb.4.1685989368904; 
 Mon, 05 Jun 2023 11:22:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4qxaZhbnRnSLOrzKOo6IwcMxeAGvIwcBniro3qIMoyi++9T+2h+OdkK7OIEF/rVlY335YSBQ==
X-Received: by 2002:ad4:5966:0:b0:61b:76dd:b643 with SMTP id
 eq6-20020ad45966000000b0061b76ddb643mr19633305qvb.4.1685989368597; 
 Mon, 05 Jun 2023 11:22:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d5-20020a0cea85000000b006286334f999sm4744827qvp.78.2023.06.05.11.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 11:22:48 -0700 (PDT)
Date: Mon, 5 Jun 2023 14:22:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 05/20] qemu_file: Use a stat64 for qemu_file_transferred
Message-ID: <ZH4n9jeN6PcoZ3A1@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-6-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, May 30, 2023 at 08:39:26PM +0200, Juan Quintela wrote:
> This way we can read it from any thread.
> I checked that it gives the same value than the current one.  We never
> use to qemu_files at the same time.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

The follow up patch may be better to be squashed or it's very confusing..

Why do we need to convert mostly everything into atomics?  Is it modified
outside migration thread?

AFAIR atomic ops are still expensive, and will get more expensive on larger
hosts, IOW it'll be good for us to keep non-atomic when possible (and
that's why when I changed some counters in postcopy work I only changed the
limited set because then the rest are still accessed in 1 single thread and
keep running fast).

> ---
>  migration/migration-stats.h | 4 ++++
>  migration/qemu-file.c       | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration-stats.h b/migration/migration-stats.h
> index 2358caad63..b7795e7914 100644
> --- a/migration/migration-stats.h
> +++ b/migration/migration-stats.h
> @@ -81,6 +81,10 @@ typedef struct {
>       * Number of bytes sent during precopy stage.
>       */
>      Stat64 precopy_bytes;
> +    /*
> +     * Number of bytes transferred with QEMUFile.
> +     */
> +    Stat64 qemu_file_transferred;
>      /*
>       * Amount of transferred data at the start of current cycle.
>       */
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index be3dab85cb..eb0497e532 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -288,6 +288,7 @@ void qemu_fflush(QEMUFile *f)
>          } else {
>              uint64_t size = iov_size(f->iov, f->iovcnt);
>              f->total_transferred += size;
> +            stat64_add(&mig_stats.qemu_file_transferred, size);
>          }
>  
>          qemu_iovec_release_ram(f);
> @@ -628,7 +629,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
>  
>  uint64_t qemu_file_transferred_noflush(QEMUFile *f)
>  {
> -    uint64_t ret = f->total_transferred;
> +    uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
>      int i;
>  
>      g_assert(qemu_file_is_writable(f));
> @@ -644,7 +645,7 @@ uint64_t qemu_file_transferred(QEMUFile *f)
>  {
>      g_assert(qemu_file_is_writable(f));
>      qemu_fflush(f);
> -    return f->total_transferred;
> +    return stat64_get(&mig_stats.qemu_file_transferred);
>  }
>  
>  void qemu_put_be16(QEMUFile *f, unsigned int v)
> -- 
> 2.40.1
> 

-- 
Peter Xu


