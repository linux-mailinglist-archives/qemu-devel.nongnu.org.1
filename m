Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D87CAD4E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPNU-0000Pv-Sr; Mon, 16 Oct 2023 11:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsPNM-0000Nc-RO; Mon, 16 Oct 2023 11:19:24 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qsPNK-0001ao-Pv; Mon, 16 Oct 2023 11:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=8ikJQCC5TLkL7JR5JlTU3UpA6g8LaKWjgM9/evGEzFk=; b=aGOU43EkvyJiadbd3LlgugWndr
 4xurUA890xm0/ENhk99UVqAb54O6T00LyeHtXfR8m3GM6lFk6OtKRHZ5HDxMqzKrpTPqvg5curQTr
 rIV6Rucgz20nRUsiqKnlZowMUo/NLQs17ZwN1GSv1fANshFRCM9lfJKWuQM8Ra8d0q9BT36RFta0K
 HgM66p0WtsRQkI9a/yI/ofe75YSiQI0/JmLUayOl4LbMquRoXLqmWyDFtxA6W3xa50XAID32EGqMX
 D1y4MMKSArdJ+xYoB6kSbjUQ7fDqJ6/e+9bWR4mjrbKDiSh7b0s3OvJc+W87KuuuGX5pAcILS2i5L
 20Sx+dJw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qsPNB-0067AK-2I; Mon, 16 Oct 2023 15:19:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qsPNC-0005ni-0J; Mon, 16 Oct 2023 16:19:14 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Woodhouse <dwmw2@infradead.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: [PATCH 10/12] hw/xen: automatically assign device index to console
 devices
Date: Mon, 16 Oct 2023 16:19:07 +0100
Message-Id: <20231016151909.22133-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016151909.22133-1-dwmw2@infradead.org>
References: <20231016151909.22133-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1bdf71eab2d76d13073e+7358+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Now that we can reliably tell whether a given device already exists, we
can allow the user to add console devices on the command line with just
'-device xen-console,chardev=foo'.

Start at 1, because we can't add the *primary* console; that's special
because the toolstack has to set up the guest end of that.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/char/xen_console.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index 2825b8c511..1a0f5ed3e1 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -333,6 +333,22 @@ static char *xen_console_get_name(XenDevice *xendev, Error **errp)
 {
     XenConsole *con = XEN_CONSOLE_DEVICE(xendev);
 
+    if (con->dev == -1) {
+        char name[11];
+        int idx = 1;
+
+        /* Theoretically we could go up to INT_MAX here but that's overkill */
+        while (idx < 100) {
+            snprintf(name, sizeof(name), "%u", idx);
+            if (!xen_backend_exists("console", name)) {
+                con->dev = idx;
+                return g_strdup(name);
+            }
+            idx++;
+        }
+        error_setg(errp, "cannot find device index for console device");
+        return NULL;
+    }
     return g_strdup_printf("%u", con->dev);
 }
 
-- 
2.40.1


