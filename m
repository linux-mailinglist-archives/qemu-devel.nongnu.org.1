Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF377DEA20
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXj-0005iw-Pp; Wed, 01 Nov 2023 21:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXh-0005ho-83
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0001YY-6O
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:40 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c115026985so501050b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888634; x=1699493434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bq1ZlMGsY4e8Iwr9tgGW/hU3fTtznVC7sHTWJluQEek=;
 b=zRKNjGclXuliehOyt41evrM3gOhaQF2dscDPsnU5kwgAL02xs6Gmyoafy/Xan4Qj5e
 99Z7Yy+4vrvMzbgEcvb3BLaN2vT0eo06YF4rFZtqLE0UtwgdN74MnyujkyiHuqqAGXq+
 eYDnvcPBtUta35nN5aQg4TTPd/OrStgRMojdjLl+ujVzIylj9XYnULqcPi8D7g8WXU4C
 BNBKMAzBIK42P4EXziWxK5uuHCO8tns++JSh+oQuXTetPsWg8GyE5gei85qwu4Gd45Af
 arb2BNUH+GcO8iUV+GMj+MhOIfoIi67az3OMW7dBqZbJYf5W+4X0onCmt8BBYX6T56U5
 lX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888634; x=1699493434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bq1ZlMGsY4e8Iwr9tgGW/hU3fTtznVC7sHTWJluQEek=;
 b=Himaaw2YDK4o/HPbwQrfBPoZTDjWG9NbBOURgwl4+DRbNDTceiRE/+MDeCDO6MY1fx
 C8so/q//hC/0Se5IZZDCvWiPlTV2KQJbye5isCeobcUjr/8JPV3EMdG8f0bfvZLQ/ckT
 9H/hTDNZFv6pNC+4+fP+K7RX/aAOdxG0aGuUyk5gYRAkLkF2fvWDS32q6DdwPQ/GF+wr
 JOpHYQSyl0CBNIrwRlZy6nvTuvDMoNZiAxSIgIwvMWfLQCxZepYd96/psXKFqM2pe4v/
 V0aePdknXxDFIfm5GZaE/TA02HHh0ErT1ZR7rV3WZCfDW7+3CRRavvEqIvipRGFifHiR
 lZiQ==
X-Gm-Message-State: AOJu0YyDd2UtRNjVF2W5+JVaye1WKJAqLKWttNb5i7MXoUWOklqgRm+9
 LpRUQVymLjnj4jRznu8mERbPaLI8R3ScGwnMh6I=
X-Google-Smtp-Source: AGHT+IGuNdnwBcw0np5WKFclogjLot9S/59ZoSXQ/loBJ005qOuBbJvCFGNlNMW5Ltn1kU4pJSdf6w==
X-Received: by 2002:a05:6a20:8428:b0:181:16dc:d1ae with SMTP id
 c40-20020a056a20842800b0018116dcd1aemr7665852pzd.48.1698888632558; 
 Wed, 01 Nov 2023 18:30:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 18/88] target/hppa: Fix extrw and depw with sar for hppa64
Date: Wed,  1 Nov 2023 18:29:06 -0700
Message-Id: <20231102013016.369010-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These are 32-bit operations regardless of processor.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ffa367b91f..ed88f724ce 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3230,7 +3230,9 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_xori_reg(tmp, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(tmp, cpu_sar, 31);
+    tcg_gen_xori_reg(tmp, tmp, 31);
+
     if (a->se) {
         tcg_gen_sar_reg(dest, src, tmp);
         tcg_gen_sextract_reg(dest, dest, 0, len);
@@ -3355,7 +3357,8 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     tmp = tcg_temp_new();
 
     /* Convert big-endian bit numbering in SAR to left-shift.  */
-    tcg_gen_xori_reg(shift, cpu_sar, TARGET_REGISTER_BITS - 1);
+    tcg_gen_andi_reg(shift, cpu_sar, 31);
+    tcg_gen_xori_reg(shift, shift, 31);
 
     mask = tcg_temp_new();
     tcg_gen_movi_reg(mask, msb + (msb - 1));
-- 
2.34.1


