Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472C78F4DC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 23:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbpZV-0008Fb-9l; Thu, 31 Aug 2023 17:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eePwZAsKCjIQcZhcbZSkWgUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--coltonlewis.bounces.google.com>)
 id 1qbmuu-0000L2-JU
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:01:22 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eePwZAsKCjIQcZhcbZSkWgUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--coltonlewis.bounces.google.com>)
 id 1qbmuq-0007CF-Eo
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:01:19 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d74a012e6a6so953513276.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693508474; x=1694113274; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w6Yyv6ujwYagqpF1MJSJZ41XD5zmN9Sx2XGwawvqoDw=;
 b=ELV7e3rqp9k5fvQ3s/XtBKQO/C0lIUFO8/Glo2yxVGCDCLeiMkVgav/x0LXzBjVcBX
 gM4xFa18KjtaiqcNagvlzacq41n1LLZGHgIdLQ4r92dXhkeeDvYnNUu6zq3cJQf5jDX/
 lN+BUyUOixk2LksrbTStxAtg/CcuoWul5ErKuzcC/RYh9++j3v1S/8/hQom4e9IbgOOF
 RGqG2c7sGjDVtVypsX4TGPQPllKPkBov2Gqz++OmIDrgxQlidmSNAjRT4qaWFt/+oBw9
 HDlGujWg2mEZ9no1+ivrX+St2l4q2I8FPaW4ayQUaGwxqPQyg4VW+6mRBK3qI8DQUZyB
 SKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508474; x=1694113274;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6Yyv6ujwYagqpF1MJSJZ41XD5zmN9Sx2XGwawvqoDw=;
 b=MVHUycyVjENqMcxfnOzDbnFdgKNszQh/M2EqkRjGgX1PQG+UrD13+VrjaQyf7FBFyS
 PC+zdtA1bkTrvyPnOSg+6ob0fNAqAYNCC7YzlMrovXpWWy23byC9bZuP7SxW8fj7OxtO
 wtKuC7Wzc+yZ+gWjKGaFIRRUr1YsUZGFievnjeZseb3xzoaHpD9/lVPkB7F2R1D1vi1+
 JggcU6EknYxetAUmj668uaV7UoRF0IoLNdVuOzBhU9FKUNmUFC78otK0AQ+kz/QhOjI8
 iaBalRipjIwYDnjgd1aJfaDxM6On6g1m2/PtX8Wx682X0Z5n97S+xgLJoOHkFweptbYo
 7pvA==
X-Gm-Message-State: AOJu0YyqbRtswhw+D6b/GC1GaYaGsrwhKZRd6EGGbKMPQ7YOsNy2ko6F
 Z9TedAVk1GdBBjDpEh6g+9uNLaP7APm2Ve6vM8X9l0zDhIqcY5j3syeuTDNlmatFgA1/SaRX45x
 Ycnpv4Hi19MQB/KtdiE47eAYmxEL7JUZuYpp49vxhRnpsqQpnlNXcmdeoCNVL//Gy2WfxgZ1bpA
 ==
X-Google-Smtp-Source: AGHT+IFrm46z1+VKEBXajhS2fuBCkEVRUtADiWBUaJPEsNV5LP51XsSIh3ik+2gqnsiJ8Ue1OyrqzsGWmZectdqWXA==
X-Received: from coltonlewis-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:11c9:b0:d20:7752:e384 with
 SMTP id n9-20020a05690211c900b00d207752e384mr16197ybu.3.1693508473694; Thu,
 31 Aug 2023 12:01:13 -0700 (PDT)
Date: Thu, 31 Aug 2023 19:00:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230831190052.129045-1-coltonlewis@google.com>
Subject: [PATCH] arm64: Restore trapless ptimer access
From: Colton Lewis <coltonlewis@google.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 kvm@vger.kernel.org, Andrew Jones <andrew.jones@linux.dev>,
 qemu-trivial@nongnu.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3eePwZAsKCjIQcZhcbZSkWgUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--coltonlewis.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 31 Aug 2023 17:51:21 -0400
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

Due to recent KVM changes, QEMU is setting a ptimer offset resulting
in unintended trap and emulate access and a consequent performance
hit. Filter out the PTIMER_CNT register to restore trapless ptimer
access.

Quoting Andrew Jones:

Simply reading the CNT register and writing back the same value is
enough to set an offset, since the timer will have certainly moved
past whatever value was read by the time it's written.  QEMU
frequently saves and restores all registers in the get-reg-list array,
unless they've been explicitly filtered out (with Linux commit
680232a94c12, KVM_REG_ARM_PTIMER_CNT is now in the array). So, to
restore trapless ptimer accesses, we need a QEMU patch to filter out
the register.

See
https://lore.kernel.org/kvmarm/gsntttsonus5.fsf@coltonlewis-kvm.c.googlers.com/T/#m0770023762a821db2a3f0dd0a7dc6aa54e0d0da9
for additional context.

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 target/arm/kvm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 4d904a1d11..2dd46e0a99 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -672,6 +672,7 @@ typedef struct CPRegStateLevel {
  */
 static const CPRegStateLevel non_runtime_cpregs[] = {
     { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
+    { KVM_REG_ARM_PTIMER_CNT, KVM_PUT_FULL_STATE },
 };
 
 int kvm_arm_cpreg_level(uint64_t regidx)
-- 
2.42.0.283.g2d96d420d3-goog


