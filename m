Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FB7DE2F0
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 16:24:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyD3y-00079z-BE; Wed, 01 Nov 2023 11:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qyD3w-00079k-7M
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:23:20 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qyD3u-0002DR-2Y
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=ievKdOSEwHc6yHmJXLe7XGpxPPo1RRS2AedqGTIMVk4=; b=jBDuyrY+sbfy
 bzkRaWYatDrVd9Q0gqTssNe5snW1vETiQ6ZxcS7VaTTtODO33scbHa//p+jEY/nwRHTTgw7yoEDCC
 ycrjqzJUlO6LOlkMakTeie7CHDAx2jE25l26klJlPuXB6V2Ab7KddJz3T6rrP2wrC7uSyREOdepB/
 FaQ15RTN5y6+JEvKOXKHwtEjnPKJFxB0RSbCb7IfHDhAaid3T2EC2Yc4Psp/h+irbXuoVSlXmbHhM
 ZbdPzan5LI0nroLJ5eMk3sm5snLf1lRMP7FZ3FamCYYqrh2XJq5yXB3h3avo9Dho0HS+BswZSYtic
 Wi5+yGgffZR10ftoCGrRSQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qyD3D-00CdA9-12;
 Wed, 01 Nov 2023 16:23:01 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	andrey.drobyshev@virtuozzo.com,
	den@openvz.org
Subject: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM exit
Date: Wed,  1 Nov 2023 17:23:11 +0200
Message-Id: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
exit.  That's a natural thing to do since in this case guest is no
longer operational anyway.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Denis V. Lunev <den@virtuozzo.com>
---
 accel/kvm/kvm-all.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..d74b3f0b0e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+static void kvm_emit_guest_crash(CPUState *cpu)
+{
+    kvm_cpu_synchronize_state(cpu);
+    qemu_mutex_lock_iothread();
+    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+    qemu_mutex_unlock_iothread();
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             case KVM_SYSTEM_EVENT_CRASH:
-                kvm_cpu_synchronize_state(cpu);
-                qemu_mutex_lock_iothread();
-                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
-                qemu_mutex_unlock_iothread();
+                kvm_emit_guest_crash(cpu);
                 ret = 0;
                 break;
             default:
                 DPRINTF("kvm_arch_handle_exit\n");
                 ret = kvm_arch_handle_exit(cpu, run);
+                if (ret < 0) {
+                    kvm_emit_guest_crash(cpu);
+                }
                 break;
             }
             break;
         default:
             DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
+            if (ret < 0) {
+                kvm_emit_guest_crash(cpu);
+            }
             break;
         }
     } while (ret == 0);
-- 
2.39.3


