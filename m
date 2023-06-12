Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8572CD21
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 19:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8lYk-0004EL-T8; Mon, 12 Jun 2023 13:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q8lYi-0004Cv-30
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 13:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q8lYf-00010R-73
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 13:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686591743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmOc9lzdwxWb33+LrNv51xobZ1q+HcuSCIKnIQG4qus=;
 b=H50LzxyDyuDlp7sggcmqGPzQJj9//kZxYta8+sLt20ZCz79IbZDRFfhObEtOEsjiNqYpMN
 2cp4Zt1rbq/fbzgHg1qb+yuzj6TFIttKm4EZf06gsoKv3ndZYJU4Xjp3iH1ndUV8llqYxx
 oStSYLYi8bAQUVTZgd6v1xsZup14wU8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Z6qGbwTpMsKV1Jgtb_91Aw-1; Mon, 12 Jun 2023 13:42:21 -0400
X-MC-Unique: Z6qGbwTpMsKV1Jgtb_91Aw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30fca80b483so97892f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 10:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686591741; x=1689183741;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmOc9lzdwxWb33+LrNv51xobZ1q+HcuSCIKnIQG4qus=;
 b=ZLpVkjTu8+patR99yaB01zPtemzFyQRlsdnQVMUZzRr8+MO5MB3d6XeAaVgXZo77sP
 Od5QN6OW4L8oZayGUpvYRwf7JIhz/6tXM31vjRcqE6+RE7kBTsoDRXhwJR/VYESsTpDa
 zCHD5uEh/8Y/IJnJ/mfnOgEhVQUHfR6a+4dz68/pbzADnxb1D/HeemSOYYi4tcfYTbIw
 ejOAj64WdvEza0LQo9db9mDZ3GdMXVMMPZxR9MPmLPfmq8ZczWD6jvQd9ANZCj56Tn2r
 dfQF8UNhnAemMaV5TsDDS5ovTu97UQLx0WJGBPBjCvFupyIwvxofrQLiPg6Rw2IGnS9a
 p8iQ==
X-Gm-Message-State: AC+VfDygPJtAYZDZR/+QlIzT2JQItfGOOUbnRQ0q37NQVo/Dpc3otZ5l
 kSfh4Ir1G26hf8To0m/LVkOJmSvQmmS/Ph7SVVzPLCXXeFFd5TXaLnVWDYXwmRlJvjce6xwxSd3
 oCzFjBZypEX2b5+U=
X-Received: by 2002:a5d:570d:0:b0:30e:586e:facc with SMTP id
 a13-20020a5d570d000000b0030e586efaccmr4670773wrv.1.1686591740648; 
 Mon, 12 Jun 2023 10:42:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74xbqB6+4WkYLgUUDP4RwlTZXDWYA8RftoUlkPlhIq6gQovvgeWw7ifrdhG04CT1bZvoi/sw==
X-Received: by 2002:a5d:570d:0:b0:30e:586e:facc with SMTP id
 a13-20020a5d570d000000b0030e586efaccmr4670756wrv.1.1686591740177; 
 Mon, 12 Jun 2023 10:42:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e?
 (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de.
 [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
 by smtp.gmail.com with ESMTPSA id
 t12-20020adfe10c000000b00307acec258esm13009207wrz.3.2023.06.12.10.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 10:42:19 -0700 (PDT)
Message-ID: <f54e55d0-b8dd-a431-7634-02fdec0611bb@redhat.com>
Date: Mon, 12 Jun 2023 19:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1686577753.git.maciej.szmigiero@oracle.com>
 <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH][RESEND v5 3/3] Add a Hyper-V Dynamic Memory Protocol
 driver (hv-balloon)
In-Reply-To: <896327748bde906826e24ce7cc45301e325e14a7.1686577753.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12.06.23 16:00, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This driver is like virtio-balloon on steroids: it allows both changing the
> guest memory allocation via ballooning and inserting pieces of extra RAM
> into it on demand from a provided memory backend.
> 
> One of advantages of these over ACPI-based PC DIMM hotplug is that such
> memory can be hotplugged in much smaller granularity because the ACPI DIMM
> slot limit does not apply.
> 
> In order to enable hot-adding additional memory a new memory backend needs
> to be created and provided to the driver via the "memdev" parameter.
> This can be achieved by, for example, adding
> "-object memory-backend-ram,id=mem1,size=32G" to the QEMU command line and
> then instantiating the driver with "memdev=mem1" parameter.
> 
> In contrast with ACPI DIMM hotplug where one can only request to unplug a
> whole DIMM stick this driver allows removing memory from guest in single
> page (4k) units via ballooning.
> 
> The actual resizing is done via ballooning interface (for example, via
> the "balloon" HMP command)
> This includes resizing the guest past its boot size - that is, hot-adding
> additional memory in granularity limited only by the guest alignment
> requirements.
> 
> After a VM reboot the guest is back to its original (boot) size.
> 
> In the future, the guest boot memory size might be changed on reboot
> instead, taking into account the effective size that VM had before that
> reboot (much like Hyper-V does).
> 
> For performance reasons, the guest-released memory is tracked in a few
> range trees, as a series of (start, count) ranges.
> Each time a new page range is inserted into such tree its neighbors are
> checked as candidates for possible merging with it.
> 
> Besides performance reasons, the Dynamic Memory protocol itself uses page
> ranges as the data structure in its messages, so relevant pages need to be
> merged into such ranges anyway.
> 
> One has to be careful when tracking the guest-released pages, since the
> guest can maliciously report returning pages outside its current address
> space, which later clash with the address range of newly added memory.
> Similarly, the guest can report freeing the same page twice.
> 
> The above design results in much better ballooning performance than when
> using virtio-balloon with the same guest: 230 GB / minute with this driver
> versus 70 GB / minute with virtio-balloon.
> 
> During a ballooning operation most of time is spent waiting for the guest
> to come up with newly freed page ranges, processing the received ranges on
> the host side (in QEMU and KVM) is nearly instantaneous.
> 
> The unballoon operation is also pretty much instantaneous:
> thanks to the merging of the ballooned out page ranges 200 GB of memory can
> be returned to the guest in about 1 second.
> With virtio-balloon this operation takes about 2.5 minutes.
> 
> These tests were done against a Windows Server 2019 guest running on a
> Xeon E5-2699, after dirtying the whole memory inside guest before each
> balloon operation.
> 
> Using a range tree instead of a bitmap to track the removed memory also
> means that the solution scales well with the guest size: even a 1 TB range
> takes just a few bytes of such metadata.
> 
> Since the required GTree operations aren't present in every Glib version
> a check for them was added to the meson build script, together with new
> "--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
> If these GTree operations are missing in the system's Glib version this
> driver will be skipped during QEMU build.
> 
> An optional "status-report=on" device parameter requests memory status
> events from the guest (typically sent every second), which allow the host
> to learn both the guest memory available and the guest memory in use
> counts.
> They are emitted externally as "HV_BALLOON_STATUS_REPORT" QMP events.
> 
> The driver is named hv-balloon since the Linux kernel client driver for
> the Dynamic Memory Protocol is named as such and to follow the naming
> pattern established by the virtio-balloon driver.
> The whole protocol runs over Hyper-V VMBus.
> 
> The driver was tested against Windows Server 2012 R2, Windows Server 2016
> and Windows Server 2019 guests and obeys the guest alignment requirements
> reported to the host via DM_CAPABILITIES_REPORT message.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   Kconfig.host                  |    3 +
>   hw/hyperv/Kconfig             |    5 +
>   hw/hyperv/hv-balloon.c        | 2040 +++++++++++++++++++++++++++++++++
>   hw/hyperv/meson.build         |    1 +
>   hw/hyperv/trace-events        |   16 +
>   meson.build                   |   28 +-
>   meson_options.txt             |    2 +
>   qapi/machine.json             |   25 +
>   scripts/meson-buildoptions.sh |    3 +
>   9 files changed, 2122 insertions(+), 1 deletion(-)
>   create mode 100644 hw/hyperv/hv-balloon.c
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index d763d892693c..2ee71578f38f 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -46,3 +46,6 @@ config FUZZ
>   config VFIO_USER_SERVER_ALLOWED
>       bool
>       imply VFIO_USER_SERVER
> +
> +config HV_BALLOON_POSSIBLE
> +    bool
> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
> index fcf65903bd05..3db31f4f4b40 100644
> --- a/hw/hyperv/Kconfig
> +++ b/hw/hyperv/Kconfig
> @@ -16,3 +16,8 @@ config SYNDBG
>       bool
>       default y
>       depends on VMBUS
> +
> +config HV_BALLOON
> +    bool
> +    default y
> +    depends on HV_BALLOON_POSSIBLE && VMBUS
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> new file mode 100644
> index 000000000000..076ac9a8bd90
> --- /dev/null
> +++ b/hw/hyperv/hv-balloon.c
> @@ -0,0 +1,2040 @@
> +/*
> + * QEMU Hyper-V Dynamic Memory Protocol driver
> + *
> + * Copyright (C) 2020-2023 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "exec/address-spaces.h"
> +#include "exec/cpu-common.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "hw/boards.h"
> +#include "hw/hyperv/dynmem-proto.h"
> +#include "hw/hyperv/vmbus.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/qdev-core.h"
> +#include "hw/qdev-properties.h"
> +#include "monitor/qdev.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-events-machine.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/visitor.h"
> +#include "qemu/error-report.h"
> +#include "qemu/module.h"
> +#include "qemu/units.h"
> +#include "qemu/timer.h"
> +#include "sysemu/balloon.h"
> +#include "sysemu/hostmem.h"
> +#include "sysemu/reset.h"
> +#include "trace.h"
> +
> +/*
> + * temporarily avoid warnings about enhanced GTree API usage requiring a
> + * too recent Glib version until GLIB_VERSION_MAX_ALLOWED finally reaches
> + * the Glib version with this API
> + */
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
> +#define TYPE_HV_BALLOON "hv-balloon"
> +#define HV_BALLOON_ADDR_PROP "addr"
> +#define HV_BALLOON_MEMDEV_PROP "memdev"
> +#define HV_BALLOON_GUID "525074DC-8985-46e2-8057-A307DC18A502"
> +#define HV_BALLOON_PFN_SHIFT 12
> +#define HV_BALLOON_PAGE_SIZE (1 << HV_BALLOON_PFN_SHIFT)
> +
> +/*
> + * Some Windows versions (at least Server 2019) will crash with various
> + * error codes when receiving DM protocol requests (at least
> + * DM_MEM_HOT_ADD_REQUEST) immediately after boot.
> + *
> + * It looks like Hyper-V from Server 2016 uses a 50-second after-boot
> + * delay, probably to workaround this issue, so we'll use this value, too.
> + */
> +#define HV_BALLOON_POST_INIT_WAIT (50 * 1000)
> +
> +#define HV_BALLOON_HA_CHUNK_SIZE (2 * GiB)
> +#define HV_BALLOON_HA_CHUNK_PAGES (HV_BALLOON_HA_CHUNK_SIZE / HV_BALLOON_PAGE_SIZE)
> +
> +#define HV_BALLOON_HR_CHUNK_PAGES 585728
> +/*
> + *                                ^ that's the maximum number of pages
> + * that Windows returns in one hot remove response
> + *
> + * If the number requested is too high Windows will no longer honor
> + * these requests
> + */
> +
> +typedef enum State {
> +    /* not a real state */
> +    S_NO_CHANGE = 0,
> +
> +    S_WAIT_RESET,
> +    S_POST_RESET_CLOSED,
> +
> +    /* init flow */
> +    S_VERSION,
> +    S_CAPS,
> +    S_POST_INIT_WAIT,
> +
> +    S_IDLE,
> +
> +    /* balloon op flow */
> +    S_BALLOON_POSTING,
> +    S_BALLOON_RB_WAIT,
> +    S_BALLOON_REPLY_WAIT,
> +
> +    /* unballoon + hot add ops flow */
> +    S_UNBALLOON_POSTING,
> +    S_UNBALLOON_RB_WAIT,
> +    S_UNBALLOON_REPLY_WAIT,
> +    S_HOT_ADD_SETUP,
> +    S_HOT_ADD_RB_WAIT,
> +    S_HOT_ADD_POSTING,
> +    S_HOT_ADD_REPLY_WAIT,
> +} State;
> +
> +typedef struct StateDesc {
> +    State state;
> +    const char *desc;
> +} StateDesc;
> +
> +typedef struct PageRange {
> +    uint64_t start;
> +    uint64_t count;
> +} PageRange;
> +
> +/* type safety */
> +typedef struct PageRangeTree {
> +    GTree *t;
> +} PageRangeTree;
> +
> +/* "our range" means the memory range owned by this driver (for hot-adding) */
> +typedef struct OurRange {
> +    PageRange range;
> +
> +    /* How many pages were hot-added to the guest */
> +    uint64_t added;
> +
> +    /* Pages at the end not currently usable */
> +    uint64_t unusable_tail;
> +
> +    /* Memory removed from the guest */
> +    PageRangeTree removed_guest, removed_both;
> +} OurRange;
> +
> +typedef struct OurRangePlugged {
> +    OurRange range;
> +    MemoryDeviceState *md;
> +    HostMemoryBackend *hostmem;
> +} OurRangePlugged;
> +
> +typedef struct HvBalloon {
> +    VMBusDevice parent;
> +    State state;
> +    bool status_reports;
> +
> +    union dm_version version;
> +    union dm_caps caps;
> +
> +    QEMUTimer post_init_timer;
> +
> +    unsigned int trans_id;
> +
> +    /* Guest target size */
> +    uint64_t target;
> +    bool target_changed;
> +
> +    /* Current (un)balloon / hot-add operation parameters */
> +    union {
> +        uint64_t balloon_diff;
> +
> +        struct {
> +            uint64_t unballoon_diff;
> +            uint64_t hot_add_diff;
> +        };
> +
> +        struct {
> +            PageRange hot_add_range;
> +            uint64_t ha_current_count;
> +        };
> +    };
> +
> +    OurRangePlugged *our_range;
> +
> +    /* Non-ours removed memory */
> +    PageRangeTree removed_guest, removed_both;
> +
> +    /* Grand totals of removed memory (both ours and non-ours) */
> +    uint64_t removed_guest_ctr, removed_both_ctr;
> +
> +    /* MEMORY_DEVICE props */
> +    uint64_t addr;
> +    HostMemoryBackend *hostmem;
> +} HvBalloon;
> +
> +#define HV_BALLOON(obj) OBJECT_CHECK(HvBalloon, (obj), TYPE_HV_BALLOON)
> +
> +#define HV_BALLOON_SET_STATE(hvb, news)             \
> +    do {                                            \
> +        assert(news != S_NO_CHANGE);                \
> +        hv_balloon_state_set(hvb, news, # news);    \
> +    } while (0)
> +
> +#define HV_BALLOON_STATE_DESC_SET(stdesc, news)         \
> +    _hv_balloon_state_desc_set(stdesc, news, # news)
> +
> +#define HV_BALLOON_STATE_DESC_INIT \
> +    {                              \
> +        .state = S_NO_CHANGE,      \
> +    }
> +
> +#define SUM_OVERFLOW_U64(in1, in2) ((in1) > UINT64_MAX - (in2))
> +#define SUM_SATURATE_U64(in1, in2)              \
> +    ({                                          \
> +        uint64_t _in1 = (in1), _in2 = (in2);    \
> +        uint64_t _result;                       \
> +                                                \
> +        if (!SUM_OVERFLOW_U64(_in1, _in2)) {    \
> +            _result = _in1 + _in2;              \
> +        } else {                                \
> +            _result = UINT64_MAX;               \
> +        }                                       \
> +                                                \
> +        _result;                                \
> +    })
> +
> +typedef struct HvBalloonReq {
> +    VMBusChanReq vmreq;
> +} HvBalloonReq;
> +
> +/* PageRange */
> +static void page_range_intersect(const PageRange *range,
> +                                 uint64_t start, uint64_t count,
> +                                 PageRange *out)
> +{
> +    uint64_t end1 = range->start + range->count;
> +    uint64_t end2 = start + count;
> +    uint64_t end = MIN(end1, end2);
> +
> +    out->start = MAX(range->start, start);
> +    out->count = out->start < end ? end - out->start : 0;
> +}
> +
> +static uint64_t page_range_intersection_size(const PageRange *range,
> +                                             uint64_t start, uint64_t count)
> +{
> +    PageRange trange;
> +
> +    page_range_intersect(range, start, count, &trange);
> +    return trange.count;
> +}
> +
> +/* return just the part of range before (start) */
> +static void page_range_part_before(const PageRange *range,
> +                                   uint64_t start, PageRange *out)
> +{
> +    uint64_t endr = range->start + range->count;
> +    uint64_t end = MIN(endr, start);
> +
> +    out->start = range->start;
> +    if (end > out->start) {
> +        out->count = end - out->start;
> +    } else {
> +        out->count = 0;
> +    }
> +}
> +
> +/* return just the part of range after (start, count) */
> +static void page_range_part_after(const PageRange *range,
> +                                  uint64_t start, uint64_t count,
> +                                  PageRange *out)
> +{
> +    uint64_t end = range->start + range->count;
> +    uint64_t ends = start + count;
> +
> +    out->start = MAX(range->start, ends);
> +    if (end > out->start) {
> +        out->count = end - out->start;
> +    } else {
> +        out->count = 0;
> +    }
> +}
> +
> +static bool page_range_joinable_left(const PageRange *range,
> +                                     uint64_t start, uint64_t count)
> +{
> +    return start + count == range->start;
> +}
> +
> +static bool page_range_joinable_right(const PageRange *range,
> +                                      uint64_t start, uint64_t count)
> +{
> +    return range->start + range->count == start;
> +}
> +
> +static bool page_range_joinable(const PageRange *range,
> +                                uint64_t start, uint64_t count)
> +{
> +    return page_range_joinable_left(range, start, count) ||
> +        page_range_joinable_right(range, start, count);
> +}
> +
> +/* PageRangeTree */
> +static gint page_range_tree_key_compare(gconstpointer leftp,
> +                                        gconstpointer rightp,
> +                                        gpointer user_data)
> +{
> +    const uint64_t *left = leftp, *right = rightp;
> +
> +    if (*left < *right) {
> +        return -1;
> +    } else if (*left > *right) {
> +        return 1;
> +    } else { /* *left == *right */
> +        return 0;
> +    }
> +}
> +
> +static GTreeNode *page_range_tree_insert_new(PageRangeTree tree,
> +                                             uint64_t start, uint64_t count)
> +{
> +    uint64_t *key = g_malloc(sizeof(*key));
> +    PageRange *range = g_malloc(sizeof(*range));
> +
> +    assert(count > 0);
> +
> +    *key = range->start = start;
> +    range->count = count;
> +
> +    return g_tree_insert_node(tree.t, key, range);
> +}
> +
> +static void page_range_tree_insert(PageRangeTree tree,
> +                                   uint64_t start, uint64_t count,
> +                                   uint64_t *dupcount)
> +{
> +    GTreeNode *node;
> +    bool joinable;
> +    uint64_t intersection;
> +    PageRange *range;
> +
> +    assert(!SUM_OVERFLOW_U64(start, count));
> +    if (count == 0) {
> +        return;
> +    }
> +
> +    node = g_tree_upper_bound(tree.t, &start);
> +    if (node) {
> +        node = g_tree_node_previous(node);
> +    } else {
> +        node = g_tree_node_last(tree.t);
> +    }
> +
> +    if (node) {
> +        range = g_tree_node_value(node);
> +        assert(range);
> +        intersection = page_range_intersection_size(range, start, count);
> +        joinable = page_range_joinable_right(range, start, count);
> +    }
> +
> +    if (!node ||
> +        (!intersection && !joinable)) {
> +        /*
> +         * !node case: the tree is empty or the very first node in the tree
> +         * already has a higher key (the start of its range).
> +         * the other case: there is a gap in the tree between the new range
> +         * and the previous one.
> +         * anyway, let's just insert the new range into the tree.
> +         */
> +        node = page_range_tree_insert_new(tree, start, count);
> +        assert(node);
> +        range = g_tree_node_value(node);
> +        assert(range);
> +    } else {
> +        /*
> +         * the previous range in the tree either partially covers the new
> +         * range or ends just at its beginning - extend it
> +         */
> +        if (dupcount) {
> +            *dupcount += intersection;
> +        }
> +
> +        count += start - range->start;
> +        range->count = MAX(range->count, count);
> +    }
> +
> +    /* check next nodes for possible merging */
> +    for (node = g_tree_node_next(node); node; ) {
> +        PageRange *rangecur;
> +
> +        rangecur = g_tree_node_value(node);
> +        assert(rangecur);
> +
> +        intersection = page_range_intersection_size(rangecur,
> +                                                    range->start, range->count);
> +        joinable = page_range_joinable_left(rangecur,
> +                                            range->start, range->count);
> +        if (!intersection && !joinable) {
> +            /* the current node is disjoint */
> +            break;
> +        }
> +
> +        if (dupcount) {
> +            *dupcount += intersection;
> +        }
> +
> +        count = rangecur->count + (rangecur->start - range->start);
> +        range->count = MAX(range->count, count);
> +
> +        /* the current node was merged in, remove it */
> +        start = rangecur->start;
> +        node = g_tree_node_next(node);
> +        /* no hinted removal in GTree... */
> +        g_tree_remove(tree.t, &start);
> +    }
> +}
> +
> +static bool page_range_tree_pop(PageRangeTree tree, PageRange *out,
> +                                uint64_t maxcount)
> +{
> +    GTreeNode *node;
> +    PageRange *range;
> +
> +    node = g_tree_node_last(tree.t);
> +    if (!node) {
> +        return false;
> +    }
> +
> +    range = g_tree_node_value(node);
> +    assert(range);
> +
> +    out->start = range->start;
> +
> +    /* can't modify range->start as it is the node key */
> +    if (range->count > maxcount) {
> +        out->start += range->count - maxcount;
> +        out->count = maxcount;
> +        range->count -= maxcount;
> +    } else {
> +        out->count = range->count;
> +        /* no hinted removal in GTree... */
> +        g_tree_remove(tree.t, &out->start);
> +    }
> +
> +    return true;
> +}
> +
> +static bool page_range_tree_intree_any(PageRangeTree tree,
> +                                       uint64_t start, uint64_t count)
> +{
> +    GTreeNode *node;
> +
> +    if (count == 0) {
> +        return false;
> +    }
> +
> +    /* find the first node that can possibly intersect our range */
> +    node = g_tree_upper_bound(tree.t, &start);
> +    if (node) {
> +        /*
> +         * a NULL node below means that the very first node in the tree
> +         * already has a higher key (the start of its range).
> +         */
> +        node = g_tree_node_previous(node);
> +    } else {
> +        /* a NULL node below means that the tree is empty */
> +        node = g_tree_node_last(tree.t);
> +    }
> +    /* node range start <= range start */
> +
> +    if (!node) {
> +        /* node range start > range start */
> +        node = g_tree_node_first(tree.t);
> +    }
> +
> +    for ( ; node; node = g_tree_node_next(node)) {
> +        PageRange *range = g_tree_node_value(node);
> +
> +        assert(range);
> +        /*
> +         * if this node starts beyond or at the end of our range so does
> +         * every next one
> +         */
> +        if (range->start >= start + count) {
> +            break;
> +        }
> +
> +        if (page_range_intersection_size(range, start, count) > 0) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static void page_range_tree_init(PageRangeTree *tree)
> +{
> +    tree->t = g_tree_new_full(page_range_tree_key_compare, NULL,
> +                              g_free, g_free);
> +}
> +
> +static void page_range_tree_destroy(PageRangeTree *tree)
> +{
> +    /* g_tree_destroy() is not NULL-safe */
> +    if (!tree->t) {
> +        return;
> +    }
> +
> +    g_tree_destroy(tree->t);
> +    tree->t = NULL;
> +}
> +
> +/* OurRange */
> +#define OUR_RANGE(ptr) ((OurRange *)(ptr))
> +
> +static void our_range_init(OurRange *our_range, uint64_t start, uint64_t count)
> +{
> +    our_range->range.start = start;
> +    our_range->range.count = count;
> +
> +    page_range_tree_init(&our_range->removed_guest);
> +    page_range_tree_init(&our_range->removed_both);
> +
> +    /* mark the whole range as unused but for potential use */
> +    our_range->added = 0;
> +    our_range->unusable_tail = 0;
> +}
> +
> +static void our_range_destroy(OurRange *our_range)
> +{
> +    page_range_tree_destroy(&our_range->removed_guest);
> +    page_range_tree_destroy(&our_range->removed_both);
> +}
> +
> +/* OurRangePlugged */
> +static OurRangePlugged *our_range_plugged_new(MemoryDeviceState *md,
> +                                              HostMemoryBackend *hostmem,
> +                                              uint64_t align,
> +                                              Error **errp)
> +{
> +    ERRP_GUARD();
> +    OurRangePlugged *our_range;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
> +    uint64_t addr, count;
> +
> +    if (!align) {
> +        align = HV_BALLOON_PAGE_SIZE;
> +    }
> +
> +    if (host_memory_backend_is_mapped(hostmem)) {
> +        error_setg(errp, "memory backend already mapped");
> +        return NULL;
> +    }
> +
> +    count = memory_device_get_region_size(md, &error_abort) / HV_BALLOON_PAGE_SIZE;
> +    if (!count) {
> +        error_setg(errp, "memory backend too small to be usable");
> +        return NULL;
> +    }
> +
> +    memory_device_pre_plug(md, ms, &align, errp);
> +    if (*errp) {
> +        return NULL;
> +    }
> +

This usage is still problematic I suspect (well, and a layer violation 
regarding the machine). The machine hotplug handler is supposed to call 
the pre_plug/plug/unplug hooks as response to pre_plug/plug/unplug 
notifications from the core. See how we handle 
virtio-mem/virtio-pmem/nvdimms as an example.

We assume that when memory_device_pre_plug() gets called, that the 
device is not realized yet, but once it gets plugged, that it already is 
realized, and that the device will actually vanish (get unrealized) when 
unplugging the device. Otherwise memory device logic like in 
get_plugged_memory_size() stops working.

As an example, see device_set_realized() on the pre_plug+realize+plug 
interaction.

IIRC, you're reusing the already-realized hv-balloon device here, correct?

Why can't you call the pre_plug/plug/unplug functions from the machine 
pre_plug/plug/unplug hooks -- exactly once for the memory device when 
plugging the hv-balloon device?

Is it to support the !memdev case or why is this this 
plugging/unplugging in our_range_plugged_new()/our_range_plugged_free() 
required?


Supporting the !memdev case is interesting: you essentially want to plug 
a memory device without a device region (or with an empty stub). I guess 
we should get that figured out somehow.


-- 
Cheers,

David / dhildenb


