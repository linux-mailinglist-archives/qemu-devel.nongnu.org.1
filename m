Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF837EC9AD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:28:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jfz-0006DD-19; Wed, 15 Nov 2023 12:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a96bd05b928ee04f18d5+7388+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r3Jfw-000657-8R; Wed, 15 Nov 2023 12:27:40 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a96bd05b928ee04f18d5+7388+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r3Jfr-0007ju-Am; Wed, 15 Nov 2023 12:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=U2nfIn0v8qQcweyjpuwetdqXtDTacmG9Ew4TFyBXTIk=; b=Z0hyEVwBzW2EjTAYTKEL9c5Jxb
 FIFLgifQJSEBNQMSx1dJbhnwRd5EyKn413VSvoQitCGS1XgTHSiuwuY1iKWaOjex+I+QwAtNtIkrZ
 ncu525Eu5aYcICJbRPH0prOFfUd7psULCeDYK1sd+1u8YT/uOWkTt+l2/HBIOf6Ok5JiT6BGVN4K/
 dPLPIQMMl72swFVHG5VOl9pTmf/iEojG7bdPQwBgUBDl2Bt90S8SMmypzJxsdYFt+nSJB12Kd96IL
 9BOfxKI4YY8f13ViEYj0RRLpzy6cDH/Si+CJs/FBAzOU6eL1n+y8cCdjZXlA7grXwNcE2848vcEG8
 KYSN3t1A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r3Jfh-00FTE8-Nd; Wed, 15 Nov 2023 17:27:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r3Jfh-004sFH-0w; Wed, 15 Nov 2023 17:27:25 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Subject: [PATCH 2/3] vl: disable default serial when xen-console is enabled
Date: Wed, 15 Nov 2023 17:24:36 +0000
Message-ID: <20231115172723.1161679-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115172723.1161679-1-dwmw2@infradead.org>
References: <20231115172723.1161679-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+a96bd05b928ee04f18d5+7388+infradead.org+dwmw2@casper.srs.infradead.org;
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


