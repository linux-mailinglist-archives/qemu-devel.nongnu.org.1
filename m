Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7747E71EF6A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kzR-0005lI-Ez; Thu, 01 Jun 2023 12:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kzK-0005ff-4F
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4kzG-0004UX-TB
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URP6T37Q595GI4L/uv/azw/lNI2RJFirAjYpfkBqpp4=;
 b=hCIP067X57GalXsr8lmYuTS4qxXUsjpAmKczXblMsezypG9Ei8xwlUjlI6kKB8LnJ7w5b6
 S0e7XnJLrOBh0SVmURZgJ+Yl4B0/+KjTmBtSu8GPo9Ta8JB6TAG5W2AT7N877ACMQIfmK8
 wlYtTJRhhr1MP4zcf/XaOUbB5Ys9Ag0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-aRVtiLN3PJm5O-1QjqMWXg-1; Thu, 01 Jun 2023 12:17:16 -0400
X-MC-Unique: aRVtiLN3PJm5O-1QjqMWXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9F0D2999B46
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 16:17:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59E87112132C;
 Thu,  1 Jun 2023 16:17:14 +0000 (UTC)
Date: Thu, 1 Jun 2023 17:17:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHjEh5GSgS+3i8HQ@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <87a5xjs6ob.fsf@secure.mitica>
 <7c02b1c2-1636-24d9-8466-3bcc6c88acbd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c02b1c2-1636-24d9-8466-3bcc6c88acbd@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 06:09:44PM +0200, Thomas Huth wrote:
> On 01/06/2023 14.33, Juan Quintela wrote:
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> ...
> > > On a test machine this reduces execution time from 13 minutes to
> > > 8 minutes.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > Hi
> > 
> > I have a different idea to get the migration tests faster.  Namely, just
> > stop letting enter the completation stage until we are ready to use it.
> > 
> > I need that functionality also for vfio migration, so as I have to
> > create the patches, can we put on hold the last two patches and give me
> > a couple of days?
> 
> A couple of days are certainly OK ... but could we please avoid being stuck
> in the current situation for many more weeks?

Also as I mentioned in my reply to Peter, I'm wary of an approach that
puts in a synchronization between the test suite and the migrate code,
because that's making migration run in a manner which doesn't actually
match how it'll run in the real world. So I think if there was a feature
to add a sync before the final iteration, we'd still want to test without
using that feature so we get proper coverage.

Could we merge this series as-is, and simply re-visit the last patch
afterwards, once we have time to debate the feature about completion
phase synchronization.

>                                               The slowness of the migration
> tests are really slowing down my turnaround times, and I think they
> contribute to the timeouts of the Travis CI tests that I'm currently facing,
> and likely also contributed to the issue that the QEMU project ran out of
> Gitlab CI minutes again last month (which is thankfully mostly hidden by the
> new private Linux runners, but some things like the Windows runners were not
> available anymore). So I'd appreciate if we'd rather get a speed up here
> merged rather sooner than later.
> 
> > Thomas, do you care if I get the whole sets of patches through the
> > migration tree?
> 
> That's fine, please take them through your tree!

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


