Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DBB1C189
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 09:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYq6-0004A7-OW; Wed, 06 Aug 2025 03:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujYq1-00047f-Un
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:45:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ujYpz-0008Bl-VG
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754466323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sooN8WuM7O2jbxqRcl8D98tGoqGYnTOOmDPteNfeR3U=;
 b=G0COBkz/zTukNmeNZY/ULwjztKYfXm+jCVnbMUR3FbkoZJj/GihBjav2x8EebyJJUPxByK
 gXi0k56H5fdT8aknWwf14Qt+VRHjSZHyIsHDzvlrutoSBx0FxQOEFg/lBLmHZX0lvu3i4O
 VxZ7FqL01uA95902k6tf+XENvW2l6rA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-tsJbwsEHNdaVTIU50_YHHg-1; Wed,
 06 Aug 2025 03:45:18 -0400
X-MC-Unique: tsJbwsEHNdaVTIU50_YHHg-1
X-Mimecast-MFC-AGG-ID: tsJbwsEHNdaVTIU50_YHHg_1754466317
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B4AD195608A; Wed,  6 Aug 2025 07:45:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA191800447; Wed,  6 Aug 2025 07:45:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79AE921E6A27; Wed, 06 Aug 2025 09:45:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: shiju.jose--- via <qemu-devel@nongnu.org>
Cc: <linux-cxl@vger.kernel.org>,  <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>,  <dave@stgolabs.net>,  <shiju.jose@huawei.com>,
 <linuxarm@huawei.com>
Subject: Re: [PATCH qemu v4 1/7] hw/cxl/events: Update for rev3.2 common
 event record format
In-Reply-To: <20250721172228.2118-2-shiju.jose@huawei.com> (shiju jose's
 message of "Mon, 21 Jul 2025 18:22:22 +0100")
References: <20250721172228.2118-1-shiju.jose@huawei.com>
 <20250721172228.2118-2-shiju.jose@huawei.com>
Date: Wed, 06 Aug 2025 09:45:12 +0200
Message-ID: <87wm7gq4fr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

shiju.jose--- via <qemu-devel@nongnu.org> writes:

> From: Shiju Jose <shiju.jose@huawei.com>
>
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
>
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8f2e9237b1..c1fe8319c8 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -42,6 +42,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-43 General
>  #     Media Event Record, Physical Address.

From docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

> @@ -73,7 +85,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-general-media-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +	    '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +	    '*ld-id':'uint16', '*head-id':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8',
> @@ -93,6 +107,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @dpa: Device Physical Address (relative to @path device).  Note
>  #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
>  #     Event Record, Physical Address.
> @@ -132,7 +158,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-dram-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint32',
> +	    '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +	    '*ld-id':'uint16', '*head-id':'uint8',
>              'dpa': 'uint64', 'descriptor': 'uint8',
>              'type': 'uint8', 'transaction-type': 'uint8',
>              '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> @@ -154,6 +182,18 @@
>  # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>  #     Record Format, Event Record Flags for subfield definitions.
>  #
> +# @maint-op-class: Maintenance operation class the device requests to initiate.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @maint-op-subclass: Maintenance operation subclass the device requests to
> +#     initiate. See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @ld-id: LD ID of LD from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
> +# @head-id: ID of the device head from where the event originated.
> +#     See CXL r3.2 Table 8-55 Common Event Record Format.
> +#
>  # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>  #     Event Record for bit definitions for bit definiions.
>  #
> @@ -184,7 +224,9 @@
>  # Since: 8.1
>  ##
>  { 'command': 'cxl-inject-memory-module-event',
> -  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint32',
> +	    '*maint-op-class':'uint8', '*maint-op-subclass':'uint8',
> +	    '*ld-id':'uint16', '*head-id':'uint8',
>              'type': 'uint8', 'health-status': 'uint8',
>              'media-status': 'uint8', 'additional-status': 'uint8',
>              'life-used': 'uint8', 'temperature' : 'int16',

This adds identical copies to three commands.

You can factor out common command arguments as follows.

1. Switch commands from implicit to explicit argument type.

    { 'command': 'cmd1', 'data': { ARGS1... } ... }

   becomes

    { 'struct': 'Args1', 'data': { ARGS1... } }
    { 'command': 'cmd1', 'data': 'Args1' ... }

2. Factor common base out of the argument types.

    { 'struct': 'Args1', 'data': { COMMON-ARGS..., SPECIAL-ARGS1... } }

   becomes

    { 'struct': 'Base, 'data': { COMMON-ARGS... } }
    { 'struct': 'Args1', 'base': 'Base', 'data': { SPECIAL-ARGS1... } }

3. Maybe use 'boxed': true with commands.

   The C function generated for a command with many arguments can be
   rather unwieldy.  'boxed': true makes it take the arguments as a
   single struct type instead.

This is not a demand.  Just give it a thought.


