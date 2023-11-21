Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD47F2EA2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 14:43:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5R1V-00073r-VM; Tue, 21 Nov 2023 08:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r5R1T-00073H-OB
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:42:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r5R1N-0000S1-8N
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 08:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700574152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlYFEnNEXuVJ2jK7hLi5DVjd0cJwAVcEOEnl2hBsrZ4=;
 b=SdgZvVKjafba0pOBT5N+cxZ39+hST3E4pH9ASHXuIq86DDd96rJ8bldEQQTNdDnuvvi5Xy
 VrPIcjLOZUaJDmW3n52j9yEDjg+ei9rBSdzwnAGbVLcL/AfiZfgH5RtQYLYP+I7LHJgYck
 4aVNwL6cMDbzQRUXFnUxRGvRlz8Y9ys=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-HdwqmlDdOd6fFc4o8RuQKQ-1; Tue,
 21 Nov 2023 08:42:28 -0500
X-MC-Unique: HdwqmlDdOd6fFc4o8RuQKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BCDA3814EA4;
 Tue, 21 Nov 2023 13:42:28 +0000 (UTC)
Received: from [10.39.194.228] (unknown [10.39.194.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09E141121306;
 Tue, 21 Nov 2023 13:42:25 +0000 (UTC)
Message-ID: <4cdfaae2-1f9d-33b1-ccf9-eeba7d5e0b8e@redhat.com>
Date: Tue, 21 Nov 2023 14:42:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 04/16] hw/uefi: add var-service-guid.c
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, graf@amazon.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <20231115151242.184645-5-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231115151242.184645-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/15/23 16:12, Gerd Hoffmann wrote:
> Add variables for a bunch of GUIDs we will need.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/uefi/var-service-guid.c | 61 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 hw/uefi/var-service-guid.c
> 
> diff --git a/hw/uefi/var-service-guid.c b/hw/uefi/var-service-guid.c
> new file mode 100644
> index 000000000000..afdc15c4e7e6
> --- /dev/null
> +++ b/hw/uefi/var-service-guid.c
> @@ -0,0 +1,61 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi vars device - GUIDs
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/dma.h"
> +
> +#include "hw/uefi/var-service.h"
> +
> +/* variable namespaces */
> +
> +QemuUUID EfiGlobalVariable = {
> +    .data = UUID_LE(0x8be4df61, 0x93ca, 0x11d2, 0xaa, 0x0d,
> +                    0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
> +};

(1) should have asked under patch#3:

can we constify these?

> +
> +QemuUUID EfiImageSecurityDatabase = {
> +    .data = UUID_LE(0xd719b2cb, 0x3d3a, 0x4596, 0xa3, 0xbc,
> +                    0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
> +};
> +
> +QemuUUID EfiCustomModeEnable = {
> +    .data = UUID_LE(0xc076ec0c, 0x7028, 0x4399, 0xa0, 0x72,
> +                    0x71, 0xee, 0x5c, 0x44, 0x8b, 0x9f)
> +};
> +
> +QemuUUID EfiSecureBootEnableDisable = {
> +    .data = UUID_LE(0xf0a30bc7, 0xaf08, 0x4556, 0x99, 0xc4,
> +                    0x0, 0x10, 0x9, 0xc9, 0x3a, 0x44)
> +};
> +
> +/* protocols */
> +
> +QemuUUID EfiSmmVariableProtocolGuid = {
> +    .data = UUID_LE(0xed32d533, 0x99e6, 0x4209, 0x9c, 0xc0,
> +                    0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
> +};
> +
> +QemuUUID VarCheckPolicyLibMmiHandlerGuid = {
> +    .data = UUID_LE(0xda1b0d11, 0xd1a7, 0x46c4, 0x9d, 0xc9,
> +                    0xf3, 0x71, 0x48, 0x75, 0xc6, 0xeb)
> +};

This isn't really a  protocol, but a GUID for "mm_header.guid".

gEfiSmmVariableProtocolGuid is a bit messy in edk2 because (IIUC) it is
used for *three* purposes:

(a) it's an actual SMM protocol GUID (MmVariableServiceInitialize() --
MdeModulePkg/Universal/Variable/RuntimeDxe/VariableSmm.c),

(b) it's used as "mm_header.guid" (see the MmiHandlerRegister call in
the same location), i.e. basically an SMI "upcall" identifier

(c) it's used as a NULL interface DXE protocol GUID for notification
purposes (VariableNotifySmmReady() --
MdeModulePkg/Universal/Variable/RuntimeDxe/VariableTraditionalMm.c).

So calling gEfiSmmVariableProtocolGuid a "protocol" in this header file
is relatively justified. But calling "VarCheckPolicyLibMmiHandlerGuid" a
protocol doesn't seem justified, because (I think) it only qualifies for
usage (b).

> +
> +/* events */

More precisely, this would be "event groups"; but peaking ahead to the
next patch, I think all five of these GUIDs (protocols + events) are
just "mm_header.guid" values.

So here's what I propose:

(2) replace

  /* protocols */

with

  /* mm_header.guid values that the guest DXE/BDS phases use for
   * sending requests to management mode
   */

and

(3) replace

  /* events */

with

  /* mm_header.guid values that the guest DXE/BDS phases use for
   * reporting event groups being signaled to management mode
   */

> +
> +QemuUUID EfiEndOfDxeEventGroupGuid = {
> +    .data = UUID_LE(0x02CE967A, 0xDD7E, 0x4FFC, 0x9E, 0xE7,
> +                    0x81, 0x0C, 0xF0, 0x47, 0x08, 0x80)
> +};

(4) I suggest consistently using either the lowercase hex characters
[a-f] or the uppercase ones [A-F] across all GUID constants in this header.


> +
> +QemuUUID EfiEventReadyToBootGuid = {
> +    .data = UUID_LE(0x7CE88FB3, 0x4BD7, 0x4679, 0x87, 0xA8,
> +                    0xA8, 0xD8, 0xDE, 0xE5, 0x0D, 0x2B)
> +};
> +
> +QemuUUID EfiEventExitBootServicesGuid = {
> +    .data = UUID_LE(0x27ABF055, 0xB1B8, 0x4C26, 0x80, 0x48,
> +                    0x74, 0x8F, 0x37, 0xBA, 0xA2, 0xDF)
> +};

I've made an effort to verify the constants themselves; they look good.

Thanks
Laszlo


