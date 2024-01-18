Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A8831C16
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU26-0002ww-SS; Thu, 18 Jan 2024 10:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0B-0000BQ-1l; Thu, 18 Jan 2024 10:08:21 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU09-00088p-1R; Thu, 18 Jan 2024 10:08:18 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d542701796so72054445ad.1; 
 Thu, 18 Jan 2024 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590495; x=1706195295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH7VWjQz/3wxOiP6K+9y/bLbtKHHaMcLKtq7W5EtwIE=;
 b=JmZ/ldpUG5T1LsiSSwyzysx8cnYq0+XN/a86G3D63baLeqDo8Jqi6GjN0nrnPhQH1z
 fcBhm9+1HZEMHxtfWuoqQNrQ4PvVXvpDM7QLLxPpTKA+Bh7z6P3Q64u3DPNOTpS9IS33
 jkido795yqF0ixbXiGuUc6Ez5dnFEg/xGm6XiIBn2SnJl8EorVXclo+X/c2wHrBJPId6
 d3vcWN1fN68EmI2PVridHl8i3IBqcYNikKAugmzMiSHMuh+ehclXCGHteZS/o3SQUINK
 XIA2hWR2wBUvfpMl7nh81qwRHUl7hVWX7kNAtLM49E9/1JmS1BxpjlImHiLqmqb0ougf
 67eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590495; x=1706195295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HH7VWjQz/3wxOiP6K+9y/bLbtKHHaMcLKtq7W5EtwIE=;
 b=aEf86S8G4/X0XX2ORXeb87CiTq6NEP98xZvsZLXepnF/JNEcqOqhvzCaQ8RL+lMjP7
 ycRV6T3OgKfqhBUSxfUhLgDV3kMauCRk8JDSgx4QHgW+JrN68CwhSINuBE47IpYINIGH
 ik2WcSh//ulcwfI8u9dWtwhkJuJLEoZVCH9ux1eYZz7y/a8Y2gZ4uFepAakQsmmq/I5D
 NFtlLUYu+wxsBGwQLE1a3LxTdHS9kUURPz3GINeqX7Tas8EMEVGmCfgz2MJhfpfiQH+T
 l05htk3T/HEZS0FBzYA2RHhm/zGdlO99VGo8Xy2lEHSN5LZsCBhLACpXJXu3htMEFZwb
 v48w==
X-Gm-Message-State: AOJu0YzqTFHvlOtdpwryyn0P3WtLW2Rp6g8kG1Sd1qgGCrrzFmyVs4Zy
 Z/EctVj/M+Tv6ZaHbp2L7AABrP7V8J3MABNLCMV4XMU7roLIRCvjXJMUi3qP
X-Google-Smtp-Source: AGHT+IGkVZQ41m9Fq8Ghs8LdENDlP7/+rUjdguDDvPuIkNyeLLieGfDyNPE439sTSl+hiP+IG7w3Mg==
X-Received: by 2002:a17:903:249:b0:1d5:e85e:816e with SMTP id
 j9-20020a170903024900b001d5e85e816emr864371plh.10.1705590494919; 
 Thu, 18 Jan 2024 07:08:14 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 17/26] target/ppc: Add migration support for BHRB
Date: Fri, 19 Jan 2024 01:06:35 +1000
Message-ID: <20240118150644.177371-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds migration support for Branch History Rolling
Buffer (BHRB) internal state.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/machine.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 6b6c31d903..731dd8df35 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -711,6 +711,26 @@ static const VMStateDescription vmstate_reservation = {
     }
 };
 
+#ifdef TARGET_PPC64
+static bool bhrb_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+    return (cpu->env.flags & POWERPC_FLAG_BHRB) != 0;
+}
+
+static const VMStateDescription vmstate_bhrb = {
+    .name = "cpu/bhrb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = bhrb_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
+        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -756,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
 #ifdef TARGET_PPC64
         &vmstate_tm,
         &vmstate_slb,
+        &vmstate_bhrb,
 #endif /* TARGET_PPC64 */
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
-- 
2.42.0


