Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941F9C181F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Nov 2024 09:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KSm-0001xA-Rd; Fri, 08 Nov 2024 03:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t9KSi-0001wr-Nb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t9KSg-0007ja-T9
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731054920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4z0O8cYTVlZ5pffZrr91loJUM8OJysxwoF6vCFbY0FA=;
 b=docw+Tmx9Cb6yEVgiJfqXacAe1jxfCc+RM9+KU6LpomdnHUrRFiGDPfnTFKHtRWhLLzGOQ
 hEYMhnvoK+wYFqt/LsYKlWrR4q+2lg2SDIkEhXSQJiCdyUBxsqPQ47zIUorwIltuhofIFN
 inSWsjJXHSQIg3CVecMBgvWtVTzfPQA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-zUv3BYBROOK1pReTqsHLEg-1; Fri,
 08 Nov 2024 03:35:18 -0500
X-MC-Unique: zUv3BYBROOK1pReTqsHLEg-1
X-Mimecast-MFC-AGG-ID: zUv3BYBROOK1pReTqsHLEg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF96A1956069; Fri,  8 Nov 2024 08:35:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9506D1956054; Fri,  8 Nov 2024 08:35:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88DCC21E6A28; Fri,  8 Nov 2024 09:35:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  qemu-block@nongnu.org,  eblake@redhat.com,
 armbru@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi: fix device-sync-config since-version
In-Reply-To: <20241108071957.727286-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 8 Nov 2024 10:19:57 +0300")
References: <20241108071957.727286-1-vsementsov@yandex-team.ru>
Date: Fri, 08 Nov 2024 09:35:08 +0100
Message-ID: <87v7wydsxv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Actually it comes in 9.2, not 9.1.
>
> Fixes: 3f98408e2e ("qapi: introduce device-sync-config")
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qapi/qdev.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 2a581129c9..25cbcf977b 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -182,7 +182,7 @@
>  #
>  # @unstable: The command is experimental.
>  #
> -# Since: 9.1
> +# Since: 9.2
>  ##
>  { 'command': 'device-sync-config',
>    'features': [ 'unstable' ],

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Michael, can you take this through your tree?


