Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA497DD23C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:36:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxriZ-0005hv-52; Tue, 31 Oct 2023 12:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxriN-0005h3-In
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxriL-0005bW-1u
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698770136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4ZF1UTa9qdNfscev5lQn0lR4MtyWewhlRWny12iEco=;
 b=JCIEu78SZZJaflz+Gu7NOGHdEowpvuMPhuaW/5YOLQoKgy61fcHVC//Au2chz+HJYGz4SQ
 kc+58Dqi6Z5Vub1/JKhfDkNwUOuuiBS8s+5a5EOV0X6uhoZjGI8ZX9gWwux7XraBXakflj
 eQdAp/DkLbKpSdiAbbhHIRtEUfOsqDI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-paTs2_ZQPTeH95vxiHPInA-1; Tue, 31 Oct 2023 12:35:33 -0400
X-MC-Unique: paTs2_ZQPTeH95vxiHPInA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55515828AC1;
 Tue, 31 Oct 2023 16:35:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47B5C10F4C;
 Tue, 31 Oct 2023 16:35:30 +0000 (UTC)
Date: Tue, 31 Oct 2023 17:35:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/7] hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
Message-ID: <ZUEs0eoqmwUY6x6H@redhat.com>
References: <20231017140150.44995-1-philmd@linaro.org>
 <20231017140150.44995-5-philmd@linaro.org>
 <ZUD+hMTWf9DidzDb@redhat.com> <20231031134856.GL7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031134856.GL7636@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 31.10.2023 um 14:48 hat Richard W.M. Jones geschrieben:
> On Tue, Oct 31, 2023 at 02:17:56PM +0100, Kevin Wolf wrote:
> > Am 17.10.2023 um 16:01 hat Philippe Mathieu-Daudé geschrieben:
> > > Access QOM parent with the proper QOM VIRTIO_SCSI_COMMON() macro.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > ---
> > >  hw/scsi/virtio-scsi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > > index 45b95ea070..fa53f0902c 100644
> > > --- a/hw/scsi/virtio-scsi.c
> > > +++ b/hw/scsi/virtio-scsi.c
> > > @@ -761,7 +761,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
> > >  
> > >  static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
> > >  {
> > > -    VirtIOSCSICommon *vs = &s->parent_obj;
> > > +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
> > >      SCSIDevice *d;
> > >      int rc;
> > 
> > Why is a dynamic cast more "proper" than a static type-safe access, even
> > more so in a hot I/O path?
> > 
> > Rich Jones posted a flamegraph the other day that surprised me because
> > object_class_dynamic_class_assert() and object_dynamic_cast_assert()
> > were shown to be a big part of scsi_req_new(). In the overall
> > performance, it's probably dwarved by other issues, but unnecessary
> > little things can add up, too.
> 
> I think Kevin is referring to one of these flamegraphs:
> 
>   http://oirase.annexia.org/tmp/2023-kvm-build-on-device.svg
>   http://oirase.annexia.org/tmp/2023-kvm-build.svg
> 
> Here's a zoom showing scsi_req_new (hopefully this URL is stable ...):
> 
>   http://oirase.annexia.org/tmp/2023-kvm-build-on-device.svg?s=scsi_req_new&x=512.9&y=501
> 
> Note that qemu has been compiled with QOM cast debug.  This is the
> default for Fedora (not RHEL) because we'd like to get early detection
> of bugs from Fedora users.

Indeed, object_dynamic_cast_assert() probably wouldn't show up any more
if you disabled QOM cast debugging. But we enable it by default, so
that's an explicit setting users have to make, and as you say, at least
Fedora doesn't.

The other one, object_class_dynamic_cast_assert() isn't even affected
by the debug setting because it does more than just asserting a plain
cast. Working around it isn't as trivial either, but I did think about
caching it in the object to avoid a string based class lookup for every
single request.

Looking at it again, strangely CONFIG_QOM_CAST_DEBUG enables a cache in
object_class_dynamic_cast_assert() that isn't used otherwise. Why don't
we want this optimisation without the debug flag?

Kevin


