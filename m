Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669F7F2C74
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:01:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PQa-0002vT-Fk; Tue, 21 Nov 2023 07:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+dd65dc28b6171b1f8060+7394+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r5PQD-0002vA-Mu
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:06 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+dd65dc28b6171b1f8060+7394+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r5PQ9-0005rM-TX
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=JzRV6ny3++3xkn4fW6mQjP91R+P7TBzpc3OKwAaM7LQ=; b=Os6KVaO+j7b6+vQBogxHDw5NDX
 F2HeJJWRkdvM3/vaSAlgH5XkLBBQb+3hD7psNoEOU8Z1L1MHTdlj5PZHEGzZfPLywOsbLdBvipVRo
 hGuZ/gpZviRBlyijFJqsmZnI20t6rVUy7408fVU1hvmcq2KJhlB3Y7gR/1KEMNOCdfNP0KgCAFigA
 gGxXSIOxmmcAWGQ77sUMi15qVO+ghXdjIzp6e/4aQEzAN+bKthEmj+I1zg/aITWEzqMHRR0ex1L/Z
 EZnetwMRkM+02zMJ0FRYffgM7pxlzlkozXiAv36ylqnOzaXtElRQt+z45sELD0SpvCkUV8YCNUfO/
 qoI9Xh+Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r5PQ6-005YXW-9j; Tue, 21 Nov 2023 11:59:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r5PQ5-005fd4-2V; Tue, 21 Nov 2023 11:59:57 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Paul Durrant <paul@xen.org>
Subject: [PULL for-8.2 1/2] vl: disable default serial when xen-console is
 enabled
Date: Tue, 21 Nov 2023 11:59:56 +0000
Message-ID: <20231121115957.1351656-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121115957.1351656-1-dwmw2@infradead.org>
References: <20231121115957.1351656-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+dd65dc28b6171b1f8060+7394+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

If a Xen console is configured on the command line, do not add a default
serial port.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 system/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a1..8109231834 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -198,6 +198,7 @@ static const struct {
     const char *driver;
     int *flag;
 } default_list[] = {
+    { .driver = "xen-console",          .flag = &default_serial    },
     { .driver = "isa-serial",           .flag = &default_serial    },
     { .driver = "isa-parallel",         .flag = &default_parallel  },
     { .driver = "isa-fdc",              .flag = &default_floppy    },
-- 
2.41.0


