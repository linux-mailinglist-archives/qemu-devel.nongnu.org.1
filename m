Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653C37B1B6A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 13:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlpUZ-0005bA-Bt; Thu, 28 Sep 2023 07:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qlpUV-0005aA-VW
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 07:47:35 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qlpUT-0005cO-Ia
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 07:47:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DD0C2757244;
 Thu, 28 Sep 2023 13:46:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A6D1875721D; Thu, 28 Sep 2023 13:46:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A5A7C757234;
 Thu, 28 Sep 2023 13:46:58 +0200 (CEST)
Date: Thu, 28 Sep 2023 13:46:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Martin Kletzander <mkletzan@redhat.com>
Subject: Re: [PATCH 08/13] Introduce machine property "audiodev"
In-Reply-To: <20230928073705.871327-9-pbonzini@redhat.com>
Message-ID: <c7988f81-2dba-6094-66f3-f010a5a52255@eik.bme.hu>
References: <20230928073705.871327-1-pbonzini@redhat.com>
 <20230928073705.871327-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 28 Sep 2023, Paolo Bonzini wrote:
> From: Martin Kletzander <mkletzan@redhat.com>
>
> Many machine types have default audio devices with no way to set the underlying
> audiodev.  Instead of adding an option for each and every one of them, this new
> property can be used as a default during machine initialisation when creating
> such devices.
>
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> [Make the property optional, instead of including it in all machines. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/core/machine.c   | 33 +++++++++++++++++++++++++++++++++
> include/hw/boards.h |  7 +++++++
> 2 files changed, 40 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index cb38b8cf4cb..6aa49c8d4f1 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,6 +39,7 @@
> #include "hw/virtio/virtio.h"
> #include "hw/virtio/virtio-pci.h"
> #include "hw/virtio/virtio-net.h"
> +#include "audio/audio.h"
>
> GlobalProperty hw_compat_8_1[] = {};
> const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> @@ -686,6 +687,26 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
>     return allowed;
> }
>
> +static char *machine_get_audiodev(Object *obj, Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    return g_strdup(ms->audiodev);
> +}
> +
> +static void machine_set_audiodev(Object *obj, const char *value,
> +                                 Error **errp)
> +{
> +    MachineState *ms = MACHINE(obj);
> +
> +    if (!audio_state_by_name(value, errp)) {
> +        return;
> +    }
> +
> +    g_free(ms->audiodev);
> +    ms->audiodev = g_strdup(value);
> +}
> +
> HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
> {
>     int i;
> @@ -931,6 +952,17 @@ out_free:
>     qapi_free_BootConfiguration(config);
> }
>
> +void machine_add_audiodev_property(MachineClass *mc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(mc);
> +
> +    object_class_property_add_str(oc, "audiodev",
> +                                  machine_get_audiodev,
> +                                  machine_set_audiodev);
> +    object_class_property_set_description(oc, "audiodev",
> +                                          "Audiodev to use for default machine devices");
> +}
> +
> static void machine_class_init(ObjectClass *oc, void *data)
> {
>     MachineClass *mc = MACHINE_CLASS(oc);
> @@ -1136,6 +1168,7 @@ static void machine_finalize(Object *obj)
>     g_free(ms->device_memory);
>     g_free(ms->nvdimms_state);
>     g_free(ms->numa_state);
> +    g_free(ms->audiodev);
> }
>
> bool machine_usb(MachineState *machine)
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6c67af196a3..b5153f5f85b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -24,6 +24,7 @@ OBJECT_DECLARE_TYPE(MachineState, MachineClass, MACHINE)
>
> extern MachineState *current_machine;
>
> +void machine_add_audiodev_property(MachineClass *mc);
> void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
> bool machine_usb(MachineState *machine);
> int machine_phandle_start(MachineState *machine);
> @@ -358,6 +359,12 @@ struct MachineState {
>     MemoryRegion *ram;
>     DeviceMemoryState *device_memory;
>
> +    /*
> +     * Included in MachineState for simplicity, but not supported
> +     * unless machine_add_audiodev_property is called.
> +     */

Maybe this comment could be improved saying something like: Only used by 
machines that have default audio parts in which case machine init should 
call machine_add_audiodev_property().

Regards,
BALATON Zoltan

> +    char *audiodev;
> +
>     ram_addr_t ram_size;
>     ram_addr_t maxram_size;
>     uint64_t   ram_slots;
>

