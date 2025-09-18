Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2BB1F865
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Aug 2025 06:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukxyH-0005h0-ME; Sun, 10 Aug 2025 00:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukxy8-0005Rj-TT; Sun, 10 Aug 2025 00:47:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukxy4-0004NZ-I0; Sun, 10 Aug 2025 00:47:40 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57A4l84n059148
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 Aug 2025 13:47:08 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Oj7N6/H2ruKzlB0+6lW05PhqF4nP8MQKh8qnSRKab6U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754801228; v=1;
 b=OocFUSh4wzxxqIOIlxZk9+h5oNy4z0DgIg9wFazaW0rgWK3gyaC/pFepeun1XjQo
 ojqopLHHYx5J8QeZEduEBsrnasz3lkBFQhnUQ7Zfjtl6VjAvd5ZSE1Pi4/pihnH5
 gncEw7YLUOmG+YtO12IyoTLvsAHiwF/yjn7HLnZJjn0DcFhQWYZsjJZgM0ICnYXn
 8VERdnkgbre1hwtr8J6hEkbinF+f/zZbwBxJb8ouRYVGBwBUfu94AeCm+KttKxJr
 8d7XU6mGlpB6w3Dw0kgElwTiaPwZVX3mnXA3q2Wnl4UZd8KjvwsyDTKJzw8kC+PV
 rTlR0+08/bT2KnyzNyrk+Q==
Message-ID: <596b1473-ea92-42d0-850f-a47d7a280d2e@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 Aug 2025 13:47:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/27] migration: push Error **errp into
 vmstate_load_state()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-2-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-2-123450810db7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/06 3:25, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load_state() must report an error
> in errp, in case of failure.
> 
> In cases where we do not want to essentially set the error
> in errp object and also not abort/exit, the caller only
> passes &error_warn, to warn on error.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/display/virtio-gpu.c     |  2 +-
>   hw/pci/pci.c                |  3 ++-
>   hw/s390x/virtio-ccw.c       |  2 +-
>   hw/scsi/spapr_vscsi.c       |  2 +-
>   hw/vfio/pci.c               |  2 +-
>   hw/virtio/virtio-mmio.c     |  3 ++-
>   hw/virtio/virtio-pci.c      |  2 +-
>   hw/virtio/virtio.c          |  4 ++--
>   include/migration/vmstate.h |  2 +-
>   migration/cpr.c             |  5 ++--
>   migration/savevm.c          |  6 +++--
>   migration/vmstate-types.c   | 11 +++++----
>   migration/vmstate.c         | 56 ++++++++++++++++++++++++++++++---------------
>   tests/unit/test-vmstate.c   | 20 ++++++++--------
>   ui/vdagent.c                |  2 +-
>   15 files changed, 75 insertions(+), 47 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5ff9f5e6dc0b6b112e36170318c900f893a73c5e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>       }
>   
>       /* load & apply scanout state */
> -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_warn);

I realized error_warn should be avoided. ERRP_GUARD() is incompatible 
with &error_warn due to the bug that the following patch fixes:
https://lore.kernel.org/qemu-devel/20250803-errp-v1-1-a59a73f63289@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH] error: Rewrite &error_warn with ERRP_GUARD()")

The fix is not going to be pulled because error_warn is going to be 
removed with the following series:
https://lore.kernel.org/qemu-devel/20250808080823.2638861-1-armbru@redhat.com/
("[PATCH 00/12] Error reporting cleanup, a fix, and &error_warn removal")

>   
>       return 0;
>   }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..80545189980f176ca6a3dc9abce7043c8bc2708c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>   int pci_device_load(PCIDevice *s, QEMUFile *f)
>   {
>       int ret;
> -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> +                             &error_warn);
>       /* Restore the interrupt status bit. */
>       pci_update_irq_status(s);
>       return ret;
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..bafcb9b76d81749925e31b5a0a1320b3332ad2cf 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>   static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>   {
>       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_warn);
>   }
>   
>   static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index 20f70fb2729de78b9636a6b8c869695dab4f8902..a4812afd0cc7c495080ef03a531c7d279af29b33 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>       assert(!req->active);
>   
>       memset(req, 0, sizeof(*req));
> -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &error_warn);
>       if (rc) {
>           fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
>           return NULL;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..04d385d7674f444844beeee7364ee0424f762758 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2795,7 +2795,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>           old_addr[bar] = pdev->io_regions[bar].addr;
>       }
>   
> -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1, &error_warn);
>       if (ret) {
>           return ret;
>       }
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..f14f0487fec3ed30d2cc3aec96950c2121265716 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -34,6 +34,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/log.h"
>   #include "trace.h"
> +#include "qapi/error.h"
>   
>   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
>   {
> @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
>   {
>       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
>   
> -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_warn);
>   }
>   
>   static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 767216d795998708f5716a23ae16c79cd90ff489..07f144d6d1bfbb561b28015de71762601080dc23 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
>   {
>       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>   
> -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_warn);
>   }
>   
>   static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 2ab1d20769495ea39445b87e3673b076ad172510..aac317a93c3cd55ece9b0fd858c7b2459f8242f9 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3317,14 +3317,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>       }
>   
>       if (vdc->vmsd) {
> -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &error_warn);
>           if (ret) {
>               return ret;
>           }
>       }
>   
>       /* Subsections */
> -    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
> +    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &error_warn);
>       if (ret) {
>           return ret;
>       }
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
>       }
>   
>   int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id);
> +                       void *opaque, int version_id, Error **errp);
>   int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                          void *opaque, JSONWriter *vmdesc);
>   int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..bdb24736f44e91ba59b6e622a315597c97e7f64d 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -202,6 +202,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>   
>   int cpr_state_load(MigrationChannel *channel, Error **errp)
>   {
> +    ERRP_GUARD();
>       int ret;
>       uint32_t v;
>       QEMUFile *f;
> @@ -233,9 +234,9 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>           return -ENOTSUP;
>       }
>   
> -    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
>       if (ret) {
> -        error_setg(errp, "vmstate_load_state error %d", ret);
> +        error_prepend(errp, "vmstate_load_state error %d: ", ret);
>           qemu_fclose(f);
>           return ret;
>       }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296ae987d0c06ba6dafda63720205fecfd..ab947620f724874f325fb9fb59bef50b7c16fb51 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
>       if (!se->vmsd) {         /* Old style */
>           return se->ops->load_state(f, se->opaque, se->load_version_id);
>       }
> -    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
> +    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> +                              NULL);
>   }
>   
>   static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
>               error_report("Configuration section missing");
>               return -EINVAL;
>           }
> -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
> +        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> +                                 NULL);
>   
>           if (ret) {
>               return ret;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..e2020a733d0921d748b6f832a193e5de8d302d5f 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -19,6 +19,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/queue.h"
>   #include "trace.h"
> +#include "qapi/error.h"
>   
>   /* bool */
>   
> @@ -549,7 +550,7 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
>   
>       /* Writes the parent field which is at the start of the tmp */
>       *(void **)tmp = pv;
> -    ret = vmstate_load_state(f, vmsd, tmp, version_id);
> +    ret = vmstate_load_state(f, vmsd, tmp, version_id, &error_warn);
>       g_free(tmp);
>       return ret;
>   }
> @@ -649,7 +650,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
>   
>       while (qemu_get_byte(f)) {
>           elm = g_malloc(size);
> -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> +        ret = vmstate_load_state(f, vmsd, elm, version_id, &error_warn);
>           if (ret) {
>               return ret;
>           }
> @@ -803,7 +804,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
>               key = (void *)(uintptr_t)qemu_get_be64(f);
>           } else {
>               key = g_malloc0(key_size);
> -            ret = vmstate_load_state(f, key_vmsd, key, version_id);
> +            ret = vmstate_load_state(f, key_vmsd, key, version_id, &error_warn);
>               if (ret) {
>                   error_report("%s : failed to load %s (%d)",
>                                field->name, key_vmsd->name, ret);
> @@ -811,7 +812,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
>               }
>           }
>           val = g_malloc0(val_size);
> -        ret = vmstate_load_state(f, val_vmsd, val, version_id);
> +        ret = vmstate_load_state(f, val_vmsd, val, version_id, &error_warn);
>           if (ret) {
>               error_report("%s : failed to load %s (%d)",
>                            field->name, val_vmsd->name, ret);
> @@ -892,7 +893,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
>   
>       while (qemu_get_byte(f)) {
>           elm = g_malloc(size);
> -        ret = vmstate_load_state(f, vmsd, elm, version_id);
> +        ret = vmstate_load_state(f, vmsd, elm, version_id, &error_warn);
>           if (ret) {
>               error_report("%s: failed to load %s (%d)", field->name,
>                            vmsd->name, ret);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 24451b054c11dfca2d76e24b053d604bb7184e1c..60ff38858cf54277992fa5eddeadb6f3d70edec3 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -132,29 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>   }
>   
>   int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> -                       void *opaque, int version_id)
> +                       void *opaque, int version_id, Error **errp)
>   {
>       const VMStateField *field = vmsd->fields;
>       int ret = 0;
>   
>       trace_vmstate_load_state(vmsd->name, version_id);
>       if (version_id > vmsd->version_id) {
> -        error_report("%s: incoming version_id %d is too new "
> -                     "for local version_id %d",
> -                     vmsd->name, version_id, vmsd->version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too new "
> +                   "for local version_id %d",
> +                   vmsd->name, version_id, vmsd->version_id);
>           trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>           return -EINVAL;
>       }
>       if  (version_id < vmsd->minimum_version_id) {
> -        error_report("%s: incoming version_id %d is too old "
> -                     "for local minimum version_id  %d",
> -                     vmsd->name, version_id, vmsd->minimum_version_id);
> +        error_setg(errp, "%s: incoming version_id %d is too old "
> +                   "for local minimum version_id %d",
> +                   vmsd->name, version_id, vmsd->minimum_version_id);
>           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>           return -EINVAL;
>       }
>       if (vmsd->pre_load) {
>           ret = vmsd->pre_load(opaque);
>           if (ret) {
> +            error_setg(errp, "VM pre load failed for: '%s', "
> +                       "version_id: %d, minimum version_id: %d, ret: %d",
> +                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
> +                       ret);
>               return ret;
>           }
>       }
> @@ -192,10 +196,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>   
>                   if (inner_field->flags & VMS_STRUCT) {
>                       ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->vmsd->version_id);
> +                                             inner_field->vmsd->version_id,
> +                                             errp);
>                   } else if (inner_field->flags & VMS_VSTRUCT) {
>                       ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> -                                             inner_field->struct_version_id);
> +                                             inner_field->struct_version_id,
> +                                             errp);
>                   } else {
>                       ret = inner_field->info->get(f, curr_elem, size,
>                                                    inner_field);
> @@ -208,30 +214,43 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>   
>                   if (ret >= 0) {
>                       ret = qemu_file_get_error(f);
> +                    if (ret < 0) {
> +                        error_setg(errp, "Failed to load %s state: %d",
> +                                   vmsd->name, ret);
> +                        return ret;
> +                    }
>                   }
>                   if (ret < 0) {
>                       qemu_file_set_error(f, ret);
> -                    error_report("Failed to load %s:%s", vmsd->name,
> -                                 field->name);
> +                    error_setg(errp,
> +                               "Failed to load %s:%s version_id: %d: ",
> +                               vmsd->name, field->name, vmsd->version_id);
>                       trace_vmstate_load_field_error(field->name, ret);
>                       return ret;
>                   }
>               }
>           } else if (field->flags & VMS_MUST_EXIST) {
> -            error_report("Input validation failed: %s/%s",
> -                         vmsd->name, field->name);
> +            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
> +                       vmsd->name, field->name, vmsd->version_id);
>               return -1;
>           }
>           field++;
>       }
>       assert(field->flags == VMS_END);
> -    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
> +    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
>       if (ret != 0) {
>           qemu_file_set_error(f, ret);
>           return ret;
>       }
>       if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
> +        if (ret < 0) {
> +            error_setg(errp,
> +                       "VM Post load failed for: %s, version_id: %d, "
> +                       "minimum_version: %d, ret: %d",
> +                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
> +                       ret);
> +        }
>       }
>       trace_vmstate_load_state_end(vmsd->name, "end", ret);
>       return ret;
> @@ -568,6 +587,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
>   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>                                      void *opaque, Error **errp)
>   {
> +    ERRP_GUARD();
>       trace_vmstate_subsection_load(vmsd->name);
>   
>       while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
> @@ -607,12 +627,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>           qemu_file_skip(f, len); /* idstr */
>           version_id = qemu_get_be32(f);
>   
> -        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
> +        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
>           if (ret) {
>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
> -            error_setg(errp,
> -                       "Loading VM subsection '%s' in '%s' failed: %d",
> -                       idstr, vmsd->name, ret);
> +            error_prepend(errp,
> +                          "Loading VM subsection '%s' in '%s' failed: %d: ",
> +                          idstr, vmsd->name, ret);
>               return ret;
>           }
>       }
> diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
> index 63f28f26f45691a70936d33e7341d16477a3471f..807deb3531f3079864ac99567d4dece7122571dd 100644
> --- a/tests/unit/test-vmstate.c
> +++ b/tests/unit/test-vmstate.c
> @@ -30,6 +30,7 @@
>   #include "../migration/savevm.h"
>   #include "qemu/module.h"
>   #include "io/channel-file.h"
> +#include "qapi/error.h"
>   
>   static int temp_fd;
>   
> @@ -114,7 +115,7 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
>       qemu_fclose(f);
>   
>       f = open_test_file(false);
> -    ret = vmstate_load_state(f, desc, obj, version);
> +    ret = vmstate_load_state(f, desc, obj, version, &error_warn);
>       if (ret) {
>           g_assert(qemu_file_get_error(f));
>       } else{
> @@ -365,7 +366,7 @@ static void test_load_v1(void)
>   
>       QEMUFile *loading = open_test_file(false);
>       TestStruct obj = { .b = 200, .e = 500, .f = 600 };
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
> +    vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &error_warn);
>       g_assert(!qemu_file_get_error(loading));
>       g_assert_cmpint(obj.a, ==, 10);
>       g_assert_cmpint(obj.b, ==, 200);
> @@ -391,7 +392,7 @@ static void test_load_v2(void)
>   
>       QEMUFile *loading = open_test_file(false);
>       TestStruct obj;
> -    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &error_warn);
>       g_assert_cmpint(obj.a, ==, 10);
>       g_assert_cmpint(obj.b, ==, 20);
>       g_assert_cmpint(obj.c, ==, 30);
> @@ -480,7 +481,7 @@ static void test_load_noskip(void)
>   
>       QEMUFile *loading = open_test_file(false);
>       TestStruct obj = { .skip_c_e = false };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &error_warn);
>       g_assert(!qemu_file_get_error(loading));
>       g_assert_cmpint(obj.a, ==, 10);
>       g_assert_cmpint(obj.b, ==, 20);
> @@ -504,7 +505,7 @@ static void test_load_skip(void)
>   
>       QEMUFile *loading = open_test_file(false);
>       TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
> -    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
> +    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &error_warn);
>       g_assert(!qemu_file_get_error(loading));
>       g_assert_cmpint(obj.a, ==, 10);
>       g_assert_cmpint(obj.b, ==, 20);
> @@ -773,7 +774,7 @@ static void test_load_q(void)
>       TestQtailq tgt;
>   
>       QTAILQ_INIT(&tgt.q);
> -    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
> +    vmstate_load_state(fload, &vmstate_q, &tgt, 1, &error_warn);
>       char eof = qemu_get_byte(fload);
>       g_assert(!qemu_file_get_error(fload));
>       g_assert_cmpint(tgt.i16, ==, obj_q.i16);
> @@ -1127,7 +1128,7 @@ static void test_gtree_load_domain(void)
>   
>       fload = open_test_file(false);
>   
> -    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
> +    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1, &error_warn);
>       eof = qemu_get_byte(fload);
>       g_assert(!qemu_file_get_error(fload));
>       g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
> @@ -1241,7 +1242,7 @@ static void test_gtree_load_iommu(void)
>       qemu_fclose(fsave);
>   
>       fload = open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
> +    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &error_warn);
>       eof = qemu_get_byte(fload);
>       g_assert(!qemu_file_get_error(fload));
>       g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
> @@ -1376,7 +1377,8 @@ static void test_load_qlist(void)
>       qemu_fclose(fsave);
>   
>       fload = open_test_file(false);
> -    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
> +    vmstate_load_state(fload, &vmstate_container, dest_container, 1,
> +                       &error_warn);
>       eof = qemu_get_byte(fload);
>       g_assert(!qemu_file_get_error(fload));
>       g_assert_cmpint(eof, ==, QEMU_VM_EOF);
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index c0746fe5b168fdc7aeb4866de2ba0c3387566649..b9a22a689d9acfeafb862ae73308db6fbd52331e 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -1008,7 +1008,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
>   
>       vdagent_clipboard_peer_register(vd);
>   
> -    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
> +    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0, &error_warn);
>       if (ret) {
>           return ret;
>       }
> 


