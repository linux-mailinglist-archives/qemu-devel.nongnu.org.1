Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60EA45969
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 10:06:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDLz-000628-DH; Wed, 26 Feb 2025 04:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnDLx-0005zo-SH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnDLv-0000aE-Pc
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740560713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icKARIbEzwePZd7nEEx6bH60DPGsTOAYlRfy38vVF/w=;
 b=IC5OMNV5XQUtutgN8MPUkR8n8O8TxLsMx37TKrN6wwrAsmwnvFX4+XUUZ4GH751B3VOwbi
 jwM9VbHd6cBwOQfPP9dvU6IweW3lvBFypIx5+Ms0phGob1NPSd0poP+LNvOVT69Lec87BK
 0ni9wGa/rjyQR0PMKurEvV80rpgEuFc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-IUCSOp4qOfOs7tH4L9aEMA-1; Wed,
 26 Feb 2025 04:05:06 -0500
X-MC-Unique: IUCSOp4qOfOs7tH4L9aEMA-1
X-Mimecast-MFC-AGG-ID: IUCSOp4qOfOs7tH4L9aEMA_1740560706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0752A193578F; Wed, 26 Feb 2025 09:05:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FAD0180035F; Wed, 26 Feb 2025 09:05:02 +0000 (UTC)
Date: Wed, 26 Feb 2025 09:04:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
Message-ID: <Z77ZLE8TAQvbfb5k@redhat.com>
References: <20250226065401.197915-1-clg@redhat.com>
 <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Feb 26, 2025 at 08:01:09AM +0100, Thomas Huth wrote:
> On 26/02/2025 07.54, Cédric Le Goater wrote:
> > The tests are using a now archived Fedora29 release. Switch to the
> > most recent Fedora41 release.
> > 
> > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > ---
> >   tests/functional/test_ppc64_powernv.py | 6 +++---
> >   tests/functional/test_ppc64_pseries.py | 6 +++---
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
> > index 685e2178ed78..a9da7905366e 100755
> > --- a/tests/functional/test_ppc64_powernv.py
> > +++ b/tests/functional/test_ppc64_powernv.py
> > @@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
> >       good_message = 'VFS: Cannot open root device'
> >       ASSET_KERNEL = Asset(
> > -        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
> > -         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
> > -        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
> > +        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
> > +         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
> > +        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
> 
> I think we should rather avoid the very latest and greatest Fedora URLs
> here... they will be invalid in a couple of months after Fedora 43 has been
> released. And if we keep switching the test assets all the time, this will
> make it more difficult to bisect regressions in the future.

Neither of the URLs here should change, as both are using the
archives.fedoraproject.org server which carries all historic
content.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


