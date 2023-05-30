Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83610716136
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z9S-0004tt-Lj; Tue, 30 May 2023 09:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z9I-0004MH-N0; Tue, 30 May 2023 09:12:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3z9G-0004QQ-GL; Tue, 30 May 2023 09:12:27 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64f47448aeaso3206888b3a.0; 
 Tue, 30 May 2023 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685452344; x=1688044344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R6Fe9x97hEqw5QBCZS01HGEHoTDqD1DWVgjBpUt1stg=;
 b=Ahl0bdQoHOnXR8idb6cSSkNsdyfUeD9OGp6NYugSnMBDHpOx94qvVeMfiiKKytHrX4
 B6DuLPRTqBjv0lSN3aCshQfrK35Co6RiiR2QT4lHqW3WZaf1z/epbBt8iSn6wx9h1Jie
 jwH5NhnPWey+XQi85ylh+qqvJnqgZSTQjhOYc8byBrzHQBvpk2z/wF81m9j+QdwY0Srh
 miBxZncgO9C0o75Z8WZrocgCq+t9ebe+q/7QAL07VsVNkoLXbSeg1EjJgaFcHCxR+1IC
 ebVHbXwqYg7w8xj5MxhDgCfigVc2HI0tO2UQtqxsRwqzrwIcQVxY/C6v8Ejpc8k903dz
 G9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452344; x=1688044344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6Fe9x97hEqw5QBCZS01HGEHoTDqD1DWVgjBpUt1stg=;
 b=bSWtApt82DO0x42zZU+2TueR83f0Fs8Qhgv3AnAjKrSiC4VjOUut82ac+m1rQJXk0q
 n+otQMcmvGT3E7U2fwTTzuTP4NTAlhGdvdFHOQJpEbyRSCOtvd7HOcH9YgGohFf9ZuHv
 NykNDP3/65OdRlVtL9FCjf/0UoDkpZZq1SEeS3CBQSxKZxVSQK4crOp5BFlxxzGtMSmt
 1QnWpi2hMefTeTyT10ps3ey6j9haaMo9czKGAx1hkuEFY3l6hwYYdeHM8WB5e2LJstL3
 pwgmhkqvxbHv0vSnWSFNPXCRYUp3E19NoP4SRUpuF3iE5Oe8HlTpzaoklsvQZdVeXm2d
 suKg==
X-Gm-Message-State: AC+VfDwHhPNLbxpdXvGrb6fry3+u+BtQRtSnNIBy2e9f2e8VQHZIlJ3x
 gyxDELKBjWY1eL/SqvuuucxA4mP2PfI=
X-Google-Smtp-Source: ACHHUZ4COggjRiGZqgbJY3Yqw0Tud/IRFBCLtEQ7E7Lnn07Om+YhiA57MvrZVqfc7HQF+EUdvRAPWQ==
X-Received: by 2002:a05:6a21:32a2:b0:10d:12a8:c95b with SMTP id
 yt34-20020a056a2132a200b0010d12a8c95bmr2822640pzb.0.1685452343677; 
 Tue, 30 May 2023 06:12:23 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a6567d7000000b0050a0227a4bcsm7904796pgs.57.2023.05.30.06.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:12:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
Subject: [PATCH v1 1/2] target/ppc: Fix decrementer time underflow and
 infinite timer loop
Date: Tue, 30 May 2023 23:12:12 +1000
Message-Id: <20230530131214.373524-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

It is possible to store a very large value to the decrementer that it
does not raise the decrementer exception so the timer is scheduled, but
the next time value wraps and is treated as in the past.

This can occur if (u64)-1 is stored on a zero-triggered exception, or
(u64)-1 is stored twice on an underflow-triggered exception, for
example.

If such a value is set in DECAR, it gets stored to the decrementer by
the timer function, which then immediately causes another timer, which
hangs QEMU.

Clamp the decrementer to the implemented width, and use that as the
value for the timer calculation, effectively preventing this overflow.

Reported-by: sdicaro@DDCI.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
sdicaro@DDCI.com debugged and reported this, I just changed their fix
to extract variable bits so it works with large decrementer. So most
of the credit goes to them.

Thanks,
Nick

 hw/ppc/ppc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 4e816c68c7..d80b0adc6c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -798,6 +798,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     int64_t signed_decr;
 
     /* Truncate value to decr_width and sign extend for simplicity */
+    value = extract64(value, 0, nr_bits);
+    decr = extract64(decr, 0, nr_bits);
     signed_value = sextract64(value, 0, nr_bits);
     signed_decr = sextract64(decr, 0, nr_bits);
 
-- 
2.40.1


