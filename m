Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3067E1AAA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:03:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZk-0004Zx-4m; Mon, 06 Nov 2023 01:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZS-0004WJ-1z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZN-0001Ot-CQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:49 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso26402115ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253924; x=1699858724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS5pbyfQkBJ8BXnndQLZdlQ4oCZm/2DiCmUpXy8qB3I=;
 b=xK6En3YO3sUV7xPZKo4mFlaxU3pvxVAk3FhDoE62lZTxpmUI79X7smGxKhcimOzeRP
 YYxjCFmodr6f+mN4OptdxKO/mxFz54owDWOhH+r/98Xom9KF1ymg2YDU6IfzRGaeAmUx
 3XNQDcYO+R+7O22HLBAOUAIFAdbz2+PLTFuRaam3zgmfJguf4ikoBwW24utYY0Dc/4fK
 3suzokdbFhAg/EqOuhNIfXDv343dI+r7wp/cPYa9L90swZPmeuilxYzOsZM9kI96Y/gh
 eK33ZLFIXSzDIMJCXQecLAB6J7g7ieHFWF9j0I5ibZMTh5Qqhq6a8RtDyCx0bJVKqQHj
 E5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253924; x=1699858724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KS5pbyfQkBJ8BXnndQLZdlQ4oCZm/2DiCmUpXy8qB3I=;
 b=eW6y4WGdO/pRSaTlwEyxm/7iymQbCB8mq4olP7XcA8dxvn2JMGyQo9MFCdmp6oPLlA
 qaE0ZQ7yx03d2ZgddYOvWTzxe3n4AuSuoU/q3quuujerCFwB9CXwl6FVIy3yXzHsWkyU
 4cPrAlaJTi+W2ena0hHsEAsw4psW/ECNV5i92tPnISH1yfjLsaQ2xa3y95lo6mKvLGby
 uMmylS6GOA/WlSW2/SIpRz3YZVKy3IesFhpTQXPwuKWHn5dBUsiw9tCT8napBAJXl3SX
 W1iuQohnCXpK/JNubylwteAN0bI4/tBpNjOUMWe9XeqY2UW4OVZo4mEdJsE1mAaQwtEZ
 28QQ==
X-Gm-Message-State: AOJu0YxVWveJY0/RIc21yvberxnDFdzkOb8a4gy4ADmRKTpBycZnBCjK
 HYUBSvje5ohRjQf/k/4r1eVsXbYVBfKCrR3SbbM=
X-Google-Smtp-Source: AGHT+IF6x85v+LXfMlV2qoF1MXUY9Xdkuj12UBsKUv0n15DbO+5Kd39o0JOX6RxrQTvCOi2RWMSlEQ==
X-Received: by 2002:a17:902:da87:b0:1cc:4146:9eb0 with SMTP id
 j7-20020a170902da8700b001cc41469eb0mr23674492plx.57.1699253924183; 
 Sun, 05 Nov 2023 22:58:44 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 17/71] target/sparc: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:33 -0800
Message-Id: <20231106065827.543129-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 274e1217df..b1b1e16b13 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -10,7 +10,7 @@ static const VMStateDescription vmstate_cpu_timer = {
     .name = "cpu_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(frequency, CPUTimer),
         VMSTATE_UINT32(disabled, CPUTimer),
         VMSTATE_UINT64(disabled_mask, CPUTimer),
@@ -29,7 +29,7 @@ static const VMStateDescription vmstate_trap_state = {
     .name = "trap_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tpc, trap_state),
         VMSTATE_UINT64(tnpc, trap_state),
         VMSTATE_UINT64(tstate, trap_state),
@@ -42,7 +42,7 @@ static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tag, SparcTLBEntry),
         VMSTATE_UINT64(tte, SparcTLBEntry),
         VMSTATE_END_OF_LIST()
@@ -111,7 +111,7 @@ const VMStateDescription vmstate_sparc_cpu = {
     .version_id = SPARC_VMSTATE_VER,
     .minimum_version_id = SPARC_VMSTATE_VER,
     .pre_save = cpu_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
         VMSTATE_UINT32(env.nwindows, SPARCCPU),
         VMSTATE_VARRAY_MULTIPLY(env.regbase, SPARCCPU, env.nwindows, 16,
-- 
2.34.1


