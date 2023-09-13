Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A179EDA9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgS96-0005GU-M2; Wed, 13 Sep 2023 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgS94-0005Fp-5e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgS90-0001q8-JE
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694620264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG++PEevahkEyzRk76QIP+0VVxAR+cPzYVJayEPnBQs=;
 b=cMGgpTib0C2BCENFdyPMSqTLdumTB9cw+yWP+benWC7AwakwhPf1BwwV7vswRuUN5cj3rz
 Iz+VzmNyQo+y1RPK/EbGFK2y628I5ATkZlMkl8RRFTl+ePAJbOcV/ZNgxsS/vQEbQzA5cA
 oeTIX9CLwMNdNuF6e2NP61pXJHTNMUw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-SXbaLvUQPaav5LimuqH-zA-1; Wed, 13 Sep 2023 11:51:00 -0400
X-MC-Unique: SXbaLvUQPaav5LimuqH-zA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39F35856A50;
 Wed, 13 Sep 2023 15:51:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4632156721;
 Wed, 13 Sep 2023 15:50:59 +0000 (UTC)
Date: Wed, 13 Sep 2023 16:50:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 avocado-devel@redhat.com, Cleber Rosa <crosa@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: Did Avocado assets hashing system changed?
Message-ID: <ZQHaYesBeALpg75C@redhat.com>
References: <4169f3e6-96b8-81af-ef09-35629b34caa7@linaro.org>
 <ZQHTR9UIdViemD2k@redhat.com>
 <03ed6dda-d80a-c0eb-595b-ce6a87d4df91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03ed6dda-d80a-c0eb-595b-ce6a87d4df91@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 13, 2023 at 05:40:25PM +0200, Thomas Huth wrote:
> On 13/09/2023 17.20, Daniel P. Berrangé wrote:
> > On Wed, Sep 13, 2023 at 04:17:24PM +0200, Philippe Mathieu-Daudé wrote:
> > > Hi,
> > > 
> > > We are trying to figure out why old assets saved in our Avocado
> > > cache (which we populate in our various CI jobs) isn't used
> > > anymore.
> > > 
> > > Trying to reproduce locally, I see for example:
> > > 
> > > 2023-09-13 14:39:18,834 test             L0520 INFO | START
> > > 14-tests/avocado/machine_mips_malta.py:MaltaMachine.test_mipsel_malta_yamon
> > > 2023-09-13 14:39:18,834 test             L0205 DEBUG| DATA
> > > (filename=output.expected) => NOT FOUND (data sources: variant, test, file)
> > > 2023-09-13 14:39:18,861 asset            L0339 INFO | Asset not in cache,
> > > fetching it.
> > > 2023-09-13 14:39:18,862 download         L0067 INFO | Fetching
> > > http://www.imgtec.com/tools/mips-tools/downloads/yamon/yamon-bin-02.22.zip
> > > -> /home/philippe.mathieu-daude/avocado/data/cache/by_location/70c32932b7794b6b37a5040a8808ac943699b944/yamon-bin-02.22.zip.csi3gk2v
> > > 2023-09-13 14:39:18,940 asset            L0144 INFO | Temporary asset file
> > > unavailable due to failed download attempt.
> > > 2023-09-13 14:39:18,940 asset            L0378 ERROR| HTTPError: HTTP Error
> > > 403: Forbidden
> > > 
> > > I remember this test used to pass last year, so checking the file I
> > > can see:
> > > 
> > > $ find ~/avocado/data/ -name yamon-bin-02.22.zip\* -ls
> > >    1489611   6629 -rw-r--r--   1 philmd primary   6776580 Dec 30  2022 /home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip
> > >    1489613      1 -rw-r--r--   1 philmd primary        46 Dec 30  2022 /home/philmd/avocado/data/cache/by_location/c1961386ba52f06c6005b48cd32195a371152769/yamon-bin-02.22.zip-CHECKSUM
> > > 
> > > But the hash is different... Looking at QEMU git history we haven't
> > > changed the URL in tests/avocado/machine_mips_malta.py, so I wonder,
> > > did Avocado changed its asset hashing during the last year?
> > 
> > How can it have changed when we've been pinned to avocado 88.1 for
> > ages now, not consuming new versions ?
> 
> We've temporarily switched to version 101 some months ago, see commit
> ec5ffa0056389c3c.

Which was quickly reverted in eaf245becd9ece615a4831c0cf4d27b165d8675f,
but I guess perhaps the cache has some files from that window of the
upgrade.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


