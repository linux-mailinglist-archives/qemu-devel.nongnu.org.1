Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DCC72F19C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FBw-0004Zk-6p; Tue, 13 Jun 2023 21:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBu-0004ZN-6h
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:54 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBs-0004TH-Kr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:53 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-75d5051fad3so152744185a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705651; x=1689297651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhXXXBp7CgQLQ1kknbAQ6A0yJaRd6FkxFDrTfEloXtk=;
 b=dFz7ziMMg6vfFLrYnS3in5nXx6UJNZ7ddbdoB5lGLPA2PyZe2v9JRsbsXRzOQGJy7J
 NPJLMJ4Ei3z9cUe3oQSBC6UofAkUm0uv4FQEyEQhxtSL2kWLEpqUIH8MbaK2T/4mvtal
 f2XL18a3l9YtzdGgit+dAVQ1lTEEjt8J/IqxSnlx3rB5nD3OSg6j/xdbCf8xakvk+GRV
 3L46nEIU6IdbmxMTdJ6+5MBZpux1E7Tt0roZqSLkvvwPGjnTd0tsaUwyp1eiF0umSycP
 VXSjqpXrwJooOf7v3SoggSW9v/QcGS8zrSlyWpnk7j7lkIRDOPZDpfJOmROjJe5+hf6p
 jiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705651; x=1689297651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhXXXBp7CgQLQ1kknbAQ6A0yJaRd6FkxFDrTfEloXtk=;
 b=hwiLeLho6m60k016N2Wqct8bKvGwWsuwqyx6D9WgfKB3YKnM7Wk3iW6kPcY2zY+Xmn
 T3KFj0zH49zLFTBpyd+/ve9wnOs308TA6K8C5l1PU/Vj3R578BbZUoUjXKvSKMwf4UHy
 o1qLw5jHByeewRPKpvKEIcPHMoK3tfPF6iMLgwXUzW2woGoFvRyB5X5C8s/CzgLnN/9o
 XsdG9XUivS80pjb2PoDb4u5q6RHvQyubdh5LZGn2p/FVGr3efPH1wh2C3EBz2iGojHuj
 vRA7I3OgyyFS8AwjkVKjF4qp0mVQnpP2xWJRnhbrkhld4Lpj3ZfeMDbXGrb8eAqask2r
 NRBw==
X-Gm-Message-State: AC+VfDzUpsX5ROoIGmifVF/7utAav4c8zdJPp57UhVRxXTRb025hYZH8
 QjGrzlDPzeOifLE9UkLndcTlTq1wyfNsRw==
X-Google-Smtp-Source: ACHHUZ5GCAHGJSKRH8h1pFcrPhvk1Zq5BvpezCzI2DXCrEvHagLhboptJD1chRxBNANMLBKpG9rARg==
X-Received: by 2002:a05:620a:4d91:b0:760:7730:cd4a with SMTP id
 uw17-20020a05620a4d9100b007607730cd4amr8436319qkn.21.1686705651461; 
 Tue, 13 Jun 2023 18:20:51 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:20:50 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/60] target/riscv/cpu.c: remove set_vext_version()
Date: Wed, 14 Jun 2023 11:19:21 +1000
Message-Id: <20230614012017.3100663-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x731.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This setter is doing nothing else but setting env->vext_ver. Assign the
value directly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1558a0b93f..13d725dc20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -252,11 +252,6 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
     env->priv_ver = priv_ver;
 }
 
-static void set_vext_version(CPURISCVState *env, int vext_ver)
-{
-    env->vext_ver = vext_ver;
-}
-
 #ifndef CONFIG_USER_ONLY
 static uint8_t satp_mode_from_str(const char *satp_mode_str)
 {
@@ -871,7 +866,7 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
         qemu_log("vector version is not specified, "
                  "use the default value v1.0\n");
     }
-    set_vext_version(env, vext_version);
+    env->vext_ver = vext_version;
 }
 
 /*
-- 
2.40.1


