Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB36282C2C7
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:33:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJWE-0007PL-FV; Fri, 12 Jan 2024 10:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOJW6-0007P3-55
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOJW3-00017Q-Rd
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705073534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4ZOZf0uCeLvPi5YNdo8XiIRLjLbs13iXLaYF+Bpw/I=;
 b=eo94vohAVxKG/u20JCBu1uGA3h3qprlB4TgsGUcDwG9KZK+nhZwOY63SObJ6sPU3yFZOKd
 WPtHPBFwU0otyMHQDuXNvz57pOrnEyJp7i3P3cFt2JfYoL4FifYkn9crM9JktBR0gg8b+H
 e1KcP9o8dOToAq1PhxIP1GrtDP/DGU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-PCU9tSVEMjmaqDy0MPl_Ww-1; Fri, 12 Jan 2024 10:32:10 -0500
X-MC-Unique: PCU9tSVEMjmaqDy0MPl_Ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA6A685A58C;
 Fri, 12 Jan 2024 15:32:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 151A6492BF0;
 Fri, 12 Jan 2024 15:32:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C99E921E680D; Fri, 12 Jan 2024 16:32:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  "Hao Xiang"
 <hao.xiang@bytedance.com>,  "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>,  "Ben Widawsky" <ben.widawsky@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>,  "Fan Ni"
 <fan.ni@samsung.com>,  "Ira Weiny" <ira.weiny@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  David Hildenbrand
 <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 linux-cxl@vger.kernel.org
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com> (Ho-Ren
 Chuang's message of "Sun, 31 Dec 2023 23:53:15 -0800")
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
Date: Fri, 12 Jan 2024 16:32:06 +0100
Message-ID: <87h6jilg95.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QAPI schema sanity review only.

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
>
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> 	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \
>
> In v1, we plan to move most of the implementations to util and break down
> this patch into different smaller patches.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

[...]

> diff --git a/qapi/common.json b/qapi/common.json
> index 6fed9cde1a..591fd73291 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -167,6 +167,25 @@
>  { 'enum': 'HostMemPolicy',
>    'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>  
> +##
> +# @HostMemType:
> +#
> +# Automatically find a backend memory type on host.

Types don't do, they are.  Suggest something like

   # Host memory types

> +# Can be further extened to support other types such as cxlpmem, hbm.

Doc comments are reference documentation for users of QMP.  This
sentence doesn't fit there.

> +#
> +# @none: do nothing (default).

Again, types don't do, they are.

(default) makes no sense here.  Types don't have defaults, optional
arguments do.  In this case, @host-mem-type below.

What kind of memory does this setting request?

> +#
> +# @cxlram: a CXL RAM backend on host.

Suggest to spell it cxl-ram.

> +#
> +# Note: HostMemType and HostMemPolicy/host-nodes cannot be set at the same
> +# time. HostMemType is used to automatically bind with one kind of
> +# host memory types.

I feel this note doesn't belong here.  Add it to the users of
HostMemType and HostMemPolicy instead.

> +#
> +# Since: 8.3
> +##
> +{ 'enum': 'HostMemType',
> +  'data': [ 'none', 'cxlram' ] }
> +

I guess you're adding this to common.json and not qom.json so it's next
to HostMemPolicy.  Okay.

>  ##
>  # @NetFilterDirection:
>  #
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 95516ba325..fa3bc29708 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -626,6 +626,7 @@
>              '*host-nodes': ['uint16'],
>              '*merge': 'bool',
>              '*policy': 'HostMemPolicy',
> +            '*host-mem-type': 'HostMemType',
>              '*prealloc': 'bool',
>              '*prealloc-threads': 'uint32',
>              '*prealloc-context': 'str',

Missing: doc comment update.

[...]


