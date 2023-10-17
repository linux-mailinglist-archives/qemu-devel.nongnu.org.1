Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C827B7CC6DF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qslWY-0007zj-UA; Tue, 17 Oct 2023 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qslWP-0007zX-3E
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qslWK-0000Vj-Bp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697554674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jfGIakZ3DxK0NypucjSmdsPcRPnlDFDzc7R9nHFgTwQ=;
 b=MODAgr9DF7zNBIfcVQaHVNOM8qYt9vN1ICKcB5pm4NP9B3AhHCgHfgSx2lhXlhchvm+MbI
 36nWo0ORK76yO9KG4aBrzzyNxkej1FGwZ+6u/ztFt6W9mWla9gEL5dZzTS6Tjz+ZHjlo01
 qcl9bL9FyK9VD2sBJA40Fibreo1/Lxo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-rnwlziI-Pq--ytfB1hIJRg-1; Tue, 17 Oct 2023 10:57:40 -0400
X-MC-Unique: rnwlziI-Pq--ytfB1hIJRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A8A858286;
 Tue, 17 Oct 2023 14:57:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C760B2166B26;
 Tue, 17 Oct 2023 14:57:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A1F1021E6A1F; Tue, 17 Oct 2023 16:57:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  eblake@redhat.com,
 dave@treblig.org,  eduardo@habkost.net,  berrange@redhat.com,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 raphael.norwitz@nutanix.com,  mst@redhat.com,  yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru,  daniil.tatianin@yandex.ru
Subject: Re: [PATCH 2/4] qapi: introduce device-sync-config
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-3-vsementsov@yandex-team.ru>
Date: Tue, 17 Oct 2023 16:57:37 +0200
In-Reply-To: <20231006202045.1161543-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 6 Oct 2023 23:20:43 +0300")
Message-ID: <87zg0h2t5q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add command to sync config from vhost-user backend to the device. It
> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> triggered interrupt to the guest or just not available (not supported
> by vhost-user server).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index fa80694735..2468f8bddf 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -315,3 +315,17 @@
>  # Since: 8.2
>  ##
>  { 'event': 'X_DEVICE_ON', 'data': 'DeviceAndPath' }
> +
> +##
> +# @x-device-sync-config:
> +#
> +# Sync config from backend to the guest.

"Sync" is not a word; "synchronize" is :)

> +#
> +# @id: the device's ID or QOM path
> +#
> +# Returns: Nothing on success
> +#          If @id is not a valid device, DeviceNotFound

Why not GenericError?  

> +#
> +# Since: 8.2
> +##
> +{ 'command': 'x-device-sync-config', 'data': {'id': 'str'} }

The commit message above and the error message below talk about command
device-sync-config, but you actually name it x-device-sync-config.

I figure you use x- to signify "unstable".  Please use feature flag
'unstable' for that.  See docs/devel/qapi-code-gen.rst section
"Features", in particular "Special features", and also the note on x- in
section "Naming rules and reserved names".

We tend to eschew abbreviations in QAPI schema names.
device-synchronize-config is quite a mouthful, though.  What do you
think?

> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 19c31446d8..b6da24389f 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -987,6 +987,29 @@ HotplugInfo *qmp_x_query_hotplug(const char *id, Error **errp)
>      return hotplug_handler_get_state(hotplug_ctrl, dev, errp);
>  }
>  
> +int qdev_sync_config(DeviceState *dev, Error **errp)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> +
> +    if (!dc->sync_config) {
> +        error_setg(errp, "device-sync-config is not supported for '%s'",
> +                   object_get_typename(OBJECT(dev)));
> +        return -ENOTSUP;
> +    }
> +
> +    return dc->sync_config(dev, errp);
> +}
> +
> +void qmp_x_device_sync_config(const char *id, Error **errp)
> +{
> +    DeviceState *dev = find_device_state(id, errp);

Not your patch's fault, but here goes anyway: when @id refers to a
non-device, find_device_state() fails with "is not a hotpluggable
device".  "hotpluggable" is misleading.

> +    if (!dev) {
> +        return;
> +    }
> +
> +    qdev_sync_config(dev, errp);
> +}
> +
>  void hmp_device_add(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;


