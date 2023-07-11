Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A314174E9A4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9DK-0004UJ-SO; Tue, 11 Jul 2023 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJ9DJ-0004U2-Mn; Tue, 11 Jul 2023 04:59:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qJ9DI-0000CQ-1x; Tue, 11 Jul 2023 04:59:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so26971355ad.0; 
 Tue, 11 Jul 2023 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689065952; x=1691657952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fknk+nbSM3+5rqIDMu2hb484hZtt8MIJnjlzR1PGkJE=;
 b=eIERUUPhnOsZ621lRNpjhPnxq94rDpdlZ0N8fbJoT6f8WLVMdFb7pg/wqTGpHffmHv
 Nc+AwHrQITdGSOzFY9BABQuG93b0eLyUyHIYxZhpxL7Fnl/PAC20mF0KHRTbKEltXRV7
 thdRtcqrkOuGZxDchkbANlD3bJZfHahOitKYYth5SZN1sDVJglSyvtwRMEfAdtHrw4mz
 ZXdk0NF3Wde7Zs0xv3n+mR9DF1KNSo7FHOyU+LuI3Bx44XxK/w03bnm2d6jL9ZKdbol8
 meFIhtmhq3tlmp9Es7Mk6P12uqakemDFIsK7FTRJTmObxhxj7KAChYauIXYuAzFYtdY7
 4Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689065952; x=1691657952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fknk+nbSM3+5rqIDMu2hb484hZtt8MIJnjlzR1PGkJE=;
 b=UN5G76Arlz8jdqhunw1tUwIWNEe9psUjHEH10x3YdMAojSYRtybvkkYg7UG9Zdybpb
 MhaiJ9G+Zo7SGgC5N2QNPqKBdLonoycAPcUy4ZzjGZ/LhfWpr/QhcJfMQYeJIqZFX0p5
 jRu+FjgVlrrvy4/fqr84nYDaYq4uqsPHYQatAUscCzl3QQo8jYD+rVpoA0d1RGp1PslZ
 lufhRccQx8fHFFI7GpsIMTif0NNEa6PhNP+zVkRnSG6Th1RgPggwTXiI/5HpeUVD30kz
 lnUcWaxWoHVSnUKQ/iYH6DHY/6eQ+hEGGMYVIo8wStW7Ywu1wlFS+L4SXAUCKalvSmts
 GTzA==
X-Gm-Message-State: ABy/qLZWByWggB4Jolkwh46uHlN7T2epZ0c6daqOZy4rIOy414O/gFA3
 j/x9Z8goosgcPSvBX2SqALz8L1igZuE=
X-Google-Smtp-Source: APBJJlG6Oj2bVl80mpz2w6+fWGMLTo0gTyns/O5GMxQ2I5j9LbFmNSO+jEwgiqPDLpz/pT6pM6XwqA==
X-Received: by 2002:a17:902:ec88:b0:1b7:fef7:d578 with SMTP id
 x8-20020a170902ec8800b001b7fef7d578mr12729803plg.41.1689065952041; 
 Tue, 11 Jul 2023 01:59:12 -0700 (PDT)
Received: from wheely.local0.net ([220.240.231.96])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a170902ed4100b001b7fa81b145sm1305660plb.265.2023.07.11.01.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 01:59:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PATCH] gdbstub: Fix client Ctrl-C handling
Date: Tue, 11 Jul 2023 18:59:03 +1000
Message-Id: <20230711085903.304496-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The gdb remote protocol has a special interrupt character (0x03) that is
transmitted outside the regular packet processing, and represents a
Ctrl-C pressed in the client. Despite not being a regular packet, it
does expect a regular stop response if the stub successfully stops the
running program.

See: https://sourceware.org/gdb/onlinedocs/gdb/Interrupts.html

Inhibiting the stop reply packet can lead to gdb client hang. So permit
a stop response when receiving a character from gdb that stops the vm.
Additionally, add a warning if that was not a 0x03 character, because
the gdb session is likely to end up getting confused if this happens.

Cc: qemu-stable@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Taylor Simpson <tsimpson@quicinc.com>
Reported-by: Frederic Barrat <fbarrat@linux.ibm.com>
Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed to")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hey Fred, I'm not sure if this is the gdb hang you were seeing, but it
is the one I could reproduce. Could be worth checking there are no more
corner case hangs after this.

Thanks,
Nick

 gdbstub/gdbstub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6911b73c07..ce8b42eb15 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
             return;
     }
     if (runstate_is_running()) {
-        /* when the CPU is running, we cannot do anything except stop
-           it when receiving a char */
+        /*
+         * When the CPU is running, we cannot do anything except stop
+         * it when receiving a char. This is expected on a Ctrl-C in the
+         * gdb client. Because we are in all-stop mode, gdb sends a
+         * 0x03 byte which is not a usual packet, so we handle it specially
+         * here, but it does expect a stop reply.
+         */
+        if (ch != 0x03) {
+            warn_report("gdbstub: client sent packet while target running\n");
+        }
+        gdbserver_state.allow_stop_reply = true;
         vm_stop(RUN_STATE_PAUSED);
     } else
 #endif
-- 
2.40.1


