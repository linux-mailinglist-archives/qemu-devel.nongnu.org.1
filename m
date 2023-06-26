Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3473E41D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDogA-0006bu-Rf; Mon, 26 Jun 2023 12:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofk-00065B-5P
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qDofg-0007uz-NX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=507dWzn7znTKw0qDssORtUAXEkOINch+e5SE37J0GBw=;
 b=W+Gek4rMo5h+CAUTOXwet/uQY/Ewfvi0j3XsTyQ3gBvr1AaoybbFt+aI7jTsOTFexD2LCV
 MiBCxkSKOYWjt5Gds7XTMzz3u1uf/8cuUrdal1/A2vVnGJNhpe2VbUf1+PXzs5aSmBOaEO
 0W1+2ZPd5nxMVieBDLVCit9DbKjjVrY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-7t1i9_-fO4meUMiXDK_zKQ-1; Mon, 26 Jun 2023 12:02:17 -0400
X-MC-Unique: 7t1i9_-fO4meUMiXDK_zKQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-54ff478ab88so1189995a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795332; x=1690387332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=507dWzn7znTKw0qDssORtUAXEkOINch+e5SE37J0GBw=;
 b=bvDjaADfCK/ef4OjO0jYJkyrUvBnfuQfFOelMBIrwrztwVOfY8PSmwiAFGoPnFDUXr
 dp3yDEUnqWpXiU6Di52dqAIqzbwZFA8mS8+qJnEuOspOqvmOymGJlffNfKGDo5OBIzCX
 DeH3SwPOsx8XRIV8E8/X/fbS6UH9Ny/s3aeZkAb+Y6BizhRpxvVPSH21MLNxzSUf47o8
 xd+ruXfaaMO9dhAklozH3OJ6rN+xM8+hjJJAKhs25uIot/1DPJ+Dhk4PIV4on/IMu71h
 /wi6saJ0wyWEjXWBBYQs/DZMAFegO8PltYgyL3A5fFxzOYufVGZaMxbVJsiHs/SmJeXQ
 Qo5g==
X-Gm-Message-State: AC+VfDxtBsGQEG0iyk3HE9z5fwYX9htg0g/I7ORLtyNHB21Dy8DRQZOw
 8gVtqD/mekudQMLIr664gp6OWa7zD5J+v3FFs3pSCeUAIHKpT3+OGX7nTiEJ1KRAMfj0tjIiNaU
 y1e4lLC4YrB7OdJl3OORSB5GHE8M5H4Kve8F2Thfy6hD+IDuJvazYJeEY0sSR+wtn3yJg91WkXN
 U=
X-Received: by 2002:a05:6a20:431f:b0:125:aeeb:f8f1 with SMTP id
 h31-20020a056a20431f00b00125aeebf8f1mr6027933pzk.40.1687795332048; 
 Mon, 26 Jun 2023 09:02:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FlBul825z3wb960/f0Z3fOQe5uUD3gOJ6lVcMLkq+1EazPPdxTSOEYVYV3v/ZyYYzIClX0g==
X-Received: by 2002:a05:6a20:431f:b0:125:aeeb:f8f1 with SMTP id
 h31-20020a056a20431f00b00125aeebf8f1mr6027907pzk.40.1687795331642; 
 Mon, 26 Jun 2023 09:02:11 -0700 (PDT)
Received: from localhost.localdomain ([115.96.139.77])
 by smtp.googlemail.com with ESMTPSA id
 l23-20020a62be17000000b0065ebeb9bb23sm4120174pff.149.2023.06.26.09.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:02:11 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 1/5] Revert "cputlb: Restrict SavedIOTLB to system
 emulation"
Date: Mon, 26 Jun 2023 21:31:52 +0530
Message-Id: <20230626160156.3938-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230626160156.3938-1-anisinha@redhat.com>
References: <20230626160156.3938-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

This reverts commit d7ee93e24359703debf4137f4cc632563aa4e8d1.

That commit tries to make a field in the CPUState struct not be
present when CONFIG_USER_ONLY is set.  Unfortunately, you can't
conditionally omit fields in structs like this based on ifdefs that
are set per-target.  If you try it, then code in files compiled
per-target (where CONFIG_USER_ONLY is or can be set) will disagree
about the struct layout with files that are compiled once-only (where
this kind of ifdef is never set).

This manifests specifically in 'make check-tcg' failing, because code
in cpus-common.c that sets up the CPUState::cpu_index field puts it
at a different offset from the code in plugins/core.c in
qemu_plugin_vcpu_init_hook() which reads the cpu_index field.  The
latter then hits an assert because from its point of view every
thread has a 0 cpu_index. There might be other weird behaviour too.

Mostly we catch this kind of bug because the CONFIG_whatever is
listed in include/exec/poison.h and so the reference to it in
build-once source files will then cause a compiler error.
Unfortunately CONFIG_USER_ONLY is an exception to that: we have some
places where we use it in "safe" ways in headers that will be seen by
once-only source files (e.g.  ifdeffing out function prototypes) and
it would be a lot of refactoring to be able to get to a position
where we could poison it.  This leaves us in a "you have to be
careful to walk around the bear trap" situation...

Fixes: d7ee93e243597 ("cputlb: Restrict SavedIOTLB to system emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230620175712.1331625-1-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ee8d6b40b3..4871ad85f0 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -226,7 +226,7 @@ struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
-#if defined(CONFIG_PLUGIN) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_PLUGIN
 /*
  * For plugins we sometime need to save the resolved iotlb data before
  * the memory regions get moved around  by io_writex.
@@ -410,11 +410,9 @@ struct CPUState {
 
 #ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
-#if !defined(CONFIG_USER_ONLY)
     /* saved iotlb data from io_writex */
     SavedIOTLB saved_iotlb;
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_PLUGIN */
+#endif
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-- 
2.39.1


