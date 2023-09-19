Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 089997A5E75
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 11:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXHi-0004yq-KT; Tue, 19 Sep 2023 05:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiXHZ-0004uM-Cy
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:44:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiXHX-0007Pl-N3
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 05:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695116674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=koZEi9vkyXslV4OU7C8l8laYlKffzDU3srbGrkTsXOY=;
 b=XcHGcAHrsob/HlqNSbVpQfc+QkOvtvfRPraJ00xrFncAcz2Nf1q0aVsPeogf1pKgmGMCK1
 4QG17YVOaIHwwOQXBbJtOEyCac8k7fGhhi1fqqlE12Pe5t77p1WweFXwHyyyYuYmEu0V+w
 Uaj6je5WqmDzakVZLLvrN8vLKKGrRW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-sWKiNggFMM-MMdybyiKI_g-1; Tue, 19 Sep 2023 05:44:23 -0400
X-MC-Unique: sWKiNggFMM-MMdybyiKI_g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DBB0801779;
 Tue, 19 Sep 2023 09:44:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31741C15BB8;
 Tue, 19 Sep 2023 09:44:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 390D621E6900; Tue, 19 Sep 2023 11:44:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  yc-core@yandex-team.ru,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  eblake@redhat.com,
 dave@treblig.org,  mst@redhat.com
Subject: Re: [PATCH v2] virtio: add VIRTQUEUE_ERROR QAPI event
References: <20230912175756.151047-1-vsementsov@yandex-team.ru>
Date: Tue, 19 Sep 2023 11:44:22 +0200
In-Reply-To: <20230912175756.151047-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 12 Sep 2023 20:57:56 +0300")
Message-ID: <877comzedl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
>
>  - collect statistics of such errors
>  - make immediate actions: take core dumps or do some other debugging
>  - inform the user through a management API or UI, so that (s)he can
>   react somehow, e.g. reset the device driver in the guest or even
>   build up some automation to do so
>
> Note that basically every inconsistency discovered during virtqueue
> processing results in a silent virtqueue stop.  The guest then just
> sees the requests getting stuck somewhere in the device for no visible
> reason.  This event provides a means to inform the management layer of
> this situation in a timely fashion.
>
> The event could be reused for some other virtqueue problems (not only
> for vhost devices) in future. For this it gets a generic name and
> structure.
>
> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---

[...]

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 6bc5a733b8..199e21cae7 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -161,3 +161,28 @@
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>    'data': { '*device': 'str', 'path': 'str' } }
> +
> +##
> +# @VirtqueueError:
> +#

Missing member documentation:

    # @vhost-vring-err: Lorem ipsum dolor sit amet, consectetur adipiscing
    #     elit, sed do eiusmod tempor incididunt ut labore et dolore magna
    #     aliqua.

> +# Since: 8.2
> +##
> +{ 'enum': 'VirtqueueError',
> +  'data': [ 'vhost-vring-err' ] }

Let's not abbreviate "error" to "err" here.

> +
> +##
> +# @VIRTQUEUE_ERROR:
> +#
> +# Emitted when a device virtqueue fails in runtime.
> +#
> +# @device: the device's ID if it has one
> +# @path: the device's QOM path
> +# @virtqueue: virtqueue index
> +# @error: error identifier
> +# @description: human readable description
> +#
> +# Since: 8.2
> +##
> +{ 'event': 'VIRTQUEUE_ERROR',
> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
> +            'error': 'VirtqueueError', 'description': 'str'} }


