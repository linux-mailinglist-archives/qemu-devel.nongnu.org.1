Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C874FFDB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJTtD-0004Ik-T9; Wed, 12 Jul 2023 03:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJTt4-0004IP-DM
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qJTsy-0005xo-PC
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689145418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vffwoc7EMwWVeQsXici3hlqjm/AaJ0JsnPadszKWxgQ=;
 b=B7TuM6Xv8LYiC/oqebQTea/aY3MJGyiddzxTGANhtVUytUDItrKdiLiTKnDrcTdOsCm3B7
 oQFz41/P7n8c0nQUCXTD6sIY61w+/Y5Afhui2RDfegUS5sx5gOMcpu4EzlckU8ENupLviJ
 /majpj8fmnP7ERoNi8PpmmnhRgTjp+M=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-bRAO7ZmzM72W0DHMix3Bpg-1; Wed, 12 Jul 2023 03:03:37 -0400
X-MC-Unique: bRAO7ZmzM72W0DHMix3Bpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAFF33806720;
 Wed, 12 Jul 2023 07:03:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50721111CB81;
 Wed, 12 Jul 2023 07:03:35 +0000 (UTC)
Date: Wed, 12 Jul 2023 08:03:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZK5QRcSYw/88j5uj@redhat.com>
References: <20230706201927.15442-1-farosas@suse.de>
 <20230706201927.15442-7-farosas@suse.de> <87jzv6jd7l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzv6jd7l.fsf@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 11, 2023 at 07:27:42PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Add basic tests for file-based migration.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration-test.c | 99 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 2fdf6a115e..c052dbe1f1 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -52,6 +52,10 @@ static bool got_dst_resume;
> >   */
> >  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
> >  
> > +#define QEMU_VM_FILE_MAGIC 0x5145564d
> > +#define FILE_TEST_FILENAME "migfile"
> > +#define FILE_TEST_OFFSET 0x1000
> > +
> >  #if defined(__linux__)
> >  #include <sys/syscall.h>
> >  #include <sys/vfs.h>
> > @@ -762,6 +766,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
> >      cleanup("migsocket");
> >      cleanup("src_serial");
> >      cleanup("dest_serial");
> > +    cleanup(FILE_TEST_FILENAME);
> >  }
> >  
> >  #ifdef CONFIG_GNUTLS
> > @@ -1459,11 +1464,28 @@ static void test_precopy_common(MigrateCommon *args)
> >               */
> >              wait_for_migration_complete(from);
> >  
> > +            /*
> > +             * For file based migration the target must begin its
> > +             * migration after the source has finished.
> > +             */
> > +            if (strstr(connect_uri, "file:")) {
> > +                migrate_incoming_qmp(to, connect_uri, "{}");
> > +            }
> > +
> 
> This is now broken since we merged commit e02f56e3de ("tests/qtest:
> massively speed up migration-test").
> 
> We cannot monitor the destination while the source is still running
> because we need the source to have finished writing to the file before
> we can start the destination. I'll have to think of another way of
> testing a migration that is done with a live source but asynchronous
> incoming migration.
> 
> Any suggestions are welcome.

Don't use test_precopy_common() at all. This helper is written from the
POV that we're actually doing a live migration. Migrate to/from file is
not live migration.

So open code the subset of pieces of test_precopy_common() that you
need for file migration. There are a handful of other tests that
take this approach since test_precopy_common wasn't suitable for
them eg test_migrate_auto_converge()

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


