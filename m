Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D978BC58
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 03:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qanCS-0006GS-Gz; Mon, 28 Aug 2023 21:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qanCM-0006GI-Li
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 21:07:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qanCK-0004V0-Cw
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 21:07:14 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c1f8aaab9aso5646135ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 18:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693271229; x=1693876029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vIf+0WsGlssEYsaPr9lTeUWdu6kzUzPleCdkCDciof8=;
 b=HlahxHKd3qZLzK+eoqBLkmm5X523aR9PfOhJkxioJCWUrS3OdxOd6ZHVRa2eVOh+Ro
 X9SRG7XCNWzKRUfO6y5fWawIpvlwwIQWggSLdOMlfjFuZ2bcJDUWnY8MN7Xqglmt+R6O
 J7bqEEmFGvX6uLHUILpZ0eMD43SY0vy56bjAJFifcF+KLAKGDd4e88rEGcwN9qsG59LK
 mZyV1zb28a4D3la/S56XPnfjonfCjBFscyYOdI+R2/jZS0FHNsc2jdbTFTxJloZ0C/cC
 dJYwnJRqIP2hNIhHL8yPU+Pq5K4/NIbEjGyC05+L445HlaJg1BrQoBsx4bVgn2XSmn9u
 dSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693271229; x=1693876029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vIf+0WsGlssEYsaPr9lTeUWdu6kzUzPleCdkCDciof8=;
 b=CT8uwnA8ikZ2nYkeW7yfNNGyy3NjBty/a7c3Z5w1I5/XCHMTnfu+CMcAqMf/ocv6lV
 /7mYu/dEDudQjHXA48ghd/U+vHJ6OeoRaCAOHGsGl6HAdp09NHTqylWupM2en0gAx1hD
 GeHXfQA8N5XUp/YNs8czgBkylSbo0tpnZqA1101BiblieW2phjuj8JXFpb4Vl0h547LN
 up9ucbWzU5RMc4RZipJDqBNYT2QkgEqthir0I4XrT7sS+6NAAoOvZxCgsokaMbzjBUpW
 AZGwElbJO+EEpiAWzmTl+38igFTuRquerVI58DF+G0UL9iCoD4FAnNQwtfR1hAlk37HS
 fhew==
X-Gm-Message-State: AOJu0YylrE33fhpu8OQemukHHVN3KmJgI6ou7ghpiEDyzq17CYSRASdK
 FHkK4gcApJP1V/iYPnpWvcc=
X-Google-Smtp-Source: AGHT+IGZ1wuQgwrShMO9Jpc0ioAWyatpZCzhcosbyBC4pG+e3t8LuzbsFnO+//SAEEqrSDeKCX440Q==
X-Received: by 2002:a17:902:d4c9:b0:1b8:a88c:4dc6 with SMTP id
 o9-20020a170902d4c900b001b8a88c4dc6mr33987526plg.45.1693271228702; 
 Mon, 28 Aug 2023 18:07:08 -0700 (PDT)
Received: from wheely.local0.net (121-44-86-215.tpgi.com.au. [121.44.86.215])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170902cecc00b001bf10059251sm7995573plg.239.2023.08.28.18.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 18:07:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ivan Warren <ivan@vmfacility.fr>
Subject: [PATCH] accel/tcg: mttcg remove false-negative halted assertion
Date: Tue, 29 Aug 2023 11:06:58 +1000
Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

mttcg asserts that an execution ending with EXCP_HALTED must have
cpu->halted. However between the event or instruction that sets
cpu->halted and requests exit and the assertion here, an
asynchronous event could clear cpu->halted.

This leads to crashes running AIX on ppc/pseries because it uses
H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted = 1 and
H_PROD sets other cpu->halted = 0 and kicks it.

H_PROD could be turned into an interrupt to wake, but several other
places in ppc, sparc, and semihosting follow what looks like a similar
pattern setting halted = 0 directly. So remove this assertion.

Reported-by: Ivan Warren <ivan@vmfacility.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b276262007..d0b6f288d9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -98,17 +98,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
                 break;
-            case EXCP_HALTED:
-                /*
-                 * during start-up the vCPU is reset and the thread is
-                 * kicked several times. If we don't ensure we go back
-                 * to sleep in the halted state we won't cleanly
-                 * start-up when the vCPU is enabled.
-                 *
-                 * cpu->halted should ensure we sleep in wait_io_event
-                 */
-                g_assert(cpu->halted);
-                break;
             case EXCP_ATOMIC:
                 qemu_mutex_unlock_iothread();
                 cpu_exec_step_atomic(cpu);
-- 
2.40.1


