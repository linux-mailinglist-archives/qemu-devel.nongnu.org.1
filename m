Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0DD7287F8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7L7I-0005SF-9X; Thu, 08 Jun 2023 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7L7B-0005OY-UD
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q7L79-0007nA-QB
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686251767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zccxy2A8vJpFSDkOqcwdI7gXFMfJgqVFM97TUuRWZAk=;
 b=JRPgFqWB0nDzWz11vqvop9/D9xHuSf3veCWCar9cZY6HWgkF5LQpQ5eGhtSNV0aGNgKmeP
 E9biFRj5VIZtXYLwtjxXz1RAvLKP647BDAFpJ14v5WZFG0avUi6gz+nYDUbtVQC+Kmq2rt
 Pvw7MIH/V76SRvC6H0tHyLhOBDYT5Q4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-gBfkedO3MXuD8wISyknT0g-1; Thu, 08 Jun 2023 15:16:03 -0400
X-MC-Unique: gBfkedO3MXuD8wISyknT0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63C34185A78B;
 Thu,  8 Jun 2023 19:16:03 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C1240D1B66;
 Thu,  8 Jun 2023 19:16:02 +0000 (UTC)
Date: Thu, 8 Jun 2023 14:15:56 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 libguestfs@redhat.com, qemu-block@nongnu.org, vsementsov@yandex-team.ru
Subject: Re: [Libguestfs] [PATCH v4 23/24] nbd/server: Prepare for
 per-request filtering of BLOCK_STATUS
Message-ID: <r3yru7q3g27ou4r4f3fmdxlilmhmvliksy6zovyh5zia35j3in@cijsy333zbvr>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-24-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608135653.2918540-24-eblake@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Thu, Jun 08, 2023 at 08:56:52AM -0500, Eric Blake wrote:
> The next commit will add support for the optional extension
> NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
> request that the server only return a subset of negotiated contexts,
> rather than all contexts.  To make that task easier, this patch
> populates the list of contexts to return on a per-command basis (for
> now, identical to the full set of negotiated contexts).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

> +++ b/nbd/server.c
> @@ -2491,6 +2491,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>              error_setg(errp, "No memory");
>              return -ENOMEM;
>          }
> +    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
> +        request->contexts = &client->contexts;
>      }

THere are paths where request->contexts is left NULL but request->type
was set...

> @@ -2841,6 +2848,11 @@ static coroutine_fn void nbd_trip(void *opaque)
>      } else {
>          ret = nbd_handle_request(client, &request, req->data, &local_err);
>      }
> +    if (request.type == NBD_CMD_BLOCK_STATUS &&
> +        request.contexts != &client->contexts) {
> +        g_free(request.contexts->bitmaps);
> +        g_free(request.contexts);
> +    }

so I think this also needs to be tweaked to check that
request.contexts is non-NULL before dereferencing to free bitmaps.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


