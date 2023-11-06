Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7C57E1AC1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg6-0006Z6-A4; Mon, 06 Nov 2023 02:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-0001CQ-Kr
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-00024n-Tw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:41 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so27836455ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254149; x=1699858949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaTu0BFcBntvQwdG3q16KFWW0mN860GF6fIN08sbBn8=;
 b=PlPkxBnLBI4Un4QMGnrLSvQWbbR0S2aOM0NjEQMmU15pP+glkH26QMzbLkj8neF2Ms
 ba0bh9jYJUX4rZqZ4k3hOIFRrnnZlkxo6CjNj7oX6/NIPCl/tITHpKuHZpjz01wFzJqQ
 IxEpKYONYmZPJjAwdOxYu1QNTmMOnBPfo0jmR7LgndZV48cHuXBJp+DQy6kkqInYbQev
 rviuwO3rzWTcnMctQ5BeyiU+gaWIDUv6C5ka92kvzBkHY105i0ZYRHSKxcTFIvGyr6Pk
 0sguP1nAugKlL9Aew3/xYbdm5enK5vzQzd1XojIe8dLQ//ajQpWof805ecWyRAzACfD/
 jIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254149; x=1699858949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaTu0BFcBntvQwdG3q16KFWW0mN860GF6fIN08sbBn8=;
 b=BMd78vN4va0n49A7Fu299gltg2IxNyXUgZR68W+szYgWyQnbDbuEN4T+3fM5KZlMdY
 sjlA1uS+hele6otBVCKsO9PGTIRlPDGCOKDEW1o5mqzkS91G03rjsEGsDdPvZkW+oR0l
 UsvVsY3BEMVB7WdZseal4ZLZv7dyZ2nQKwwH2WIY97y6jylU1HXFVzELyfkcaHuxZaDZ
 /gyc27ZIWrsZ+UmZpSnm6Sp6JjrAAmkK+GDzr0znI8ZEUxtWiQ3qW9bTI5LHrXXG7QgX
 XM0M+/aE3rkfIqc3v4WnxwmP0xDC2+4H3dZzjT4FiLSlSEJqhE76Sg4NGibeD6+83ntN
 hTwQ==
X-Gm-Message-State: AOJu0YwGSXGNmt3tuRcnS2LLmK6Eo1Emdo/QNz1bD1kRqfH47szDYue0
 IGD/zeEzG9b8OXnzqEbZs3PivgVr6gaDTvf+RFE=
X-Google-Smtp-Source: AGHT+IFhw29gyZ5Q1ZiRFtw8vAvOu8q3tTqWxuSud6KdPHVsS/Bp/Fqt04LjlAzekI74SgE1Vr1yNw==
X-Received: by 2002:a17:90a:4f48:b0:27d:166b:40f6 with SMTP id
 w8-20020a17090a4f4800b0027d166b40f6mr21761056pjl.41.1699254149646; 
 Sun, 05 Nov 2023 23:02:29 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 71/71] docs: Constify VMstate in examples
Date: Sun,  5 Nov 2023 22:58:27 -0800
Message-Id: <20231106065827.543129-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index 240eb16d90..3b8a34e8ac 100644
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


