Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A094712724
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2X37-0000Zs-OI; Fri, 26 May 2023 09:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2X2v-0000Zd-Dr
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2X2r-0004WL-Kl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685105987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SEEz8WD3fRD/3dScMN09HhNt93E6cjxf8Ki27er7b0=;
 b=Gv3Sm0zr0FfMRXGIcdEbXcrnyqTCbR9VFWKWWVPO68//VcNauygWravyxDRDMYqdGMsv2i
 U3KeA+RTuine344PmS5cO4vzLL5zsd5RINfyGweKdN9l84a5x9ZtfGixdJ90dVBXw7roT8
 19Hd207h4kfioY8rGmIq9iiuMGtDrtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-Ft24XO3LM6ykrZ4ts1Rv_g-1; Fri, 26 May 2023 08:59:42 -0400
X-MC-Unique: Ft24XO3LM6ykrZ4ts1Rv_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CD9C185A795;
 Fri, 26 May 2023 12:59:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 265D140CFD45;
 Fri, 26 May 2023 12:59:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0380821E692E; Fri, 26 May 2023 14:59:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Fan Ni
 <fan.ni@samsung.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Michael Roth
 <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Markus Armbruster <armbru@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 2/4] hw/cxl: QMP based poison injection support
References: <20230522145029.6370-1-Jonathan.Cameron@huawei.com>
 <20230522145029.6370-3-Jonathan.Cameron@huawei.com>
Date: Fri, 26 May 2023 14:59:39 +0200
In-Reply-To: <20230522145029.6370-3-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Mon, 22 May 2023 15:50:27 +0100")
Message-ID: <87edn39rk4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

> Inject poison using qmp command cxl-inject-poison to add an entry to the

QMP command

> poison list.
>
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List. So a normal memory read to an address
> that is on the poison list will not yet result in a synchronous exception
> (and similar for partial cacheline writes).
> That is left for a future patch.
>
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
>
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
>
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
>
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
>
> Adjusted to select a device on your machine.
>
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7:
>   Formatting changes requested by Markus Armbruster
> ---
>  qapi/cxl.json               | 21 +++++++++
>  include/hw/cxl/cxl.h        |  1 +
>  include/hw/cxl/cxl_device.h | 20 +++++++++
>  hw/cxl/cxl-mailbox-utils.c  | 90 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  6 +++
>  6 files changed, 194 insertions(+)
>
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index b21c9b4c1c..4849fca776 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,27 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-poison:
> +#
> +# Poison records indicate that a CXL memory device knows that a
> +# particular # memory region may be corrupted. This may be because of
> +# locally detected # errors (e.g. ECC failure) or poisoned writes
> +# received from other components in the system. This injection
> +# mechanism enables testing of the OS handling of poison records which
> +# may be queried via the CXL mailbox.

Delete the two stray '#' characters.

Two spaces between sentences for consistency, please.

Together:

   # Poison records indicate that a CXL memory device knows that a
   # particular memory region may be corrupted.  This may be because of
   # locally detected errors (e.g. ECC failure) or poisoned writes
   # received from other components in the system.  This injection
   # mechanism enables testing of the OS handling of poison records which
   # may be queried via the CXL mailbox.


> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @start: Start address - must be 64 byte aligned.
> +#
> +# @length: Length of poison to inject - must be a multiple of 64 bytes.

The ASCII minus character will be rendered as minus, not as dash.  Ugly.
You could use Unicode dash, but I'd recommend

   # @length: Length of poison to inject; must be a multiple of 64 bytes.

> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-poison',
> +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'size' }}
> +
>  ##
>  # @CxlUncorErrorType:
>  #

With these tweaks
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


