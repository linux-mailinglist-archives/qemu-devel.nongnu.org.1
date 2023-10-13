Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499107C86C3
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrIAE-00084l-0z; Fri, 13 Oct 2023 09:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrI9s-00081l-I3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qrI9q-0000k6-MU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697203489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VX/jgejW6aMFFwzflXjQEulCwC2lpnGl//1qqVFN0eQ=;
 b=KneyE4xMDsm40E0od/N0GQEurbQWCXvKu13RXzQwpYT5ezk3j6e/hLeHPiEuzAStl8/DCD
 hr0oW3WanXCPLur3PjaP4a0r8zHQrOQ5scZTCp6aeTfR1b70XJfQ+xLmDFnomxpNcyApEM
 IB4f+SetxrtrAEsQqCYFOvasfj0w/cY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-18D5wf4fNqq2Q9tYk3IJ9w-1; Fri, 13 Oct 2023 09:24:45 -0400
X-MC-Unique: 18D5wf4fNqq2Q9tYk3IJ9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 728D4185A7B2;
 Fri, 13 Oct 2023 13:24:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B89B1130514;
 Fri, 13 Oct 2023 13:24:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C3AF21E6A21; Fri, 13 Oct 2023 15:24:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  dave@treblig.org,
 mst@redhat.com,  yc-core@yandex-team.ru,  den-plotnikov@yandex-team.ru
Subject: Re: [PATCH v3] virtio: add VIRTQUEUE_ERROR QAPI event
References: <20231003075129.27440-1-vsementsov@yandex-team.ru>
Date: Fri, 13 Oct 2023 15:24:44 +0200
In-Reply-To: <20231003075129.27440-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 3 Oct 2023 10:51:29 +0300")
Message-ID: <87jzrqfyeb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>

[...]

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 6bc5a733b8..55d6c9018e 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -161,3 +161,31 @@
>  ##
>  { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>    'data': { '*device': 'str', 'path': 'str' } }
> +
> +##
> +# @VirtqueueError:
> +#
> +# @vhost-vring-error: Vhost device reported failure through
> +#     through vring error fd.
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'VirtqueueError',
> +  'data': [ 'vhost-vring-error' ] }
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

Please add blank lines between the @argument sections, to blend in with
recent commit a937b6aa739 (qapi: Reformat doc comments to conform to
current conventions).

> +#
> +# Since: 8.2
> +##
> +{ 'event': 'VIRTQUEUE_ERROR',
> + 'data': { '*device': 'str', 'path': 'str', 'virtqueue': 'int',
> +            'error': 'VirtqueueError', 'description': 'str'} }

With that:
Acked-by: Markus Armbruster <armbru@redhat.com>


