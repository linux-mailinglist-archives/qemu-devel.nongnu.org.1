Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA1C7D1F51
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIEj-0005OO-Q0; Sat, 21 Oct 2023 16:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEi-0005OG-GL
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:06:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEg-0006xx-9v
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:06:16 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso294345066b.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697918772; x=1698523572;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCpmOqx1I8jr4bBASa0Og5iNsiQJYZIhwSMQmZBEF4I=;
 b=TGbvrKUMFTIkP2flW6ue6pzGOdMbLSyy1LGaJ3CCy+l8ounSQ0Ss1FuighrNPVCUkD
 ymYX57EE/aQSDLmNCGs0Q3bclb2y6MrkWfBKZz+qpPHCxLztsRBsDsybW97eEJscB+81
 3veWs0kY9EThTU6cOC0ErX4TgVNDinjNgs8DJZUbtXtgKQPLnmLspv3It4uS8Mgbj/qT
 e/EvSmycN7NyLWtBV0yOONs8/FJryd7eY+AK2E+jj4/4m21nleBF9DPEGn/fX28fENOp
 P30/cGx0HDC32eCLz6j5T24JnxqCNOyB5Uquxw/gLx7CBGFXnyNm8LB0RaVr2PikG1DJ
 vXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697918772; x=1698523572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCpmOqx1I8jr4bBASa0Og5iNsiQJYZIhwSMQmZBEF4I=;
 b=vjlEogq4bbK4PS+ME4iblMA3cSaTt1p2O2W0qvkPIjtXAFMHXpPjAIeeJeHDAt0yNf
 6Urv0LkEy2n3TjNf7g0mZY9Px10RmyO5hv9iM/dTycVcqjmokotRtnjq01KY8VOurV/I
 hoSqWLoFxA6eau8afMVfqvLacIUVE0PrsqKHgNsYyTkXEARKnpBxd9tW8p+ch4ALBZt+
 /36iDDAEbJbdi88sqKgF1dWPpYMTczTIw+gaVcve8nq87VMKAaYKF3KrBN79azRTVIOb
 uayjzppugy4+CgDEjZg6Ha9XCEAaanQDMgELY4m8Y+QU47NquUiPnd+0iBzKRE0GiR23
 llgQ==
X-Gm-Message-State: AOJu0YwgI4p96pYg59XeJ5Q1+6BSH5GrPIRjuY6Ris1NtbybfY0fBOEz
 T2CP7nrR7g9QqdfS9tmqC7RG35ixfF7n6SaEevI=
X-Google-Smtp-Source: AGHT+IFSNwEYulDujmEdEcRDzLYBflM7SNE9W9U7LJvVROOLyHeQtuevRW7bR1yc25d+aTa4+bGSbA==
X-Received: by 2002:a17:907:74a:b0:9be:4bfd:6a6c with SMTP id
 xc10-20020a170907074a00b009be4bfd6a6cmr3805342ejb.41.1697918772687; 
 Sat, 21 Oct 2023 13:06:12 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090617c200b0098ce63e36e9sm4138253eje.16.2023.10.21.13.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 13:06:12 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, roman@roolebo.dev, pbonzini@redhat.com,
 lists@philjordan.eu, phil@philjordan.eu
Subject: [PATCH v2 4/4] i386/hvf: Fixes dirty memory tracking by page
 granularity RX->RWX change
Date: Sat, 21 Oct 2023 22:05:18 +0200
Message-Id: <20231021200518.30125-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231021200518.30125-1-phil@philjordan.eu>
References: <20231021200518.30125-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62b;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

When using x86 macOS Hypervisor.framework as accelerator, detection of
dirty memory regions is implemented by marking logged memory region
slots as read-only in the EPT, then setting the dirty flag when a
guest write causes a fault. The area marked dirty should then be marked
writable in order for subsequent writes to succeed without a VM exit.

However, dirty bits are tracked on a per-page basis, whereas the fault
handler was marking the whole logged memory region as writable. This
change fixes the fault handler so only the protection of the single
faulting page is marked as dirty.

(Note: the dirty page tracking appeared to work despite this error
because HVF’s hv_vcpu_run() function generated unnecessary EPT fault
exits, which ended up causing the dirty marking handler to run even
when the memory region had been marked RW. When using
hv_vcpu_run_until(), a change planned for a subsequent commit, these
spurious exits no longer occur, so dirty memory tracking malfunctions.)

Additionally, the dirty page is set to permit code execution, the same
as all other guest memory; changing memory protection from RX to RW not
RWX appears to have been an oversight.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 43d64574ad..a15ee469c3 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -135,9 +135,10 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
+            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE);
+            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
 
-- 
2.36.1


