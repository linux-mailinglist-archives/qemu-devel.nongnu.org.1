Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91A72F1A1
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FD9-0006Jn-4V; Tue, 13 Jun 2023 21:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FD3-000658-Pr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:06 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FD2-0004ht-9K
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:05 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-651e298be3fso6515668b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705723; x=1689297723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkCQSgruRPMPZjZF+1icp4EFQaXk9PWIhAOrbc5ldxM=;
 b=h+tMUQiCU3SE3K0pl3N1/i7QeA+He4SWhikyMeijm+ZgpK72+3TC+n/pfni5e3IMp+
 XzpMqsHbXvtbn2Ego03zjwns4K0lvghIqG2Sffph5Fek240v5jGwmphSmgJU8yV+aqOA
 fdBuShbr0k9Ksl42oAorgecJrOOrvfaMHx5+TNoQDvW3yGfHhZO2LOH4fRgNg3ShsJvm
 Ge8dqt5veiuOFiR0PiyriTNppwF4PXPeWjGN7S0RM95sfU0khJtqUIjUrxtDc4KPmRqT
 yvFmBe26AOhmkUnpLcb4I+AKauR/FlowiHlawikliOL07gMmWzdNDMLv/vxClWxn++Uo
 4QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705723; x=1689297723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkCQSgruRPMPZjZF+1icp4EFQaXk9PWIhAOrbc5ldxM=;
 b=QwSG+CK9ABnuZN5Bp8jPfr1BqiH8n5ZJOXzVqzdIP+6tEUK95Z3bVykjdIh15RC2Yw
 p4iai2ogD+UJ7fhzdXxyTgdDlH4eqMbpmgI+I0yh88mvPB8kDYudT19GsRVp5OLnvQrz
 HUZIT/tEzF4QnojGLkz0zGoF8DALqarlvoE0JKULJPDlsjBOQZawDmUNmIYOiXAQdj8H
 1yBOPw+T8mYX0IBYagp5ry3eW/GrevKJTDmtnu1gPhAaj82aJlwswGJ3nngw6VQJkB1/
 dbSmd74lz5toDMV4pldAGYstuIeESFOsoZSdRrL4XPMybuMbQxLvvd/AozoJZlnyPibu
 tuNQ==
X-Gm-Message-State: AC+VfDxbj85QxFlNlLEvIZRlXpEGQ+i75sXAQJm8M4Q4eLFsYYzDB6AA
 xG7Bel1ORy7SI+k+zIep9+AkRJfdSmVYeg==
X-Google-Smtp-Source: ACHHUZ4ikCjcWBiOVkS4aDzK2aYoUIkYJBQ/UFjWVUonr4nmNoPv2mb1uU73+65hVHz3eheyXg/eKw==
X-Received: by 2002:a05:6a20:7287:b0:11d:2b0c:7f32 with SMTP id
 o7-20020a056a20728700b0011d2b0c7f32mr608910pzk.13.1686705722762; 
 Tue, 13 Jun 2023 18:22:02 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 22/60] target/riscv: Flush TLB when pmpaddr is updated
Date: Wed, 14 Jun 2023 11:19:39 +1000
Message-Id: <20230614012017.3100663-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

TLB should be flushed not only for pmpcfg csr changes, but also for
pmpaddr csr changes.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230517091519.34439-10-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 48a3e44a77..e0acee7a15 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -531,6 +531,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
             if (is_next_cfg_tor) {
                 pmp_update_rule_addr(env, addr_index + 1);
             }
+            tlb_flush(env_cpu(env));
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpaddr write - locked\n");
-- 
2.40.1


