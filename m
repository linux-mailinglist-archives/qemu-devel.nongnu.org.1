Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792787089FE
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:02:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzkjw-0005Un-3B; Thu, 18 May 2023 17:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzkju-0005UA-9P
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pzkjm-0001G8-T8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684443638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tsHUXIv18vaPzPj+aNkO9mqgGgz5poj6VuQd++nXL3Y=;
 b=euLQi6hvtSmSfukg9viYH11Ehk28hAYYH+rHALk+ZDg9Es6LDnknimSFFugh1z/6wg1P1X
 9CIH49jWjsPL2h3IV/FkT+VraZgblruSqv+HqRDRo6mSXKPBI99lYK6C4YDyNx/54Eu54/
 GljM6D+PTs4vwIbIt3ILZBUj46G87tg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-p4O958xmOuWltE5ALg26yA-1; Thu, 18 May 2023 17:00:34 -0400
X-MC-Unique: p4O958xmOuWltE5ALg26yA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19CA8101A555;
 Thu, 18 May 2023 21:00:34 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC5F406D5E0;
 Thu, 18 May 2023 21:00:33 +0000 (UTC)
Date: Thu, 18 May 2023 16:00:31 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH 3/3] iotests: Test commit with iothreads and ongoing I/O
Message-ID: <lab6k3vpdmoujfx2va7zzllxmyn2gedkdfndcrgowywrvbhokt@o6dj37fqmi5z>
References: <20230517152834.277483-1-kwolf@redhat.com>
 <20230517152834.277483-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517152834.277483-4-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 17, 2023 at 05:28:34PM +0200, Kevin Wolf wrote:
> This tests exercises graph locking, draining, and graph modifications
> with AioContext switches a lot. Amongst others, it serves as a
> regression test for bdrv_graph_wrlock() deadlocking because it is called
> with a locked AioContext and for AioContext handling in the NBD server.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I've now confirmed the following setups with just './check
graph-changes-while-io -qcow2':

patch 3 alone => test fails with wrlock assertion (good, we're
catching the 8.0 regression where the new assertion failure is
tripping)

patch 1 and 3 => test fails differently than patch 3 alone (good,
we're exposing the fact that NBD had a pre-existing bug, regardless of
whether the added rwlock made it easier to spot)

patch 2 and 3 => test passes (good, patch 2 appears to have fixed this
particular bug, and when we are ready to revert patch 1 because we get
rid of AioContext locking we'll still be okay)

patch 1, 2, and 3 => test passes (good, we fixed the NBD bug, and have
regression testing in place for a scenario that previously wasn't
getting good testing)

As such, I'm happy to supply:

Tested-by: Eric Blake <eblake@redhat.com>


Now on to the patch itself...

> ---
>  tests/qemu-iotests/iotests.py                 |  4 ++
>  .../qemu-iotests/tests/graph-changes-while-io | 56 +++++++++++++++++--
>  .../tests/graph-changes-while-io.out          |  4 +-
>  3 files changed, 58 insertions(+), 6 deletions(-)
> 

> @@ -84,6 +84,54 @@ class TestGraphChangesWhileIO(QMPTestCase):
>  
>          bench_thr.join()
>  
> +    def test_commit_while_io(self) -> None:
> +        # Run qemu-img bench in the background
> +        bench_thr = Thread(target=do_qemu_img_bench, args=(200000, ))

TIL - you can create a 1-item tuple in Python.  It caught me
off-guard, but makes sense now that I've re-read it.

> +
> +        # While qemu-img bench is running, repeatedly commit overlay to node0
> +        while bench_thr.is_alive():
> +            result = self.qsd.qmp('block-commit', {
> +                'job-id': 'job0',
> +                'device': 'overlay',
> +            })
> +            self.assert_qmp(result, 'return', {})
> +
> +            result = self.qsd.qmp('block-job-cancel', {
> +                'device': 'job0',
> +            })
> +            self.assert_qmp(result, 'return', {})
> +
> +            cancelled = False
> +            while not cancelled:
> +                for event in self.qsd.get_qmp().get_events(wait=10.0):

The updated test took about 34 seconds on my machine; long enough that
it is rightfully not part of './check -g quick', but still reasonable
that I had no problems reproducing the issue while the test was
running.

> +                    if event['event'] != 'JOB_STATUS_CHANGE':
> +                        continue
> +                    if event['data']['status'] == 'null':
> +                        cancelled = True
> +
> +        bench_thr.join()
> +

It feels a bit odd that the test is skipped during './check -nbd', yet
it IS utilizing nbd, and the fix in patch 2 is indeed in NBD code.
But that's not a flaw in the test itself, just a limitation of what
images we need in order to set up the NBD service in a way to trigger
the problem.

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm in a spot where I can quickly queue this through my NBD tree so we
can get it backported to 8.0.1; pull request coming up, provided the
full series passes a few more tests on my end.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


