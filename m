Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DBC7132AB
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 07:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2mmX-0005vB-OB; Sat, 27 May 2023 01:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2mmU-0005v2-ER
 for qemu-devel@nongnu.org; Sat, 27 May 2023 01:47:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2mmS-0008VJ-Iu
 for qemu-devel@nongnu.org; Sat, 27 May 2023 01:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685166474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2cLSz5x0dwcnYHsCNtEwKjeqH64D25OQDGG7RfrIVk=;
 b=Y/7x/ZTQL8QY+Y+Px2PaaqM0TfgYES+3qtdePEeLEIcAjItjVLnWabflwf7NVanrx+/DsE
 T0/s/TJs5XOajtarldWWPiWZpqK2MrqQZleWuQims1wyp2rU31c0a2TLpzULWZz8HEbFRd
 1VBchGtutjS1fCiJC5QNByEjBKkzb60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Rlj9xgpBPIaNmROQVmAEhQ-1; Sat, 27 May 2023 01:47:48 -0400
X-MC-Unique: Rlj9xgpBPIaNmROQVmAEhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83D87800B2A;
 Sat, 27 May 2023 05:47:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08421140E954;
 Sat, 27 May 2023 05:47:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9C0B21E692E; Sat, 27 May 2023 07:47:45 +0200 (CEST)
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
Subject: Re: [PATCH v8 5/7] hw/cxl/events: Add injection of General Media
 Events
References: <20230526171304.1613-1-Jonathan.Cameron@huawei.com>
 <20230526171304.1613-6-Jonathan.Cameron@huawei.com>
Date: Sat, 27 May 2023 07:47:45 +0200
In-Reply-To: <20230526171304.1613-6-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Fri, 26 May 2023 18:13:02 +0100")
Message-ID: <87y1la496m.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/cxl.json               |  74 ++++++++++++++++++++++++
>  include/hw/cxl/cxl_events.h |  20 +++++++
>  hw/mem/cxl_type3.c          | 111 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  10 ++++
>  4 files changed, 215 insertions(+)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index ed1c7eea3a..7f0b432767 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json

[...]

> +##
> +# @cxl-inject-general-media-event:
> +#
> +# Inject an event record for a General Media Event (CXL r3.0
> +# 8.2.9.2.1.1).  This event type is reported via one of the event logs
> +# specified via the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @log: event log to add the event to
> +#
> +# @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
> +#     Record Format, Event Record Flags for subfield definitions.
> +#
> +# @dpa: Device Physical Address (relative to @path device).  Note
> +#     lower bits include some flags. See CXL r3.0 Table 8-43 General

Two spaces between sentences for consistency, please.

> +#     Media Event Record, Physical Address.
> +#

[...]


