Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB270DD25
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Rg6-0003HN-HO; Tue, 23 May 2023 09:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1Rg3-0003Gr-18
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1Rg1-0000CH-1e
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684847022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaSVe/ubveQ5cCN/BW/OiX+WXZA/Pko+U1uyj19xY+A=;
 b=Iemp9glofkT7hKHmYuL76PyErKA8UUxl99qTCHQGNqKjIRwWu/2qclrxmmrSktC3DpnqKR
 SLhCVYKlLHBQQ02wYfp/X1SsyueG7FETcuEka6UkB7GjvrfpAJhwpzltK7rVEOXLcFPLq3
 2qMohu3NR58LcN7zQ5lWObYEbmW83nU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-TwoyCvP8PZubBErDk_T_zw-1; Tue, 23 May 2023 09:02:32 -0400
X-MC-Unique: TwoyCvP8PZubBErDk_T_zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47FD71C06ECB;
 Tue, 23 May 2023 13:02:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BAB59D73;
 Tue, 23 May 2023 13:02:29 +0000 (UTC)
Date: Tue, 23 May 2023 14:02:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 jacek.halon@gmail.com
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Message-ID: <ZGy5YogBNyCyam0L@redhat.com>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <ZGx2bzKuwO6e4E2L@redhat.com>
 <CAA8xKjVkD=K3Xnn4DyE3jVMjX_szqfb5mtkbb0odgN_5jQa93Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8xKjVkD=K3Xnn4DyE3jVMjX_szqfb5mtkbb0odgN_5jQa93Q@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 23, 2023 at 02:50:09PM +0200, Mauro Matteo Cascella wrote:
> On Tue, May 23, 2023 at 10:16 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, May 08, 2023 at 04:18:13PM +0200, Mauro Matteo Cascella wrote:
> > > The cursor_alloc function still accepts a signed integer for both the cursor
> > > width and height. A specially crafted negative width/height could make datasize
> > > wrap around and cause the next allocation to be 0, potentially leading to a
> > > heap buffer overflow. Modify QEMUCursor struct and cursor_alloc prototype to
> > > accept unsigned ints.
> > >
> > I concur with Marc-Andre that there is no code path that can
> > actually trigger an overflow:
> >
> >
> >   hw/display/ati.c:        s->cursor = cursor_alloc(64, 64);
> >   hw/display/vhost-user-gpu.c:            s->current_cursor = cursor_alloc(64, 64);
> >   hw/display/virtio-gpu.c:            s->current_cursor = cursor_alloc(64, 64);
> >
> > Not exploitable as fixed size
> >
> >   hw/display/qxl-render.c:    c = cursor_alloc(cursor->header.width, cursor->header.height);
> >
> > Cursor header defined as:
> >
> >   typedef struct SPICE_ATTR_PACKED QXLCursorHeader {
> >       uint64_t unique;
> >       uint16_t type;
> >       uint16_t width;
> >       uint16_t height;
> >       uint16_t hot_spot_x;
> >       uint16_t hot_spot_y;
> >   } QXLCursorHeader;
> >
> > So no negative values can be passed to cursor_alloc()

> >
> > > Fixes: CVE-2023-1601
> > > Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc (CVE-2021-4206)")
> >
> > Given there is no possible codepath that can overflow, CVE-2023-1601
> > looks invalid to me. It should be clsoed as not-a-bug and these two
> > Fixes lines removed.
> 
> I think you can tweak the original PoC [1] to trigger this bug.
> Setting width/height to 0x80000000 (versus 0x8000) should do the
> trick. You should be able to overflow datasize while bypassing the
> sanity check (width > 512 || height > 512) as width/height are signed
> prior to this patch. I haven't tested it, though.

The QXLCursorHeader  width/height fields are uint16_t, so 0x80000000
will get truncated. No matter what value the guest sets, when we
interpret this in qxl_cursor when calling cursor_alloc, the value
will be in the range 0-65535, as that's the bounds of uint16_t.

We'll pass this unsigned value to cursor_alloc() which converts from
uint16_t, to (signed) int. 'int' is larger than uint16_t, so the
result will still be positive in the range 0-65535, and so the sanity
check > 512 will fire and protect us.

I still see no bug, let alone a CVE.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


