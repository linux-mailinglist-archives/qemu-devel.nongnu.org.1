Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8981AD5D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fp-0002Ih-S2; Wed, 20 Dec 2023 22:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fl-0002De-Ny
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:33 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fk-00010U-7A
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:33 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67f3f602bd5so1857606d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129070; x=1703733870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8axF/F5pGDpk6KrMVCFve1EVLehnx3zt/ALRmYCufUA=;
 b=aQG7XlpT+0XaHqkWcV2oJgBISJsh3PP0bhKlg3zeK2i11hjXskUx4p6ZLrF+RntTvw
 c2++7mgoNpO0ZhEm67q4xA4pTKnowqZ90t1RSJWUovnyeukQ+xDqLrCN855zcAzcfMym
 hhnxBOngVc/BEXa2XRfhjhgOeOMF61JOYyri1xFoK33SUfF3ZcuEXwY6UenKGGvgvSnK
 3ylg75V4bcBjWw2p6osBh10s2epTTICmPfT69Je1RQk2JSODQw0BS/b0QNhugVLItu4/
 0akFBZaylGL81U2zos8YOwtQlvtpuCbEi39r2kYIPIyQEqiAXcSSHO0scf6AAxueZmzo
 XP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129070; x=1703733870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8axF/F5pGDpk6KrMVCFve1EVLehnx3zt/ALRmYCufUA=;
 b=nuxgOJjNmkJcjZbvxviWmTsxNbPlbytaQ4jYqPRpFvvLNcd10V9Nzdbps2z7q+UirT
 JHwlEYTYIDqTWkvxX/etvVMfy3cMJngPMEcDCI+ZU2TJbIiil2RGwx2CdZuLaXbLfBnt
 DO/hRS40ginq9itszyJEBKatgJipD6ArDfXzSqJKk/4nh4DCwCztLkMPOx/ZrALfU6Gj
 hk+HUAGrLn5JNigFKCJNnzDKfou6+nNZiamnaN/jStzp5oyJYW9pJo/gNWtJ/YPCXai+
 IJYVkyIsbzc+vEb39xtnpHGF4Cyw7+bLcXT/AWemzULncW32PPGkKS+vfA8eJVBGXmPn
 jFmw==
X-Gm-Message-State: AOJu0YysLCJMwm+aw/5RCgOATe8akD/yzhxAlCIC+nWIggZ4v2B03BHB
 /BWGyfl9Yy9vNgoFVK1NRy/uR6HxL3qxf2+ssh6XnHTz
X-Google-Smtp-Source: AGHT+IF5k2WYJzDsD4q9jzr7EMgPSmbt8sbt3wzvXz4bYkly86amUzxmi4o44V2bcXFfoWdzUZ33Kw==
X-Received: by 2002:a05:6214:2307:b0:67f:5f7f:92e6 with SMTP id
 gc7-20020a056214230700b0067f5f7f92e6mr4531997qvb.2.1703129070585; 
 Wed, 20 Dec 2023 19:24:30 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 65/71] cpu-target: Constify VMState
Date: Thu, 21 Dec 2023 14:16:46 +1100
Message-Id: <20231221031652.119827-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2e.google.com
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
 cpu-target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 508013e23d..430dc53566 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -87,7 +87,7 @@ static const VMStateDescription vmstate_cpu_common_exception_index = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_common_exception_index_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(exception_index, CPUState),
         VMSTATE_END_OF_LIST()
     }
@@ -105,7 +105,7 @@ static const VMStateDescription vmstate_cpu_common_crash_occurred = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_common_crash_occurred_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(crash_occurred, CPUState),
         VMSTATE_END_OF_LIST()
     }
@@ -117,12 +117,12 @@ const VMStateDescription vmstate_cpu_common = {
     .minimum_version_id = 1,
     .pre_load = cpu_common_pre_load,
     .post_load = cpu_common_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(halted, CPUState),
         VMSTATE_UINT32(interrupt_request, CPUState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_cpu_common_exception_index,
         &vmstate_cpu_common_crash_occurred,
         NULL
-- 
2.34.1


