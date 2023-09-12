Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DD79D0BC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2BI-0001GS-OK; Tue, 12 Sep 2023 08:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qg2BF-0001Ey-QT
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qg2BA-0000pS-JG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694520459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=d29cq8t30AkGY6F/sKv63lCp4G5bgRg+h27bd+M4al8=;
 b=DLVebQSz4eJQ6MG76VIraMAx6T9NPmGjPj0SlTk+trEz+DGS8rYNnhpHnKFNUrX7+7gcNF
 Tsb60AL/vwXecNa0muz3uZUQALuUSGE/kT5Jui5cQ4LeFaTkIrlcN4UMOsSvXVQdgz465a
 lbmz8GcehBpEwWLSDfMpmnReDRXo5a8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-q0MtiZmIO3CsVzrn8RlAGw-1; Tue, 12 Sep 2023 08:07:38 -0400
X-MC-Unique: q0MtiZmIO3CsVzrn8RlAGw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c3a2c5a58bso38388565ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694520457; x=1695125257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d29cq8t30AkGY6F/sKv63lCp4G5bgRg+h27bd+M4al8=;
 b=EKtXCJojBbBuuFas6HK2bZpxrcQy8wObSGwIXKsoiaxaC5KWldqVjU0sI7Zj+XQwl2
 k0JPpvyYM0kNhwF5SXoOvubCIrfZYLpMJLIE07vK29jCPP3DEXiuXCY7xe3z5rJ0T+nN
 tE8t4F9YUmu7dRkIGfWEIsWsPLRKiQvwfG8+6b1YTx+fPMjMho4aIG35n4qp3lWgQQxC
 e9pPAFAVuphzQVODg/6wcQHjDZqLu0RYa5p3LvGqzkKJC8r0QaWZlNMLOH73qk6gVNYS
 kwHADBAOqpqn857i6kTcRaJIjtttqMfwqdJo/7j/fBfbix/l9pKw6IiRVZS2+oyvUFOp
 LOAw==
X-Gm-Message-State: AOJu0YwOPxR2omvtvbN6G3iqvrbT7kMTKUWXUmVqBnAfWQCsAlGrH4tN
 KUmg7/OK41DoblqOkfTGeKRn8SFF3D5AXUPsAB8t0uZOGg/2VTozShV5kF1y6+QMQAUs3HhYFuN
 5cNn8lH4AjbnIxSw=
X-Received: by 2002:a17:902:d4c4:b0:1b8:a88c:4dc6 with SMTP id
 o4-20020a170902d4c400b001b8a88c4dc6mr15483763plg.45.1694520457328; 
 Tue, 12 Sep 2023 05:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF34QWMpGeE5xKdCFg/2Xen82Of23R9Qj5xedJeeNMugyNToIu4XmaHxejZKsDQe2PMdLBvbw==
X-Received: by 2002:a17:902:d4c4:b0:1b8:a88c:4dc6 with SMTP id
 o4-20020a170902d4c400b001b8a88c4dc6mr15483735plg.45.1694520457000; 
 Tue, 12 Sep 2023 05:07:37 -0700 (PDT)
Received: from localhost.localdomain ([115.96.158.157])
 by smtp.googlemail.com with ESMTPSA id
 x18-20020a170902821200b001bb9d6b1baasm8275480pln.198.2023.09.12.05.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 05:07:36 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: david@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
Date: Tue, 12 Sep 2023 17:36:50 +0530
Message-Id: <20230912120650.371781-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
guest processor and set phys_bits to 36 if PAE feature is set. This is in
addition to checking the presence of PSE36 CPUID feature for setting 36 bit
phys_bits.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Note: Not sure what tests I should be running in order to make sure I am
not breaking any guest OSes. Usual qtests pass.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 24ee67b42d..f3a5c99117 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
 
-        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
+        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
             cpu->phys_bits = 36;
         } else {
             cpu->phys_bits = 32;
-- 
2.39.1


