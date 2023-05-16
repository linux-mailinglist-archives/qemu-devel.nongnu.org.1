Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE85704BC0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysTH-0007DW-Mi; Tue, 16 May 2023 07:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1pysSp-0006wa-Rm
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:03:35 -0400
Received: from mx.treblig.org ([46.235.229.95])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1pysSm-0000vu-Bv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 07:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
 :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oL7uufKHk2lX47uImdrWHC6tQg6XjYxtnLx2t0i4yjo=; b=bMurw0mkkvV1lenfqzEoYDgD0O
 LolVXs9+XClFZqeIOVq7w3i0sCBLjIV8ganIck38pHJ6b/WVX67Bjj4WPr5uyKtk8CA3dLlQpVHVP
 Uq4sNLn+azYykuXW8v9Z3Zl93rivpyGB+Oue9BzD1JjUhlwTLJeBVZ+wyW3nVLbP3GfQRe7PUcv/F
 2HgIngfJvkYTXVZ4gZoX5saWeaujHEPM6M4p79lxKQX21msnXAMJgzzODw875xlhg2J/PsiG/FyOP
 hUgnZU80V+HEzvglMEHvKot+gEkb63QH5qh2KNiGpDzew7PVktNC8KWlqV/DK9XOmaPbyha6AbcEz
 hZm9TOaw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
 (envelope-from <dg@treblig.org>)
 id 1pysSa-008tXv-Aw; Tue, 16 May 2023 11:03:16 +0000
Date: Tue, 16 May 2023 11:03:16 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "T.J. Alumbaugh" <talumbau@google.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yuanchu Xie <yuanchu@google.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Yu Zhao <yuzhao@google.com>
Subject: Re: [RFC PATCH 1/1] virtio-balloon: Add Working Set Reporting feature
Message-ID: <ZGNi9Bfy1SuLxqtA@gallifrey>
References: <20230510143856.964541-1-talumbau@google.com>
 <20230510143856.964541-2-talumbau@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230510143856.964541-2-talumbau@google.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-21-amd64 (x86_64)
X-Uptime: 10:27:06 up 57 days, 21:01, 1 user, load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
Received-SPF: pass client-ip=46.235.229.95; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* T.J. Alumbaugh (talumbau@google.com) wrote:
>  Working Set Reporting supported in virtio-balloon.
>  - adds working set reporting and notification vqueues
>  - QMP API additions:
>    - guest-ws property on balloon
>    - generates QMP WS_EVENT when new reports available
>    - ws_config, ws_request commands

Hi,
  1st it's probably best to split this patch up into a few 
separate patches; something like:
    1) Updating the virtio_balloon header
    2) the main virtio-balloon code
    3) Adding the qmp code
    4) Adding the HMP code
    5) The migration code

    That would make it easier for people to review
the bits they know.

Also, please make sure migration works between a host
without this feature and one which does; I suggest
turning the feature off in older machine types, and
also just checking that it works.

See more comments below.

Dave

> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  hmp-commands.hx                               |  26 ++
>  hw/core/machine-hmp-cmds.c                    |  21 ++
>  hw/virtio/virtio-balloon-pci.c                |   2 +
>  hw/virtio/virtio-balloon.c                    | 225 +++++++++++++++++-
>  include/hw/virtio/virtio-balloon.h            |  17 +-
>  include/monitor/hmp.h                         |   2 +
>  .../standard-headers/linux/virtio_balloon.h   |  17 ++
>  include/sysemu/balloon.h                      |   8 +-
>  monitor/monitor.c                             |   1 +
>  qapi/machine.json                             |  66 +++++
>  qapi/misc.json                                |  26 ++
>  softmmu/balloon.c                             |  32 ++-
>  12 files changed, 437 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 9afbb54a51..f3548a148f 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1396,6 +1396,32 @@ SRST
>    Request VM to change its memory allocation to *value* (in MB).
>  ERST
>  
> +    {
> +        .name       = "ws_config",
> +        .args_type  = "i0:i,i1:i,i2:i,refresh:i,report:i",
> +        .params     = "bin intervals 0-2, refresh and report thresholds",
> +        .help       = "Working Set intervals, refresh/report thresholds (ms)",
> +        .cmd        = hmp_ws_config,
> +    },
> +
> +SRST
> +``ws_config``
> +  Set the intervals (in ms), refresh, and report thresholds for WS reporting
> +ERST
> +
> +    {
> +        .name       = "ws_request",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "Request the Working Set of the guest.",
> +        .cmd        = hmp_ws_request,
> +    },
> +
> +SRST
> +``wss_request``

Typo 'ws*s*'

Some other comments on that:
  a) When you've split the hmp stuff out into a separate patch you can
     give an example of the command (especially ws_config) in the
     commit message.

  b) Would it make sense to have a query-ws/info ws to display the last received
     working set info?

  c) Some may feel 'ws' is a bit terse and want the unabbreviated
  version.  (Is it also general, or is it actually virtio balloon
  specific, ie should the name include virtio or balloon?)

  d) You've got 3 bin intervals; is that '3' set in stone or is it
  likely to change in the future, in which case perhaps you want the
  perameters to be more flexible.  I note your migration code
  transfers a 'number of bins'.

> +  Request the Working Set Size of the guest.
> +ERST
> +
>      {
>          .name       = "set_link",
>          .args_type  = "name:s,up:b",
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c3e55ef9e9..dd11865ddc 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -237,6 +237,27 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, err);
>  }
>  
> +void hmp_ws_request(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +
> +    qmp_ws_request(&err);
> +    hmp_handle_error(mon, err);
> +}
> +
> +void hmp_ws_config(Monitor *mon, const QDict *qdict)
> +{
> +    uint64_t i0 = qdict_get_int(qdict, "i0");
> +    uint64_t i1 = qdict_get_int(qdict, "i1");
> +    uint64_t i2 = qdict_get_int(qdict, "i2");
> +    uint64_t refresh = qdict_get_int(qdict, "refresh");
> +    uint64_t report = qdict_get_int(qdict, "report");
> +    Error *err = NULL;
> +
> +    qmp_ws_config(i0, i1, i2, refresh, report, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
> index ce2645ba71..92409de924 100644
> --- a/hw/virtio/virtio-balloon-pci.c
> +++ b/hw/virtio/virtio-balloon-pci.c
> @@ -68,6 +68,8 @@ static void virtio_balloon_pci_instance_init(Object *obj)
>      object_property_add_alias(obj, "guest-stats-polling-interval",
>                                OBJECT(&dev->vdev),
>                                "guest-stats-polling-interval");
> +    object_property_add_alias(obj, "guest-ws", OBJECT(&dev->vdev),
> +                              "guest-ws");
>  }
>  
>  static const VirtioPCIDeviceTypeInfo virtio_balloon_pci_info = {
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d004cf29d2..31b18435c8 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -27,6 +27,7 @@
>  #include "exec/address-spaces.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-machine.h"
> +#include "qapi/qapi-visit-misc.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> @@ -169,6 +170,116 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
>      }
>  }
>  
> +/*
> + * reset_working_set - Mark all items in the array as unset
> + *
> + * This function needs to be called at device initialization and
> + * whenever a new Working Set config is specified.
> + */
> +static inline void reset_working_set(VirtIOBalloon *dev)
> +{
> +    int i;
> +    for (i = 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
> +        dev->ws[i].idle_age = 0;
> +        if (dev->ws[i].memory_size_bytes) {
> +            dev->ws[i].memory_size_bytes->anon = 0;
> +            dev->ws[i].memory_size_bytes->file = 0;
> +        } else {
> +            dev->ws[i].memory_size_bytes = g_malloc0(sizeof(MemoryBin));
> +        }
> +    }
> +}
> +
> +static void virtio_balloon_receive_working_set(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +    VirtIOBalloonWS ws;
> +    size_t offset = 0;
> +    int count = 0;
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +
> +    if (s->ws_vq_elem != NULL) {
> +        /* This should never happen if the driver follows the spec. */
> +        virtqueue_push(vq, s->ws_vq_elem, 0);
> +        virtio_notify(vdev, vq);
> +        g_free(s->ws_vq_elem);
> +    }
> +
> +    s->ws_vq_elem = elem;
> +
> +    /* Initialize the Working Set to get rid of any stale values. */
> +    reset_working_set(s);
> +
> +    while (iov_to_buf(elem->out_sg, elem->out_num, offset, &ws, sizeof(ws)) == sizeof(ws)) {
> +        uint64_t idle_age_ms = virtio_tswap64(vdev, ws.idle_age_ms);
> +        uint64_t bytes_anon = virtio_tswap64(vdev, ws.memory_size_bytes[0]);
> +        uint64_t bytes_file = virtio_tswap64(vdev, ws.memory_size_bytes[1]);
> +        s->ws[count].idle_age = idle_age_ms;
> +        s->ws[count].memory_size_bytes->anon = bytes_anon;
> +        s->ws[count].memory_size_bytes->file = bytes_file;
> +        offset += sizeof(ws);
> +        count++;
> +    }
> +    qapi_event_send_ws_event();
> +}
> +
> +static void virtio_balloon_send_ws_request(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +    size_t sz = 0;
> +    uint16_t tag = 0;
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +    tag = WS_REQUEST;
> +    sz = iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag));
> +    assert(sz == sizeof(tag));
> +    virtqueue_push(vq, elem, sz);
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +}
> +
> +static void virtio_balloon_send_ws_config(VirtIODevice *vdev, VirtQueue *vq,
> +                                          uint64_t i0, uint64_t i1, uint64_t i2,
> +                                          uint64_t refresh, uint64_t report)
> +{
> +    VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> +    VirtQueueElement *elem;
> +    uint16_t tag = 0;
> +    size_t sz = 0;
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +
> +    tag = WS_CONFIG;
> +    s->ws_intervals[0] = i0;
> +    s->ws_intervals[1] = i1;
> +    s->ws_intervals[2] = i2;
> +    s->ws_refresh_threshold = refresh;
> +    s->ws_report_threshold = report;
> +
> +    sz = iov_from_buf(elem->in_sg, elem->in_num, 0, &tag, sizeof(tag));
> +    assert(sz == sizeof(uint16_t));
> +    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, s->ws_intervals,
> +                       (VIRTIO_BALLOON_WS_NR_BINS - 1) * \
> +                       sizeof(s->ws_intervals[0]));
> +    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_refresh_threshold,
> +                       sizeof(uint64_t));
> +    sz += iov_from_buf(elem->in_sg, elem->in_num, sz, &s->ws_report_threshold,
> +                       sizeof(uint64_t));
> +    virtqueue_push(vq, elem, sz);
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +}
> +
>  static const char *balloon_stat_names[] = {
>     [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
>     [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
> @@ -237,6 +348,43 @@ static void balloon_stats_poll_cb(void *opaque)
>      virtio_notify(vdev, s->svq);
>      g_free(s->stats_vq_elem);
>      s->stats_vq_elem = NULL;
> +
> +}
> +
> +static void balloon_ws_get_all(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    Error *err = NULL;
> +    VirtIOBalloon *s = VIRTIO_BALLOON(obj);
> +    char ws_buf[4];
> +    WorkingSetInfo *wsinfo;
> +    int i;
> +
> +    if (!visit_start_struct(v, name, NULL, 0, &err)) {
> +        goto out;
> +    }
> +
> +    if (!visit_start_struct(v, "ws", NULL, 0, &err)) {
> +        goto out_end;
> +    }
> +    for (i = 0; i < VIRTIO_BALLOON_WS_NR_BINS; i++) {
> +        wsinfo = s->ws + i;
> +        sprintf(ws_buf, "ws%d", i);
> +        if (!visit_type_WorkingSetInfo(v, ws_buf, &wsinfo, &err)) {
> +            goto out_nested;
> +        }
> +    }
> +    visit_check_struct(v, &err);
> +out_nested:
> +    visit_end_struct(v, NULL);
> +
> +    if (!err) {
> +        visit_check_struct(v, &err);
> +    }
> +out_end:
> +    visit_end_struct(v, NULL);
> +out:
> +    error_propagate(errp, err);
>  }
>  
>  static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
> @@ -697,8 +845,11 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
>      if (s->qemu_4_0_config_size) {
>          return sizeof(struct virtio_balloon_config);
>      }
> +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_WS_REPORTING)) {
> +        return sizeof(struct virtio_balloon_config);
> +    }
>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> -        return sizeof(struct virtio_balloon_config);
> +        return offsetof(struct virtio_balloon_config, ws_num_bins);
>      }
>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>          return offsetof(struct virtio_balloon_config, poison_val);
> @@ -714,6 +865,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>      config.num_pages = cpu_to_le32(dev->num_pages);
>      config.actual = cpu_to_le32(dev->actual);
>      config.poison_val = cpu_to_le32(dev->poison_val);
> +    config.ws_num_bins = cpu_to_le32(VIRTIO_BALLOON_WS_NR_BINS);
>  
>      if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
>          config.free_page_hint_cmd_id =
> @@ -748,6 +900,14 @@ static bool virtio_balloon_page_poison_support(void *opaque)
>      return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
>  }
>  
> +static bool virtio_balloon_ws_reporting_support(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING);
> +}
> +
>  static void virtio_balloon_set_config(VirtIODevice *vdev,
>                                        const uint8_t *config_data)
>  {
> @@ -766,6 +926,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
>      if (virtio_balloon_page_poison_support(dev)) {
>          dev->poison_val = le32_to_cpu(config.poison_val);
>      }
> +    dev->ws_num_bins = 0;
> +    if (virtio_balloon_ws_reporting_support(dev)) {
> +        dev->ws_num_bins = le32_to_cpu(config.ws_num_bins);
> +    }
>      trace_virtio_balloon_set_config(dev->actual, oldactual);
>  }
>  
> @@ -775,6 +939,7 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>      f |= dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +    virtio_add_feature(&f, VIRTIO_BALLOON_F_WS_REPORTING);
>  
>      return f;
>  }
> @@ -786,6 +951,24 @@ static void virtio_balloon_stat(void *opaque, BalloonInfo *info)
>                                               VIRTIO_BALLOON_PFN_SHIFT);
>  }
>  
> +static void virtio_balloon_ws_request(void *opaque)
> +{
> +    VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    virtio_balloon_send_ws_request(vdev, dev->cvq);
> +}
> +
> +static void virtio_balloon_ws_config(void *opaque, uint64_t i0, uint64_t i1,
> +                                      uint64_t i2, uint64_t refresh, uint64_t report)
> +{
> +    VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    printf("VIRTIO-BALLOON: ws config");

Left over debug! Turn it into a trace_ 

> +    virtio_balloon_send_ws_config(vdev, dev->cvq, i0, i1, i2, refresh, report);
> +}
> +
>  static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
>  {
>      VirtIOBalloon *dev = VIRTIO_BALLOON(opaque);
> @@ -835,6 +1018,17 @@ static const VMStateDescription vmstate_virtio_balloon_page_poison = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_virtio_balloon_ws_reporting = {
> +    .name = "virtio-balloon-device/working-set-report",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = virtio_balloon_ws_reporting_support,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(ws_num_bins, VirtIOBalloon),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_virtio_balloon_device = {
>      .name = "virtio-balloon-device",
>      .version_id = 1,
> @@ -848,6 +1042,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>      .subsections = (const VMStateDescription * []) {
>          &vmstate_virtio_balloon_free_page_hint,
>          &vmstate_virtio_balloon_page_poison,
> +        &vmstate_virtio_balloon_ws_reporting,
>          NULL
>      }
>  };
> @@ -861,7 +1056,9 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      virtio_init(vdev, VIRTIO_ID_BALLOON, virtio_balloon_config_size(s));
>  
>      ret = qemu_add_balloon_handler(virtio_balloon_to_target,
> -                                   virtio_balloon_stat, s);
> +                                   virtio_balloon_stat,
> +                                   virtio_balloon_ws_request,
> +                                   virtio_balloon_ws_config, s);
>  
>      if (ret < 0) {
>          error_setg(errp, "Only one balloon device is supported");
> @@ -896,7 +1093,11 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>                                             virtio_balloon_handle_report);
>      }
>  
> +    s->wvq = virtio_add_queue(vdev, 128, virtio_balloon_receive_working_set);
> +    s->cvq = virtio_add_queue(vdev, 128, NULL);
> +
>      reset_stats(s);
> +    reset_working_set(s);
>  }
>  
>  static void virtio_balloon_device_unrealize(DeviceState *dev)
> @@ -922,6 +1123,8 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
>      if (s->reporting_vq) {
>          virtio_delete_queue(s->reporting_vq);
>      }
> +    virtio_delete_queue(s->wvq);
> +    virtio_delete_queue(s->cvq);
>      virtio_cleanup(vdev);
>  }
>  
> @@ -939,6 +1142,12 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
>          s->stats_vq_elem = NULL;
>      }
>  
> +    if (s->ws_vq_elem != NULL) {
> +        virtqueue_unpop(s->wvq, s->ws_vq_elem, 0);
> +        g_free(s->ws_vq_elem);
> +        s->ws_vq_elem = NULL;
> +    }
> +
>      s->poison_val = 0;
>  }
>  
> @@ -953,6 +1162,13 @@ static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
>          virtio_balloon_receive_stats(vdev, s->svq);
>      }
>  
> +    if (!s->ws_vq_elem && vdev->vm_running &&
> +        (status & VIRTIO_CONFIG_S_DRIVER_OK) && virtqueue_rewind(s->wvq, 1)) {
> +        /* poll ws queue for the element we have discarded when the VM
> +         * was stopped */
> +        virtio_balloon_receive_working_set(vdev, s->wvq);
> +    }
> +
>      if (virtio_balloon_free_page_support(s)) {
>          /*
>           * The VM is woken up and the iothread was blocked, so signal it to
> @@ -983,6 +1199,9 @@ static void virtio_balloon_instance_init(Object *obj)
>      s->free_page_hint_cmd_id = VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>      s->free_page_hint_notify.notify = virtio_balloon_free_page_hint_notify;
>  
> +    object_property_add(obj, "guest-ws", "guest working set",
> +                        balloon_ws_get_all, NULL, NULL, NULL);
> +
>      object_property_add(obj, "guest-stats", "guest statistics",
>                          balloon_stats_get_all, NULL, NULL, NULL);
>  
> @@ -1011,6 +1230,8 @@ static Property virtio_balloon_properties[] = {
>                      VIRTIO_BALLOON_F_PAGE_POISON, true),
>      DEFINE_PROP_BIT("free-page-reporting", VirtIOBalloon, host_features,
>                      VIRTIO_BALLOON_F_REPORTING, false),
> +    DEFINE_PROP_BIT("working-set", VirtIOBalloon, host_features,
> +                    VIRTIO_BALLOON_F_WS_REPORTING, true),
>      /* QEMU 4.0 accidentally changed the config size even when free-page-hint
>       * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
>       * property retains this quirk for QEMU 4.1 machine types.
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index 5139cf8ab6..99a1a5ca85 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -17,6 +17,7 @@
>  
>  #include "standard-headers/linux/virtio_balloon.h"
>  #include "hw/virtio/virtio.h"
> +#include "qapi/qapi-types-misc.h"
>  #include "sysemu/iothread.h"
>  #include "qom/object.h"
>  
> @@ -25,7 +26,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBalloon, VIRTIO_BALLOON)
>  
>  #define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
>  
> +#define VIRTIO_BALLOON_WS_NR_BINS	4  /* Number of bins in WS report */
> +
>  typedef struct virtio_balloon_stat VirtIOBalloonStat;
> +typedef struct virtio_balloon_ws VirtIOBalloonWS;
>  
>  typedef struct virtio_balloon_stat_modern {
>         uint16_t tag;
> @@ -40,15 +44,25 @@ enum virtio_balloon_free_page_hint_status {
>      FREE_PAGE_HINT_S_DONE = 3,
>  };
>  
> +enum virtio_balloon_ws_operation {
> +    WS_REQUEST = 1,
> +    WS_CONFIG = 2,
> +};
> +
>  struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq;
> +    VirtQueue *ivq, *dvq, *svq, *free_page_vq, *reporting_vq, *wvq, *cvq;
>      uint32_t free_page_hint_status;
>      uint32_t num_pages;
>      uint32_t actual;
>      uint32_t free_page_hint_cmd_id;
>      uint64_t stats[VIRTIO_BALLOON_S_NR];
> +    WorkingSetInfo ws[VIRTIO_BALLOON_WS_NR_BINS];
> +    uint64_t ws_intervals[VIRTIO_BALLOON_WS_NR_BINS-1];
> +    uint64_t ws_refresh_threshold;
> +    uint64_t ws_report_threshold;
>      VirtQueueElement *stats_vq_elem;
> +    VirtQueueElement *ws_vq_elem;
>      size_t stats_vq_offset;
>      QEMUTimer *stats_timer;
>      IOThread *iothread;
> @@ -71,6 +85,7 @@ struct VirtIOBalloon {
>  
>      bool qemu_4_0_config_size;
>      uint32_t poison_val;
> +    uint32_t ws_num_bins;
>  };
>  
>  #endif
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 13f9a2dedb..ad3184112f 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -59,6 +59,8 @@ void hmp_nmi(Monitor *mon, const QDict *qdict);
>  void hmp_info_network(Monitor *mon, const QDict *qdict);
>  void hmp_set_link(Monitor *mon, const QDict *qdict);
>  void hmp_balloon(Monitor *mon, const QDict *qdict);
> +void hmp_ws_config(Monitor *mon, const QDict *qdict);
> +void hmp_ws_request(Monitor *mon, const QDict *qdict);
>  void hmp_loadvm(Monitor *mon, const QDict *qdict);
>  void hmp_savevm(Monitor *mon, const QDict *qdict);
>  void hmp_delvm(Monitor *mon, const QDict *qdict);
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index f343bfefd8..8d489a2ebd 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -37,6 +37,7 @@
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
>  #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> +#define VIRTIO_BALLOON_F_WS_REPORTING	6 /* Working set report virtqueues */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -59,6 +60,8 @@ struct virtio_balloon_config {
>  	};
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	uint32_t poison_val;
> +	/* Stores the number of histogram bins if WS reporting in use */
> +	uint32_t ws_num_bins;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> @@ -116,4 +119,18 @@ struct virtio_balloon_stat {
>  	__virtio64 val;
>  } QEMU_PACKED;
>  
> +enum virtio_balloon_ws_op {
> +    VIRTIO_BALLOON_WS_REQUEST = 1, // a Working Set request from the host
> +    VIRTIO_BALLOON_WS_CONFIG = 2,  // a WS config update from the host
> +};
> +
> +struct virtio_balloon_ws {
> +        __virtio16 tag;
> +        __virtio16 node_id;
> +        uint8_t reserved[4];
> +	__virtio64 idle_age_ms;
> +	// Track separately for ANON_AND_FILE.
> +	__virtio64 memory_size_bytes[2];
> +} QEMU_PACKED;
> +
>  #endif /* _LINUX_VIRTIO_BALLOON_H */
> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
> index 867687b73a..fb1de215d9 100644
> --- a/include/sysemu/balloon.h
> +++ b/include/sysemu/balloon.h
> @@ -18,10 +18,16 @@
>  #include "qapi/qapi-types-machine.h"
>  
>  typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
> +typedef void (QEMUBalloonWSRequest)(void *opaque);
>  typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
> +typedef void (QEMUBalloonWSConfig)(void *opaque, uint64_t i0, uint64_t i1,
> +                                   uint64_t i2, uint64_t refresh,
> +                                   uint64_t report);
>  
>  int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> -                             QEMUBalloonStatus *stat_func, void *opaque);
> +                             QEMUBalloonStatus *stat_func,
> +                             QEMUBalloonWSRequest *wss_func,
> +                             QEMUBalloonWSConfig *config_func, void *opaque);
>  void qemu_remove_balloon_handler(void *opaque);
>  
>  #endif
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 602535696c..52ac7c4599 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -329,6 +329,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>      [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
>      [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>      [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_WS_EVENT]          = { 1000 * SCALE_MS },
>      [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
>      [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
>      [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
> diff --git a/qapi/machine.json b/qapi/machine.json
> index fcd69965e5..5810f7c3fa 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1048,6 +1048,57 @@
>  ##
>  { 'command': 'balloon', 'data': {'value': 'int'} }
>  
> +##
> +# @ws-config:
> +#
> +# Specify the config parameters for Working Set reporting.
> +#
> +# @i0: the endpoint of the first interval (in ms)
> +#
> +# @i1: the endpoint of the second interval (in ms)
> +#
> +# @i2: the endpoint of the third interval (in ms)
> +#
> +# @refresh: the refresh threshold (in ms) for Working Set reporting
> +#
> +# @report: the report threshold (in ms) for Working Set reporting
> +#
> +# Returns: - Nothing on success
> +#          - If no balloon device is present, DeviceNotActive
> +#
> +# Example:
> +#
> +# -> { "execute": "ws-config",
> +#                 "arguments": { "i0": 100,
> +#                                "i1": 500,
> +#                                "i2": 2000,
> +#                                "refresh": 750,
> +#                                "report": 1000 } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'ws-config', 'data': {'i0': 'uint64',
> +                                       'i1': 'uint64',
> +                                       'i2': 'uint64',
> +                                       'refresh': 'uint64',
> +                                       'report': 'uint64'} }
> +##
> +# @ws-request:
> +#
> +# Request the Working Set report from the guest.
> +#
> +# Returns: - Nothing on success
> +#          - If no balloon device is present, DeviceNotActive
> +#
> +# Example:
> +#
> +# -> { "execute": "ws-request", "arguments": {} }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'ws-request', 'data': {} }
> +
> +
>  ##
>  # @BalloonInfo:
>  #
> @@ -1106,6 +1157,21 @@
>  { 'event': 'BALLOON_CHANGE',
>    'data': { 'actual': 'int' } }
>  
> +##
> +# @WS_EVENT:
> +#
> +# Emitted when the guest sends a new Working Set report.
> +#
> +# Note: this event is rate-limited.
> +#
> +# Example:
> +#
> +# <- { "event": "WS_EVENT",
> +#      "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
> +#
> +##
> +{ 'event': 'WS_EVENT' }
> +
>  ##
>  # @MemoryInfo:
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 4afaee7fe7..b1da595c80 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -523,6 +523,32 @@
>  { 'struct': 'CommandLineOptionInfo',
>    'data': { 'option': 'str', 'parameters': ['CommandLineParameterInfo'] } }
>  
> +##
> +# @MemoryBin:
> +#
> +# A bin of memory with a size in bytes. File-backed and
> +# anonymous memory are tracked separately.
> +#
> +# @anon: number of bytes of anonymous memory
> +# @file: number of bytes of file-backed memory
> +##
> +{ 'struct': 'MemoryBin',
> +  'data': { 'anon': 'uint64',
> +            'file': 'uint64' } }
> +
> +##
> +# @WorkingSetInfo:
> +#
> +# A bin of memory of the given size that has been idle at most `idle-age` ms
> +#
> +# @idle-age: guest-relative time (in milliseconds)
> +#
> +# @memory-size-bytes: A MemoryBin with file and anon info.
> +##
> +{ 'struct': 'WorkingSetInfo',
> +  'data': { 'idle-age': 'uint64',
> +            'memory-size-bytes': 'MemoryBin' } }
> +
>  ##
>  # @query-command-line-options:
>  #
> diff --git a/softmmu/balloon.c b/softmmu/balloon.c
> index e0e8969a4b..8ff30fe43b 100644
> --- a/softmmu/balloon.c
> +++ b/softmmu/balloon.c
> @@ -35,6 +35,8 @@
>  
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
> +static QEMUBalloonWSRequest *balloon_ws_request_fn;
> +static QEMUBalloonWSConfig *balloon_ws_config_fn;
>  static void *balloon_opaque;
>  
>  static bool have_balloon(Error **errp)
> @@ -53,9 +55,12 @@ static bool have_balloon(Error **errp)
>  }
>  
>  int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
> -                             QEMUBalloonStatus *stat_func, void *opaque)
> +                             QEMUBalloonStatus *stat_func,
> +                             QEMUBalloonWSRequest *ws_request_func,
> +                             QEMUBalloonWSConfig *ws_config_func, void *opaque)
>  {
> -    if (balloon_event_fn || balloon_stat_fn || balloon_opaque) {
> +    if (balloon_event_fn || balloon_stat_fn || balloon_ws_request_fn \
> +        || balloon_ws_config_fn || balloon_opaque) {
>          /* We're already registered one balloon handler.  How many can
>           * a guest really have?
>           */
> @@ -63,6 +68,8 @@ int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
>      }
>      balloon_event_fn = event_func;
>      balloon_stat_fn = stat_func;
> +    balloon_ws_request_fn = ws_request_func;
> +    balloon_ws_config_fn = ws_config_func;
>      balloon_opaque = opaque;
>      return 0;
>  }
> @@ -74,6 +81,8 @@ void qemu_remove_balloon_handler(void *opaque)
>      }
>      balloon_event_fn = NULL;
>      balloon_stat_fn = NULL;
> +    balloon_ws_request_fn = NULL;
> +    balloon_ws_config_fn = NULL;
>      balloon_opaque = NULL;
>  }
>  
> @@ -104,3 +113,22 @@ void qmp_balloon(int64_t target, Error **errp)
>      trace_balloon_event(balloon_opaque, target);
>      balloon_event_fn(balloon_opaque, target);
>  }
> +
> +void qmp_ws_request(Error **errp)
> +{
> +    if (!have_balloon(errp)) {
> +        return;
> +    }
> +
> +    balloon_ws_request_fn(balloon_opaque);
> +}
> +
> +void qmp_ws_config(uint64_t i0, uint64_t i1, uint64_t i2, uint64_t refresh,
> +                       uint64_t report, Error **errp)
> +{
> +    if (!have_balloon(errp)) {
> +        return;
> +    }
> +
> +    balloon_ws_config_fn(balloon_opaque, i0, i1, i2, refresh, report);
> +}
> -- 
> 2.40.1.521.gf1e218fcd8-goog
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

