Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6187CD983
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt43f-0008GJ-Hv; Wed, 18 Oct 2023 06:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt43b-0008CX-EC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt43X-00063V-Gk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697625938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PhkLQkfbLQ+nqrFkH2XKOdJiKMtp9F33jvN3et6OBCU=;
 b=CMMcOd2Gq1dRhUDD3xX1WR+PHsvlYPEcvIGZdDW00XB1JA5AuiKsq9I1IcQa01FuX0iQbl
 XMoR8+Ke2kNnGwUpU7G1T/vrggK0w15oDqt0Gb1yqoborAIjrdEYToJ0qHPt/Vzwmq2Mnd
 m+zeSenaMUWv30ot643NyaSrRlRkeJQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-u_knbaJGNj2VTcXcQ5bhhQ-1; Wed, 18 Oct 2023 06:45:34 -0400
X-MC-Unique: u_knbaJGNj2VTcXcQ5bhhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75EA93822540;
 Wed, 18 Oct 2023 10:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BD192026D4C;
 Wed, 18 Oct 2023 10:45:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E280B21E6A1F; Wed, 18 Oct 2023 12:45:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 den@openvz.org,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v8 4/7] qapi: add x-blockdev-replace command
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
 <20231017184444.932733-5-vsementsov@yandex-team.ru>
Date: Wed, 18 Oct 2023 12:45:31 +0200
In-Reply-To: <20231017184444.932733-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Oct 2023 21:44:41 +0300")
Message-ID: <874jiotdis.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

> Add a command that can replace bs in following BdrvChild structures:
>
>  - qdev blk root child
>  - block-export blk root child
>  - any child of BlockDriverState selected by child-name
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 89751d81f2..cf92e0df8b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -6054,3 +6054,86 @@
>  ##
>  { 'struct': 'DummyBlockCoreForceArrays',
>    'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
> +
> +##
> +# @BlockParentType:
> +#
> +# @qdev: block device, such as created by device_add, and denoted by
> +#     qdev-id
> +#
> +# @driver: block driver node, such as created by blockdev-add, and
> +#     denoted by node-name
> +#
> +# @export: block export, such created by block-export-add, and
> +#     denoted by export-id
> +#
> +# Since 8.2
> +##
> +{ 'enum': 'BlockParentType',
> +  'data': ['qdev', 'driver', 'export'] }
> +
> +##
> +# @BdrvChildRefQdev:
> +#
> +# @qdev-id: the device's ID or QOM path
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'BdrvChildRefQdev',
> +  'data': { 'qdev-id': 'str' } }
> +
> +##
> +# @BdrvChildRefExport:
> +#
> +# @export-id: block export identifier
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'BdrvChildRefExport',
> +  'data': { 'export-id': 'str' } }
> +
> +##
> +# @BdrvChildRefDriver:
> +#
> +# @node-name: the node name of the parent block node
> +#
> +# @child: name of the child to be replaced, like "file" or "backing"
> +#
> +# Since 8.2
> +##
> +{ 'struct': 'BdrvChildRefDriver',
> +  'data': { 'node-name': 'str', 'child': 'str' } }
> +
> +##
> +# @BlockdevReplace:
> +#
> +# @parent-type: type of the parent, which child is to be replaced
> +#
> +# @new-child: new child for replacement
> +#
> +# Since 8.2
> +##
> +{ 'union': 'BlockdevReplace',
> +  'base': {
> +      'parent-type': 'BlockParentType',
> +      'new-child': 'str'
> +  },
> +  'discriminator': 'parent-type',
> +  'data': {
> +      'qdev': 'BdrvChildRefQdev',
> +      'export': 'BdrvChildRefExport',
> +      'driver': 'BdrvChildRefDriver'
> +  } }
> +
> +##
> +# @x-blockdev-replace:
> +#
> +# Replace a block-node associated with device (selected by
> +# @qdev-id) or with block-export (selected by @export-id) or
> +# any child of block-node (selected by @node-name and @child)
> +# with @new-child block-node.
> +#
> +# Since 8.2
> +##
> +{ 'command': 'x-blockdev-replace', 'boxed': true,
> +  'data': 'BlockdevReplace' }
> diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
> new file mode 100644
> index 0000000000..0e751ce4f7
> --- /dev/null
> +++ b/stubs/blk-by-qdev-id.c
> @@ -0,0 +1,9 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend.h"
> +
> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
> +{
> +    error_setg(errp, "blk '%s' not found", id);

Is this expected to happen?

> +    return NULL;
> +}

[...]

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


