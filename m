Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D37828CE4
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:48:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNH8D-0001VA-PO; Tue, 09 Jan 2024 13:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@gmx.com>)
 id 1rNH7z-0001T9-Ds; Tue, 09 Jan 2024 13:47:07 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@gmx.com>)
 id 1rNH7v-0003CC-3x; Tue, 09 Jan 2024 13:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1704826016; x=1705430816; i=megari@gmx.com;
 bh=y1Tla0g7mOfrvLjx8TXJ7cpaPBL2JPbuyBLCQtqE6Lo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Reply-To;
 b=bwr/F/z5VArtDteD9NBSQUndmw4j7gYbmhHvcN0t65bsTXGCuqM0ESPmWav+xizk
 HXq9z5yJqYCdlriB2zYT9B0fDzYhIdGMdGD5PlNh/rhqrNSpfHEY90/s1xUGD0SoI
 a9ohjqP7hFJK0LoBYXgBc5D6+FPUuwMlbRJSYZVxv9RUZS9ZSCvGM+6QG40M8LM4h
 XQsB88NLGJMzeyPSwxbnA//j8yRrb404vjrJQH89EFtsuugczQnQtYlHRF6jx3EdK
 hrZH2aXxmlvFIpHrEFmJ9zXdmHuu1EG4LO0FuuVK5BmtG1+N3WQD+UQblbMQO++rf
 dQ/QMjy6lt6FkNEWcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from asuna.localdomain ([62.78.246.74]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QF5-1rLtgL0GaD-001UBm; Tue, 09
 Jan 2024 19:46:56 +0100
From: megari@gmx.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Ari Sundholm <ari@tuxera.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] block/blklogwrites: Fix a bug when logging "write zeroes"
 operations.
Date: Tue,  9 Jan 2024 20:46:46 +0200
Message-ID: <20240109184646.1128475-1-megari@gmx.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2n2VRea+weQArjDPF1DOKp16kUaxxMy/k75awDT7RmcrXVi02K+
 YnNL+sMsT2DMEYnOEwzn7uRCOMedVWF43kOGQLWgLlSXO7Ag8fE4jL7yLZO10Ii0KHeZzSs
 YZHeSCTleA5ChcBEuLsXwPGc0lYmTVzC1CHFJbzwL7XOQKngLuFMs9+C3iKRvKA/fn0qbCi
 +PJz09Uax002Gw+OxUn3g==
UI-OutboundReport: notjunk:1;M01:P0:Zn0KflrFsfY=;rhmEmA6t3+1HSiGkfSR4loHAVqr
 o0i3lZjETfo5uw2+T6x2krdW8xNN/0RKcOjMPaJByz3XEZWlQ1+sVqa4/byj2s9/fWkW67lSP
 +DlBQ/VhZJCRR2IIUi7tYLOrr6hNpttn9AFGLIbLCu6D2AJQBSxB31YnLSUQSJFIkO38xAvFe
 yEjncevq5jBfJ6235ROoeVwj33ITOy5wLzGE9M5poxOIMi2frkCSNxYzXSZEmtlf2lekhneNp
 HalNGX534rn34vyxIouKSzmREaXZT87Q5epw9/IU6HahUY2dtl7R1kw6wCEgpJ4/F8z2IsPJb
 /lJniFutKCq3uuswVNvTb4EaV7dSK8HRFGXgl0Db9hDt8OUNqxyeQyCDl0KUZUR4gDO9DtM8m
 wXg//XX5RHD0gggVTo7qai2DzbdXnVjcJaJyPVIeZKcaR+0i/89iYp0Q9UO/W5JO6IjjLBjBh
 bu/s6Nk96npk+WIS7N+3BssE3SjKdVTrhvlw7Y98sFkcjYIxSNuAZIhxqklwBuUeS1xdUB9xT
 /eA0mTsCjdpORfrURQioP9WkI4RUZ3SO97aFw6k2VCdS7zj/fp1npr1NdMD3mvNld5XUdBC5I
 meWxM3seBgsBajfDYnWBa5dlFYdOrUBfv4nN740vIGWx7gpFnVy+BjL5paMRSYHOWMILPOUY+
 Qk5e4JQof7u0UGTxC2RZY+TmZfRtUuN4qM4ZtXMjXySKfTHbBGZSCjXw3T5TikfQknnFCXmpI
 zsOlciqT8WTrH9iPwolLOxJbN/YcjCZUSLKKr2nU4oTLNOLahX4YhX6hDkP5PS6Tsr+fz0onP
 96F0Eh+4K4wc2+FTvjisF8B/UFCxAmB4NLLY1MOgt8itExYZpme5vKP4v7hCYgV+OUSA5kvIQ
 +Muzqhu806X8zP+RYhct2qG2/YSsXlA0+PjUH/kQt+6PDJSUGCwjHxwBIBqThDSIY17Ojhubb
 G2iWmQ==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=megari@gmx.com;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Ari Sundholm <ari@tuxera.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Ari Sundholm <ari@tuxera.com>

There is a bug in the blklogwrites driver pertaining to logging "write
zeroes" operations, causing log corruption. This can be easily observed
by setting detect-zeroes to something other than "off" for the driver.

The issue is caused by a concurrency bug pertaining to the fact that
"write zeroes" operations have to be logged in two parts: first the log
entry metadata, then the zeroed-out region. While the log entry
metadata is being written by bdrv_co_pwritev(), another operation may
begin in the meanwhile and modify the state of the blklogwrites driver.
This is as intended by the coroutine-driven I/O model in QEMU, of
course.

Unfortunately, this specific scenario is mishandled. A short example:
    1. Initially, in the current operation (#1), the current log sector
number in the driver state is only incremented by the number of sectors
taken by the log entry metadata, after which the log entry metadata is
written. The current operation yields.
    2. Another operation (#2) may start while the log entry metadata is
being written. It uses the current log position as the start offset for
its log entry. This is in the sector right after the operation #1 log
entry metadata, which is bad!
    3. After bdrv_co_pwritev() returns (#1), the current log sector
number is reread from the driver state in order to find out the start
offset for bdrv_co_pwrite_zeroes(). This is an obvious blunder, as the
offset will be the sector right after the (misplaced) operation #2 log
entry, which means that the zeroed-out region begins at the wrong
offset.
    4. As a result of the above, the log is corrupt.

Fix this by only reading the driver metadata once, computing the
offsets and sizes in one go (including the optional zeroed-out region)
and setting the log sector number to the appropriate value for the next
operation in line.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Cc: qemu-stable@nongnu.org
=2D--
 block/blklogwrites.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 7207b2e757..ba717dab4d 100644
=2D-- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -328,22 +328,39 @@ static void coroutine_fn GRAPH_RDLOCK
 blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 {
     BDRVBlkLogWritesState *s =3D lr->bs->opaque;
-    uint64_t cur_log_offset =3D s->cur_log_sector << s->sectorbits;

-    s->nr_entries++;
-    s->cur_log_sector +=3D
-            ROUND_UP(lr->qiov->size, s->sectorsize) >> s->sectorbits;
+    /*
+     * Determine the offsets and sizes of different parts of the entry, a=
nd
+     * update the state of the driver.
+     *
+     * This needs to be done in one go, before any actual I/O is done, as=
 the
+     * log entry may have to be written in two parts, and the state of th=
e
+     * driver may be modified by other driver operations while waiting fo=
r the
+     * I/O to complete.
+     */
+    const uint64_t entry_start_sector =3D s->cur_log_sector;
+    const uint64_t entry_offset =3D entry_start_sector << s->sectorbits;
+    const uint64_t qiov_aligned_size =3D ROUND_UP(lr->qiov->size, s->sect=
orsize);
+    const uint64_t entry_aligned_size =3D qiov_aligned_size +
+        ROUND_UP(lr->zero_size, s->sectorsize);
+    const uint64_t entry_nr_sectors =3D entry_aligned_size >> s->sectorbi=
ts;

-    lr->log_ret =3D bdrv_co_pwritev(s->log_file, cur_log_offset, lr->qiov=
->size,
+    s->nr_entries++;
+    s->cur_log_sector +=3D entry_nr_sectors;
+
+    /*
+     * Write the log entry. Note that if this is a "write zeroes" operati=
on,
+     * only the entry header is written here, with the zeroing being done
+     * separately below.
+     */
+    lr->log_ret =3D bdrv_co_pwritev(s->log_file, entry_offset, lr->qiov->=
size,
                                   lr->qiov, 0);

     /* Logging for the "write zeroes" operation */
     if (lr->log_ret =3D=3D 0 && lr->zero_size) {
-        cur_log_offset =3D s->cur_log_sector << s->sectorbits;
-        s->cur_log_sector +=3D
-                ROUND_UP(lr->zero_size, s->sectorsize) >> s->sectorbits;
+        const uint64_t zeroes_offset =3D entry_offset + qiov_aligned_size=
;

-        lr->log_ret =3D bdrv_co_pwrite_zeroes(s->log_file, cur_log_offset=
,
+        lr->log_ret =3D bdrv_co_pwrite_zeroes(s->log_file, zeroes_offset,
                                             lr->zero_size, 0);
     }

=2D-
2.43.0


