Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9DB715823
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 10:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3uW4-0005i3-BB; Tue, 30 May 2023 04:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3uW1-0005hH-Ii; Tue, 30 May 2023 04:15:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3uVz-0007kS-LF; Tue, 30 May 2023 04:15:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91B7C9477;
 Tue, 30 May 2023 11:15:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0660C8594;
 Tue, 30 May 2023 11:15:32 +0300 (MSK)
Message-ID: <4aa77e25-c224-c2aa-d17d-54d3d04f763e@tls.msk.ru>
Date: Tue, 30 May 2023 11:15:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: stable-8.0.1 re-tagging?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Hi!

Yesterday I pushed v8.0.1 tag for 8.0.1 stable qemu release, but in the
process of publishing it, Michael Roth discovered a regression in iotest
which we all overlooked when initial patch has been applied to master.

The commit in question is this one:

commit de79b52604e43fdeba6cee4f5af600b62169f2d2
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Tue May 2 17:11:19 2023 -0400

     block/export: call blk_set_dev_ops(blk, NULL, NULL)

It caused iotest 307 to fail, - qemu failed with Sig11.  This has been
fixed by this commit:

commit a184563778f2b8970eb93291f08108e66432a575
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Wed May 10 22:35:55 2023 +0200

     block/export: Fix null pointer dereference in error path

I applied it on top of other 8.0.1 changes, things are now working fine.

The question now is: should we re-tag v8.0.1, or should I push
v8.0.2 instead (with 8.0.1 not being released and published
on the download page)?

This is the first time something like this happens, it seems: a bug
in release is discovered between pushing the tag and publishing
things, so we haven't been in this situation before, when the tag
is there but the release should not happen.

I removed the tag for the bad release from gitlab.org qemu repository, -
I thought the permissions wont let me do that, but it just worked.
The tag still exists locally and on my clone of qemu repository on
gitlab.

So I can restore v8.0.1 and push v8.0.2, or I can re-push v8.0.1 for
the new commit (which would be one extra commit after "Updating version
for v8.0.1").

I'm for creating new v8.0.1 tag for the new commit.  But I'd like to
hear opinions of others on this matter, since this is an important
process which definitely should be public.

The reason for this failure is my misunderstanding: for some reason
I was sure whole range of tests is done within the CI infrastructure,
but it turned out even basic iotests aren't run.  It's interesting that
I did run iotests locally, just to become more famliar with that stuff,
the day before I cherry-picked the bad commit in question :)

And another lesson for me to learn, - actually 2 - first is to listen
to myself, since my inner self did think about running more complete
checks after a bunch of block-io changes which I picked up, but I didn't
think about that with enough attention. And second is to verify whatever
I "think" is true, instead of relying on own assumptions, - here, I was
sure iotests are run within CI infrastructure, but nothing really indicates
this is the case.

Thanks!

/mjt

