Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB05712780
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2XUt-0007fh-TN; Fri, 26 May 2023 09:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XUr-0007fQ-Gq
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2XUp-0001yz-Bb
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685107718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1u+d0QLPLhu6u1ZtPtEQ+lNzfqu2BcTe91KHWNQ0VQ8=;
 b=U6TzniMFrsXkmgsa1Xa7vREo/F6XXGkgLZS/P94iRCapTCaPRobbX8ukx9QGgPnMLEY816
 jq/Ows1g7J8EIHeeBmjXAJyP4KRd2lIpoEu3GZgW5Hv6j7uKmGKmfu9zfeoB8zSSC45noV
 CWAjTHECjcUk7uZiK1kyGEaDNQXzmDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-aoUE_WSHMGab4WRhfpEl8w-1; Fri, 26 May 2023 09:28:35 -0400
X-MC-Unique: aoUE_WSHMGab4WRhfpEl8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6A1E8007D9;
 Fri, 26 May 2023 13:28:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DA91121314;
 Fri, 26 May 2023 13:28:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 856CF21E692E; Fri, 26 May 2023 15:28:32 +0200 (CEST)
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
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
Date: Fri, 26 May 2023 15:28:32 +0200
In-Reply-To: <20230522150947.11546-8-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Mon, 22 May 2023 16:09:47 +0100")
Message-ID: <87h6rz8bnj.fsf@pond.sub.org>
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
>
> ---
> v7: Expanded docs for qapi and added a lot of cross references to
>     the CXL revision 3.0 specification.
> ---
>  qapi/cxl.json               | 54 ++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h | 19 ++++++++++++
>  hw/mem/cxl_type3.c          | 62 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    | 12 +++++++
>  4 files changed, 147 insertions(+)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index ce9adcbc55..05c560cfe5 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -147,6 +147,60 @@
>              '*column': 'uint16', '*correction-mask': [ 'uint64' ]
>             }}
>  
> +##
> +# @cxl-inject-memory-module-event:
> +#
> +# Inject an event record for a Memory Module Event (CXL r3.0
> +# 8.2.9.2.1.3). # This event includes a copy of the Device Health

Stray '#'.

> +# info at the time of the event.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: Event Log to add the event to
> +#
> +# @flags: Event Record Flags. See CXL r3.0 Table 8-42 Common Event
> +#         Record Format, Event Record Flags for subfield definitions.
> +#
> +# @type: Device Event Type. See CXL r3.0 Table 8-45 Memory Module
> +#        Event Record for bit definitions for bit definiions.
> +#
> +# @health-status: Overall health summary bitmap. See CXL r3.0 Table
> +#                 8-100 Get Health Info Output Payload, Health Status
> +#                 for bit definitions.
> +#
> +# @media-status: Overall media health summary. See CXL r3.0 Table
> +#                8-100 Get Health Info Output Payload, Media Status
> +#                for bit definitions.
> +#
> +# @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
> +#                     Payload, Additional Status for subfield
> +#                     definitions.
> +#
> +# @life-used: Percentage (0-100) of factory expected life span.
> +#
> +# @temperature: Device temperature in degrees Celsius.
> +#
> +# @dirty-shutdown-count: Number of time the device has been unable to

Number of times

> +#                        determine whether data loss may have occurred.
> +#
> +# @corrected-volatile-error-count: Total number of correctable errors in
> +#                                  volatile memory.
> +#
> +# @corrected-persistent-error-count: Total number correctable errors in
> +#                                    persistent memory

Please format like

   # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
   #     Record Format, Event Record Flags for subfield definitions.
   #
   # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
   #     Event Record for bit definitions for bit definiions.
   #
   # @health-status: Overall health summary bitmap.  See CXL r3.0 Table
   #     8-100 Get Health Info Output Payload, Health Status for bit
   #     definitions.
   #
   # @media-status: Overall media health summary.  See CXL r3.0 Table
   #     8-100 Get Health Info Output Payload, Media Status for bit
   #     definitions.
   #
   # @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
   #     Payload, Additional Status for subfield definitions.
   #
   # @life-used: Percentage (0-100) of factory expected life span.
   #
   # @temperature: Device temperature in degrees Celsius.
   #
   # @dirty-shutdown-count: Number of time the device has been unable to
   #     determine whether data loss may have occurred.
   #
   # @corrected-volatile-error-count: Total number of correctable errors
   #     in volatile memory.
   #
   # @corrected-persistent-error-count: Total number correctable errors
   #     in persistent memory

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).


> +#
> +# Since: 8.1
> +##
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

With these tweaks
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


