Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB059EE9B8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 16:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkiM-0000tO-Ip; Thu, 12 Dec 2024 10:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLkiJ-0000sQ-Sp
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLkiG-00005w-38
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734015764;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mz8WrP9UPqYYbrSwBy4iaAMbCfnM2VrAwjpYHddZclE=;
 b=DlKmuKktXe2nUg/MPF4oQO3l2PA50K2oFr0gDzjxw5h9mci+IlYHkiYM+SMCG0627occwY
 UhqzoTcdqIH/haCQhvphri5PrqmsOdSQR7IFZpndJYyKa0NVyP8LtwleLbnM2Bq4/yKyn7
 y86y87/SJ12w+Gx0dKpk4H5i1LrbGSM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-AfhqnUEgMj6Utok1vtK1Fw-1; Thu,
 12 Dec 2024 10:02:39 -0500
X-MC-Unique: AfhqnUEgMj6Utok1vtK1Fw-1
X-Mimecast-MFC-AGG-ID: AfhqnUEgMj6Utok1vtK1Fw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F83E1955F42; Thu, 12 Dec 2024 15:02:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F8D195605A; Thu, 12 Dec 2024 15:02:36 +0000 (UTC)
Date: Thu, 12 Dec 2024 15:02:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH v2 30/31] tests/functional: skip tests if assets are not
 available
Message-ID: <Z1r7CeI7TuHQXvAI@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-31-berrange@redhat.com>
 <0185be25-32f7-436b-b8e6-2e55c1cd0e18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0185be25-32f7-436b-b8e6-2e55c1cd0e18@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 12, 2024 at 03:14:53PM +0100, Thomas Huth wrote:
> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> > If downloading of assets has been disabled, then skip running a
> > test if the assets it has registered are not already downloaded.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/qemu_test/asset.py    |  8 +++++++-
> >   tests/functional/qemu_test/testcase.py | 11 +++++++++++
> >   2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> > index c5d3e73c4b..39832b2587 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -65,6 +65,12 @@ def _check(self, cache_file):
> >       def valid(self):
> >           return self.cache_file.exists() and self._check(self.cache_file)
> > +    def fetchable(self):
> > +        return not os.environ.get("QEMU_TEST_NO_DOWNLOAD", False)
> > +
> > +    def available(self):
> > +        return self.valid() or self.fetchable()
> > +
> >       def _wait_for_other_download(self, tmp_cache_file):
> >           # Another thread already seems to download the asset, so wait until
> >           # it is done, while also checking the size to see whether it is stuck
> > @@ -103,7 +109,7 @@ def fetch(self):
> >                              self.cache_file, self.url)
> >               return str(self.cache_file)
> > -        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > +        if not self.fetchable():
> >               raise Exception("Asset cache is invalid and downloads disabled")
> >           self.log.info("Downloading %s to %s...", self.url, self.cache_file)
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > index 7bece8738a..6c67a9459c 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -184,6 +184,14 @@ def scratch_file(self, *args):
> >       def log_file(self, *args):
> >           return str(Path(self.outputdir, *args))
> > +    def assets_available(self):
> > +        for name, asset in vars(self.__class__).items():
> > +            if name.startswith("ASSET_") and type(asset) == Asset:
> > +                if not asset.available():
> > +                    self.log.debug(f"Asset {asset.url} not available")
> > +                    return False
> > +        return True
> > +
> >       def setUp(self, bin_prefix):
> >           self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
> >           self.arch = self.qemu_bin.split('-')[-1]
> > @@ -209,6 +217,9 @@ def setUp(self, bin_prefix):
> >           self.machinelog.setLevel(logging.DEBUG)
> >           self.machinelog.addHandler(self._log_fh)
> > +        if not self.assets_available():
> > +            self.skipTest('One or more assets is not available')
> 
> So if a test_*.py file consists of multiple subtests, this will now skip all
> of them if just the asset of one subtest is missing?

Yep, I kept it simple. Often multiple assets all come from the same
server (eg kernel + initrd), and the same assets are used across
multiple tests.

> Could we maybe handle this test skipping in the new archive_extract() and
> uncompress() functions instead, so that only the related subtests will be
> skipped? (We still might need another wrapper function in testcase for the
> spots that still call .fetch() on the assets directly, though)

I'm not sure its worth the effort to ensure we don't leave gaves in places
that need skipping.

We still intend that this skipping scenario is highly undesirable at all,
and want to try to ensure it never actually triggers. ie we want cache
working in GitLab CI, so that we almost never need to download anything.

Most likely place to see skips is for developers locally if they're
runing tests for the first time, or haven't done it for a long while.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


