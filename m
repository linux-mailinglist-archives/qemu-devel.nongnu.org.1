Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E770B660
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0zpy-0007Wz-SL; Mon, 22 May 2023 03:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q0zpu-0007Wp-QC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q0zps-0006SD-56
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684740003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9V4Z+Pxe9qIbxCcWDry2Az1P35E1LlASr3jNpJSfIY=;
 b=dt4RUMRwRj+RdyD6yLvZdS++AhevZtajKc9/qy9k+CM8QB4XvrsI9pfl3C4WHVlnW7UYEM
 D2hrZuhZAdIw5kucEnuKFTch4Q9MaFXDUveqsElIfqlcXIAO/xvAkzwKtEdIsmEL6yelrf
 +LesQMqwSadICApXuqTg4CjiOZ48iwY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-Sc-cUJLaMJKZhCJZR_Q_RQ-1; Mon, 22 May 2023 03:19:59 -0400
X-MC-Unique: Sc-cUJLaMJKZhCJZR_Q_RQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2781D802E58;
 Mon, 22 May 2023 07:19:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E5521121314;
 Mon, 22 May 2023 07:19:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8192B21E692E; Mon, 22 May 2023 09:19:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Fan Ni
 <fan.ni@samsung.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,  Mike Maslenkin
 <mike.maslenkin@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
 <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
Date: Mon, 22 May 2023 09:19:57 +0200
In-Reply-To: <20230423165140.16833-6-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Sun, 23 Apr 2023 17:51:38 +0100")
Message-ID: <87lehgq1cy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index ca3af3f0b2..9dcd308a49 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,56 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @CxlEventLog:
> +#
> +# CXL has a number of separate event logs for different types of event.

types of events

> +# Each such event log is handled and signaled independently.
> +#
> +# @informational: Information Event Log
> +# @warning: Warning Event Log
> +# @failure: Failure Event Log
> +# @fatal: Fatal Event Log

Are these proper nouns?  If not, the words should not be capitalized.

> +#
> +# Since: 8.1
> +##

Please format like

   ##
   # @CxlEventLog:
   #
   # CXL has a number of separate event logs for different types of
   # events.  Each such event log is handled and signaled independently.
   #
   # @informational: Information Event Log
   #
   # @warning: Warning Event Log
   #
   # @failure: Failure Event Log
   #
   # @fatal: Fatal Event Log
   #
   # Since: 8.1
   ##

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

The blank lines help with catching certain errors.  rST loves to
surprise...

> +{ 'enum': 'CxlEventLog',
> +  'data': ['informational',
> +           'warning',
> +           'failure',
> +           'fatal'
> +           ]

Make that
              'fatal']

> + }
> +
> +##
> +# @cxl-inject-gen-media-event:

Suggest cxl-inject-general-media-event, because we traditionally avoid
abbreviations in QMP, for better or worse.

> +#
> +# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.1.1)

What's "CXL r3.0", and where could a reader find it?

Aside: the idea of a document with numbered section nested six levels
deep is kind of horrifying :)

Again, capitalize "General Media Event" only if it's a proper noun.  If
"CXL r3.0" capitalizes it this way, it is.

> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to

event log

> +# @flags: header flags

Either specify the header flags here, or point to specification.

> +# @physaddr: Physical Address

Perhaps "Guest physical address"

Address of what?

We have no consistent naming convention for guest physical addresses.  I
see @addr, @memaddr, @gpa.  Let's not add yet another name for the same
thing without need.

> +# @descriptor: Descriptor

No.

> +# @type: Type

No.

> +# @transaction-type: Transaction Type

No.

> +# @channel: Channel

No.

> +# @rank: Rank

No.

> +# @device: Device

No.

See, I can do too terse, too!

> +# @component-id: Device specific string

Probably no.

> +#
> +# Since: 8.1
> +##

Again, please format like

   ##
   # @cxl-inject-general-media-event:
   #
   # Inject an event record for a General Media Event (CXL r3.0
   # 8.2.9.2.1.1) This event type is reported via one of the event logs
   # specified via the log parameter.
   #
   # @path: CXL type 3 device canonical QOM path
   #
   # @log: Event Log to add the event to
   #
   # @flags: header flags
   #
   # @physaddr: Physical Address
   #
   # @descriptor: Descriptor
   #
   # @type: Type
   #
   # @transaction-type: Transaction Type
   #
   # @channel: Channel
   #
   # @rank: Rank
   #
   # @device: Device
   #
   # @component-id: Device specific string
   #
   # Since: 8.1
   ##

> +{ 'command': 'cxl-inject-gen-media-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'physaddr': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8',
> +            '*device': 'uint32', '*component-id': 'str'
> +            }}

Make that

               '*device': 'uint32', '*component-id': 'str' } }

> +
>  ##
>  # @cxl-inject-poison:
>  #


