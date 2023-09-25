Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D7B7AD6D7
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjaM-0003wM-Gj; Mon, 25 Sep 2023 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkjaI-0003vm-Rq
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qkjaD-0008HG-1U
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695640614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMBXKSASeR1RNOF89AhJv31YL4HA7Na9VE12bIYNhsg=;
 b=jPzdXzHOpQEddFkkBd/ZdEJYqV2JUf43RyxM39MDLYqR2DUXqhzeZ6ss4gr4F/AmhAExkV
 EC5o5EaAEpvLzTR1WO+CKVIV+T1x4+V7WKhUJ6+TzL4O6o+72YvHlB4EyMXuxZ7aXYkHxA
 zLVS49h9fvkzHvE5p6gX5msGgmPtPkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-gjyTLmcMNMODJlh2A1oZUA-1; Mon, 25 Sep 2023 07:16:50 -0400
X-MC-Unique: gjyTLmcMNMODJlh2A1oZUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB061101A529;
 Mon, 25 Sep 2023 11:16:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6837E2156701;
 Mon, 25 Sep 2023 11:16:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BBE121E6900; Mon, 25 Sep 2023 13:16:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v7 5/7] qapi: Add query-memory-devices support to
 hv-balloon
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <a9f908446234de087ab5857f53a9449173f809dc.1693240836.git.maciej.szmigiero@oracle.com>
Date: Mon, 25 Sep 2023 13:16:48 +0200
In-Reply-To: <a9f908446234de087ab5857f53a9449173f809dc.1693240836.git.maciej.szmigiero@oracle.com>
 (Maciej S. Szmigiero's message of "Mon, 28 Aug 2023 18:48:22 +0200")
Message-ID: <871qem8pun.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Used by the driver to report its provided memory state information.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576cac6..5ede977cf2bc 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1265,6 +1265,29 @@
>            }
>  }
>  
> +##
> +# @HvBalloonDeviceInfo:
> +#
> +# hv-balloon provided memory state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @max-size: the maximum size of memory that the device can provide
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HvBalloonDeviceInfo',
> +  'data': { '*id': 'str',
> +            '*memaddr': 'size',
> +            'max-size': 'size',
> +            '*memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfoKind:
>  #
> @@ -1276,10 +1299,13 @@
>  #
>  # @sgx-epc: since 6.2.
>  #
> +# @hv-balloon: since 8.2.
> +#

Not this patch's fault: documentation linking enum values and device
types would be nice.

>  # Since: 2.1
>  ##
>  { 'enum': 'MemoryDeviceInfoKind',
> -  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc' ] }
> +  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> +            'hv-balloon' ] }
>  
>  ##
>  # @PCDIMMDeviceInfoWrapper:
> @@ -1313,6 +1339,14 @@
>  { 'struct': 'SgxEPCDeviceInfoWrapper',
>    'data': { 'data': 'SgxEPCDeviceInfo' } }
>  
> +##
> +# @HvBalloonDeviceInfoWrapper:
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HvBalloonDeviceInfoWrapper',
> +  'data': { 'data': 'HvBalloonDeviceInfo' } }
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
> @@ -1327,7 +1361,8 @@
>              'nvdimm': 'PCDIMMDeviceInfoWrapper',
>              'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>              'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
> -            'sgx-epc': 'SgxEPCDeviceInfoWrapper'
> +            'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
>            }
>  }
>  

Acked-by: Markus Armbruster <armbru@redhat.com>


