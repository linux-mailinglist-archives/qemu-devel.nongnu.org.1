Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1397DB585
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:55:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxO1v-0002Wm-Co; Mon, 30 Oct 2023 04:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxO1q-0002WV-Ag
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxO1n-0007mB-L8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698656021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gISEnm6WYjJfz9gSzH2VPnBYqH+lQr4ujRBvlecC/+Q=;
 b=UClB5Y78fs4VIW+9rr1o4rU5LmPyq39TMNOK4oF+TZG7G4/GQUHc/pB+XQ++VFe0XCuUq5
 ocIUUR+Td9tmGO4G2rpnQYVBRQM2xO8BVLutdRDMIwvWXlQmnhY/oI9/+qC2e3o6osOGAF
 BbMcHtjarQIVLrVjsoKU6/34ipFVK/8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-VM3c3chBP4yEYGXZDfElmA-1; Mon, 30 Oct 2023 04:53:38 -0400
X-MC-Unique: VM3c3chBP4yEYGXZDfElmA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A922D85A59D;
 Mon, 30 Oct 2023 08:53:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64716492BFD;
 Mon, 30 Oct 2023 08:53:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6814D21E6A1F; Mon, 30 Oct 2023 09:53:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	richard.henderson@linaro.org,
	eduardo@habkost.net
Subject: [PATCH] MAINTAINERS: Fully cover target/i386/*
Date: Mon, 30 Oct 2023 09:53:36 +0100
Message-ID: <20231030085336.2681386-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Many files in target/i386/ are not covered:

    target/i386/arch_dump.c
    target/i386/arch_memory_mapping.c
    target/i386/cpu-dump.c
    target/i386/cpu-internal.h
    target/i386/cpu-param.h
    target/i386/cpu-qom.h
    target/i386/cpu-sysemu.c
    target/i386/cpu.c
    target/i386/cpu.h
    target/i386/cpuid_register
    target/i386/gdbstub.c
    target/i386/helper.c
    target/i386/helper.h
    target/i386/host-cpu.c
    target/i386/host-cpu.h
    target/i386/machine.c
    target/i386/meson.build
    target/i386/monitor.c
    target/i386/ops_sse.h
    target/i386/svm.h
    target/i386/trace-events
    target/i386/trace.h
    target/i386/xsave_helper.c

Similar files in other target/$t/ are covered by "$t TCG CPUs".  Do
the same here, taking care not to hijack files that are already
covered by other sections.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8d6b140f..60020ac734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -396,6 +396,8 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <richard.henderson@linaro.org>
 M: Eduardo Habkost <eduardo@habkost.net>
 S: Maintained
+F: target/i386/*
+X: target/i386/sev*
 F: target/i386/tcg/
 F: tests/tcg/i386/
 F: tests/tcg/x86_64/
-- 
2.41.0


