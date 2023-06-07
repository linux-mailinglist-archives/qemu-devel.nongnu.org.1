Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D872629D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0h-0002oC-3M; Wed, 07 Jun 2023 10:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0f-0002nz-De
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:37 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0d-0003PJ-QK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hHLTPA5r0vzs3zH7Id5pGL8t1rKKqxf49ksrYuCdo6U=;
 b=L0OWhZcSP1CfrJNvlcbnNWKtGSxYk+TEcjLqmpAS3SQQR33xWBwLkPb1
 akZ6ZN6eWbU/A9g9Ws279uerQJcxpGVs7Y37Pk8ttzMZ2ebfnEU4F1Buv
 WWj1Uex8DXSKYcSoS5JjnDEFhUlVMEQTbKMP+/3hKn/vl5BZ5NYtGEYX1 s=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 114430924
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:SVMdHaxp2SSxlrVg8lx6t+cxxirEfRIJ4+MujC+fZmUNrF6WrkUBm
 mpJWG2BPKrfMzTxe9gkboqx/BsHsZ+EyYVmTgFlpSAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPa8T5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUhEz
 cw6LW09VBeevMGT36KVGsR0lv12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMwhrD/
 jOcowwVBDlZBs7Cxjvf1k70i/DslxnVBpkwFaORo6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHVUwK9v1aNuxcOXNwWGOp89QLl90bPy1/HXC5eFGcHMYF48pZsHlTGy
 2NlgfvADwRfkrjIeUia64y3iCyiF3g4NX87MHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJQwc0
 wxmvwBl2exN0JdjO7GTuAme3mny/sShohsdvF2/Y46z0u9uiGdJjaSM4EOT0/tPJZ3xorKp7
 CldwJj2AAzj4PiweM2xrAclRunBCxWtame0bbtT834JqVyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLvU5t0l/S7RIi8PhwxUjaoSsIpHONg1Hs3DXN8Iki3yBR8+U3BE
 cnznTmQ4YYyVv08kWveqxY12r433CEurV4/triipylLJYG2PSbPIZ9caQvmUwzMxP/cyOkj2
 4oFZpTiJtQ2eLGWXxQ7BqZNdQ1bcyJmX8meRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:QpOZzKPukz5HWcBcTvOjsMiBIKoaSvp037BL7S9MoHluGfBw+P
 re+cjzuSWUtN9pYgBCpTniAse9qA3nhPxICOAqVN/JMWXbUQ2TXeVfBODZowEIdReOj9J15O
 NNdLV/Fc21LXUSt7eD3OBgKadG/DBQytHPudvj
X-Talos-CUID: 9a23:Q0sml20b/ot9XCLQEWCt27xfM8odQl/YkUfqJFKDKkN2WJPFZEeAwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3ABKViSw4hyZAZeveOqT71WJ04xowr0bbzB0FXtal?=
 =?us-ascii?q?ettanPxZeZSy/jSqeF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="114430924"
To: <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 02/12] hw/xen: Fix memory leak in libxenstore_open() for Xen
Date: Wed, 7 Jun 2023 15:18:29 +0100
Message-ID: <20230607141839.48422-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa4.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

There was a superfluous allocation of the XS handle, leading to it
being leaked on both the error path and the success path (where it gets
allocated again).

Spotted by Coverity (CID 1508098).

Fixes: ba2a92db1ff6 ("hw/xen: Add xenstore operations to allow redirection to internal emulation")
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230412185102.441523-3-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-operations.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index 4b78fbf4bd..3d213d28df 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -287,7 +287,7 @@ static void watch_event(void *opaque)
 static struct qemu_xs_handle *libxenstore_open(void)
 {
     struct xs_handle *xsh = xs_open(0);
-    struct qemu_xs_handle *h = g_new0(struct qemu_xs_handle, 1);
+    struct qemu_xs_handle *h;
 
     if (!xsh) {
         return NULL;
-- 
Anthony PERARD


