Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A507150ED
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 23:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3kLu-0006Tg-6a; Mon, 29 May 2023 17:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3kLr-0006TO-Ng; Mon, 29 May 2023 17:24:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3kLq-0003cl-3G; Mon, 29 May 2023 17:24:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B08F393A8;
 Tue, 30 May 2023 00:24:15 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 19E0C848A;
 Tue, 30 May 2023 00:24:14 +0300 (MSK)
Message-ID: <f4d89121-1b31-ae77-0ea9-67df940d2f15@tls.msk.ru>
Date: Tue, 30 May 2023 00:24:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: stable-8.0: block/export: call blk_set_dev_ops and Fix null pointer
 dereference in error path
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

For some reason I picked up this commit:

commit de79b52604e43fdeba6cee4f5af600b62169f2d2
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Tue May 2 17:11:19 2023 -0400

     block/export: call blk_set_dev_ops(blk, NULL, NULL)

for stable-8.0.1.  However it turned out it fails iotests, up until
the fix, which is

commit a184563778f2b8970eb93291f08108e66432a575
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Wed May 10 22:35:55 2023 +0200

     block/export: Fix null pointer dereference in error path

It's a good question why I picked the first one up to begin
with, but now, especially after not realizing iotests are not
run within CI framework automatically - I ended up with broken
v8.0.1 which I tagged earlier today.

What do you think, what is better for 8.0.1 - to revert first
commit or to add second on top?

Thanks!

/mjt

