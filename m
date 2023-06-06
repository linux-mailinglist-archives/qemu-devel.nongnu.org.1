Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705BC7236FD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Pgk-0004v6-Ln; Tue, 06 Jun 2023 01:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgi-0004ui-W3
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6Pgh-0004D5-FU
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4VWB/QIRuKBo2P+IdJiLWtR4YzapCXGmuLXjtj1eBc=;
 b=R5qdofAJaDFsCDDso3ezXrtNEcmjWHbQ6RG/DcNZaiRXIwNOC1a2hmIg99XLf2WOrTNWiy
 MaFSs5e8TOJGPf1y0YZO3JEX8+2srbnoV+0dfcktQxnHGns5608j6GjXnbWsiE3IxCtQm5
 1Mwuq7u589hnc1EjB3LpbtLzi6WiSEk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-q9sgLEW3N_a8AYByp_YOng-1; Tue, 06 Jun 2023 01:56:51 -0400
X-MC-Unique: q9sgLEW3N_a8AYByp_YOng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D32453C025D8;
 Tue,  6 Jun 2023 05:56:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1CF92166B25;
 Tue,  6 Jun 2023 05:56:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 17/18] linux-user/elfload: Introduce elf_hwcap_str() on s390x
Date: Tue,  6 Jun 2023 07:56:20 +0200
Message-Id: <20230606055621.523175-18-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

It is required for implementing /proc/cpuinfo emulation.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230605113950.1169228-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/loader.h  |  1 +
 linux-user/elfload.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index ad6ca9dbe3..59cbeacf24 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -58,6 +58,7 @@ extern unsigned long guest_stack_size;
 
 #ifdef TARGET_S390X
 uint32_t get_elf_hwcap(void);
+const char *elf_hwcap_str(uint32_t bit);
 #endif
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 49ec9ccc94..d80d68484b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1605,6 +1605,33 @@ uint32_t get_elf_hwcap(void)
     return hwcap;
 }
 
+const char *elf_hwcap_str(uint32_t bit)
+{
+    static const char *hwcap_str[] = {
+        [HWCAP_S390_ESAN3]     = "esan3",
+        [HWCAP_S390_ZARCH]     = "zarch",
+        [HWCAP_S390_STFLE]     = "stfle",
+        [HWCAP_S390_MSA]       = "msa",
+        [HWCAP_S390_LDISP]     = "ldisp",
+        [HWCAP_S390_EIMM]      = "eimm",
+        [HWCAP_S390_DFP]       = "dfp",
+        [HWCAP_S390_HPAGE]     = "edat",
+        [HWCAP_S390_ETF3EH]    = "etf3eh",
+        [HWCAP_S390_HIGH_GPRS] = "highgprs",
+        [HWCAP_S390_TE]        = "te",
+        [HWCAP_S390_VXRS]      = "vx",
+        [HWCAP_S390_VXRS_BCD]  = "vxd",
+        [HWCAP_S390_VXRS_EXT]  = "vxe",
+        [HWCAP_S390_GS]        = "gs",
+        [HWCAP_S390_VXRS_EXT2] = "vxe2",
+        [HWCAP_S390_VXRS_PDE]  = "vxp",
+        [HWCAP_S390_SORT]      = "sort",
+        [HWCAP_S390_DFLT]      = "dflt",
+    };
+
+    return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
+}
+
 static inline void init_thread(struct target_pt_regs *regs, struct image_info *infop)
 {
     regs->psw.addr = infop->entry;
-- 
2.31.1


