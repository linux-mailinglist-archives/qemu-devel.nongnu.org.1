Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD507DE548
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyEvI-0004DV-Ma; Wed, 01 Nov 2023 13:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyEvF-0004B8-6O
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qyEvC-00014L-Ro
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698859345;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZArrblthc2H73QniWmHZeD/EftDFxgAHlAXYueVYkZk=;
 b=IiolpWbM2VbUCi7tQEFRtprWDSS1/x8quyCS6MxI8H6x5pHZnGzjtt/HJJEYlVLWtvIsNY
 +/i30AW7PllKARFOseGdNmTh4sie2ANuVHuKq5MUmZwvP2JFv2LQoBWksL2oW+Ru7vbCg1
 1oApOivIjn8zNrFINnVpNKrDka59Cgw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-yTVFoxysMlKgcNvUsngfzg-1; Wed,
 01 Nov 2023 13:22:18 -0400
X-MC-Unique: yTVFoxysMlKgcNvUsngfzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A88E1C18CCA;
 Wed,  1 Nov 2023 17:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 280B410F5B;
 Wed,  1 Nov 2023 17:22:17 +0000 (UTC)
Date: Wed, 1 Nov 2023 17:22:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Mike Maslenkin <mike.maslenkin@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com, den@openvz.org
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Message-ID: <ZUKJR1oMhrcF3V35@redhat.com>
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
 <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
 <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
 <5f3a8585-18ed-4e05-ac6b-ac21178dfe79@redhat.com>
 <ZUKB9YwvUcNLp7B3@redhat.com>
 <a222db3e-727d-4bd1-b842-7badd009f843@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a222db3e-727d-4bd1-b842-7badd009f843@virtuozzo.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 01, 2023 at 06:03:36PM +0100, Denis V. Lunev wrote:
> On 11/1/23 17:51, Daniel P. Berrangé wrote:
> > On Tue, Oct 31, 2023 at 03:33:52PM +0100, Hanna Czenczek wrote:
> > > On 01.10.23 22:46, Denis V. Lunev wrote:
> > > > Can you please not top-post. This makes the discussion complex. This
> > > > approach is followed in this mailing list and in other similar lists
> > > > like LKML.
> > > > 
> > > > On 10/1/23 19:08, Mike Maslenkin wrote:
> > > > > I thought about "conv=notrunc", but my main concern is changed virtual
> > > > > disk metadata.
> > > > > It depends on how qemu-img used.
> > > > > May be I followed to wrong pattern, but pros and cons of adding "conv"
> > > > > parameter was not in my mind in scope of the first patch version.
> > > > > I see 4 obvious ways of using `qemu-img dd`:
> > > > > 1. Copy virtual disk data between images of same format. I think disk
> > > > > geometry must be preserved in this case.
> > > > > 2. Copy virtual disk data between different formats. It is a valid
> > > > > pattern? May be `qemu-img convert` should to be used instead?
> > > > > 3. Merge snapshots to specified disk image, i.e read current state and
> > > > > write it to new disk image.
> > > > > 4. Copy virtual disk data to raw binary file. Actually this patch
> > > > > breaks 'dd' behavior for this case when source image is less (in terms
> > > > > of logical blocks) than existed raw binary file.
> > > > >       May be for this case condition can be improved to smth like
> > > > >      if (strcmp(fmt, "raw") || !g_file_test(out.filename,
> > > > > G_FILE_TEST_EXISTS)) . And parameter "conv=notrunc" may be implemented
> > > > > additionally for this case.
> > > > My personal opinion is that qemu dd when you will need to
> > > > extract the SOME data from the original image and process
> > > > it further. Thus I use it to copy some data into raw binary
> > > > file. My next goal here would add ability to put data into
> > > > stdout that would be beneficial for. Though this is out of the
> > > > equation at the moment.
> > > > 
> > > > Though, speaking about the approach, I would say that the
> > > > patch changes current behavior which is not totally buggy
> > > > under a matter of this or that taste. It should be noted that
> > > > we are here in Linux world, not in the Mac world where we
> > > > were in position to avoid options and selections.
> > > > 
> > > > Thus my opinion that original behavior is to be preserved
> > > > as somebody is relying on it. The option you are proposing
> > > > seems valuable to me also and thus the switch is to be added.
> > > > The switch is well-defined in the original 'dd' world thus
> > > > either conv= option would be good, either nocreat or notrunc.
> > > > For me 'nocreat' seems more natural.
> > > > 
> > > > Anyway, the last word here belongs to either Hanna or Kevin ;)
> > > Personally, and honestly, I see no actual use for qemu-img dd at all,
> > > because we’re trying to mimic a subset of an interface of a rather complex
> > > program that has been designed to do what it does. We can only fail at
> > > that.  Personally, whenever I need dd functionality, I use
> > > qemu-storage-daemon’s fuse export, and then use the actual dd program on
> > > top.  Alternatively, qemu-img convert is our native interface;
> > > unfortunately, its feature set is lacking when compared to qemu-img dd, but
> > > I think it would be better to improve that rather than working on qemu-img
> > > dd.
> > Is there a clear view of what gaps exist in 'qemu-img convert', and more
> > importantly, how much work is it to close the gaps, such that 'dd' could
> > potentially be deprecated & eventually removed ?
> > 
> I am using 'qemu-img dd' as a way to get (some) content
> from the image. I have dreamed about getting it to
> stdout.

FWIW, you can use qemu-img convert to extract a subset of data from an
image by layering in the 'raw' format.

  qemu-img convert --image-opts \
      driver=raw,offset=1024,size=512,file.driver=file,file.filename=demo.img data.bin

somewhat annoyingly it forces 'size' to be a multiple of 512. That makes
sense if you're using the output as backing for a VM disk, but for simply
extracting data, conceptually it shouldn't be needed.

Yes, the syntax gets hairy with image opts :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


