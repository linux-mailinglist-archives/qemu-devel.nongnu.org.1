Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71A712326
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TVF-0006Qp-UG; Fri, 26 May 2023 05:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2TVD-0006Q1-Tu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2TVC-0001eY-Fp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685092369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTgbFY+X6gh7CWke0cbo8IWGbnzSU6BzdXGh/4776Os=;
 b=bfW0kleoXJfENZEvOChC23CR/cROKcTdvytLmXcos9IvYBZMopLw63CUcNm4CaFI7G/HXT
 G2zKjrgaHDFwxnIJMuQx1BlRG7ziLh4ug/Jwk+Bsdf8t8XFOIWTL6GpqTRYRzV1JP+Po9x
 vrP3Jhm/kYhVoPHU0edSWrdHqR1ksrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-2DpJFnvlPx-NIU9ZvBQ88g-1; Fri, 26 May 2023 05:12:45 -0400
X-MC-Unique: 2DpJFnvlPx-NIU9ZvBQ88g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A4B7811E86;
 Fri, 26 May 2023 09:12:45 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 929402166B2B;
 Fri, 26 May 2023 09:12:43 +0000 (UTC)
Date: Fri, 26 May 2023 11:12:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Jo=E3o?= Silva <jsilva@suse.de>,
 Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 2/6] block: Mark bdrv_co_get_allocated_file_size() as
 mixed
Message-ID: <ZHB4CpsdCO4qg7NW@redhat.com>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523213903.18418-3-farosas@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 23.05.2023 um 23:38 hat Fabiano Rosas geschrieben:
> Some callers of this function are about to be converted to use
> coroutines, so allow it to be executed both inside and outside a
> coroutine.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This is not a sufficient justification for introducing a new mixed
function (we want to get rid of them, not add new ones).

You need to explain why the new coroutine callers can't directly call
bdrv_co_get_allocated_file_size() instead of going through the wrapper.
This is usually only the case if you have a function that doesn't know
whether it runs in coroutine context or not. Functions that you
explicitly convert to coroutine_fn know for sure.

>  include/block/block-io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index a27e471a87..c1f96faca5 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -87,7 +87,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
>  int64_t coroutine_fn GRAPH_RDLOCK
>  bdrv_co_get_allocated_file_size(BlockDriverState *bs);
>  
> -int64_t co_wrapper_bdrv_rdlock
> +int64_t co_wrapper_mixed_bdrv_rdlock
>  bdrv_get_allocated_file_size(BlockDriverState *bs);

You're changing bdrv_get_allocated_file_size() (which is the
function you really mean), but the subject line talks about
bdrv_co_get_allocated_file_size().

Kevin


