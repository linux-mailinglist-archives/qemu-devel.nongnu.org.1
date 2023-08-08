Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BA77442A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRE9-00063v-O5; Tue, 08 Aug 2023 14:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qTRE6-00063H-W6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qTRE5-0004so-MW
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691518477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NVu2LsdpSbDkyb2riWniYDRcMKsdf0tTivVS/I9UwM=;
 b=QpOCCMCSunVVe9IzP/Bq5PLN+9JsK1EEkrEUnxfd1mH75OThW5rlyVC03HfzNaAkhqyd+q
 BtfQddpRKXxstbUgMbDT94yDcYgJTNy9vsfm4TRKdc+d/Hyu1kl395yr/krQbODXYlzDXN
 gnJ98PKpD9/5ConkAav7FHxhp0vMTeM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-od-HllrbN-2fYOKaRmmh3A-1; Tue, 08 Aug 2023 14:14:33 -0400
X-MC-Unique: od-HllrbN-2fYOKaRmmh3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 150A63806736;
 Tue,  8 Aug 2023 18:14:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AD322166B25;
 Tue,  8 Aug 2023 18:14:31 +0000 (UTC)
Date: Tue, 8 Aug 2023 13:14:30 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/2] block: minimize bs->reqs_lock section in
 tracked_request_end()
Message-ID: <yffykpkv4p4ihbat3ahowrf3mcvz42l5onktrsnefwxrmkxetl@j5luqc7v6wob>
References: <20230808155852.2745350-1-stefanha@redhat.com>
 <20230808155852.2745350-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808155852.2745350-2-stefanha@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 08, 2023 at 11:58:51AM -0400, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/io.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/io.c b/block/io.c
> index 055fcf7438..85d5176256 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -593,8 +593,14 @@ static void coroutine_fn tracked_request_end(BdrvTrackedRequest *req)
>  
>      qemu_co_mutex_lock(&req->bs->reqs_lock);
>      QLIST_REMOVE(req, list);
> +    qemu_co_mutex_unlock(&req->bs->reqs_lock);
> +
> +    /*
> +     * At this point qemu_co_queue_wait(&req->wait_queue, ...) won't be called
> +     * anymore because the request has been removed from the list, so it's safe
> +     * to restart the queue outside reqs_lock to minimize the critical section.
> +     */
>      qemu_co_queue_restart_all(&req->wait_queue);
> -    qemu_co_mutex_unlock(&req->bs->reqs_lock);
>  }
>  
>  /**
> -- 
> 2.41.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


