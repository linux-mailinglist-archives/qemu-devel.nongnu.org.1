Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8618201DF
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQH-0000Qv-Cr; Fri, 29 Dec 2023 16:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ5-0008Rb-CV
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:32 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ3-0000QZ-8l
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:28 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-204f50f305cso1240900fac.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885365; x=1704490165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hi1W/QRtc07jh63VGtl4+gPGbFgx4yL88GoyzHH2HjY=;
 b=OBCITQaHTc8rHRDQa4p7NZWESC+VdVq9J4MEX1osJBzz7uY3gr00dsriqUbIktyB0K
 xpMNwda2pxhXWSxWvJ38XS6sJWgoWLm9i6q4ufSuHKj5yV/FgJUFZVPfNArv53t9NYnW
 FW+K+PwTkkvk46rAPS5eOOTdDwQgY9g+NURRrdgtCTK+SQSisPOLcM7/8m28d5JFJDun
 1UpDFocu9ECbEleXKPijaBQrqlnSXenXMfjajvZTr3XD3x0tbWRUK8socQEEK38Q+7F4
 wsPmWsd6vBehQtKywmUxFSXhhxd/784mTwAfQJl0A6BNOWmDoYn5Ljq2lwwl4zTpCmS3
 jUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885365; x=1704490165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hi1W/QRtc07jh63VGtl4+gPGbFgx4yL88GoyzHH2HjY=;
 b=c5KgCt5Dix2qNUlOOeGz5LRVkNtbHxfss4bInrZwKfXOtE2yoPh2h0XkPZRqEsZF9S
 KXTslUqPZIvRcYwKSy2HLDesK1GPp29J0LjgFLROyH3LWSp8zFmA8Tivi6aQlM059N7t
 nZrRkdCISTfa8LxirQqM9hi62FKYpHZB5GAcARVFf5BjC01Ntu+96+k0dLcWEPAO58xb
 nIbKGNcG/b5RfJFTxPaj+Tv4pAb6btgZ89LGkazsSnSUMisitmTUsCyx2MP8p0KXhzw0
 20p0uQfVYPoPxWkjqWZzbSovN7hnpw7uGcRz98Kukkc0YZz6fVCQlcyAOXsutvNkk+7Y
 xIhA==
X-Gm-Message-State: AOJu0YwX/b0vvj5tRrKkAUZwUqoS4Qwu+yD0En/wc52Z5oAIypfDpQc5
 u/yNBuJ6SmeYVnbh7Ull02bPCYhJx4doCd1KYmyESNfrxDAJdA==
X-Google-Smtp-Source: AGHT+IFyp44B1XF5HFiVieUchFiqgirBcjwKYkLEdZxIaiB53sQO76/NAf+3ukF7FGeFw9KWoLz5bA==
X-Received: by 2002:a05:6871:588:b0:204:3f62:a8a0 with SMTP id
 u8-20020a056871058800b002043f62a8a0mr13359299oan.71.1703885365255; 
 Fri, 29 Dec 2023 13:29:25 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 65/71] cpu-target: Constify VMState
Date: Sat, 30 Dec 2023 08:23:40 +1100
Message-Id: <20231229212346.147149-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231221031652.119827-66-richard.henderson@linaro.org>
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


