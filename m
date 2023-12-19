Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE82817E86
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 01:09:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFNfv-0005m7-Qf; Mon, 18 Dec 2023 19:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNft-0005kW-1S; Mon, 18 Dec 2023 19:09:29 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rFNfr-0008ID-FR; Mon, 18 Dec 2023 19:09:28 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B46F775A4BF;
 Tue, 19 Dec 2023 01:09:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id xDilfp289RKs; Tue, 19 Dec 2023 01:09:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA68375A406; Tue, 19 Dec 2023 01:09:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C84C9756094;
 Tue, 19 Dec 2023 01:09:23 +0100 (CET)
Date: Tue, 19 Dec 2023 01:09:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 08/12] hw/block/fdc-isa: Implement relocation and
 toggling for TYPE_ISA_FDC
In-Reply-To: <20231218185114.119736-9-shentey@gmail.com>
Message-ID: <42552a96-7db9-50a0-6a4c-76ecae98df35@eik.bme.hu>
References: <20231218185114.119736-1-shentey@gmail.com>
 <20231218185114.119736-9-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 18 Dec 2023, Bernhard Beschow wrote:
> Implement isa_fdc_set_{enabled,iobase} in order to implement relocation and
> toggling of SuperI/O functions in the VIA south bridges without breaking
> encapsulation.

You may want to revise these commit messages. What toggling means is only 
defined in the last patch but I can't think of a better name for it other 
than spelling out enable/disable. It's probably also not relevant in this 
commit message to mention VIA south bridges as this is a generic function 
not specific to that usage only.

Regards,
BALATON Zoltan

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> include/hw/block/fdc.h |  3 +++
> hw/block/fdc-isa.c     | 14 ++++++++++++++
> 2 files changed, 17 insertions(+)
>
> diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
> index 35248c0837..c367c5efea 100644
> --- a/include/hw/block/fdc.h
> +++ b/include/hw/block/fdc.h
> @@ -14,6 +14,9 @@ void fdctrl_init_sysbus(qemu_irq irq, hwaddr mmio_base, DriveInfo **fds);
> void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
>                        DriveInfo **fds, qemu_irq *fdc_tc);
>
> +void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase);
> +void isa_fdc_set_enabled(ISADevice *fdc, bool enabled);
> +
> FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
> int cmos_get_fd_drive_type(FloppyDriveType fd0);
>
> diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
> index b4c92b40b3..c989325de3 100644
> --- a/hw/block/fdc-isa.c
> +++ b/hw/block/fdc-isa.c
> @@ -192,6 +192,20 @@ static Aml *build_fdinfo_aml(int idx, FloppyDriveType type)
>     return dev;
> }
>
> +void isa_fdc_set_iobase(ISADevice *fdc, hwaddr iobase)
> +{
> +    FDCtrlISABus *isa = ISA_FDC(fdc);
> +
> +    fdc->ioport_id = iobase;
> +    isa->iobase = iobase;
> +    portio_list_set_address(&isa->portio_list, isa->iobase);
> +}
> +
> +void isa_fdc_set_enabled(ISADevice *fdc, bool enabled)
> +{
> +    portio_list_set_enabled(&ISA_FDC(fdc)->portio_list, enabled);
> +}
> +
> int cmos_get_fd_drive_type(FloppyDriveType fd0)
> {
>     int val;
>

