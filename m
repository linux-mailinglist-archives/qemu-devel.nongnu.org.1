Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC91380C774
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 11:57:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCdxN-0000Ps-PT; Mon, 11 Dec 2023 05:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rCdxK-0000Pc-HO; Mon, 11 Dec 2023 05:56:10 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rCdxG-00069b-S2; Mon, 11 Dec 2023 05:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=8tcRn2Jik/WAZu/NnQABjEZ/osafgiaB916KAVIfTxk=; b=i7+1a0ZVpOiW
 rI5zDw1RBGtZg8rp9ZR91AT/DJvVOl7iqCw84IRAqvX8GuEemJw4tKrgqp4MOi7XoLhYuMqaYMB3K
 YU6mm7ze/+uLsJ2tehQt+uDmo/ZQ28vlnyI1Irvv01FHZMZj8aAmwzw9vMNbQeG5Ws0GnyHkkFilV
 sPkUM6PSqsFcwzl8sqOZ3pQehFYZCPmJLTaTYvgKtXy1GLvnpFrCjYfBMkk8ygHVaIxZKxaL+KWFm
 3BXssR39NlPhseAFj+zE7jF9ma5HKYrwOG6G6ZviwsHUAMk4arEdWtHC0BdCw9BNb+GB2R7UpNaE6
 5XmktvTREIQu7LiwC8jjiA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rCdvL-000MeT-3A;
 Mon, 11 Dec 2023 11:55:52 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH] block: allocate aligned write buffer for 'truncate -m full'
Date: Mon, 11 Dec 2023 12:55:59 +0200
Message-Id: <20231211105559.316897-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In case we're truncating an image opened with O_DIRECT, we might get
-EINVAL on write with unaligned buffer.  In particular, when running
iotests/298 with '-nocache' we get:

qemu-io: Failed to resize underlying file: Could not write zeros for
preallocation: Invalid argument

Let's just allocate the buffer using qemu_blockalign0() instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b862406c71..cee8de510b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2354,7 +2354,7 @@ static int handle_aiocb_truncate(void *opaque)
             goto out;
         }
 
-        buf = g_malloc0(65536);
+        buf = qemu_blockalign0(aiocb->bs, 65536);
 
         seek_result = lseek(fd, current_length, SEEK_SET);
         if (seek_result < 0) {
@@ -2413,7 +2413,7 @@ out:
         }
     }
 
-    g_free(buf);
+    qemu_vfree(buf);
     return result;
 }
 
-- 
2.39.3


