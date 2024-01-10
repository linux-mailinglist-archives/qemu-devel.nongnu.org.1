Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C165829587
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:00:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPQ-0001LQ-Gh; Wed, 10 Jan 2024 03:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPO-0001L2-73
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:58 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPM-0003Om-EJ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:57:57 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6dddb927d02so1314418a34.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877075; x=1705481875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tO8QCDRIQciXrsOlhLApS3566yGiSd41upknfvrc94=;
 b=IxwpBZfDrs+CLF1jHYj7BFHkIkoAvBCfFLhznMOU9san0Y79QIZ/46kFkVSCVEfwss
 c+A2Wldm/qI3U07o18cx9P15dZcsTD9PTGQz2b3huv67OGGvIE9ge5icWVdTppev+2JG
 bIid7tsHSGUv7TNpFO5CnZnMm4CDB5zQfrqVknhhA1d4lgXpkDMrd5bbs6rPYbClIQgA
 HSQQRtwA+sQmL5LSNK1mWGrtKtfwD2fQ1LnKDb3FGpFLFMQmDtonN+lq1V3xGtT09Z8m
 hQ44jH6vMt8TZW5GHROt5qoH8XZ3Rx5lcTXyGRKGOOcq2XFQVejpr939C4BVzgRRKfFN
 5qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877075; x=1705481875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tO8QCDRIQciXrsOlhLApS3566yGiSd41upknfvrc94=;
 b=hMzSzdzjlkfzZ+7tGyqMAwtbcmC4uFr6Ipw5gt0n3hORwuR523tn0W006IuGgyrNS5
 RKomq06t6vUB2qXEJTu8S0r8+PZ5zDniI9XBAfMv6J1baAdsCueaZpzCQayyWTz5YFuh
 rlZstEX6rpk8E0wX4ElND2VrCpsQjWeVdmEThZ16oBr8uEM8Y/luWTcrnGMgqmsQeW1Z
 bT1FIsuSgNXv4X5+fukafxN6sNMkaEsE95a8gc3u7u0zmUTOAtO5aZwC8e2M/NsITcGM
 5YT+vD9nNxJikH8KRUSTP631OTDtTXsaDw3ZuDKDg07cihLXKavVesryfkFkDA5HQsWk
 i2fQ==
X-Gm-Message-State: AOJu0YxJ15lFaAdqfWShOLShsYhdku4FcypL9WIGfSqpMbsSR43bAnB3
 2ylQvBzPJYAr2vvfceP8ILsN3T51nnCr10/i
X-Google-Smtp-Source: AGHT+IHl3QDxeylr+qXHDKSKoBy0gj4fPfCoATa8iMMZlc/YlAcOQiNQY7sDHvUhcj/tCv9blXdsXw==
X-Received: by 2002:a9d:66ca:0:b0:6dd:e62d:8b35 with SMTP id
 t10-20020a9d66ca000000b006dde62d8b35mr453366otm.5.1704877074972; 
 Wed, 10 Jan 2024 00:57:54 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:57:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Subject: [PULL 03/65] target/riscv: Fix th.dcache.cval1 priviledge check
Date: Wed, 10 Jan 2024 18:56:31 +1000
Message-ID: <20240110085733.1607526-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x330.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

According to the specification, the th.dcache.cvall1 can be executed
under all priviledges.
The specification about xtheadcmo located in,
https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadcmo/dcache_cval1.adoc

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Christoph Muellner <christoph.muellner@vrull.eu>
Message-ID: <20231208094315.177-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 810d76665a..dbb6411239 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -296,7 +296,7 @@ NOP_PRIVCHECK(th_dcache_csw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_cisw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_isw, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_dcache_cpal1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
-NOP_PRIVCHECK(th_dcache_cval1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
+NOP_PRIVCHECK(th_dcache_cval1, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MSU)
 
 NOP_PRIVCHECK(th_icache_iall, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
 NOP_PRIVCHECK(th_icache_ialls, REQUIRE_XTHEADCMO, REQUIRE_PRIV_MS)
-- 
2.43.0


