Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C34E878EB0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 07:19:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjvSk-00072K-46; Tue, 12 Mar 2024 02:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rjvSg-00071Y-Rh
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:18:07 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rjvSc-0004XQ-UG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 02:18:06 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78863dc4247so118006585a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710224279; x=1710829079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g1w+Bq/HKayQEtXVRZT/0IpFF4Q07xqLAcu8q3O3ps=;
 b=hGcjg/2Xp7ANW66YU1rXijSkClaZibJxEKI/DOLU9ii8k3YsYPhkkEa5NW4lMzltaf
 216h+ctVCzYCltjNvgrZicvWAaGof1MjUE7suQQ50c96y6sfxDynpgY+Rd/UhMz53T4v
 VZYVp7EvGKwC6CeSwE83k1l8dExJ2AfzMrJlLozyryKQ0CBpMQU3tbfBlfj2jTipnIqu
 aP4MwdwFXGZR53z2FOyIBrW/Xlgm9VfKA8LEeb/s5aJAihXe5ncIJlWNjXxFMqNthVNr
 mrQkevlasFMBWUq3fbndbC8ZflB/5oOHYtnwswogWUqW+cdtSa8yhZ6KBMhMkKI1HUaG
 Dz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710224279; x=1710829079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g1w+Bq/HKayQEtXVRZT/0IpFF4Q07xqLAcu8q3O3ps=;
 b=iTbJXd25vfj8NJPKawlfu82VrSKXMGAVQx/IQzj2cOar95NTXzkmZmVXEFoajgvlf6
 Oy7IUlYj9COL0ngRApanwPLxI1uMRqemWboy2Y9rZHiMkjk6pr51bxy19o5aj3qcaEMb
 i2VdLo4JX+MYnFKkVyRqwr9zxxh6V5A7E8FKeUSRbo8SpnWg5zp5LFwSBpKO6fZKkLdH
 s/ki4h6hJ4TdU8u8Y11T0d4JIiDzPe09mkFBeLxeaZL5Qm1sHWXBX5pNEWLkTTILgbpi
 eB9NTVrvYAw6OmjIRnI8WH3zqVfFTL0fAXPA7hODUy3JdKiFE/X38egjST0B2aCkRBxm
 Q53w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFe+AF4D06AgWyjQ+j/RpTMz67fdlfuiVmEG5fhD3uHEIM71VlFj6gqDgyNrrdJNJnasMEGKCZbJsP3G0hRlPq9ewKsL8=
X-Gm-Message-State: AOJu0YyuIhMzIoLh1HiELugssjApe/uRatI6WJbSOslnP5M4Dl7ibTb7
 AZ7qSi6+ki/r3m5H08trGH7I2zua2Wdj+KAdTM+L7AhyqlM8xjaVrDVBpAHZfQw=
X-Google-Smtp-Source: AGHT+IFtueu2hHzThmvc/JKtQbFGEvZGODzMhvBN+JE313AMau+fPRj/Wh1ccpFe+lfa9yfwLLS1Ww==
X-Received: by 2002:a05:620a:15bc:b0:788:70b4:159 with SMTP id
 f28-20020a05620a15bc00b0078870b40159mr4209916qkk.42.1710224279479; 
 Mon, 11 Mar 2024 23:17:59 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.133])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a05620a221200b00787b93d8df1sm3394396qkh.99.2024.03.11.23.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 23:17:59 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Gregory Price" <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, tj@kernel.org, john@jagalactic.com,
 "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
 "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huang Ying <ying.huang@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 1/1] memory tier: acpi/hmat: create CPUless memory tiers
 after obtaining HMAT info
Date: Tue, 12 Mar 2024 06:17:27 +0000
Message-Id: <20240312061729.1997111-2-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240312061729.1997111-1-horenchuang@bytedance.com>
References: <20240312061729.1997111-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=horenchuang@bytedance.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The current implementation treats emulated memory devices, such as
CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
(E820_TYPE_RAM). However, these emulated devices have different
characteristics than traditional DRAM, making it important to
distinguish them. Thus, we modify the tiered memory initialization process
to introduce a delay specifically for CPUless NUMA nodes. This delay
ensures that the memory tier initialization for these nodes is deferred
until HMAT information is obtained during the boot process. Finally,
demotion tables are recalculated at the end.

* Abstract common functions into `find_alloc_memory_type()`
Since different memory devices require finding or allocating a memory type,
these common steps are abstracted into a single function,
`find_alloc_memory_type()`, enhancing code scalability and conciseness.

* Handle cases where there is no HMAT when creating memory tiers
There is a scenario where a CPUless node does not provide HMAT information.
If no HMAT is specified, it falls back to using the default DRAM tier.

* Change adist calculation code to use another new lock, mt_perf_lock.
In the current implementation, iterating through CPUlist nodes requires
holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
trying to acquire the same lock, leading to a potential deadlock.
Therefore, we propose introducing a standalone `mt_perf_lock` to protect
`default_dram_perf`. This approach not only avoids deadlock but also
prevents holding a large lock simultaneously.

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 drivers/acpi/numa/hmat.c     | 11 ++++++
 drivers/dax/kmem.c           | 13 +------
 include/linux/acpi.h         |  6 ++++
 include/linux/memory-tiers.h |  8 +++++
 mm/memory-tiers.c            | 70 +++++++++++++++++++++++++++++++++---
 5 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..28812ec2c793 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -38,6 +38,8 @@ static LIST_HEAD(targets);
 static LIST_HEAD(initiators);
 static LIST_HEAD(localities);
 
+static LIST_HEAD(hmat_memory_types);
+
 static DEFINE_MUTEX(target_lock);
 
 /*
@@ -149,6 +151,12 @@ int acpi_get_genport_coordinates(u32 uid,
 }
 EXPORT_SYMBOL_NS_GPL(acpi_get_genport_coordinates, CXL);
 
+struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
+{
+	return find_alloc_memory_type(adist, &hmat_memory_types);
+}
+EXPORT_SYMBOL_GPL(hmat_find_alloc_memory_type);
+
 static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
@@ -1038,6 +1046,9 @@ static __init int hmat_init(void)
 	if (!hmat_set_default_dram_perf())
 		register_mt_adistance_algorithm(&hmat_adist_nb);
 
+	/* Post-create CPUless memory tiers after getting HMAT info */
+	memory_tier_late_init();
+
 	return 0;
 out_put:
 	hmat_free_structures();
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 42ee360cf4e3..aee17ab59f4f 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
 
 static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
 {
-	bool found = false;
 	struct memory_dev_type *mtype;
 
 	mutex_lock(&kmem_memory_type_lock);
-	list_for_each_entry(mtype, &kmem_memory_types, list) {
-		if (mtype->adistance == adist) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
-		mtype = alloc_memory_type(adist);
-		if (!IS_ERR(mtype))
-			list_add(&mtype->list, &kmem_memory_types);
-	}
+	mtype = find_alloc_memory_type(adist, &kmem_memory_types);
 	mutex_unlock(&kmem_memory_type_lock);
 
 	return mtype;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..3f927ff01f02 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -434,12 +434,18 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 
 #ifdef CONFIG_ACPI_HMAT
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+struct memory_dev_type *hmat_find_alloc_memory_type(int adist);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 69e781900082..4bc2596c5774 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
 int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 			     const char *source);
 int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
+struct memory_dev_type *find_alloc_memory_type(int adist,
+							struct list_head *memory_types);
+void memory_tier_late_init(void);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -136,5 +139,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
 {
 	return -EIO;
 }
+
+static inline void memory_tier_late_init(void)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0537664620e5..79f748d60e6f 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/acpi.h>
 
 #include "internal.h"
 
@@ -35,6 +36,7 @@ struct node_memory_type_map {
 };
 
 static DEFINE_MUTEX(memory_tier_lock);
+static DEFINE_MUTEX(mt_perf_lock);
 static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
@@ -623,6 +625,58 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 }
 EXPORT_SYMBOL_GPL(clear_node_memory_type);
 
+struct memory_dev_type *find_alloc_memory_type(int adist, struct list_head *memory_types)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	list_for_each_entry(mtype, memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, memory_types);
+	}
+
+	return mtype;
+}
+EXPORT_SYMBOL_GPL(find_alloc_memory_type);
+
+static void memory_tier_late_create(int node)
+{
+	struct memory_dev_type *mtype = NULL;
+	int adist = MEMTIER_ADISTANCE_DRAM;
+
+	mt_calc_adistance(node, &adist);
+	if (adist != MEMTIER_ADISTANCE_DRAM) {
+		mtype = hmat_find_alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			__init_node_memory_type(node, mtype);
+		else
+			pr_err("Failed to allocate a memory type at %s()\n", __func__);
+	}
+
+	set_node_memory_tier(node);
+}
+
+void memory_tier_late_init(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	for_each_node_state(nid, N_MEMORY)
+		if (!node_state(nid, N_CPU))
+			memory_tier_late_create(nid);
+
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(memory_tier_late_init);
+
 static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
 {
 	pr_info(
@@ -636,7 +690,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 {
 	int rc = 0;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	if (default_dram_perf_error) {
 		rc = -EIO;
 		goto out;
@@ -684,7 +738,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	}
 
 out:
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 	return rc;
 }
 
@@ -700,7 +754,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 	    perf->read_bandwidth + perf->write_bandwidth == 0)
 		return -EINVAL;
 
-	mutex_lock(&memory_tier_lock);
+	mutex_lock(&mt_perf_lock);
 	/*
 	 * The abstract distance of a memory node is in direct proportion to
 	 * its memory latency (read + write) and inversely proportional to its
@@ -713,7 +767,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
 		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
 		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
 		(perf->read_bandwidth + perf->write_bandwidth);
-	mutex_unlock(&memory_tier_lock);
+	mutex_unlock(&mt_perf_lock);
 
 	return 0;
 }
@@ -836,6 +890,14 @@ static int __init memory_tier_init(void)
 	 * types assigned.
 	 */
 	for_each_node_state(node, N_MEMORY) {
+		if (!node_state(node, N_CPU))
+			/*
+			 * Defer memory tier initialization on CPUless numa nodes.
+			 * These will be initialized when HMAT information is
+			 * available.
+			 */
+			continue;
+
 		memtier = set_node_memory_tier(node);
 		if (IS_ERR(memtier))
 			/*
-- 
Ho-Ren (Jack) Chuang


