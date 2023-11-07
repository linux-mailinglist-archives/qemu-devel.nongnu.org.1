Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959C7E3507
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 07:08:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0FEs-0008Q7-8x; Tue, 07 Nov 2023 01:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <min_halo@163.com>) id 1r0C54-0007OU-5Q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:44:42 -0500
Received: from m15.mail.163.com ([45.254.50.219])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <min_halo@163.com>) id 1r0C50-0005BE-Qe
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ReoMS
 e7DGKG/nQ2vzUN29OZC5JV6rBdSnDHtbl367Is=; b=QOCFLz0SEwESuCgULAsIQ
 NNkFn/gKZSGDj5R/AKK/VzOAdcXlOa91VZfxsRNPH5Dbwv4Mu3WB3PUp81ed5tE6
 dFJQtWc4D5S7f3cwgHtqna+jth4glROnrKmfSmV6iRkEXkKiB8auXdp8W+r2Jy7e
 2ozRJE3GIPfsr23ReE4hIE=
Received: from thinkpadx13gen2i.. (unknown [111.48.58.12])
 by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wA33peDpEllJ4BFBA--.3S2;
 Tue, 07 Nov 2023 10:44:20 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Zongmin Zhou <min_halo@163.com>,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] dump:Add close fd on error return to avoid resource leak
Date: Tue,  7 Nov 2023 10:44:17 +0800
Message-Id: <20231107024417.585475-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA33peDpEllJ4BFBA--.3S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTiqNtrDUUUU
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbisAQhq2Nfyn8ogwAAsc
Received-SPF: pass client-ip=45.254.50.219; envelope-from=min_halo@163.com;
 helo=m15.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Nov 2023 01:06:58 -0500
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

Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
---
 dump/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dump/dump.c b/dump/dump.c
index 1c304cadfd..ad5294e853 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
         return;
     }
     if (kdump_raw && lseek(fd, 0, SEEK_CUR) == (off_t) -1) {
+        close(fd);
         error_setg(errp, "kdump-raw formats require a seekable file");
         return;
     }
-- 
2.34.1


