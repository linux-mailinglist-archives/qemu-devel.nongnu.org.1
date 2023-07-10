Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE574E1B8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuW-0003za-W9; Mon, 10 Jul 2023 19:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuS-0003tB-VS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzuR-0004Bn-Hc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ankrdrqe8uBDyZbVrO/a93nDhI3+nBuaqJDTmGENhZA=;
 b=Gkz9GGFtYSgPquxboJPwMZvgnTo/TCRPbP/gTkaanA9VwDxCeykeIaqg+hO3+Cf1uBTgvU
 gXNtW3j98W8qp0QtWFwHVzG52XGFq0yVO5pEdBveUv4gwGnOTE1U39FQuaSSDat8Nc+jvU
 r0sHKIjhzVeCMNEVJgDJnKfRrXgR1u8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Uza6_PwZOmyQw2oZu5y8oA-1; Mon, 10 Jul 2023 19:03:06 -0400
X-MC-Unique: Uza6_PwZOmyQw2oZu5y8oA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbab56aac7so29564835e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030184; x=1691622184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ankrdrqe8uBDyZbVrO/a93nDhI3+nBuaqJDTmGENhZA=;
 b=d+wRK2AQAYFdCcSsRdicwYLPbhNx9VkFDT2Ug6dnhIdCV8qU7cKuJoy+l1W7JL4Hfx
 Y1LAi2lXPqrtooI/SMhgGpX8K4Zu7o5xZETJBsFW2cDrAkh+6Cb4XJIqJIUO0GGR4aVk
 pbamlsUvbpc4INxcKvUCsp6Dhfs/2H7wZBzakSDBwi5ZFYyRveO3izTOexHb2jutyFIF
 CqQoeKiqODw4mWLXgJhgUY9yZdsZV2dXJxIRDESTFN+oR7w/udYRFnNn1b/yiU6ht1pc
 gGEsIYzHYnZeCgJprUG0rX8I72JYahQtuhQmAvj5aND5LOV8CraEudZIOA2US70UKhEy
 TGZQ==
X-Gm-Message-State: ABy/qLZtVW9yrAOQp/E0iHo2p+Daz5aEFrGqjaUNoUzEriM10wWlwQQp
 hUQqZpFJt+UlQ5wpOgl9wTXwsM8H4VWpu/B9kBRtSmhQBr7MbEdx08L1JuUCqfotkn+HpCtiTXm
 9E5QheukbbmemrZFE0qCbl9x4YmbFNnlmsQ+GOYcCtCZPGIy4O7PsoH1l2jgcsJNrM//H
X-Received: by 2002:a1c:7204:0:b0:3fa:9767:c816 with SMTP id
 n4-20020a1c7204000000b003fa9767c816mr13024287wmc.39.1689030184726; 
 Mon, 10 Jul 2023 16:03:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHRwitSvNph3vvNBOvYBTEbH/FIplESB2PS4lWC0aygi2kprZsvRs79NHlHAG7hjBb9SEOnlg==
X-Received: by 2002:a1c:7204:0:b0:3fa:9767:c816 with SMTP id
 n4-20020a1c7204000000b003fa9767c816mr13024274wmc.39.1689030184407; 
 Mon, 10 Jul 2023 16:03:04 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 18-20020a05600c025200b003fbca942499sm11337838wmj.14.2023.07.10.16.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:03 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 13/66] hw/smbios: Fix thread count in type4
Message-ID: <7298fd7de5551c4501f54381228458e3c21cab4b.1689030052.git.mst@redhat.com>
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

>From SMBIOS 3.0 specification, thread count field means:

Thread Count is the total number of threads detected by the BIOS for
this processor socket. It is a processor-wide count, not a
thread-per-core count. [1]

So here we should use threads per socket other than threads per core.

[1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count

Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230628135437.1145805-4-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index d67415d44d..3aae9328c0 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
 {
     char sock_str[128];
     size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
+    unsigned threads_per_socket;
 
     if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         tbl_len = SMBIOS_TYPE_4_LEN_V30;
@@ -747,17 +748,19 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
     SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
     SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
 
+    threads_per_socket = machine_topo_get_threads_per_socket(ms);
+
     t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
     t->core_enabled = t->core_count;
 
-    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
+    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
 
     t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
     t->processor_family2 = cpu_to_le16(0x01); /* Other */
 
     if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
         t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
-        t->thread_count2 = cpu_to_le16(ms->smp.threads);
+        t->thread_count2 = cpu_to_le16(threads_per_socket);
     }
 
     SMBIOS_BUILD_TABLE_POST;
-- 
MST


