Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2D79EC2F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRUb-00059c-OF; Wed, 13 Sep 2023 11:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgRUX-00057S-EU
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qgRUV-000661-6b
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694617758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWQL6UPpuhLFdYF/nNsdP1WtDNqz+rD6lL+J0h+mVwM=;
 b=NNKjCz3BVL07nHn4Tr6U7rluXxokX7416UVIgJFUDGPoLrXa0So6Ep/L9kp9iB28N7oMHW
 1WyEY3R2ucnboIIo6rjIIhhYHJ8xIYgdw4b7ek8viZt1djB236xCUlNpZxSf2GIucRUY1E
 ofCIfAeDWnr36pG05bZoL7BqUO1+G+s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-mxOnM6oWNLCjJ6EK6_lAmA-1; Wed, 13 Sep 2023 11:09:15 -0400
X-MC-Unique: mxOnM6oWNLCjJ6EK6_lAmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36D80804BA4;
 Wed, 13 Sep 2023 15:09:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 840B910085AA;
 Wed, 13 Sep 2023 15:09:14 +0000 (UTC)
Date: Wed, 13 Sep 2023 10:09:12 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/3] iotests: improve 'not run' message for nbd-multiconn
 test
Message-ID: <alf6l3p3fljsbojtznh23dgqre54nocpfrz6bikub5njtruo6l@36rhlom2iwu7>
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906140917.559129-3-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 06, 2023 at 04:09:16PM +0200, Denis V. Lunev wrote:
> The test actually requires Python bindings to libnbd rather than libnbd
> itself. Clarify that inside the message.

Makes sense; distros have the freedom to break the upstream monolithic
libnbd project into smaller distribution packages for minimizing
dependencies for different functionalities.

> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  tests/qemu-iotests/tests/nbd-multiconn | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/tests/nbd-multiconn b/tests/qemu-iotests/tests/nbd-multiconn
> index b121f2e363..478a1eaba2 100755
> --- a/tests/qemu-iotests/tests/nbd-multiconn
> +++ b/tests/qemu-iotests/tests/nbd-multiconn
> @@ -142,4 +142,4 @@ if __name__ == '__main__':
>  
>          iotests.main(supported_fmts=['qcow2'])
>      except ImportError:
> -        iotests.notrun('libnbd not installed')
> +        iotests.notrun('Python bindings to libnbd are not installed')
> -- 
> 2.34.1
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


