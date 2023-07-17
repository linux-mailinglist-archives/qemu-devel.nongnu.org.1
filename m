Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADE75600C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLL5R-0005ne-7b; Mon, 17 Jul 2023 06:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLL5O-0005nS-3q
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLL5M-0002SE-DT
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689588247;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UC5+SgrNwYmWl996CWbgbpRTAGX5wjtmTPsB5m9Ow8E=;
 b=QzdD9y5G2odMADii/UsgGLs9+9xGuWmaC4/3fTFnLz7ql1A+7vjFmlakKu8r0vB9ZYjKgV
 eIyapFXmWBsXSKFZEdrspAEUC/wHP93LDwzXZqTvzGjuMbAB9nHGGQJjNVeFRu3eDpKrpi
 /Sp8PSBdGVKYttYB38IsD0y1GJEoUfQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-rAtzfuWAPEWtP6H62t0xDw-1; Mon, 17 Jul 2023 06:04:05 -0400
X-MC-Unique: rAtzfuWAPEWtP6H62t0xDw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BD01C2BD68;
 Mon, 17 Jul 2023 10:04:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFF29492B02;
 Mon, 17 Jul 2023 10:04:03 +0000 (UTC)
Date: Mon, 17 Jul 2023 11:04:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shiyuan Gao <gaoshiyuan@baidu.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] vnc,ps2: fix the PS/2 mouse work badly when connect VNC
Message-ID: <ZLUSEb4w0ZtzwB1H@redhat.com>
References: <20230717025936.71456-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230717025936.71456-1-gaoshiyuan@baidu.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Mon, Jul 17, 2023 at 10:59:36AM +0800, Shiyuan Gao wrote:
> When only use PS/2 mouse without usb-tablet, the mouse pointer of the
> guest on the VNC will work badly that the cursor of VNC is inconsistent
> with the mouse pointer of guest.
> 
> The reason is the PS/2 mouse use relative coordinates and we can't know
> the initial position of the guest mouse pointer.
> 
> So move the guest mouse pointer to (0, 0) of the screen when connect the
> VNC, and then move the mouse pointer to the cursor of VNC(absolute
> coordinates are also relative coordinates).

This is not a solution, because even if you know the starting position
of the pointer, the host/guest pointers can have different motion
acceleration behaviour, so they'll loose sync with each other. You'll
have problems such as the host pointer exiting the VNC window before
the guest pointer has got to the far edge.

Trying to make a relative pointer work correctly in combination with
absolute input events from VNC is never going to work.

This is why QEMU created a VNC extension to allows switching the VNC
protocol from absolute to relative pointer motion events.

If you need to run a VM with only the PS/2 pointer, then you need
to be using a client that supports this extension:

  https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#qemu-pointer-motion-change-pseudo-encoding


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


