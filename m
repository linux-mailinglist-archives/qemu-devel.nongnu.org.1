Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442FE81AD20
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:18:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZC-0007K6-AP; Wed, 20 Dec 2023 22:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Z2-0007JJ-Pm
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:38 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Z0-0003iv-S0
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:36 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7811d1e68b0so20267085a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128654; x=1703733454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jk9Vc/G/WhG7Ra47Fk+bBcdTGc1y4UfLcAaOsD/xb38=;
 b=aHcNDdiMHuuAPlZuGVyZyvpPozdRKTthCFuGzEItHzvKNVwXdYR9CCSDq4rMHvUNSL
 OgjwHbokmHFPWpLvlZGFSPeXck6KorsjyxFvJV6o7ucyn9QnnY1JcfM6iLNhuKOLk/Wp
 tjBzSop5QXkMy9lA4kXA/gAlbu2btYf0ELLpbT9CnFoyDfnkAvvpfz01w4S2PtE9AvN4
 2QJvnwbPrE8CA6nRtcqUcHMCAboIlZmU5VpPjJnVxWexX0JZK/QW7v+2m4XrXwTMuBg+
 MNoTOfk8Ju03Zmnp0FTC6nbtwxNW9oYX9s94KbGujRhRfzNslAnjn/yimqMRYmfobiIZ
 082A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128654; x=1703733454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jk9Vc/G/WhG7Ra47Fk+bBcdTGc1y4UfLcAaOsD/xb38=;
 b=QEL/78wfGot221FSRfkaZKOYUb8ouQ2VKJCzXiEitGi7tQCRkdl+GsCKIQ3tARPDLy
 gToK1MSHvafxICpYoCXCAk29bTv40HrfK1aZXj6ruyAvYX5fipSyKVvsPNjcxT8U6TIO
 HwVYSXYdFc7vNgk5AZRIVDKE0wwPu0OUZopZYLpMrsFS7KRKWZZdYoKhTStXVuNMKOo6
 VqTOTcT56otdD9ET83+XLyjG8mL/MbiIqzx5vjRkhhv0UMaK7fRmGPmsTIQ1TK9LZ6xW
 jzW2i4ujGNV5kuCVSfFoVNqgdfx3jpCuWVziEqxTWJqGXiTp8nB13Fsj5y/cQRhUZTPy
 pXyQ==
X-Gm-Message-State: AOJu0YyYL+M+/z7e81IXZs7lgPZ/ISzEpGkhpKd2K3NX7cCxkqR0JWrI
 2iGowM3io67elswCvPBmjSCtrXVEf5DF+hbflzN70FnG
X-Google-Smtp-Source: AGHT+IEUVj3ZoLp9htoyeJ0VPHFshnC+3Qdi/JWTT5mBYKPPC/mjaRa6syMMphZHr3X53YWnqHmQ4A==
X-Received: by 2002:a05:620a:15a4:b0:77e:ced9:3fab with SMTP id
 f4-20020a05620a15a400b0077eced93fabmr22472936qkk.15.1703128654069; 
 Wed, 20 Dec 2023 19:17:34 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/71] target/cris: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:47 +1100
Message-Id: <20231221031652.119827-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/cris/machine.c b/target/cris/machine.c
index f370f33486..7b9bde872a 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -26,7 +26,7 @@ static const VMStateDescription vmstate_tlbset = {
     .name = "cpu/tlbset",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(lo, TLBSet),
         VMSTATE_UINT32(hi, TLBSet),
         VMSTATE_END_OF_LIST()
@@ -37,7 +37,7 @@ static const VMStateDescription vmstate_cris_env = {
     .name = "env",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CPUCRISState, 16),
         VMSTATE_UINT32_ARRAY(pregs, CPUCRISState, 16),
         VMSTATE_UINT32(pc, CPUCRISState),
@@ -85,7 +85,7 @@ const VMStateDescription vmstate_cris_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU(),
         VMSTATE_STRUCT(env, CRISCPU, 1, vmstate_cris_env, CPUCRISState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


