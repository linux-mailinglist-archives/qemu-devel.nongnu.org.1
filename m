Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5907B68BB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneDF-0007jQ-0w; Tue, 03 Oct 2023 08:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qneDA-0007jI-Ow
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qneD1-0002yA-OA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696334940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iyd/5UtRmEVWn0lgc2pBJN/ZycRPHJgCojPkxqCgNhM=;
 b=aEvFmXM9iN3NUrnBCa+8UcQZBs1wGoHDUdSP40gEafFWgqcfLZ6VsBQ4JaIZvGc3Ujleln
 pDd6xOkhgiYRN5R93hr6+nX515PKiqAz2x+KunGsogxdSnDhMk0EgoEJkwe9idzo9k2Ov1
 1GYKJPyJooNcefSPInI0gD8MmwBvJpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-2PYUbiT2NMaoJLEKh5Rbtg-1; Tue, 03 Oct 2023 08:08:53 -0400
X-MC-Unique: 2PYUbiT2NMaoJLEKh5Rbtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BD29101B043;
 Tue,  3 Oct 2023 12:08:53 +0000 (UTC)
Received: from [10.39.192.186] (unknown [10.39.192.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8C3140E962;
 Tue,  3 Oct 2023 12:08:51 +0000 (UTC)
Message-ID: <1a38db01-56df-8528-4bcb-e372bd5ae334@redhat.com>
Date: Tue, 3 Oct 2023 14:08:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] hw/vfio: add ramfb migration support
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, kraxel@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
 <20231003085644.1220326-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231003085644.1220326-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/3/23 10:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
>
> Turn it off by default on machines <= 8.1 for compatibility reasons.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/vfio/pci.h     |  3 +++
>  hw/core/machine.c |  1 +
>  hw/vfio/display.c | 23 +++++++++++++++++++++++
>  hw/vfio/pci.c     | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)

Quoting the hunks somewhat out of order (so that I can better understand
the dependencies):

>
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2d836093a8..fd06695542 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
>      bool no_kvm_ioeventfd;
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
> +    OnOffAuto ramfb_migrate;
>      bool defer_kvm_irq_routing;
>      bool clear_parent_atomics_on_exit;
>      VFIODisplay *dpy;

So this is where the complications start. The structure that contains
the "RAMFBState *ramfb" field is VFIODisplay (i.e., the "dpy" field
here), not VFIOPCIDevice. In order to stay consistent with the previous
patch in the series, we'd have to add the flag to VFIODisplay.

But it seems that VFIODisplay cannot have its own properties. Because:

- properties are associated in a TypeInfo.class_init function, with
  device_class_set_props()

- there is no TypeInfo for VFIODisplay, only for VFIOPCIDevice.

To make things even more complicated, both TYPE_VFIO_PCI and
TYPE_VFIO_PCI_NOHOTPLUG use VFIOPCIDevice directly. The latter only
differs in the exposure of the property "ramfb". Commit b290659fc3dd
("hw/vfio/display: add ramfb support", 2018-10-15) introduced the
property with TYPE_VFIO_PCI_NOHOTPLUG, *but* it squeezed the boolean
field backing the property to VFIOPCIDevice, rather than creating a
separate structure type *containing* VFIOPCIDevice *plus* the new field
"enable_ramfb".

I'm not sure if that was optimal (it may have been "unavoidable" for all
I know), but either way, now we have no choice but to follow suit, and
add the property's "backing field" to VFIOPCIDevice *again*.

OK. I kinda convinced myself this is proper. Let's move on.

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..4689f2e5c1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3484,6 +3515,7 @@ static const TypeInfo vfio_pci_dev_info = {
>
>  static Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>

This is where we expose the new knob as a property, side to side with
the previously mentioned "ramfb" one. OK.

> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 47a07d1d9b..f2f8940a85 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -32,6 +32,7 @@
>
>  GlobalProperty hw_compat_8_1[] = {
>      { "ramfb", "x-migrate", "off" },
> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
>  };
>  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>

Setting the property to "off" for old machine types, OK.

> @@ -3275,6 +3298,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          if (!vfio_migration_realize(vbasedev, errp)) {
>              goto out_deregister;
>          }
> +        if (vbasedev->enable_migration == ON_OFF_AUTO_OFF) {
> +            if (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO) {
> +                vdev->ramfb_migrate = ON_OFF_AUTO_OFF;
> +            } else if (vdev->ramfb_migrate == ON_OFF_AUTO_ON) {
> +                error_setg(errp, "x-ramfb-migrate requires migration");
> +                goto out_deregister;
> +            }
> +        }
>      }
>
>      vfio_register_err_notifier(vdev);

This looks good to me from two aspects, and not so good from two other
aspects.

- good: seems to ensure the knob consistency that Alex highlighted

- good: we enforce the "ramfb=on requires display=on" predicate too in
  the same function

- (1) not so good: with regard to error handling, I think the placement
  of this new logic could be improved, IMO. If we fail here, we're still
  past a successful vfio_migration_realize() call, and I'm not sure if
  jumping to the "out_deregister" label can undo *that*. Right now,
  nothing after the vfio_migration_realize() call can fail inside
  vfio_realize(), so the error path may not be ready for rolling back
  vfio_migration_realize().

  Looking at the larger context:

    if (vdev->display_xres || vdev->display_yres) {
        if (vdev->dpy == NULL) {
            error_setg(errp, "xres and yres properties require display=on");
            goto out_deregister;
        }
        if (vdev->dpy->edid_regs == NULL) {
            error_setg(errp, "xres and yres properties need edid support");
            goto out_deregister;
        }
    }

    if (!pdev->failover_pair_id) {
        if (!vfio_migration_realize(vbasedev, errp)) {
            goto out_deregister;
        }
    }

  I suggest inserting the new consistency check *between* those two
  checks (and not after the second one). The reason is that both
  existent checks jump to "out_deregister" in case of failure, which
  means that you can insert further checks (and actions that don't
  allocate new resources) between them, and jump to "out_deregister" in
  case of failure.

- (2) not so good: we should reject an explicit "x-ramfb-migrate=on"
  setting if "enable_ramfb" is false. The valid (accepted) combinations
  are:

  #  display  ramfb  x-ramfb-migrate
  -  -------  -----  ---------------
  1  off      off    auto
  2  off      off    off
  3  on       off    auto
  4  on       off    off
  5  on       on     auto
  6  on       on     off
  7  on       on     on

  "ramfb ==> display" is alread enforced; we need to check
  "(x-ramfb-migrate==on) ==> ramfb" additionally.

Now the tricky part follows:

> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 3b2ca3c24c..4689f2e5c1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2608,6 +2608,25 @@ static bool vfio_msix_present(void *opaque, int version_id)
>      return msix_present(pdev);
>  }
>
> +static bool vfio_display_needed(void *opaque)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +
> +    /* the only thing that justifies the VFIODisplay sub-section atm */
> +    return vdev->ramfb_migrate != ON_OFF_AUTO_OFF;
> +}

This doesn't look right to me. Consider again the table of valid cases
(as enforced by vfio_realize() per my suggestion above):

  #  display  ramfb  x-ramfb-migrate  result
  -  -------  -----  ---------------  -------------------------------------
  1  off      off    auto             no VFIODisplay object --> CRASH
  2  off      off    off              VFIODisplay migration unnecessary, OK
  3  on       off    auto             no RAMFBState object --> CRASH
  4  on       off    off              VFIODisplay migration unnecessary, OK
  5  on       on     auto             VFIODisplay migration needed, OK
  6  on       on     off              VFIODisplay migration unnecessary, OK
  7  on       on     on               VFIODisplay migration needed, OK

Suggestions:

- (3) name the function vfio_display_migration_needed()

- the condition should be:

    vdev->ramfb_migrate != ON_OFF_AUTO_OFF && vdev->enable_ramfb

  The condition (vdev->ramfb_migrate != ON_OFF_AUTO_OFF) restricts the
  table to the following rows:

    #  display  ramfb  x-ramfb-migrate  result
    -  -------  -----  ---------------  -------------------------------------
    1  off      off    auto             no VFIODisplay object --> CRASH
    3  on       off    auto             no RAMFBState object --> CRASH
    5  on       on     auto             VFIODisplay migration needed, OK
    7  on       on     on               VFIODisplay migration needed, OK

  From these, cases #5 and #7 are fine, and the additional restriction
  (vdev->enable_ramfb) leaves them unhurt.

  We need to exclude cases #1 and #3, and that's what the additional
  restriction (vdev->enable_ramfb) will do.

- (4) *Equivalently*, you could use the *easier-to-understand* condition

    vdev->ramfb_migrate == ON_OFF_AUTO_ON ||
    (vdev->ramfb_migrate == ON_OFF_AUTO_AUTO && vdev->enable_ramfb)

- (5) And then I'd suggest adding the comment (which matches the latter
  formulation of the condition):

  /*
   * We need to migrate the VFIODisplay object if ramfb *migration* was
   * explicitly requested (in which case we enforced both ramfb=on and
   * display=on), or ramfb migration was left at the default "auto"
   * setting, and *ramfb* was explicitly requested (in which case we
   * enforced display=on).
   */

> +
> +const VMStateDescription vmstate_vfio_display = {
> +    .name = "VFIOPCIDevice/VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vfio_display_needed,
> +    .fields = (VMStateField[]){
> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstate, VFIODisplay),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_vfio_pci_config = {
>      .name = "VFIOPCIDevice",
>      .version_id = 1,
> @@ -2616,6 +2635,10 @@ const VMStateDescription vmstate_vfio_pci_config = {
>          VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>          VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription*[]) {
> +        &vmstate_vfio_display,
> +        NULL
>      }
>  };
>

Seems OK.

> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 2d836093a8..fd06695542 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
>  int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>  void vfio_display_finalize(VFIOPCIDevice *vdev);
>
> +extern const VMStateDescription vfio_display_vmstate;
> +
>  #endif /* HW_VFIO_VFIO_PCI_H */

Seems right.

> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index bec864f482..de5bf71dd1 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -542,3 +542,26 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
>      vfio_display_edid_exit(vdev->dpy);
>      g_free(vdev->dpy);
>  }
> +
> +static bool migrate_needed(void *opaque)
> +{
> +    /*
> +     * If we are here, it's because vfio_display_needed(), which is only true
> +     * when dpy->ramfb_migrate atm.
> +     *
> +     * If the migration condition is changed, we should check here if
> +     * ramfb_migrate is true. (this will need a way to lookup the associated
> +     * VFIOPCIDevice somehow, or fields to be moved, ..)
> +     */
> +    return true;
> +}

(6) Adding this test function with constant "true" returned seems
helpful, yes; how about the following impl though:

  static bool migrate_needed(void *opaque)
  {
      VFIODisplay *dpy = opaque;
      bool ramfb_exists = dpy->ramfb != NULL;

      /* see vfio_display_migration_needed() */
      assert(ramfb_exists);
      return ramfb_exists;
  }

> +
> +const VMStateDescription vfio_display_vmstate = {
> +    .name = "VFIODisplay",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = migrate_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMFBState),
> +    }
> +};

Thanks!
Laszlo


