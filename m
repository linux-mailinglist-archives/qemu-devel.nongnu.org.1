Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80D7AEA8D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:39:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Sz-0006C0-LP; Tue, 26 Sep 2023 06:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Su-00060K-CS; Tue, 26 Sep 2023 06:38:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Ss-00020o-FN; Tue, 26 Sep 2023 06:38:52 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvx5V3z5Pz6K8jp;
 Tue, 26 Sep 2023 18:37:34 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:38:30 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 36/37] tcg/mttcg: enable threads to unregister in
 tcg_ctxs[]
Date: Tue, 26 Sep 2023 11:36:53 +0100
Message-ID: <20230926103654.34424-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926103654.34424-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Miguel Luis <miguel.luis@oracle.com>

[This patch is just for reference. It has problems as it does not takes care of
the TranslationBlocks and their assigned regions during CPU unrealize]

When using TCG acceleration in a multi-threaded context each vCPU has its own
thread registered in tcg_ctxs[] upon creation and tcg_cur_ctxs stores the current
number of threads that got created. Although, the lack of a mechanism to
unregister these threads is a problem when exercising vCPU hotplug/unplug
due to the fact that tcg_cur_ctxs gets incremented everytime a vCPU gets
hotplugged but never gets decremented everytime a vCPU gets unplugged, therefore
breaking the assert stating tcg_cur_ctxs < tcg_max_ctxs after a certain amount
of vCPU hotplugs.

Suggested-by: Salil Mehta <salil.mehta@huawei.com>
[SM: Check Things To Do Section, https://lore.kernel.org/all/20200613213629.21984-1-salil.mehta@huawei.com/]
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c |  1 +
 include/tcg/tcg.h               |  1 +
 tcg/tcg.c                       | 23 +++++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b276262007..5cf9747ef2 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -127,6 +127,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_mutex_unlock_iothread();
     rcu_remove_force_rcu_notifier(&force_rcu.notifier);
     rcu_unregister_thread();
+    tcg_unregister_thread();
     return NULL;
 }
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..6c1cd2a618 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -785,6 +785,7 @@ static inline void *tcg_malloc(int size)
 
 void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
 void tcg_register_thread(void);
+void tcg_unregister_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddfe9a96cb..6760f40823 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -742,6 +742,14 @@ static void alloc_tcg_plugin_context(TCGContext *s)
 #endif
 }
 
+static void free_tcg_plugin_context(TCGContext *s)
+{
+#ifdef CONFIG_PLUGIN
+    g_ptr_array_unref(s->plugin_tb->insns);
+    g_free(s->plugin_tb);
+#endif
+}
+
 /*
  * All TCG threads except the parent (i.e. the one that called tcg_context_init
  * and registered the target's TCG globals) must register with this function
@@ -791,6 +799,21 @@ void tcg_register_thread(void)
 
     tcg_ctx = s;
 }
+
+void tcg_unregister_thread(void)
+{
+    TCGContext *s = tcg_ctx;
+    unsigned int n;
+
+    /* Unclaim an entry in tcg_ctxs */
+    n = qatomic_fetch_dec(&tcg_cur_ctxs);
+    g_assert(n > 1);
+    qatomic_store_release(&tcg_ctxs[n - 1], 0);
+
+    free_tcg_plugin_context(s);
+
+    g_free(s);
+}
 #endif /* !CONFIG_USER_ONLY */
 
 /* pool based memory allocation */
-- 
2.34.1


