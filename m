Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F1712763
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:21:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XM2-0005Qw-9V; Fri, 26 May 2023 09:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XLo-0005QP-Ay
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XLm-0000Tl-II
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685107161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ng1sb99r9g6y93ciXnJG76ZXnX1l2siF9h6qKanEa8A=;
 b=CBWxr2lQFH2FBVuKSByZuTJOMjTRos/c1lJeB3A4X+KKRcXY7hTJJepQsUysSzebBf35/7
 MMmzpV2Yqw1yjFRJU/NCDvAfwvn9PPR9QpSwettiy1UibxFf2Eua9rLx0+fK0CZLiG1UiA
 So4+66SupY7htLXNcab3ljPnFBUK+5M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-sT2yC6QUMp-nu6mitf0U2Q-1; Fri, 26 May 2023 09:19:20 -0400
X-MC-Unique: sT2yC6QUMp-nu6mitf0U2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E7E3800EA4;
 Fri, 26 May 2023 13:19:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E755C154D1;
 Fri, 26 May 2023 13:19:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD35321E692E; Fri, 26 May 2023 15:19:17 +0200 (CEST)
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
Subject: Re: [PATCH v7 5/7] hw/cxl/events: Add injection of General Media
 Events
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-6-Jonathan.Cameron@huawei.com>
Date: Fri, 26 May 2023 15:19:17 +0200
In-Reply-To: <20230522150947.11546-6-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Mon, 22 May 2023 16:09:45 +0100")
Message-ID: <87353j9qne.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> From: Ira Weiny <ira.weiny@intel.com>
>
> To facilitate testing provide a QMP command to inject a general media
> event.  The event can be added to the log specified.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v7: Various docs updates and field renames including a lot more
>     specification references.
> ---
>  qapi/cxl.json               |  79 +++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  20 +++++++
>  hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  10 ++++
>  4 files changed, 220 insertions(+)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4849fca776..7700e26a0d 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,85 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @CxlEventLog:
> +#
> +# CXL has a number of separate event logs for different types of
> +# events. Each such event log is handled and signaled independently.

Two spaces between sentences please, for consistency.

> +#
> +# @informational: Information Event Log
> +#
> +# @warning: Warning Event Log
> +#
> +# @failure: Failure Event Log
> +#
> +# @fatal: Fatal Event Log
> +#
> +# Since: 8.1
> +##
> +{ 'enum': 'CxlEventLog',
> +  'data': ['informational',
> +           'warning',
> +           'failure',
> +           'fatal']
> + }
> +
> +##
> +# @cxl-inject-general-media-event:
> +#
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1) This event type is reported via one of the event logs

Period at end of sentence, please:

   # 8.2.9.2.1.1).  This event type is reported via one of the event logs

> +# specified via the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: event log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @dpa: Device Physical Address (relative to @path device). Note lower
> +#       bits include some flags. See CXL r3.0 Table 8-43 General Media
> +#       Event Record, Physical Address.
> +#
> +# @descriptor: Memory Event Descriptor with additional memory
> +#              event information. See CXL r3.0 Table 8-43 General
> +#              Media Event Record, Memory Event Descriptor for bit
> +#              definitions.
> +#
> +# @type: Type of memory event that occurred. See CXL r3.0 Table 8-43
> +#        General Media Event Record, Memory Event Type for possible
> +#        values.
> +#
> +# @transaction-type: Type of first transaction that caused the event
> +#                    to occur. See CXL r3.0 Table 8-43 General Media
> +#                    Event Record, Transaction Type for possible
> +#                    values.
> +#
> +# @channel: The channel of the memory event location. A channel is
> +#           an interface that can be independently accessed for a
> +#           transaction.
> +#
> +# @rank: The rank of the memory event location. A rank is a set of
> +#        memory devices on a channel that together execute a
> +#        transaction.
> +#
> +# @device: Bitmask that represents all devices in the rank associated
> +#          with the memory event location.
> +#
> +# @component-id: Device specific component identifier for the event.
> +#                May describe a field replaceable sub-component of
> +#                the device.

Please format like

   # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
   #     Record Format, Event Record Flags for subfield definitions.
   #
   # @dpa: Device Physical Address (relative to @path device).  Note
   #     lower bits include some flags. See CXL r3.0 Table 8-43 General
   #     Media Event Record, Physical Address.
   #
   # @descriptor: Memory Event Descriptor with additional memory event
   #     information.  See CXL r3.0 Table 8-43 General Media Event
   #     Record, Memory Event Descriptor for bit definitions.
   #
   # @type: Type of memory event that occurred.  See CXL r3.0 Table 8-43
   #     General Media Event Record, Memory Event Type for possible
   #     values.
   #
   # @transaction-type: Type of first transaction that caused the event
   #     to occur.  See CXL r3.0 Table 8-43 General Media Event Record,
   #     Transaction Type for possible values.
   #
   # @channel: The channel of the memory event location.  A channel is an
   #     interface that can be independently accessed for a transaction.
   #
   # @rank: The rank of the memory event location.  A rank is a set of
   #     memory devices on a channel that together execute a transaction.
   #
   # @device: Bitmask that represents all devices in the rank associated
   #     with the memory event location.
   #
   # @component-id: Device specific component identifier for the event.
   #     May describe a field replaceable sub-component of the device.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-general-media-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'dpa': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8',
> +            '*device': 'uint32', '*component-id': 'str' } }
> +
>  ##
>  # @cxl-inject-poison:
>  #

With these tweaks
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


