Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F067E2D7C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 21:01:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r05hI-0007x9-QN; Mon, 06 Nov 2023 14:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r05gy-0006OM-3Q; Mon, 06 Nov 2023 14:55:25 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r05gn-00066j-IS; Mon, 06 Nov 2023 14:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=vZowVkCjMFbp95UJRr5lu+JPxdNb9doXjcXZRlmZdv8=; b=Y/rkI5F0NcvCFoLbktSjr9lD+p
 JghtzoFzu1jDfHij1/EbcuKd66GBWDMTanBgalqLdoTiZOA/Vs2zIKMhAwjpEWhC+ogI3P5/QnQCW
 ee3GrAB/elUOQ5ZswbLXnTB04HdYuoyZ0IZ7KB3LfvtHV92kmes+GTH4SFL+BHuFQiu3iKxL3hk09
 ao5Od0E02mZsu2PxliLHdwYKYf7QvlXUrSJLbvKvuGmlm4k6bho2IPdG20Ysp2YAFS9TM3WOSH94j
 0W9WhgZJl96jwmHF+1r7uuYiuvxpYSbQ3efgbg4ED59wjEdGIKiLh2g8faL+E72DdJnyM+9+xJoXV
 9yAC6hug==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r05fd-007tb3-6F; Mon, 06 Nov 2023 19:54:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r05fd-001GPu-1Y; Mon, 06 Nov 2023 19:54:01 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH for-8.3 v2 45/46] net: remove qemu_show_nic_models(),
 qemu_find_nic_model()
Date: Mon,  6 Nov 2023 19:49:50 +0000
Message-ID: <20231106195352.301038-46-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106195352.301038-1-dwmw2@infradead.org>
References: <20231106195352.301038-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org;
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

These old functions can be removed now too. Let net_param_nic() print
the full set of network devices directly, and also make it note that a
list more specific to this platform/config will be available by using
'-nic model=help' instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/net/net.h |  3 ---
 net/net.c         | 39 ++++++---------------------------------
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 1512650190..290e604f03 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -201,9 +201,6 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
-int qemu_show_nic_models(const char *arg, const char *const *models);
-int qemu_find_nic_model(NICInfo *nd, const char * const *models,
-                        const char *default_model);
 NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
                             const char *alias);
 bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
diff --git a/net/net.c b/net/net.c
index ffc722069f..a3532a71a5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -962,38 +962,6 @@ GPtrArray *qemu_get_nic_models(const char *device_type)
     return nic_models;
 }
 
-int qemu_show_nic_models(const char *arg, const char *const *models)
-{
-    int i;
-
-    if (!arg || !is_help_option(arg)) {
-        return 0;
-    }
-
-    printf("Available NIC models:\n");
-    for (i = 0 ; models[i]; i++) {
-        printf("%s\n", models[i]);
-    }
-    return 1;
-}
-
-int qemu_find_nic_model(NICInfo *nd, const char * const *models,
-                        const char *default_model)
-{
-    int i;
-
-    if (!nd->model)
-        nd->model = g_strdup(default_model);
-
-    for (i = 0 ; models[i]; i++) {
-        if (strcmp(nd->model, models[i]) == 0)
-            return i;
-    }
-
-    error_report("Unsupported NIC model: %s", nd->model);
-    return -1;
-}
-
 static int net_init_nic(const Netdev *netdev, const char *name,
                         NetClientState *peer, Error **errp)
 {
@@ -1776,9 +1744,14 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
         }
         if (is_help_option(type)) {
             GPtrArray *nic_models = qemu_get_nic_models(TYPE_DEVICE);
+            int i;
             show_netdevs();
             printf("\n");
-            qemu_show_nic_models(type, (const char **)nic_models->pdata);
+            printf("Supported NIC models "
+                   "(use -nic model=help for a filtered list):\n");
+            for (i = 0 ; nic_models->pdata[i]; i++) {
+                printf("%s\n", (char *)nic_models->pdata[i]);
+            }
             g_ptr_array_free(nic_models, true);
             exit(0);
         }
-- 
2.41.0


