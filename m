Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08404708DB8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 04:22:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzpj9-0003FN-GJ; Thu, 18 May 2023 22:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzpj7-0003F0-I3
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzpj6-0001a2-1D
 for qemu-devel@nongnu.org; Thu, 18 May 2023 22:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684462814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=//M2M3Jb8g3iOu3zwVCBL0HPzZsn92ZVAv7BqEtqi2A=;
 b=UVJnF8lcKQ/b4XEMwRxXAltLauiEP6SEITNtKP9Q8Iwn2hUHfW4pwDqsEa/Pph7UtH0zUc
 dbLfrGgbvL/H895D9bNM8xNZbj3Jq9uPanoeehQiNj0JEohb2e6t24zrmUzKdSsleebPzn
 I1SKM0jT3MsxH6z/qWN3IB/k+XXrSp8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-T0SjTn4pP9KIjVFCW0V1Wg-1; Thu, 18 May 2023 22:20:12 -0400
X-MC-Unique: T0SjTn4pP9KIjVFCW0V1Wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C910800047;
 Fri, 19 May 2023 02:20:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80FCD40C2063;
 Fri, 19 May 2023 02:20:11 +0000 (UTC)
Date: Thu, 18 May 2023 21:20:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 6/8] iotests: always use a unique sub-directory per test
Message-ID: <waaue3b3fdx5gzukta36lief42hy7rcpxc5sq22zyrf4ege553@ojch3hmp2zrk>
References: <20230303160727.3977246-1-berrange@redhat.com>
 <20230303160727.3977246-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303160727.3977246-7-berrange@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 03, 2023 at 04:07:25PM +0000, Daniel P. Berrangé wrote:
> The current test runner is only safe against parallel execution within
> a single instance of the 'check' process, and only if -j is given a
> value greater than 2. This prevents running multiple copies of the
> 'check' process for different test scenarios.
> 
> This change switches the output / socket directories to always include
> the test name, image format and image protocol. This should allow full
> parallelism of all distinct test scenarios. eg running both qcow2 and
> raw tests at the same time, or both file and nbd tests at the same
> time.
> 
> It would be possible to allow for parallelism of the same test scenario
> by including the pid, but that would potentially let many directories
> accumulate over time on failures, so is not done.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  tests/qemu-iotests/testrunner.py | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

git bisect points to this commit as being the reason behind the
following regression in iotests:

$ ./check -nbd 104
...
--- /home/eblake/qemu/tests/qemu-iotests/104.out
+++ /home/eblake/qemu/build/tests/qemu-iotests/scratch/raw-nbd-104/104.out.bad
@@ -2,11 +2,11 @@
 === Check qemu-img info output ===

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1024
-image: TEST_DIR/t.IMGFMT
+image: nbd+unix://?socket=/tmp/tmpqathrkpn/IMGFMT-nbd-104/nbd
 file format: IMGFMT
 virtual size: 1 KiB (1024 bytes)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1234
-image: TEST_DIR/t.IMGFMT
+image: nbd+unix://?socket=/tmp/tmpqathrkpn/IMGFMT-nbd-104/nbd
 file format: IMGFMT
 virtual size: 1.5 KiB (1536 bytes)
 *** done
Failures: 104

Back in 2015, commit a231cb2726, we added a hack that turned
nbd://... into TEST_DIR/t.IMGFMT to satisfy the output matching in the
various iotests, but with our new per-test directories, that filter is
no longer firing.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


