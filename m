Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFC27EE0D8
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 13:48:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3bld-0006Gy-JO; Thu, 16 Nov 2023 07:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3bla-0006GL-PO
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 07:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1r3blZ-0005hX-3N
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 07:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700138799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37/vd5BT2BR+X/Vmpl9N9wIK1MYiu2a3rUJxZx7ieP0=;
 b=QRpgmZEAKvU7ojQixLhutnNadbBJs0GLoUVLQM+UZeOFptPA2Gv0Qhimxxapq2ieOf243z
 wbgpIB2vDPRhoexQurOPrOM6tyf4bhME7DK4jzOOL1dyLh86hwfz90fGHW3zajg4Sa9V37
 wc1PNKcFsImyNvIdazL+gAB7fVK0fQk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-4hzgqoaDPX-ydVN_ZLGjbw-1; Thu,
 16 Nov 2023 07:46:35 -0500
X-MC-Unique: 4hzgqoaDPX-ydVN_ZLGjbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4BC43C1ACD5;
 Thu, 16 Nov 2023 12:46:34 +0000 (UTC)
Received: from [10.39.193.151] (unknown [10.39.193.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D04E37ACE;
 Thu, 16 Nov 2023 12:46:32 +0000 (UTC)
Message-ID: <5d7cc3e7-a534-0352-6a86-fb95fdf3ccfa@redhat.com>
Date: Thu, 16 Nov 2023 13:46:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/16] hw/uefi: add include/hw/uefi/var-service-api.h
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
 <20231115151242.184645-2-kraxel@redhat.com>
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231115151242.184645-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/15/23 16:12, Gerd Hoffmann wrote:
> This file defines the register interface of the uefi-vars device.
> It's only a handful of registers: magic value, command and status
> registers, location and size of the communication buffer.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/uefi/var-service-api.h | 40 +++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 include/hw/uefi/var-service-api.h
> 
> diff --git a/include/hw/uefi/var-service-api.h b/include/hw/uefi/var-service-api.h
> new file mode 100644
> index 000000000000..37fdab32741f
> --- /dev/null
> +++ b/include/hw/uefi/var-service-api.h
> @@ -0,0 +1,40 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * uefi-vars device - API of the virtual device for guest/host communication.
> + */
> +#ifndef QEMU_UEFI_VAR_SERVICE_API_H
> +#define QEMU_UEFI_VAR_SERVICE_API_H
> +
> +
> +/* isa: io range */
> +#define UEFI_VARS_IO_BASE                   0x520
> +
> +/* sysbus: fdt node path */
> +#define UEFI_VARS_FDT_NODE       "qemu-uefi-vars"
> +#define UEFI_VARS_FDT_COMPAT     "qemu,uefi-vars"
> +
> +/* registers */
> +#define UEFI_VARS_REG_MAGIC                  0x00  /* 16 bit */
> +#define UEFI_VARS_REG_CMD_STS                0x02  /* 16 bit */
> +#define UEFI_VARS_REG_BUFFER_SIZE            0x04  /* 32 bit */
> +#define UEFI_VARS_REG_BUFFER_ADDR_LO         0x08  /* 32 bit */
> +#define UEFI_VARS_REG_BUFFER_ADDR_HI         0x0c  /* 32 bit */
> +#define UEFI_VARS_REGS_SIZE                  0x10
> +
> +/* magic value */
> +#define UEFI_VARS_MAGIC_VALUE               0xef1
> +
> +/* command values */
> +#define UEFI_VARS_CMD_RESET                  0x01
> +#define UEFI_VARS_CMD_MM                     0x02
> +
> +/* status values */
> +#define UEFI_VARS_STS_SUCCESS                0x00
> +#define UEFI_VARS_STS_BUSY                   0x01
> +#define UEFI_VARS_STS_ERR_UNKNOWN            0x10
> +#define UEFI_VARS_STS_ERR_NOT_SUPPORTED      0x11
> +#define UEFI_VARS_STS_ERR_BAD_BUFFER_SIZE    0x12
> +
> +
> +#endif /* QEMU_UEFI_VAR_SERVICE_API_H */

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


