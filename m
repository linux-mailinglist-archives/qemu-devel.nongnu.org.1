Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31BF71277A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XST-0006ic-7v; Fri, 26 May 2023 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XSL-0006i7-3h
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XSG-0001aa-F1
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685107563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpE6fBo1uhBAwvJHIsd3MMI2XmaSxrfO3j8Ty99c4u4=;
 b=YUZ44EbHzKt71WQFS7FZ1ICUnHQRTyeOSBT5nrJthWNcQr3ma7ELxR23Jv3sjWQKbdk4iY
 Y1AKBVCT8Eo9VAGVRTz/vi1yl7X/lZVVbVSer3qHgxARvkQ0Z1wLn1dG1vGbEHH1DSvtMj
 5dnI+UxUpH/Ykzxls0MnqTiAS56yJB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-nQmp7LYnOMOnjblOaFRgfg-1; Fri, 26 May 2023 09:26:02 -0400
X-MC-Unique: nQmp7LYnOMOnjblOaFRgfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4715E811E91;
 Fri, 26 May 2023 13:26:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7FB3C15612;
 Fri, 26 May 2023 13:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E88A21E692E; Fri, 26 May 2023 15:25:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Fan Ni
 <fan.ni@samsung.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,  Mike Maslenkin
 <mike.maslenkin@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 6/7] hw/cxl/events: Add injection of DRAM events
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-7-Jonathan.Cameron@huawei.com>
Date: Fri, 26 May 2023 15:25:59 +0200
In-Reply-To: <20230522150947.11546-7-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Mon, 22 May 2023 16:09:46 +0100")
Message-ID: <87pm6n8brs.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> provides information related to DRAM devices.
>
> Example injection command in QMP:
>
> { "execute": "cxl-inject-dram-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "dpa": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "rank": 17,
>         "nibble-mask": 37421234,
>         "bank-group": 7,
>         "bank": 11,
>         "row": 2,
>         "column": 77,
>         "correction-mask": [33, 44, 55,66]
>     }}
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v7: Additional documentation, plus rename physaddr to dpa reduce
>     confusion
> ---
>  qapi/cxl.json               |  63 ++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  23 +++++++
>  hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  13 ++++
>  4 files changed, 215 insertions(+)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 7700e26a0d..ce9adcbc55 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -84,6 +84,69 @@
>              '*channel': 'uint8', '*rank': 'uint8',
>              '*device': 'uint32', '*component-id': 'str' } }
>  
> +##
> +# @cxl-inject-dram-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)

Period at end of sentence, please.

> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: Event log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @dpa: Device Physical Address (relative to @path device). Note lower
> +#       bits include some flags. See CXL r3.0 Table 8-44 DRAM Event
> +#       Record, Physical Address.
> +#
> +# @descriptor: Memory Event Descriptor with additional memory
> +#              event information. See CXL r3.0 Table 8-44 DRAM Event
> +#              Record, Memory Event Descriptor for bit definitions.
> +#
> +# @type: Type of memory event that occurred. See CXL r3.0 Table 8-44
> +#        DRAM Event Record, Memory Event Type for possible values.
> +#
> +# @transaction-type: Type of first transaction that caused the event
> +#                    to occur. See CXL r3.0 Table 8-44 DRAM Event
> +#                    Record, Transaction Type for possible values.
> +#
> +# @channel: The channel of the memory event location.  A channel is
> +#           an interface that can be independently accessed for a
> +#           transaction.
> +#
> +# @rank: The rank of the memory event location. A rank is a set of
> +#        memory devices on a channel that together execute a
> +#        transaction.
> +#
> +# @nibble-mask: Identify one or more nibbles that the error affects

"Identifies", I think.

> +#
> +# @bank-group: Bank group of the memory event location, incorporating
> +#              a number of Banks.
> +#
> +# @bank: Bank of the memory event location. A single bank is accessed
> +#        per read or write of the memory.
> +#
> +# @row: Row address within the DRAM.
> +#
> +# @column: Column address within the DRAM.
> +#
> +# @correction-mask: Bits within each nibble. Used in order of bits set
> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.

Please format like

   # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
   #     Record Format, Event Record Flags for subfield definitions.
   #
   # @dpa: Device Physical Address (relative to @path device).  Note
   #     lower bits include some flags.  See CXL r3.0 Table 8-44 DRAM
   #     Event Record, Physical Address.
   #
   # @descriptor: Memory Event Descriptor with additional memory event
   #     information.  See CXL r3.0 Table 8-44 DRAM Event Record, Memory
   #     Event Descriptor for bit definitions.
   #
   # @type: Type of memory event that occurred.  See CXL r3.0 Table 8-44
   #     DRAM Event Record, Memory Event Type for possible values.
   #
   # @transaction-type: Type of first transaction that caused the event
   #     to occur.  See CXL r3.0 Table 8-44 DRAM Event Record,
   #     Transaction Type for possible values.
   #
   # @channel: The channel of the memory event location.  A channel is an
   #     interface that can be independently accessed for a transaction.
   #
   # @rank: The rank of the memory event location.  A rank is a set of
   #     memory devices on a channel that together execute a transaction.
   #
   # @nibble-mask: Identifies one or more nibbles that the error affects
   #
   # @bank-group: Bank group of the memory event location, incorporating
   #     a number of Banks.
   #
   # @bank: Bank of the memory event location.  A single bank is accessed
   #     per read or write of the memory.
   #
   # @row: Row address within the DRAM.
   #
   # @column: Column address within the DRAM.
   #
   # @correction-mask: Bits within each nibble.  Used in order of bits
   #     set in the nibble-mask.  Up to 4 nibbles may be covered.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'dpa': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +           }}
> +
>  ##
>  # @cxl-inject-poison:
>  #

With these tweaks
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


