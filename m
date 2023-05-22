Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2578270B6F1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10Gh-0008IT-3R; Mon, 22 May 2023 03:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10Ge-0008ID-AG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10Gc-0004UH-KM
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684741661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VO5u3qLvUSTWr+iOxKggEsysxts1br5aWt9KTefkE0=;
 b=Y6yveICxGmNhhPMzC7kgxWsFPtLt0ujR4jv+AUjGV6yVPSBYEZjOc6DM6BncGGflqncn4l
 OyYPbN6Wya3MlPdtE+pwuNtI6U9SL3VVuuPeyai3fK3ok/EutAdJ9p116r/C8ckkzf79fI
 BAvWvCTaPqyUZSHby6w1KsEBeMQl3Uo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-p-0bd962PAG0rI5o9JoJeg-1; Mon, 22 May 2023 03:47:36 -0400
X-MC-Unique: p-0bd962PAG0rI5o9JoJeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6427811E7C;
 Mon, 22 May 2023 07:47:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B69F40CFD45;
 Mon, 22 May 2023 07:47:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30F3821E692E; Mon, 22 May 2023 09:47:34 +0200 (CEST)
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
Subject: Re: [PATCH v5 7/7] hw/cxl/events: Add injection of Memory Module
 Events
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
 <20230423165140.16833-8-Jonathan.Cameron@huawei.com>
Date: Mon, 22 May 2023 09:47:34 +0200
In-Reply-To: <20230423165140.16833-8-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Sun, 23 Apr 2023 17:51:40 +0100")
Message-ID: <877ct0q02x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

> These events include a copy of the device health information at the
> time of the event. Actually using the emulated device health would
> require a lot of controls to manipulate that state.  Given the aim
> of this injection code is to just test the flows when events occur,
> inject the contents of the device health state as well.
>
> Future work may add more sophisticate device health emulation
> including direct generation of these records when events occur
> (such as a temperature threshold being crossed).  That does not
> reduce the usefulness of this more basic generation of the events.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 190db58385..aae70667c2 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -90,6 +90,41 @@
>              '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>             }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0 8.2.9.2.1.3)

End the sentence with a period, please.

> +# This event includes a copy of the Device Health info at the time of
> +# the event.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @type: Device Event Type (see spec for permitted values)
> +# @health-status: Overall health summary bitmap (see spec for permitted bits)
> +# @media-status: Overall media health summary (see spec for permitted values)
> +# @additional-status: Complex field (see spec for meaning)

"spec" is not a word.  Yes, typing out references gets tedious, but your
readers will appreciate tediously unambiguous references.

> +# @life-used: Percentage (0-100) of factory expected life span
> +# @temperature: Device temperature in degrees Celsius
> +# @dirty-shutdown-count: Counter incremented whenever device is unable

Suggest something like "number of times the device has been unable to
determine whether data loss ..."

> +#                        to determine if data loss may have occurred.
> +# @corrected-volatile-error-count: Total number of correctable errors in
> +#                                  volatile memory
> +# @corrected-persistent-error-count: Total number correctable errors in
> +#                                    persistent memory
> +#
> +# Since: 8.1
> +##


Please format like

   ##
   # @cxl-inject-memory-module-event:
   #
   # Inject an event record for a Memory Module Event (CXL r3.0
   # 8.2.9.2.1.3).  This event includes a copy of the Device Health info
   # at the time of the event.
   #
   # @path: CXL type 3 device canonical QOM path
   #
   # @log: Event Log to add the event to
   #
   # @flags: header flags
   #
   # @type: Device Event Type (see spec for permitted values)
   #
   # @health-status: Overall health summary bitmap (see spec for
   #     permitted bits)
   #
   # @media-status: Overall media health summary (see spec for permitted
   #     values)
   #
   # @additional-status: Complex field (see spec for meaning)
   #
   # @life-used: Percentage (0-100) of factory expected life span
   #
   # @temperature: Device temperature in degrees Celsius
   #
   # @dirty-shutdown-count: Counter incremented whenever device is unable
   #     to determine if data loss may have occurred.
   #
   # @corrected-volatile-error-count: Total number of correctable errors
   #     in volatile memory
   #
   # @corrected-persistent-error-count: Total number correctable errors
   #     in persistent memory
   #
   # Since: 8.1
   ##

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

> +{ 'command': 'cxl-inject-memory-module-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags' : 'uint8',
> +            'type': 'uint8', 'health-status': 'uint8',
> +            'media-status': 'uint8', 'additional-status': 'uint8',
> +            'life-used': 'uint8', 'temperature' : 'int16',
> +            'dirty-shutdown-count': 'uint32',
> +            'corrected-volatile-error-count': 'uint32',
> +            'corrected-persistent-error-count': 'uint32'
> +            }}
> +
>  ##
>  # @cxl-inject-poison:
>  #


