Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AD8814C7
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 16:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmy2p-00053s-RQ; Wed, 20 Mar 2024 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmy2m-00051F-3h
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmy2g-0004m6-R4
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710949190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTPuXIM7vXAJSuvFkMvFlSwtbO1hHBilClKFa33WT+4=;
 b=DnGT7Jbs6kz8WPpLlXn+FQRmlz+HStfRXQah5RNAgCfLQ4O4QLieOaEYjulyh4Xa7lLDvV
 twixWvSWQ/lw2dNj5yiklc79Xl50gQPn3djpxD1Ro2JVexPR+zXiFhemiiFc/2wXyvwvDG
 +RW4rmsCt3c39VeX69jJyPM2/X0Dym0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-o_qvO40rP1iK8gDBbKUyLA-1; Wed, 20 Mar 2024 11:39:46 -0400
X-MC-Unique: o_qvO40rP1iK8gDBbKUyLA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2717800262;
 Wed, 20 Mar 2024 15:39:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC28D2022C1D;
 Wed, 20 Mar 2024 15:39:43 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:39:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 7/7] tests/migration-test: add qpl compression test
Message-ID: <ZfsDOabHdAqPBKvL@redhat.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-8-yuan1.liu@intel.com>
 <Zfq-Yu-aLa1OJL25@redhat.com>
 <PH7PR11MB5941FDC1E4B9723CBBAEC2B4A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941FDC1E4B9723CBBAEC2B4A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 03:30:40PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: Wednesday, March 20, 2024 6:46 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: peterx@redhat.com; farosas@suse.de; qemu-devel@nongnu.org;
> > hao.xiang@bytedance.com; bryan.zhang@bytedance.com; Zou, Nanhai
> > <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v5 7/7] tests/migration-test: add qpl compression test
> > 
> > On Wed, Mar 20, 2024 at 12:45:27AM +0800, Yuan Liu wrote:
> > > add qpl to compression method test for multifd migration
> > >
> > > the migration with qpl compression needs to access IAA hardware
> > > resource, please run "check-qtest" with sudo or root permission,
> > > otherwise migration test will fail
> > 
> > That's not an acceptable requirement.
> > 
> > If someone builds QEMU with QPL, the migration test *must*
> > pass 100% reliably when either running on a host without
> > the QPL required hardware, or when lacking permissions.
> > 
> > The test case needs to detect these scenarios and automatically
> > skip the test if it is incapable of running successfully.
> > This raises another question though. If QPL migration requires
> > running as root, then it is effectively unusable for QEMU, as
> > no sane deployment ever runs QEMU as root.
> > 
> > Is there a way to make QPL work for non-root users ?
> 
> There are two issues here
> 1. I need to add an IAA resource detection before the QPL test begins
>    In this way, when QPL resources are unavailable, the live migration 
>    test will not be affected.
> 
> 2. I need to add some additional information about IAA configuration in 
>    the devel/qpl-compression.rst documentation. In addition to configuring 
>    IAA resources, the system administrator also needs to assign IAA resources
>    to user groups.
>    For example, the system administrator runs "chown -R user /dev/iax", then
>    all IAA resources can be accessed by "user", this method does not require 
>    sudo or root permissions

Ok, so in the test suite you likely should do something
approximately like

#ifdef CONFIG_QPL
  if (access("/dev/iax", R_OK|W_OK) == 0) {
    migration_test_add("/migration/multifd/tcp/plain/qpl",
                       test_multifd_tcp_qpl);
  }
#endif

possibly more if you need to actually query supported features
of /dev/iax before trying to use it

> 
> > > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > > ---
> > >  tests/qtest/migration-test.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > > index 71895abb7f..052d0d60fd 100644
> > > --- a/tests/qtest/migration-test.c
> > > +++ b/tests/qtest/migration-test.c
> > > @@ -2815,6 +2815,15 @@
> > test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
> > >  }
> > >  #endif /* CONFIG_ZSTD */
> > >
> > > +#ifdef CONFIG_QPL
> > > +static void *
> > > +test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
> > > +                                            QTestState *to)
> > > +{
> > > +    return test_migrate_precopy_tcp_multifd_start_common(from, to,
> > "qpl");
> > > +}
> > > +#endif /* CONFIG_QPL */
> > > +
> > >  static void test_multifd_tcp_none(void)
> > >  {
> > >      MigrateCommon args = {
> > > @@ -2880,6 +2889,17 @@ static void test_multifd_tcp_zstd(void)
> > >  }
> > >  #endif
> > >
> > > +#ifdef CONFIG_QPL
> > > +static void test_multifd_tcp_qpl(void)
> > > +{
> > > +    MigrateCommon args = {
> > > +        .listen_uri = "defer",
> > > +        .start_hook = test_migrate_precopy_tcp_multifd_qpl_start,
> > > +    };
> > > +    test_precopy_common(&args);
> > > +}
> > > +#endif
> > > +
> > >  #ifdef CONFIG_GNUTLS
> > >  static void *
> > >  test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
> > > @@ -3789,6 +3809,10 @@ int main(int argc, char **argv)
> > >      migration_test_add("/migration/multifd/tcp/plain/zstd",
> > >                         test_multifd_tcp_zstd);
> > >  #endif
> > > +#ifdef CONFIG_QPL
> > > +    migration_test_add("/migration/multifd/tcp/plain/qpl",
> > > +                       test_multifd_tcp_qpl);
> > > +#endif
> > >  #ifdef CONFIG_GNUTLS
> > >      migration_test_add("/migration/multifd/tcp/tls/psk/match",
> > >                         test_multifd_tcp_tls_psk_match);
> > > --
> > > 2.39.3
> > >
> > >
> > 
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-
> > https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-
> > https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-
> > https://www.instagram.com/dberrange :|
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


