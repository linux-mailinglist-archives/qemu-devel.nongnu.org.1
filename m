Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B05745FA9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLIs-0000AP-JG; Mon, 03 Jul 2023 11:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGLIq-0000A2-8p
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qGLIo-000841-Gn
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688397441;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=viRWLxlsJNHiCP9pq8fce23hodPXzyn6j1R6pIXco3Y=;
 b=TyCvW5DziBszMizmED/0g+XF88B2dOTP6a3czxpyFnOY+6QP9le+4HRFstcX38H4ZEvWU2
 zBKFrcBOgzfRy+uJa9cm/R5k/PsblJHxbNbRuVEAZzEtvYpByWWUC/uja81Z6UsLpGr55p
 3k7wQJzrj4LGh9LA12qrLGPXSn/VkYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-9qe_nKt_NmiwWVIslvLEwA-1; Mon, 03 Jul 2023 11:17:15 -0400
X-MC-Unique: 9qe_nKt_NmiwWVIslvLEwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78912101A528;
 Mon,  3 Jul 2023 15:17:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 947DC15230A7;
 Mon,  3 Jul 2023 15:17:14 +0000 (UTC)
Date: Mon, 3 Jul 2023 16:17:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 0/2] tests/qtest: Run migration subtests via meson
Message-ID: <ZKLmeCMHd/bt7UIo@redhat.com>
References: <20230703144700.13536-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703144700.13536-1-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Mon, Jul 03, 2023 at 11:46:58AM -0300, Fabiano Rosas wrote:
> We've had some issues with the migration-test failing in CI and giving
> no clue as to which migration sub-test has failed. I think it would be
> an improvement to have each subtest listed individually.

If the migration-test (or any test) actually fails, the meson test
log should show us exactly which test case failed already. We had
some jobs which didn't publish the log as an artifact, but I think
we finally have those all fixed.

If the migration-test hangs, however, then we get stuck until the
GitLab CI job timeout and get no useful info. For this scenario
we need to enable timeouts at the meson level, which are currently
all disabled. I've got a series here to address this:

  https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00305.html

It needs 

> 
> With this we can see which migration test has failed, can set timeouts
> individually and can run 'make check-migration' to run only the
> migration tests.

IMHO focusing just on migration-test is undesirable, as while this
has been one of the least reliable ones, other tests do also exhibit
hard to debug failures for much the same reasons. IOW, we need
improved debugging across the board rather than specialcased solutions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


