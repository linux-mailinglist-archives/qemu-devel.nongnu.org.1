Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4A7348B8
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0Ix-0002nl-9O; Sun, 18 Jun 2023 17:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Iv-0002nW-DZ
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0It-0006VO-U0
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgxeCtFMSIiD02O7MZKA8Zu+VBfme7I0NGA2UZarPVQ=;
 b=ewPUg2zIxw+1tufK6WICvMXd1zo6dgGUlx5DRqqPpPndZG8FLRmJv1b/uc/hyAvnsHCY8h
 cJ9FMtMizf8flAMmCER1Zz1nwIRQyPlILP+fo5dWJa6Hmw4OPQyw/DE8MgQ2Z7+U/aHk15
 FpSBKbMftkwHT0e0As6t2hEkvOuFLVQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-jiViesAxPmy4HOdwUCrLLQ-1; Sun, 18 Jun 2023 17:51:21 -0400
X-MC-Unique: jiViesAxPmy4HOdwUCrLLQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-988907e1b15so60644766b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125080; x=1689717080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgxeCtFMSIiD02O7MZKA8Zu+VBfme7I0NGA2UZarPVQ=;
 b=GuDuntrPAR4vEuozjnPHE8zpAaC1rKobURG8PMJpRmfqif6fvkFhON3jUk39m/okbX
 hB1L6EcnBN4jUED9px58pbzeHkIeQyGwvqOOo2i2GU+ifPCV1HTDk6IOItl9buGGlARR
 F6ZJFmxIvJGos9u7SpPI+PjUDrv5LxvsoPtGMKnscubyvFEOYJV4xZQHma16ZOpVGlF5
 HVGc6Qc900Apc9LwK9zjDrhrFd5xXKsFaYxupwUkA07BZz2hqL66nD9+ImLFxGszO74V
 BbcYS9OglGmfW3Nk/HhSqw4fsbbvuMmUsYvnRkxNtRngQKnjPYdtVjrsnksOC6K1/6fz
 p9RA==
X-Gm-Message-State: AC+VfDwxmIJgKdCpmlv3vH6gPid2D7yocbJFHgVNjeqWi9c0Nbd+G9ns
 fcfQb8/TFESVls4HQacfd6Uu0okmO6SVbsW383p+TCPT7+jWAgmUk3WMSz7QYAzwS4qZGSjD9I8
 vnPdPL3553DU1x83A9xSW/4OcC/ySaQ3UJ6ftP2tD+OCDe7s0VEovvpYlDoIzXQKuDc2lPv44Hr
 edig==
X-Received: by 2002:a17:907:8a15:b0:988:acb4:f74 with SMTP id
 sc21-20020a1709078a1500b00988acb40f74mr1027882ejc.34.1687125079812; 
 Sun, 18 Jun 2023 14:51:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ClbIayv+vuXIqlUUyEIzddl/VZ/URgulQ9+Ri3rfoEHiWCq95ItBuGYRKs+HVVYkZ4LwM7A==
X-Received: by 2002:a17:907:8a15:b0:988:acb4:f74 with SMTP id
 sc21-20020a1709078a1500b00988acb40f74mr1027869ejc.34.1687125079480; 
 Sun, 18 Jun 2023 14:51:19 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a170906379900b00977cc473b41sm13985984ejc.142.2023.06.18.14.51.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/i386: fix INVD vmexit
Date: Sun, 18 Jun 2023 23:51:08 +0200
Message-Id: <20230618215114.107337-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Due to a typo or perhaps a brain fart, the INVD vmexit was never generated.
Fix it (but not that fixing just the typo would break both INVD and WBINVD,
due to a case of two wrongs making a right).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 5cf14311a60..9783fe80a30 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6119,7 +6119,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x108: /* invd */
     case 0x109: /* wbinvd */
         if (check_cpl0(s)) {
-            gen_svm_check_intercept(s, (b & 2) ? SVM_EXIT_INVD : SVM_EXIT_WBINVD);
+            gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
         }
         break;
-- 
2.40.1


