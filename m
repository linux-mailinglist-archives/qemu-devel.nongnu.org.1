Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34878FABA0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 09:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOLG-0008En-N6; Tue, 04 Jun 2024 03:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEOLE-0008Do-IM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEOLA-0002PQ-GS
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FcB9ETi94T1Sg4UsIahfY5q2MFlrFvPSkqweeCBgCgQ=;
 b=hGyJ1giCkDrn69R2Ul32xPiCl8+H3CDVqOpV9Xe0hp2fAbQH22cF5qqjZsoQxhltDDKQTR
 vH+pZ7yYHZBmKHo8dDTBQMjqlCc6OUBq5+nLaAsyYOOKxBx/yDtB8U7QqFnTnGB6xlhz7o
 uvtLPLfps2PBiEP1nwo5f+tos40yaGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-33QwUMzeMaK69hfFc_53BQ-1; Tue, 04 Jun 2024 03:12:12 -0400
X-MC-Unique: 33QwUMzeMaK69hfFc_53BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D00C80027E;
 Tue,  4 Jun 2024 07:12:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D16E227EC;
 Tue,  4 Jun 2024 07:12:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F2FCB21E6757; Tue,  4 Jun 2024 09:12:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org,  jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org,  gregory.price@memverge.com,
 ira.weiny@intel.com,  dan.j.williams@intel.com,
 a.manzanares@samsung.com,  dave@stgolabs.net,  nmtadam.samsung@gmail.com,
 jim.harris@samsung.com,  Jorgen.Hansen@wdc.com,  wj28.lee@gmail.com,
 mst@redhat.com,  Fan Ni <fan.ni@samsung.com>,  Svetly Todorov
 <svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240523174651.1089554-12-nifan.cxl@gmail.com> (nifan cxl's
 message of "Thu, 23 May 2024 10:44:51 -0700")
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20240523174651.1089554-12-nifan.cxl@gmail.com>
Date: Tue, 04 Jun 2024 09:12:09 +0200
Message-ID: <87o78hb2ra.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TRACKER_ID=0.1,
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

nifan.cxl@gmail.com writes:

> From: Fan Ni <fan.ni@samsung.com>
>
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
>
> With the change, we allow to release an extent only when its DPA range
> is contained by a single accepted extent in the device. That is to say,
> extent superset release is not supported yet.
>
> 1. Add dynamic capacity extents:
>
> For example, the command to add two continuous extents (each 128MiB long)
> to region 0 (starting at DPA offset 0) looks like below:
>
> { "execute": "qmp_capabilities" }
>
> { "execute": "cxl-add-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "selection-policy": "prescriptive",
>       "region": 0,
>       "extents": [
>       {
>           "offset": 0,
>           "len": 134217728
>       },
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> 2. Release dynamic capacity extents:
>
> For example, the command to release an extent of size 128MiB from region 0
> (DPA offset 128MiB) looks like below:
>
> { "execute": "cxl-release-dynamic-capacity",
>   "arguments": {
>       "path": "/machine/peripheral/cxl-dcd0",
>       "host-id": 0,
>       "removal-policy":"prescriptive",
>       "region": 0,
>       "extents": [
>       {
>           "offset": 134217728,
>           "len": 134217728
>       }
>       ]
>   }
> }
>
> Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4281726dec..57d9f82014 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -361,3 +361,146 @@
>  ##
>  {'command': 'cxl-inject-correctable-error',
>   'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
> +
> +##
> +# @CXLDynamicCapacityExtent:

Three existing type names start with Cxl, and only one starts with CXL.
Please make your new ones start with Cxl, not CXL:
CxlDynamicCapacityExtent.

> +#
> +# A single dynamic capacity extent
> +#
> +# @offset: The offset (in bytes) to the start of the region
> +#     where the extent belongs to.
> +#
> +# @len: The length of the extent in bytes.

What is this?  Memory?

> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'CXLDynamicCapacityExtent',
> +  'data': {
> +      'offset':'uint64',
> +      'len': 'uint64'
> +  }
> +}
> +
> +##
> +# @CXLExtSelPolicy:

CxlExtentSelectionPolicy

> +#
> +# The policy to use for selecting which extents comprise the added
> +# capacity, as defined in cxl spec r3.1 Table 7-70.

Use the official title: "as defined in the CXL Specification 3.1" (I
think, the actual document is behind a click-through agreement).

> +#
> +# @free: 0h = Free
> +#
> +# @contiguous: 1h = Continuous

What does "1h =" mean?  The numeric encoding?

What exactly is "contiguous" / "continuous"?  I figure it's clear enough
if you have the CXL spec open in another window.  Can we condense it
into one phrase for use here?

> +#
> +# @prescriptive: 2h = Prescriptive
> +#
> +# @enable-shared-access: 3h = Enable Shared Access

Similar questions.

> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'CXLExtSelPolicy',
> +  'data': ['free',
> +           'contiguous',
> +           'prescriptive',
> +           'enable-shared-access']
> +}
> +
> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to initiate to add dynamic capacity extents to a host.  It

"Initiate adding dynamic capacity extents"

When a command initiates something, we commonly need a way to detect
completion, and sometimes need a way to track progress.

How can we detect completion, and if we can't, why's that okay?

Can adding capacity fail after the command succeeded?  If yes, how can
we detect that?

How long until completion after the command succeeded?  Unbounded time?

> +# simulates operations defined in cxl spec r3.1 7.6.7.6.5.

"defined in the CXL Specification 3.1 section 7.6.7.6.5"

More of the same below, not noting it again.

> +#
> +# @path: CXL DCD canonical QOM path.

Sure the QOM path needs to be canonical?

If not, what about "path to the CXL dynamic capacity device in the QOM
tree".  Intentionally close to existing descriptions of @qom-path
elsewhere.

> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# @selection-policy: The "Selection Policy" bits as defined in
> +#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
> +#     selecting which extents comprise the added capacity.
> +#
> +# @region: The "Region Number" field as defined in cxl spec r3.1
> +#     Table 7-70.  The dynamic capacity region where the capacity
> +#     is being added.  Valid range is from 0-7.

Scratch the second sentence?

> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-70.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-add-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'selection-policy': 'CXLExtSelPolicy',
> +            'region': 'uint8',
> +            '*tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}
> +
> +##
> +# @CXLExtRemovalPolicy:

CxlExtentRemovalPolicy

> +#
> +# The policy to use for selecting which extents comprise the released
> +# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
> +#
> +# @tag-based: value = 0h.  Extents are selected by the device based
> +#     on tag, with no requirement for contiguous extents.
> +#
> +# @prescriptive: value = 1h.  Extent list of capacity to release is
> +#     included in the request payload.

I guess "value = ..." documents the numeric value.  Sure that's useful
here?

> +#
> +# Since: 9.1
> +##
> +{ 'enum': 'CXLExtRemovalPolicy',
> +  'data': ['tag-based',
> +           'prescriptive']
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to initiate to release dynamic capacity extents from a

"Initiate releasing dynamic capacity extents"

When a command initiates something, we commonly need a way to detect
completion, and sometimes need a way to track progress.  See
cxl-add-dynamic-capacity above.

> +# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
> +#
> +# @path: CXL DCD canonical QOM path.

My comment on cxl-add-dynamic-capacity argument @path applies.

> +#
> +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
> +#     spec r3.1 Table 7-71.
> +#
> +# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
> +#     Table 7-71.  When set, device does not wait for a Release

"the device"

> +#     Dynamic Capacity command from the host.  Host immediately
> +#     loses access to released capacity.

"Instead, the host immediately loses"

> +#
> +# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
> +#     Table 7-71.  When set, device should sanitize all released

"the device"

> +#     capacity as a result of this request.

What does it mean "to sanitize capacity"?  Is this about scrubbing the
memory?

> +#
> +# @region: The "Region Number" field as defined in cxl spec r3.1
> +#     Table 7-71.  The dynamic capacity region where the capacity
> +#     is being added.  Valid range is from 0-7.

My comment on cxl-add-dynamic-capacity argument @region applies.

> +#
> +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> +#
> +# @extents: The "Extent List" field as defined in cxl spec r3.1
> +#     Table 7-71.
> +#
> +# Since : 9.1
> +##
> +{ 'command': 'cxl-release-dynamic-capacity',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'removal-policy': 'CXLExtRemovalPolicy',
> +            '*forced-removal': 'bool',
> +            '*sanitize-on-release': 'bool',
> +            'region': 'uint8',
> +            '*tag': 'str',
> +            'extents': [ 'CXLDynamicCapacityExtent' ]
> +           }
> +}


