Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00AB52ECA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 12:41:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwei3-0004nC-Gs; Thu, 11 Sep 2025 06:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwei0-0004mZ-05
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwehr-0002gr-PU
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757587144;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGsCdrfJ7Rm3QeHY7rN/TEiM82TbFL4gLglvuRgCTsE=;
 b=Oau4SoJrBEISlkFI09rEVBkz8uXjMfXVQpIwen9ALPSNcbH4vPeJGPlvLGg7VSTBWkAp01
 Nd6AeoKcvmdM0MpwPggg37njene94pUS8ghcK7sxNafFKvrGbG0J6hps4rW8vSWpUAi3uk
 upbDmByI2MndE7Xptv/wk2ZuEN0Q8lA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-8EjUKPnrO9m9ruEHD1JDuQ-1; Thu,
 11 Sep 2025 06:39:03 -0400
X-MC-Unique: 8EjUKPnrO9m9ruEHD1JDuQ-1
X-Mimecast-MFC-AGG-ID: 8EjUKPnrO9m9ruEHD1JDuQ_1757587142
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C2C9195608E; Thu, 11 Sep 2025 10:39:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 602C3300021A; Thu, 11 Sep 2025 10:38:59 +0000 (UTC)
Date: Thu, 11 Sep 2025 11:38:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, hreitz@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>, armbru@redhat.com
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMKmvQ1IyBzK93lD@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com> <aMHFrDEW8cbnXajG@redhat.com>
 <CAK9dgmYY-193Nom=DteAp2mDCNCMdA-fUMi8PH5iAoVVZ59cKQ@mail.gmail.com>
 <aMKeqBDvzEM0682l@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMKeqBDvzEM0682l@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 11, 2025 at 12:04:24PM +0200, Kevin Wolf wrote:
> Am 11.09.2025 um 04:33 hat Yong Huang geschrieben:
> > On Thu, Sep 11, 2025 at 2:38 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > 
> > > Am 10.09.2025 um 18:08 hat Kevin Wolf geschrieben:
> > > > Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
> > > > > luks-detached-header   fail       [17:15:26] [17:15:38]   12.2s
> > >         failed, exit status 1
> > > > > ---
> > > /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header.out
> > > > > +++
> > > /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/luks-detached-header.out.bad
> > > > > @@ -1,5 +1,55 @@
> > > > > -..
> > > > > +EE
> > > > > +======================================================================
> > > > > +ERROR: test_detached_luks_header
> > > (__main__.TestDetachedLUKSHeader.test_detached_luks_header)
> > > > > +----------------------------------------------------------------------
> > > > > +Traceback (most recent call last):
> > > > > +  File
> > > "/home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header",
> > > line 139, in setUp
> > > > > +    res = qemu_img_create(
> > > > > +          ^^^^^^^^^^^^^^^^
> > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > 278, in qemu_img_create
> > > > > +    return qemu_img('create', *args)
> > > > > +           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > 261, in qemu_img
> > > > > +    return qemu_tool(*full_args, check=check,
> > > combine_stdio=combine_stdio)
> > > > > +
> > >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > 241, in qemu_tool
> > > > > +    raise VerboseProcessError(
> > > > > +qemu.utils.VerboseProcessError: Command
> > > '('/home/thuth/tmp/qemu-build/qemu-img', 'create', '-f', 'luks', '-o',
> > > 'iter-time=10', '-o', 'key-secret=sec0', '-o', 'detached-header=true',
> > > '--object', 'secret,id=sec0,data=foo',
> > > '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/detached_header.img2')'
> > > returned non-zero exit status 1.
> > > > > +  ┏━ output
> > > ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > > > +  ┃ Formatting
> > > '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/l
> > > > > +  ┃ uks-file-luks-detached-header/detached_header.img2', fmt=luks
> > > > > +  ┃ size=-1 key-secret=sec0 iter-time=10 detached-header=true
> > > > > +  ┃ qemu-img:
> > > /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luk
> > > > > +  ┃ s-file-luks-detached-header/detached_header.img2: Parameter
> > > > > +  ┃ 'detached-header' is unexpected
> > > > > +
> > > ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > >
> > > > This one is surprising. I don't think anything relevant in the luks
> > > > driver has changed since the test was introduced. At the same time, the
> > > > code clearly has a problem when it tries to convert a QemuOpts
> > > > containing a "detached-header" option into a QAPI object when the schema
> > > > doesn't even have this option. Was this broken from the beginning? Would
> > > > have been for a year and half.
> > >
> > > I bisected this one because I was curious how this could happen, and it
> > > was broken quite explicitly by commit e818c01a:
> > >
> > > commit e818c01ae6e7c54c7019baaf307be59d99ce80b9 (HEAD)
> > > Author: Daniel P. Berrangé <berrange@redhat.com>
> > > Date:   Mon Feb 19 15:12:59 2024 +0000
> > >
> > >     qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header
> > >
> > >     The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
> > >     was left over from earlier patch iterations.
> > >
> > >     Acked-by: Markus Armbruster <armbru@redhat.com>
> > >     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > >
> > > The test case demonstrates that it actually wasn't unused.
> > >
> > > If we don't want to reintroduce the field in QAPI, we need to explicitly
> > >
> > 
> > Keeping the detached-header option is more convenient for users when
> > creating a detached-header image.
> > 
> > My inclination is to bring this optionback.  Any suggestions? cc @Daniel P.
> > Berrangé <berrange@redhat.com>
> 
> Having it available for users in qemu-img is different from having it in
> QAPI. Arguably there is no use for it in QAPI, as long as you make sure
> that it's taken out of the QemuOpts before going to QAPI.

Ah so what we actually need to fix is

diff --git a/block/crypto.c b/block/crypto.c
index 4eed3ffa6a..8b60510c61 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -792,7 +792,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     char *buf = NULL;
     int64_t size;
     bool detached_hdr =
-        qemu_opt_get_bool(opts, "detached-header", false);
+        qemu_opt_get_bool_del(opts, "detached-header", false);
     unsigned int cflags = 0;
     int ret;
     Error *local_err = NULL;


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


