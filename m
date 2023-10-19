Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE07CF887
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRwi-0003bi-4m; Thu, 19 Oct 2023 08:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtRwX-0003Wt-7N
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:16:02 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtRwV-0008TY-CQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:16:00 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso383467fac.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697717757; x=1698322557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GT7PX3u/u07Xpwj34/mqgt1W5Ac4zq+LdeTQ6ZORZnY=;
 b=FjAZKVkGlc/z4g77WaInHgukehWn/xVceQzCfpYu7HzSff2zAQdKjCQ1gjakr613DB
 d746yEtfg5o4Z9WM8/yK3JW12QstbQ/dl7jIkni+O5SKK3Cr/0Odq7AXhMKGs4WK6owL
 R4HBglLwArAFHtnrRA4KpMiLb3wmWmXCL/xDI9nh2MNpDBj1qbPxlgjCro2bibNdk8Mh
 XpVrbOzVSnGWK7zvojX4GKJeIcNMaF56IAyotkNUi2g8+2xW1ZO/88Yitkn4j+LRp6QL
 dJ9xm/+rP+iKH8lpmB6DBB08c2J9CvVZchy5J/vsCnojcaX+cdExBYeEXOrZsya9NX+F
 Hdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717757; x=1698322557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GT7PX3u/u07Xpwj34/mqgt1W5Ac4zq+LdeTQ6ZORZnY=;
 b=CqS7JvW6RB9rOLIeRXU5aBtTxZ1BjpDTEUGssd+cSpKZrpZEN4jVPTqGexHGe5BT7b
 Cn/fpcTvb32/lOlca/GAHpEi6rsJAQA2QgEH87RItY0gNR1pwEZ2huNSUXpaOv4cchX/
 5p+Gdqr38l02ebL3dnJ+zfOGhoP6qIjHJfdiIALDHveMIwlefxeR0oSJ8uWuZtI0JrQX
 NsWwnVbJECGIJv053+clx0c9KuIecFPV9ISg7+48h9c7qlsPHG+D5hLRAeBM05Zj9HGL
 7XkSTKlC8Nu8j3wfEUV+lBRTz5HYAA76WcyVTGRs2oB+dl0+KnyGNnq7zg+2r1lp4iMr
 43TQ==
X-Gm-Message-State: AOJu0YxTu953C9pEiTQEA07ZCDvvs9ejOjVJciXM5T+OD3rQ8SmFQFzS
 oFnwnK6cRnrDGMhlIqS5XlmZ+8J3TXJ//AVkPyI=
X-Google-Smtp-Source: AGHT+IEku7zifYgH1VQvzO3RDMVaVVg1r+Pvdti7RWjkwu0oPsADxz9WcA8sUfdEld5llU7LxIOZEB1aLYOWc8I9fSw=
X-Received: by 2002:a05:6870:b424:b0:1e9:e280:6c37 with SMTP id
 x36-20020a056870b42400b001e9e2806c37mr797350oap.6.1697717757493; Thu, 19 Oct
 2023 05:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <202310191528414853267@zte.com.cn>
In-Reply-To: <202310191528414853267@zte.com.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 05:15:45 -0700
Message-ID: <CAJSP0QXFHat0wgpC-y-ZZbqWNhoN1V03PE7+hnLhbny6NwN3Lg@mail.gmail.com>
Subject: Re: Re: [PATCH] virtio-blk: don't start dataplane during the stop of
 dataplane
To: lv.mengzhao@zte.com.cn
Cc: stefanha@redhat.com, mst@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-devel@nongnu.org, hu.jian@zte.com.cn, cv11411@126.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 19 Oct 2023 at 00:31, <lv.mengzhao@zte.com.cn> wrote:
>
> On Tue, Oct 17, 2023 at 10:04PM +0800, stefanha@redhat.com wrote:
>
> > > From: hujian <hu.jian@zte.com.cn>
>
> > >
>
> > > During the stop of dataplane for virtio-blk, virtio_bus_cleanup_host_notifier() is be
>
> > > called to clean up notifier at the end, if polled ioeventfd, virtio_blk_handle_output()
>
> > > is used to handle io request. But due to s->dataplane_disabled is false, it will be
>
> > > returned directly, which drops io request.
>
> > > Backtrace:
>
> > > ->virtio_blk_data_plane_stop
>
> > >   ->virtio_bus_cleanup_host_notifier
>
> > >     ->virtio_queue_host_notifier_read
>
> > >       ->virtio_queue_notify_vq
>
> > >         ->vq->handle_output
>
> > >           ->virtio_blk_handle_output
>
> > >             ->if (s->dataplane  && !s->dataplane_stoped)
>
> > >               ->if (!s->dataplane_disabled)
>
> > >                 ->return *
>
> > >             ->virtio_blk_handle_output_do
>
> > > The above problem can occur when using "virsh reset" cmdline to reset guest, while
>
> > > guest does io.
>
> > > To fix this problem, don't try to start dataplane if s->stopping is true, and io would
>
> > > be handled by virtio_blk_handle_vq().
>
> > >
>
> > > Signed-off-by: hujian <hu.jian@zte.com.cn>
>
> > > ---
>
> > >  hw/block/virtio-blk.c | 2 +-
>
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> >
>
> > I have dropped this patch again after Fiona pointed out it does not
>
> > compile and Kevin noticed that handling requests from the main loop
>
> > thread while the I/O is still being processed in the IOThread is going
>
> > to cause thread-safety issues.
>
> >
>
> > Can you explain the problem you are seeing in more detail? You run
>
> > "virsh reset" while the guest is doing I/O. Then what happens?
>
> >
>
> > Stefan
>
>
> 1 Compilation issues
>
> I'm sorry to be in such a hurry to submit the patch that I forgot to compile it locally.
>
> Compilable patches are at the bottom.
>
>
> 2 Troubleshooting

I won't be able to reply until November 2nd. Maybe Kevin or Hanna can
discuss this with you in the meantime.

Stefan

> We have done a lifecycle test for the VM (QEMU version: 4.1.0, Host kernel version: 4.18),
>
> which is loop execution: virsh create -> virsh suspend -> virsh resume -> virsh reset ->
>
> virsh shutdown, and io stress test inside the virtual machine. After the loop is executed
>
> about 200 times, after "virsh reset" is executed, the virtual machine goes into emergency
>
> mode and fails to start normally. Theoretically, "virsh reset" may causes data loss of
>
> virtual machine, but not enough to put it into emergency mode.
>
>
> Coincidentally, I happen to be fixing another different fault with the same phenomenon,
>
> which is caused by a our private patch, this patch calls virtio_blk_data_plane_ [stop|start]
>
> to operate the dataplane, if QEMU is processing io requests at same time, it may cause the
>
> loss of io requests.
>
>
> Analyzing virtio_blk_data_plane_stop(), virtio_bus_cleanup_host_notifier() is used to
>
> clean up notifiers, and my understanding is that it would handle the remaining IO requests.
>
> The stack is as follows, I add the print at the star line and find that virtio_blk_handle_output()
>
> returned directly instead of continuing to call virtio_blk_handle_vq() to handle io. So I modify
>
> the code here to make it don't return during the stop of dataplane, and our internal private patch
>
> works normally.
>
>
> Backtrace:
>
> ->virtio_blk_data_plane_stop
>
>   ->virtio_bus_cleanup_host_notifier
>
>     ->virtio_queue_host_notifier_read
>
>       ->virtio_queue_notify_vq
>
>         ->vq->handle_output
>
>           ->virtio_blk_handle_output
>
>             ->if (s->dataplane  && !s->dataplane_stoped)
>
>               ->if (!s->dataplane_disabled)
>
>                 ->return *
>
>             ->virtio_blk_handle_vq
>
>
> Back to the problem caused by the virsh reset, libvirt sends the "system_reset" QEMU
>
> monitor command to QEMU, and QEMU calls qmp_system_reset(), and eventually calls
>
> virtio_blk_data_plane_[stop|start] to reset devices. I suspect that io loss will
>
> also occur if QEMU still has io to process during the stop of dataplane.
>
>
> 3 Thread-safety issues
>
> virtio_blk_data_plane_stop() calls blk_set_aio_context() to switch bs back to the QEMU
>
> main loop after virtio_bus_cleanup_host_notifier(), so the remaining IO requests
>
> are still handling by iothread(if configured). I'm a little confused as to why there
>
> is thread-safety issues.
>
>
> Lastly, please CC to cv11411@126.com, this is my private email, so I can contact with
>
> you in my free time, Thanks.
>
>
> 4 Compilable patches
>
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>
> index 39e7f23..d3a719c 100644
>
> --- a/hw/block/virtio-blk.c
>
> +++ b/hw/block/virtio-blk.c
>
> @@ -1165,8 +1165,9 @@ void virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq)
>
>  static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>
>  {
>
>      VirtIOBlock *s = (VirtIOBlock *)vdev;
>
> +    VirtIOBlockDataPlane *dp = s->dataplane;
>
>
> -    if (s->dataplane && !s->dataplane_started) {
>
> +    if (s->dataplane && !s->dataplane_started && !dp->stopping) {
>
>          /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
>
>           * dataplane here instead of waiting for .set_status().
>
>           */
>
>
>
>
>

