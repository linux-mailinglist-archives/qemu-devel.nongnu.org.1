Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B698F7CCC4A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspm5-00069Q-4t; Tue, 17 Oct 2023 15:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qspm2-00068y-Ru
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qspm0-0006cJ-3M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697571034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gR0La8LCkTNFe5NWbWDSmeB/wAyIKk2gjloGliKSQ8o=;
 b=fRE3PJAvS8a0mgAlPzG17uYO5idS69lVjNhpn/B/NVKofzRvcnhJty2DRJxWkwGCLy9SFk
 mPeiZHQZdXHAhoRNjNEd0Iqe5ORq38OEOBRsngRXQ1NkFHdHlWI+145wuJDmWyWAnX6olD
 prCzf2YyG5Kji8E6b4ZY6pcbhOtHJnI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-NKTAS7XuMmywqLxbuW3JBg-1; Tue, 17 Oct 2023 15:30:31 -0400
X-MC-Unique: NKTAS7XuMmywqLxbuW3JBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 058743C1ACE6;
 Tue, 17 Oct 2023 19:30:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1023325C8;
 Tue, 17 Oct 2023 19:30:29 +0000 (UTC)
Date: Tue, 17 Oct 2023 21:30:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v3 4/8] qemu-img: add chunk size parameter to
 compare_buffers()
Message-ID: <ZS7g1NZCHC/Rblre@redhat.com>
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
 <20230919165804.439110-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919165804.439110-5-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 19.09.2023 um 18:58 hat Andrey Drobyshev geschrieben:
> Add @chsize param to the function which, if non-zero, would represent
> the chunk size to be used for comparison.  If it's zero, then
> BDRV_SECTOR_SIZE is used as default chunk size, which is the previous
> behaviour.
> 
> In particular, we're going to use this param in img_rebase() to make the
> write requests aligned to a predefined alignment value.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qemu-img.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 4dc91505bf..0f67b021f7 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1274,23 +1274,29 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
>  }
>  
>  /*
> - * Compares two buffers sector by sector. Returns 0 if the first
> - * sector of each buffer matches, non-zero otherwise.
> + * Compares two buffers chunk by chunk, where @chsize is the chunk size.
> + * If @chsize is 0, default chunk size of BDRV_SECTOR_SIZE is used.
> + * Returns 0 if the first chunk of each buffer matches, non-zero otherwise.
>   *
> - * pnum is set to the sector-aligned size of the buffer prefix that
> - * has the same matching status as the first sector.
> + * @pnum is set to the size of the buffer prefix aligned to @chsize that
> + * has the same matching status as the first chunk.
>   */
>  static int compare_buffers(const uint8_t *buf1, const uint8_t *buf2,
> -                           int64_t bytes, int64_t *pnum)
> +                           int64_t bytes, uint64_t chsize, int64_t *pnum)

uint64_t might be too large, depending on the platform. memcmp() takes
size_t, so in theory we can get truncation.

I assume that we won't see a problem in practice because you'll never
pass that large values, but I'd prefer making chsize size_t here.

Kevin


