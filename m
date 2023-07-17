Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0468475600D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:06:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLL6d-0006HG-Ry; Mon, 17 Jul 2023 06:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLL6V-0006Cp-V5
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLL6U-0002lO-7Y
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689588317;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFUQckVdAIH4Z6Y2aJowRhdpOqgIh4DiGLOydxhA/Eg=;
 b=fVmcXif7YAfxkNTgU/cpvioqubUzgHAMctH1WQ1qmePh3W7fbiQBKA3+OMCUqmAhRPqm9M
 lpZOC4D4MI0spRa1/10io33Omp7djho4whcRXtM8Bf6kH2JUuzAjoT6GsswGRQXOmMGrnw
 qMWx8DkVnpLCUBHGoP1P6w2miFKNXY4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-fa8HG2GcORekSlvFk_AvKw-1; Mon, 17 Jul 2023 06:05:15 -0400
X-MC-Unique: fa8HG2GcORekSlvFk_AvKw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C3E78D1685;
 Mon, 17 Jul 2023 10:05:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB454CD0F1;
 Mon, 17 Jul 2023 10:05:13 +0000 (UTC)
Date: Mon, 17 Jul 2023 11:05:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Gao,Shiyuan" <gaoshiyuan@baidu.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Message-ID: <ZLUSV0B1GqLl9Sr5@redhat.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
 <CAMxuvaz4NwRfCoWGVBofihBsZnBya7cv3Cq7w-Y6Wzd0mPoDQQ@mail.gmail.com>
 <EF20B207-4AAE-4A30-8D0B-CB208867756A@baidu.com>
 <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxssGvBLb-gFFEibDcQ+MJyorDJi-xSMTBVRCNyVyFVqA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 17, 2023 at 01:16:41PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 17, 2023 at 12:54 PM Gao,Shiyuan <gaoshiyuan@baidu.com> wrote:
> 
> > Hi,
> > > Hi Shiyuan
> > >
> > > On Mon, Jul 17, 2023 at 7:16 AM Shiyuan Gao <gaoshiyuan@baidu.com>
> > wrote:
> > >
> > > > When only use PS/2 mouse without usb-tablet, the mouse pointer of the
> > > > guest on the VNC will work badly that the cursor of VNC is inconsistent
> > > > with the mouse pointer of guest.
> > > >
> > > >
> > > Afaik, VNC doesn't support client-side drawing of guest mouse (there are
> > no
> > > message to set guest mouse position). So the guest mouse should be drawn
> > by
> > > the server, and currently QEMU doesn't do it.
> > >
> > >
> > > > The reason is the PS/2 mouse use relative coordinates and we can't know
> > > > the initial position of the guest mouse pointer.
> > > >
> > >
> > > It's not just about the initial position.
> >
> > Now pointer_event use the cursor of VNC init the vs->last_x, vs->last_y
> > when
> > connect the VNC and the relative coordinates is based on VNC cursor. If the
> > initial position of VNC cursor is inconsistent with guest mouse, the
> > inconsistency will keep. I think the root cause is we cann't know the
> > postion
> > of the guest mouse pointer.
> >
> 
> last_x/last_y is only used when the client doesn't support relative motion
> (pointer-motion change pseudo encoding): it doesn't have a direct relation
> with the guest pointer position, it's only use to compute the relative
> motion of the client pointer as a fallback.
> 
> 
> > >
> > > >
> > > >
> > > So move the guest mouse pointer to (0, 0) of the screen when connect the
> > > > VNC, and then move the mouse pointer to the cursor of VNC(absolute
> > > > coordinates are also relative coordinates).
> > > >
> > > >
> > > It's hardly a solution, you still have no clue what will be the guest
> > mouse
> > > position.
> >
> > We have no clue what will be the guest mouse position, we can move the
> > guest
> > mouse to (0,0) each connect the VNC. Now, the cursor of VNC will be the
> > relative coordinates. In a way, this is a quirk to know the guest mouse
> > position.
> >
> 
> There is no guarantee the guest pointer will be at (0,0) though, and that
> doesn't explain how that would help. Which client are you using? Are you
> drawing the guest cursor? This can't be done currently with the lack of a
> message to tell the guest mouse position. (moving / sync-ing the client
> cursor position would be even worse in many ways)
> 
> 
> > >
> > >
> > > > On windows VM, also need disable "Enhance Pointer Precision" Option in
> > > > "Pointer Options" (Control Panel -> Mouse).
> > > >
> > > >
> > > Apparently, this option doesn't have much to do with relative mouse
> > motion.
> > > Can you explain what it does with this change?
> >
> > Emmm, I don't know why this can solve the problem. It's quite effective and
> > get this way from
> >
> > https://forum.proxmox.com/threads/is-it-possible-not-to-use-usbdevice-tablet.1498/
> > .
> >
> > Only use this way, we need to manually align the VNC cursor with the guest
> > mouse.
> >
> 
> It's a bit vague what the "VNC cursor" mean. If you mean the client cursor
> position, there is no way to align / sync with the guest without an extra
> message to inform the client of its position. There is even a comment about
> that in vnc.c  /* can we ask the client(s) to move the pointer ??? */)
> 
> 
> 
> > >
> > > Which guest OS are you using? Hopefully they all support either
> > usb-tablet
> > > or vmmouse extension for absolute positioning. Otherwise, I'd suggest
> > using
> > > Spice, which has those messages for client side guest-mouse drawing.
> > >
> >
> > Yeah, I know the best way is use a absolute positioning. We need remove
> > all usb devices,
> > I can only use the PS/2 mouse.
> >
> 
> Can't you use vmmouse extension?

For modern Linux there is virtio-input too IIUC


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


