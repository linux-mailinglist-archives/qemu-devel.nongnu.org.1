Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2874E1BA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuW-0003uW-4q; Mon, 10 Jul 2023 19:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuS-0003sj-C5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuQ-0004Bc-QN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8By2ZmyapkS1ozV1Uy5Uvrkjg6+zILSxVQCNLRXQ83o=;
 b=hZGO1gyVCAcMCNmPbnZSRMG2z7Kp2KJLyIqWKQxTKYm+VTzq3SEb9/GgvRACDcQ4M2aKKG
 4BecShyNTiPtV2XST8olFBZDef4Pvhp3gVVap7JZ08wBs0O1ZfV7qpKqOwc3YhW/hKzCU9
 7LXcWGOioH6Kfs8DVLuJIKOKutJoYtQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352--SyFSNwAMrKNKnDLl4RwBA-1; Mon, 10 Jul 2023 19:03:09 -0400
X-MC-Unique: -SyFSNwAMrKNKnDLl4RwBA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fa9a282fffso29956065e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030187; x=1691622187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8By2ZmyapkS1ozV1Uy5Uvrkjg6+zILSxVQCNLRXQ83o=;
 b=agQ2f8jalMuAFaZ4JjmQFDix1qcJAc6uPVO2DPZE0oCeeRzAEqHZqrIvGzzmqnTsEt
 +GJYZBzdS9FasT7/0adrihA/Ssolqc6x8FlCGy/52ayhgt3woI9BDYTgZoM9MFi1zKbS
 g9bo7rkbyOZZtmDIIndxsTYnZ9hDeW+eMdzlyDMCv/pQ71ONED7W0fgEFhmVuUa+bNfj
 I/JEjFaLbjijk8bznuKyZp0s6+tQPq6G/AWquApT40ICweLJu4hLa6HrcvobNtwfv2b8
 C1dWaLnpy6nZN4zlcA0LmfZx2qT4mZ+mxtKXcxaCkqbkHi7bPEmqJSl+SW39eCeSmtLX
 AAxQ==
X-Gm-Message-State: ABy/qLYBL3hZEc6BCLDfRmTV4+FiDaxfUl6JmotgvZG8jw5L+ug+gdW8
 LyqRXa/85Pt7Rqe/2daIfLeQZ+NTMORXgBFi9zf7oYx4I2V4Zl3RqjoW2N7hlIuHbP+EBfIxC11
 P9bsq6/JPayT11wanVlI2Sl16vQAFSvKcZqUbDkHPKW35yeNEBh2ako69+fdlOTTezkWT
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr12296991wmj.16.1689030187370; 
 Mon, 10 Jul 2023 16:03:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0xLtqHoIU2smbyj5RjpSC2IK5XLLgd3Z4Hx91R4i5OXuAXZqgzdHOWPAu9S2K+A+4Z4n8MA==
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id
 q14-20020a7bce8e000000b003fb40ec9483mr12296977wmj.16.1689030187034; 
 Mon, 10 Jul 2023 16:03:07 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 24-20020a05600c22d800b003fbaade072dsm938719wmg.23.2023.07.10.16.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:06 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 14/66] hw/smbios: Fix core count in type4
Message-ID: <196ea60a734c346d7d75f1d89aa37703d4d854e7.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

>From SMBIOS 3.0 specification, core count field means:

Core Count is the number of cores detected by the BIOS for this
processor socket. [1]

Before 003f230e37d7 ("machine: Tweak the order of topology members in
struct CpuTopology"), MachineState.smp.cores means "the number of cores
in one package", and it's correct to use smp.cores for core count.

But 003f230e37d7 changes the smp.cores' meaning to "the number of cores
in one die" and doesn't change the original smp.cores' use in smbios as
well, which makes core count in type4 go wrong.

Fix this issue with the correct "cores per socket" caculation.

[1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count

Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-5-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3aae9328c0..10cd22f610 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
     unsigned threads_per_socket;
+    unsigned cores_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -749,8 +750,9 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
     threads_per_socket = machine_topo_get_threads_per_socket(ms);
+    cores_per_socket = machine_topo_get_cores_per_socket(ms);
 
-    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
+    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
     t->core_enabled = t->core_count;
 
     t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
@@ -759,7 +761,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
-        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
+        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
         t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
-- 
MST


