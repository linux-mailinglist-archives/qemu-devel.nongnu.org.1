Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB674FFC4
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJTk3-0002aZ-ID; Wed, 12 Jul 2023 02:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qJTk0-0002a2-Pf
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:54:24 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qJTjx-0000J6-ME
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689144861; x=1720680861;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=46VBqph2BK7VydwH9YFsHZfv2JV3P88g7zPsZJf0tUw=;
 b=f729tNZ516hjfaWNoKd/UhQf/kI0iSz/ZKLnyhhIk0MEBna2iFhef2C9
 T8tyLevOq4qF/KaXtUH57GjaZCqEo+lzflHbYnpnNXbTd1WxAS4g+WeYW
 UrI8QZMOtXMg0ig56KCDy0XiTLi3bxBHD+KECdMon5xXsUxjyD1hpCswr
 PVCdwjBB0cGElmodcuEnh6EbRo6eRSiZqpiSN8gme2B8ebqdq0q/9lE0a
 T6WQekzk0/zlyTPLDwzYXRHUYWAlA6g0m4B5WHPg5WO4VMqCMen+Lk/iS
 INKkQrKRSEpoOpe2vx8jolpFPNJPKjdBUyYI1lrN4a3d9X1x/c7YftnbC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344418941"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
 d="scan'208,217";a="344418941"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2023 23:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791502308"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
 d="scan'208,217";a="791502308"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.93.29.0])
 ([10.93.29.0])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2023 23:54:08 -0700
Content-Type: multipart/alternative;
 boundary="------------coLaKL00wnpI8UAIcfsp6glz"
Message-ID: <a6e2fca0-11af-915f-20ec-31df80fa665d@intel.com>
Date: Wed, 12 Jul 2023 14:54:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
 <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
 <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
 <CACGkMEu6JQp-KHgoiz=3o=mNb1hkivGUb9WMHSATC_aLo58HnA@mail.gmail.com>
 <CAJaqyWdM2FR1kT6DWtVxcmc=_bNA9k9A-qZXb_kJFkcpHRW2Kg@mail.gmail.com>
 <CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com>
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=lingshan.zhu@intel.com; helo=mga12.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------coLaKL00wnpI8UAIcfsp6glz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/11/2023 3:34 PM, Jason Wang wrote:
>
>
> On Tue, Jul 11, 2023 at 3:25 PM Eugenio Perez Martin 
> <eperezma@redhat.com> wrote:
>
>     On Tue, Jul 11, 2023 at 9:05 AM Jason Wang <jasowang@redhat.com>
>     wrote:
>     >
>     > On Tue, Jul 11, 2023 at 12:09 PM Zhu, Lingshan
>     <lingshan.zhu@intel.com> wrote:
>     > >
>     > >
>     > >
>     > > On 7/11/2023 10:50 AM, Jason Wang wrote:
>     > > > On Mon, Jul 10, 2023 at 4:53 PM Zhu Lingshan
>     <lingshan.zhu@intel.com> wrote:
>     > > >> In the poweroff routine, no need to fetch last available index.
>     > > >>
>     > > > This is because there's no concept of shutdown in the vhost
>     layer, it
>     > > > only knows start and stop.
>     > > >
>     > > >> This commit also provides a better debug message in the vhost
>     > > >> caller vhost_virtqueue_stop,
>     > > > A separate patch is better.
>     > > OK
>     > > >
>     > > >> because if vhost does not fetch
>     > > >> the last avail idx successfully, maybe the device does not
>     > > >> suspend, vhost will sync last avail idx to vring used idx as a
>     > > >> work around, not a failure.
>     > > > This only happens if we return a negative value?
>     > > Yes
>     > > >
>     > > >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>     > > >> ---
>     > > >>   hw/virtio/vhost-vdpa.c | 10 ++++++++++
>     > > >>   hw/virtio/vhost.c      |  2 +-
>     > > >>   2 files changed, 11 insertions(+), 1 deletion(-)
>     > > >>
>     > > >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>     > > >> index 3c575a9a6e..10b445f64e 100644
>     > > >> --- a/hw/virtio/vhost-vdpa.c
>     > > >> +++ b/hw/virtio/vhost-vdpa.c
>     > > >> @@ -26,6 +26,7 @@
>     > > >>   #include "cpu.h"
>     > > >>   #include "trace.h"
>     > > >>   #include "qapi/error.h"
>     > > >> +#include "sysemu/runstate.h"
>     > > >>
>     > > >>   /*
>     > > >>    * Return one past the end of the end of section. Be
>     careful with uint64_t
>     > > >> @@ -1391,6 +1392,15 @@ static int
>     vhost_vdpa_get_vring_base(struct vhost_dev *dev,
>     > > >>       struct vhost_vdpa *v = dev->opaque;
>     > > >>       int ret;
>     > > >>
>     > > >> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
>     > > >> +        /*
>     > > >> +         * Some devices do not support this call properly,
>     > > >> +         * and we don't need to retrieve the indexes
>     > > >> +         * if it is shutting down
>     > > >> +         */
>     > > >> +        return 0;
>     > > > Checking runstate in the vhost code seems like a layer
>     violation.
>     > > >
>     > > > What happens without this patch?
>     > > vhost tries to fetch vring base,
>     > > vhost_vdpa needs suspend the device before retrieving
>     last_avail_idx.
>     > > However not all devices can support .suspend properly so this call
>     > > may fail.
>     >
>     > I think this is where I'm lost. If the device doesn't support
>     > suspending, any reason we only try to fix the case of shutdown?
>     >
>     > Btw, the fail is intended:
>     >
>     >     if (!v->suspended) {
>     >         /*
>     >          * Cannot trust in value returned by device, let vhost
>     recover used
>     >          * idx from guest.
>     >          */
>     >         return -1;
>     >     }
>     >
>
>     The fail is intended, but to recover the last used idx, either from
>     device or from the guest, is only useful in the case of migration.
>
>
> Note that we had userspace devices like VDUSE now, so it could be 
> useful in the case of a VDUSE daemon crash or reconnect.
This code blcok is for vhost_vdpa backend, and I think vduse is another 
code path.
Return a guest used idx may be a good idea but as Eugenio pointed out 
that may duplicate the code.
>
>
>     I think the main problem is the error message, actually. But I think
>     it has no use either to recover last_avail_idx or print a debug
>     message if we're not migrating. Another solution would be to recover
>     it from the guest at vhost_vdpa_get_vring_base, but I don't like the
>     duplication.
>
>     > And if we return to success here, will we go to set an uninitialized
>     > last avail idx?
>     >
>
>     It will be either the default value (is set to 0 at
>     __virtio_queue_reset) or the one received from a migration (at
>     virtio_load).
>
>
> 0 is even sub-optimal than the index used. Anyhow, VHOST_DEBUG should 
> not be enabled for production environments.
Returning 0 sounds like a queue reset, yes we can reset a queue if 
failed to suspend it, I am not sure whther
0 is better than guest used idx.

I think we are not able to disable VHOST_DEBUG because customers can 
build QEMU by their own.

Thanks
>
> Thanks
>
>
>     Thanks!
>
>     >     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>     >     if (r < 0) {
>     >     ...
>     >     }.else {
>     >         virtio_queue_set_last_avail_idx(vdev, idx, state.num);
>     >     }
>     >
>     > Thanks
>     >
>     > > Then vhost will print an error shows something failed.
>     > >
>     > > The error msg is confused, as stated in the commit log, restoring
>     > > last_avail_idx with guest used idx
>     > > is a workaround rather than a failure. And no needs to fetch
>     last_avail_idx
>     > > when power off.
>     > >
>     > > Thanks
>     > > >
>     > > > Thanks
>     > > >
>     > > >> +    }
>     > > >> +
>     > > >>       if (v->shadow_vqs_enabled) {
>     > > >>           ring->num =
>     virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
>     > > >>           return 0;
>     > > >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>     > > >> index 82394331bf..7dd90cff3a 100644
>     > > >> --- a/hw/virtio/vhost.c
>     > > >> +++ b/hw/virtio/vhost.c
>     > > >> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct
>     vhost_dev *dev,
>     > > >>
>     > > >>       r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>     > > >>       if (r < 0) {
>     > > >> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore
>     failed: %d", idx, r);
>     > > >> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the
>     guest used idx for vhost VQ %u", idx);
>     > > >>           /* Connection to the backend is broken, so let's
>     sync internal
>     > > >>            * last avail idx to the device used idx.
>     > > >>            */
>     > > >> --
>     > > >> 2.39.3
>     > > >>
>     > >
>     >
>

--------------coLaKL00wnpI8UAIcfsp6glz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace"><br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 7/11/2023
        3:34 PM, Jason Wang wrote:<br>
      </font></div>
    <blockquote type="cite"
cite="mid:CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><font face="monospace"><br>
          </font></div>
        <font face="monospace"><br>
        </font>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr"><font face="monospace">On
              Tue, Jul 11, 2023 at 3:25 PM Eugenio Perez Martin &lt;<a
                href="mailto:eperezma@redhat.com" moz-do-not-send="true"
                class="moz-txt-link-freetext">eperezma@redhat.com</a>&gt;
              wrote:<br>
            </font></div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"><font face="monospace">On
              Tue, Jul 11, 2023 at 9:05 AM Jason Wang &lt;<a
                href="mailto:jasowang@redhat.com" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">jasowang@redhat.com</a>&gt;
              wrote:<br>
              &gt;<br>
              &gt; On Tue, Jul 11, 2023 at 12:09 PM Zhu, Lingshan &lt;<a
                href="mailto:lingshan.zhu@intel.com" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">lingshan.zhu@intel.com</a>&gt;
              wrote:<br>
              &gt; &gt;<br>
              &gt; &gt;<br>
              &gt; &gt;<br>
              &gt; &gt; On 7/11/2023 10:50 AM, Jason Wang wrote:<br>
              &gt; &gt; &gt; On Mon, Jul 10, 2023 at 4:53 PM Zhu
              Lingshan &lt;<a href="mailto:lingshan.zhu@intel.com"
                target="_blank" moz-do-not-send="true"
                class="moz-txt-link-freetext">lingshan.zhu@intel.com</a>&gt;
              wrote:<br>
              &gt; &gt; &gt;&gt; In the poweroff routine, no need to
              fetch last available index.<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt; &gt; This is because there's no concept of
              shutdown in the vhost layer, it<br>
              &gt; &gt; &gt; only knows start and stop.<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt;&gt; This commit also provides a better
              debug message in the vhost<br>
              &gt; &gt; &gt;&gt; caller vhost_virtqueue_stop,<br>
              &gt; &gt; &gt; A separate patch is better.<br>
              &gt; &gt; OK<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt;&gt; because if vhost does not fetch<br>
              &gt; &gt; &gt;&gt; the last avail idx successfully, maybe
              the device does not<br>
              &gt; &gt; &gt;&gt; suspend, vhost will sync last avail idx
              to vring used idx as a<br>
              &gt; &gt; &gt;&gt; work around, not a failure.<br>
              &gt; &gt; &gt; This only happens if we return a negative
              value?<br>
              &gt; &gt; Yes<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt;&gt; Signed-off-by: Zhu Lingshan &lt;<a
                href="mailto:lingshan.zhu@intel.com" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">lingshan.zhu@intel.com</a>&gt;<br>
              &gt; &gt; &gt;&gt; ---<br>
              &gt; &gt; &gt;&gt;   hw/virtio/vhost-vdpa.c | 10
              ++++++++++<br>
              &gt; &gt; &gt;&gt;   hw/virtio/vhost.c      |  2 +-<br>
              &gt; &gt; &gt;&gt;   2 files changed, 11 insertions(+), 1
              deletion(-)<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt; &gt;&gt; diff --git a/hw/virtio/vhost-vdpa.c
              b/hw/virtio/vhost-vdpa.c<br>
              &gt; &gt; &gt;&gt; index 3c575a9a6e..10b445f64e 100644<br>
              &gt; &gt; &gt;&gt; --- a/hw/virtio/vhost-vdpa.c<br>
              &gt; &gt; &gt;&gt; +++ b/hw/virtio/vhost-vdpa.c<br>
              &gt; &gt; &gt;&gt; @@ -26,6 +26,7 @@<br>
              &gt; &gt; &gt;&gt;   #include "cpu.h"<br>
              &gt; &gt; &gt;&gt;   #include "trace.h"<br>
              &gt; &gt; &gt;&gt;   #include "qapi/error.h"<br>
              &gt; &gt; &gt;&gt; +#include "sysemu/runstate.h"<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt; &gt;&gt;   /*<br>
              &gt; &gt; &gt;&gt;    * Return one past the end of the end
              of section. Be careful with uint64_t<br>
              &gt; &gt; &gt;&gt; @@ -1391,6 +1392,15 @@ static int
              vhost_vdpa_get_vring_base(struct vhost_dev *dev,<br>
              &gt; &gt; &gt;&gt;       struct vhost_vdpa *v =
              dev-&gt;opaque;<br>
              &gt; &gt; &gt;&gt;       int ret;<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt; &gt;&gt; +    if
              (runstate_check(RUN_STATE_SHUTDOWN)) {<br>
              &gt; &gt; &gt;&gt; +        /*<br>
              &gt; &gt; &gt;&gt; +         * Some devices do not support
              this call properly,<br>
              &gt; &gt; &gt;&gt; +         * and we don't need to
              retrieve the indexes<br>
              &gt; &gt; &gt;&gt; +         * if it is shutting down<br>
              &gt; &gt; &gt;&gt; +         */<br>
              &gt; &gt; &gt;&gt; +        return 0;<br>
              &gt; &gt; &gt; Checking runstate in the vhost code seems
              like a layer violation.<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt; What happens without this patch?<br>
              &gt; &gt; vhost tries to fetch vring base,<br>
              &gt; &gt; vhost_vdpa needs suspend the device before
              retrieving last_avail_idx.<br>
              &gt; &gt; However not all devices can support .suspend
              properly so this call<br>
              &gt; &gt; may fail.<br>
              &gt;<br>
              &gt; I think this is where I'm lost. If the device doesn't
              support<br>
              &gt; suspending, any reason we only try to fix the case of
              shutdown?<br>
              &gt;<br>
              &gt; Btw, the fail is intended:<br>
              &gt;<br>
              &gt;     if (!v-&gt;suspended) {<br>
              &gt;         /*<br>
              &gt;          * Cannot trust in value returned by device,
              let vhost recover used<br>
              &gt;          * idx from guest.<br>
              &gt;          */<br>
              &gt;         return -1;<br>
              &gt;     }<br>
              &gt;<br>
            </font>
            <font face="monospace"><br>
              The fail is intended, but to recover the last used idx,
              either from<br>
              device or from the guest, is only useful in the case of
              migration.<br>
            </font></blockquote>
          <div><font face="monospace"><br>
            </font></div>
          <div><font face="monospace">Note that we had userspace devices
              like VDUSE now, so it could be useful in the case of a
              VDUSE daemon crash or reconnect.</font></div>
        </div>
      </div>
    </blockquote>
    <font face="monospace">This code blcok is for vhost_vdpa backend,
      and I think vduse is another code path.<br>
      Return a guest used idx may be a good idea but as Eugenio pointed
      out that may duplicate the code.<br>
    </font>
    <blockquote type="cite"
cite="mid:CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><font face="monospace"><br>
            </font></div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <font face="monospace"><br>
              I think the main problem is the error message, actually.
              But I think<br>
              it has no use either to recover last_avail_idx or print a
              debug<br>
              message if we're not migrating. Another solution would be
              to recover<br>
              it from the guest at vhost_vdpa_get_vring_base, but I
              don't like the<br>
              duplication.<br>
            </font>
            <font face="monospace"><br>
              &gt; And if we return to success here, will we go to set
              an uninitialized<br>
              &gt; last avail idx?<br>
              &gt;<br>
            </font>
            <font face="monospace"><br>
              It will be either the default value (is set to 0 at<br>
              __virtio_queue_reset) or the one received from a migration
              (at<br>
              virtio_load).<br>
            </font></blockquote>
          <div><font face="monospace"><br>
            </font></div>
          <div><font face="monospace">0 is even sub-optimal than the
              index used. Anyhow, VHOST_DEBUG should not be enabled for
              production environments.</font></div>
        </div>
      </div>
    </blockquote>
    <font face="monospace">Returning 0 sounds like a queue reset, yes we
      can reset a queue if failed to suspend it, I am not sure whther<br>
      0 is better than guest used idx.<br>
      <br>
      I think we are not able to disable VHOST_DEBUG because customers
      can build QEMU by their own.<br>
      <br>
      Thanks <br>
    </font>
    <blockquote type="cite"
cite="mid:CACGkMEsGL7kcx4g-ZVHYTE9cyw3+YWDxWFxYdsRTA9zUi6G_dQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><font face="monospace"><br>
            </font></div>
          <div><font face="monospace">Thanks</font></div>
          <div><font face="monospace"> </font></div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <font face="monospace"><br>
              Thanks!<br>
            </font>
            <font face="monospace"><br>
              &gt;     r =
              dev-&gt;vhost_ops-&gt;vhost_get_vring_base(dev,
              &amp;state);<br>
              &gt;     if (r &lt; 0) {<br>
              &gt;     ...<br>
              &gt;     }.else {<br>
              &gt;         virtio_queue_set_last_avail_idx(vdev, idx,
              state.num);<br>
              &gt;     }<br>
              &gt;<br>
              &gt; Thanks<br>
              &gt;<br>
              &gt; &gt; Then vhost will print an error shows something
              failed.<br>
              &gt; &gt;<br>
              &gt; &gt; The error msg is confused, as stated in the
              commit log, restoring<br>
              &gt; &gt; last_avail_idx with guest used idx<br>
              &gt; &gt; is a workaround rather than a failure. And no
              needs to fetch last_avail_idx<br>
              &gt; &gt; when power off.<br>
              &gt; &gt;<br>
              &gt; &gt; Thanks<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt; Thanks<br>
              &gt; &gt; &gt;<br>
              &gt; &gt; &gt;&gt; +    }<br>
              &gt; &gt; &gt;&gt; +<br>
              &gt; &gt; &gt;&gt;       if (v-&gt;shadow_vqs_enabled) {<br>
              &gt; &gt; &gt;&gt;           ring-&gt;num =
              virtio_queue_get_last_avail_idx(dev-&gt;vdev,
              ring-&gt;index);<br>
              &gt; &gt; &gt;&gt;           return 0;<br>
              &gt; &gt; &gt;&gt; diff --git a/hw/virtio/vhost.c
              b/hw/virtio/vhost.c<br>
              &gt; &gt; &gt;&gt; index 82394331bf..7dd90cff3a 100644<br>
              &gt; &gt; &gt;&gt; --- a/hw/virtio/vhost.c<br>
              &gt; &gt; &gt;&gt; +++ b/hw/virtio/vhost.c<br>
              &gt; &gt; &gt;&gt; @@ -1262,7 +1262,7 @@ void
              vhost_virtqueue_stop(struct vhost_dev *dev,<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt; &gt;&gt;       r =
              dev-&gt;vhost_ops-&gt;vhost_get_vring_base(dev,
              &amp;state);<br>
              &gt; &gt; &gt;&gt;       if (r &lt; 0) {<br>
              &gt; &gt; &gt;&gt; -        VHOST_OPS_DEBUG(r, "vhost VQ
              %u ring restore failed: %d", idx, r);<br>
              &gt; &gt; &gt;&gt; +        VHOST_OPS_DEBUG(r, "sync last
              avail idx to the guest used idx for vhost VQ %u", idx);<br>
              &gt; &gt; &gt;&gt;           /* Connection to the backend
              is broken, so let's sync internal<br>
              &gt; &gt; &gt;&gt;            * last avail idx to the
              device used idx.<br>
              &gt; &gt; &gt;&gt;            */<br>
              &gt; &gt; &gt;&gt; --<br>
              &gt; &gt; &gt;&gt; 2.39.3<br>
              &gt; &gt; &gt;&gt;<br>
              &gt; &gt;<br>
              &gt;<br>
            </font>
            <font face="monospace"><br>
            </font>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <font face="monospace"><br>
    </font>
  </body>
</html>

--------------coLaKL00wnpI8UAIcfsp6glz--

