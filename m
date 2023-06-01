Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD6719ED2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ihe-00038t-5G; Thu, 01 Jun 2023 09:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iha-0002tQ-Qx
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4ihY-00013C-Lp
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685627451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m4EmV5uPuvh5N0/Gimz/BODktXOlUM5UZdev3fZ8ZBw=;
 b=bK/lKNDVvd52bzyPs/tMi5eBxIRsb6htF/501X9CS/Nuc6DbhXq1UdroYdU96rxFcItb19
 etoMwCX6V3EQCXg7ETYHenzi+xQN1dqunEp9rVShSYdRBrzda18JrM6y8O59xzJKgs7Z1s
 lt8Fxz4ytrD8F+XmF0qivaFTX7NyuGA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-tuwMtM8lOii0vD_xpp3PEQ-1; Thu, 01 Jun 2023 09:50:50 -0400
X-MC-Unique: tuwMtM8lOii0vD_xpp3PEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48A9A8028B1;
 Thu,  1 Jun 2023 13:50:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DACE22166B25;
 Thu,  1 Jun 2023 13:50:49 +0000 (UTC)
Date: Thu, 1 Jun 2023 08:50:48 -0500
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 01/12] file-posix: remove incorrect coroutine_fn calls
Message-ID: <w7g7ibw4j4yipnhjbnjqyoxg5llnwr6t5pfwf4uvjilw63gwuw@mzxtxvdfhwfe>
References: <20230601115145.196465-1-pbonzini@redhat.com>
 <20230601115145.196465-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115145.196465-2-pbonzini@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 01, 2023 at 01:51:34PM +0200, Paolo Bonzini wrote:
> raw_co_getlength is called by handle_aiocb_write_zeroes, which is not a coroutine
> function.  This is harmless because raw_co_getlength does not actually suspend,
> but in the interest of clarity make it a non-coroutine_fn that is just wrapped
> by the coroutine_fn raw_co_getlength.  Likewise, check_cache_dropped was only
> a coroutine_fn because it called raw_co_getlength, so it can be made non-coroutine
> as well.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/file-posix.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 

> @@ -2696,7 +2696,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>      }
>  
>      if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
> -        int64_t cur_length = raw_co_getlength(bs);
> +        int64_t cur_length = raw_getlength(bs);

Shouldn't this one still call the raw_co_getlength() wrapper?

> @@ -3245,7 +3250,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
>           * round up if necessary.
>           */
>          if (!QEMU_IS_ALIGNED(*pnum, bs->bl.request_alignment)) {
> -            int64_t file_length = raw_co_getlength(bs);
> +            int64_t file_length = raw_getlength(bs);

Likewise this one?

>  
>  static bool coroutine_fn cdrom_co_is_inserted(BlockDriverState *bs)
>  {
> -    return raw_co_getlength(bs) > 0;
> +    return raw_getlength(bs) > 0;
>  }

and this one?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


