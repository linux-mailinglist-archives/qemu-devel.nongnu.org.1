Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980F8201D9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQP-0001bU-OD; Fri, 29 Dec 2023 16:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQK-0000yt-Dp
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:44 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQI-0000S4-Nf
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:44 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9e62ff056so2713906b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885381; x=1704490181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2Xo1Swghl855R8AX0ytJsmYmGWmMhQtAvSG9IogLkE=;
 b=jS4tDVXTWQagODUMNPxbosJTnHS4kqt+xcATcHKrJq+eLjOj5M0rxy0ya664K0rxCf
 kLP9yGGZddN3QVH0QgDGiQshHveFxDLnbaLoBwmOYD393P+sPqSObtlrWnVjP0ZFGU8m
 iRMAxZAbt078fE1N3+sAKbYLAR+9P6lqLkDo0YwS/9qxgEiz/KfWVGkUASLECf1GfzC3
 7evPUJUt/Hkqz1fms8dpXxWSkneSRSMuRfBuSM0M7RMF6IPQYlncEBFFwWAv0sUWtRLT
 gex5u7WBgrmpw5bonDHV8kXjypgLG1PpWPbhPwci78ZEM9V69aAeLW1gd0bUNxfvd2oo
 3A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885381; x=1704490181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2Xo1Swghl855R8AX0ytJsmYmGWmMhQtAvSG9IogLkE=;
 b=kguplRSkhHZ+JARtV4b7q1KNpzSfWsBcnd6OTWjf5WDC7GtLqMIlu23ta5XU0YoRDC
 GngbNs3kNlkbDdW/FjlboY2CoMFhv3lFKdCw7eGm9hWg9bBDty4WgEy7qUpR3IPzoImp
 FzG8F+hLBeF8iu5hIgFqBTYSpIwJuAfJtJFQvCcsXdWwk1HO/oX9bGZTG28IpzoltBH4
 XsPwOBPPnEu7ep3IXRn+dDLRqvBzEuHBBo7fYdMNc33UkyPmIaAs6d7v6i+zuTamDmLQ
 5us2yzmpck3wbwQiOUC38YRt2H1IZyngXc8KYKCdr5hoT8wixkXxtStZNXLMNLuM5c8w
 Qq4A==
X-Gm-Message-State: AOJu0YwCZDUJOlGnQAbRMs8RGinXMicZKPRNc8pY1AWhdQgpDSHlZa4Q
 Vk0JJOtI5tMCP6Ma36SWUlm4bw2AXGIcmcQjJfvAKjxcQTQFKQ==
X-Google-Smtp-Source: AGHT+IGooGYi+lOHhJ6QnGkcxdcOcxFlipI5Nzl+k39crz/nbuttOHH7esIov5UHNoUw6b27jV1bqA==
X-Received: by 2002:a05:6a00:84e:b0:6d9:bd17:1653 with SMTP id
 q14-20020a056a00084e00b006d9bd171653mr8840496pfk.37.1703885381277; 
 Fri, 29 Dec 2023 13:29:41 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 71/71] docs: Constify VMstate in examples
Date: Sat, 30 Dec 2023 08:23:46 +1100
Message-Id: <20231229212346.147149-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-72-richard.henderson@linaro.org>
---
 docs/devel/clocks.rst    | 2 +-
 docs/devel/migration.rst | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 675fbeb6ab..c4d14bde04 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -502,7 +502,7 @@ This is typically used to migrate an input clock state. For example:
 
     VMStateDescription my_device_vmstate = {
         .name = "my_device",
-        .fields = (VMStateField[]) {
+        .fields = (const VMStateField[]) {
             [...], /* other migrated fields */
             VMSTATE_CLOCK(clk, MyDeviceState),
             VMSTATE_END_OF_LIST()
diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index ec55089b25..95351ba51f 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -158,7 +158,7 @@ An example (from hw/input/pckbd.c)
       .name = "pckbd",
       .version_id = 3,
       .minimum_version_id = 3,
-      .fields = (VMStateField[]) {
+      .fields = (const VMStateField[]) {
           VMSTATE_UINT8(write_cmd, KBDState),
           VMSTATE_UINT8(status, KBDState),
           VMSTATE_UINT8(mode, KBDState),
@@ -294,7 +294,7 @@ Example:
       .pre_save = ide_drive_pio_pre_save,
       .post_load = ide_drive_pio_post_load,
       .needed = ide_drive_pio_state_needed,
-      .fields = (VMStateField[]) {
+      .fields = (const VMStateField[]) {
           VMSTATE_INT32(req_nb_sectors, IDEState),
           VMSTATE_VARRAY_INT32(io_buffer, IDEState, io_buffer_total_len, 1,
                                vmstate_info_uint8, uint8_t),
@@ -312,11 +312,11 @@ Example:
       .version_id = 3,
       .minimum_version_id = 0,
       .post_load = ide_drive_post_load,
-      .fields = (VMStateField[]) {
+      .fields = (const VMStateField[]) {
           .... several fields ....
           VMSTATE_END_OF_LIST()
       },
-      .subsections = (const VMStateDescription*[]) {
+      .subsections = (const VMStateDescription * const []) {
           &vmstate_ide_drive_pio_state,
           NULL
       }
-- 
2.34.1


