Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B67870F7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZApw-0007ma-93; Thu, 24 Aug 2023 09:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZApu-0007m7-Hf
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZAps-0001pD-7c
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692885439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqNKQmFppXW4awMh/9Wa6mJu0b6j9MR8qmi3KxIN/o4=;
 b=gNsr6dTHQNnPAQ3dB0NO1HDiZ8/9sjlKj+Qii7IalaFUgNGgCyMwx6MH2SptsKTTcg/g9i
 Jp3kPSWVzsIWZ7CQw4Jxp45v91CDA9bLOj2cQJhj4o2tT6aHefM7TR6m7RvV8mtsUS8ljL
 aI48F/gXcpdNFa6CnYkw3TRN91unjD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-L32FbP3vN36S7f7hjOBdDg-1; Thu, 24 Aug 2023 09:57:14 -0400
X-MC-Unique: L32FbP3vN36S7f7hjOBdDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 450BB1161A62
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 13:57:14 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE676B2B6;
 Thu, 24 Aug 2023 13:57:13 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 3/3] target/i386: Fix duplicated feature name in FEAT_KVM
Date: Thu, 24 Aug 2023 15:57:10 +0200
Message-Id: <20230824135710.343175-4-twiederh@redhat.com>
In-Reply-To: <20230824135710.343175-1-twiederh@redhat.com>
References: <20230824135710.343175-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The mistake became apparent as there were two features with the same name
in this cpuid leaf. The names are now in line with the documentation from
https://kernel.org/doc/html/latest/virt/kvm/x86/cpuid.html

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b74d80371..ceb291f8a8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -852,7 +852,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_KVM] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
+            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
             NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
             "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",
-- 
2.39.2


