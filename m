Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EE7A272D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhEUi-0005q7-Bx; Fri, 15 Sep 2023 15:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qhEUg-0005pg-9P
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qhEUe-0004br-Jy
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694806123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jv+wXwbrvDNbB/o/cpNVT6Znyqt9z4qiX+MKmHil6Ls=;
 b=DGvPUIjQ0HUvFF/nc21CrgYRGPNkmmJ2VXe+fgDA3rk1ATeha3gFkAEkmIvuKAFPe5/cAj
 jB8ARWw21rZB+o90DBh3GQOIfnGTCpuzttMvNKuDvUeS4Ut3ba0tvRrCwIE/kTkueH8g7U
 z8a+2z4LXkCFm0qn9qP5om6dWJ/4Nw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-QTblvnLKPDGG7KqOYEXTig-1; Fri, 15 Sep 2023 15:28:39 -0400
X-MC-Unique: QTblvnLKPDGG7KqOYEXTig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BE70101B04A;
 Fri, 15 Sep 2023 19:28:39 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4386D200BC7F;
 Fri, 15 Sep 2023 19:28:38 +0000 (UTC)
Date: Fri, 15 Sep 2023 14:28:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH v2 4/8] qemu-img: add chunk size parameter to
 compare_buffers()
Message-ID: <wqgh7d253dkxdrzgikxo6oxipkxsf4g73i3dl7oapnknyg3r6k@2r3vepqbgz3o>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915162016.141771-5-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Sep 15, 2023 at 07:20:12PM +0300, Andrey Drobyshev wrote:
> Add @chsize param to the function which, if non-zero, would represent
> the chunk size to be used for comparison.  If it's zero, then
> BDRV_SECTOR_SIZE is used as default chunk size, which is the previous
> behaviour.
> 
> In particular, we're going to use this param in img_rebase() to make the
> write requests aligned to a predefined alignment value.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qemu-img.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index d12e4a4753..fcd31d7b5b 100644
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
> + * @pnum is set to the size of the buffer prefix aligned to @chsize that
>   * has the same matching status as the first sector.

s/sector/chunk/

With that,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


