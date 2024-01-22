Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D28360DF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:16:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRsGk-0004RV-0J; Mon, 22 Jan 2024 06:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rRsGf-0004RB-Lo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rRsGd-0004SG-Mo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705922102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9CvW5YGbWvUCZYax74H3dwp+p9ofG4OmjxEQRr/Z91o=;
 b=S/JUn99X3s1zqe+vOkmeeip6k2TqykSw41+bQgX/l1zA9Mw/6+8OansS4CnJMGhn+cuHca
 oahunvtp+e6bKWbNDL05QHokM9zg77UhDJ33XrHzGwgLB1DLuNHtd0CeRdHNX/n3Fi6lCr
 UNaPGV0vTVQMMO2hR9yHTFLQLTEB6Uk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-3XhAOKXFN8W4LRW4EXi7Jg-1; Mon, 22 Jan 2024 06:14:58 -0500
X-MC-Unique: 3XhAOKXFN8W4LRW4EXi7Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2CE101A526;
 Mon, 22 Jan 2024 11:14:58 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F311C060AF;
 Mon, 22 Jan 2024 11:14:57 +0000 (UTC)
Date: Mon, 22 Jan 2024 12:14:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, ira.weiny@intel.com,
 Jonathan.Cameron@huawei.com, mst@redhat.com
Subject: Re: [PULL 00/14] Block layer patches
Message-ID: <Za5OL56iirwteiEe@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
 <CAFEAcA9eR1Hs9CUu7MTdMsc93kUXt_btzS364AaO6V1axn5P8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9eR1Hs9CUu7MTdMsc93kUXt_btzS364AaO6V1axn5P8g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 20.01.2024 um 18:21 hat Peter Maydell geschrieben:
> On Fri, 19 Jan 2024 at 18:15, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:
> >
> >   Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to ced0d71c5270bed828ed2bd4b116ddfb12862bf9:
> >
> >   block/blklogwrites: Protect mutable driver state with a mutex. (2024-01-19 18:45:44 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches
> >
> > - virtio-blk: Multiqueue fixes and cleanups
> > - blklogwrites: Fixes for write_zeroes and superblock update races
> > - commit/stream: Allow users to request only format driver names in
> >   backing file format
> > - monitor: only run coroutine commands in qemu_aio_context
> >
> > ----------------------------------------------------------------
> 
> Got some compile failures on this one; looks like the compiler
> on our s390 box didn't like this:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/5973441293
> https://gitlab.com/qemu-project/qemu/-/jobs/5973441291
> https://gitlab.com/qemu-project/qemu/-/jobs/5973441330
> 
> In file included from ../include/qemu/host-utils.h:33,
> from ../include/qemu/bitops.h:16,
> from ../include/qemu/timer.h:4,
> from ../include/block/aio.h:24,
> from ../include/block/aio-wait.h:28,
> from ../include/block/block-io.h:27,
> from ../block/blklogwrites.c:15:
> ../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
> ../include/qemu/bswap.h:148:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 148 | ((((_x) & 0x00000000000000ffU) << 56) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> ../include/qemu/bswap.h:149:36: error: left shift count >= width of
> type [-Werror=shift-count-overflow]
> 149 | (((_x) & 0x000000000000ff00U) << 40) | \
> | ^~
> ../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
> 409 | .nr_entries = const_le64(0),
> | ^~~~~~~~~~
> cc1: all warnings being treated as errors

Looks like const_le64() introduced in commit 845d80a8 is buggy. I wonder
why we even added it when there is no user of it (this blklogwrites one
is the first one, so it exposes the error).

Of course, 0 is just as good as const_le64(0), so I'll just change it to
that for now. But I suppose const_le64() should either be fixed (and
used by something) or removed.

Kevin


