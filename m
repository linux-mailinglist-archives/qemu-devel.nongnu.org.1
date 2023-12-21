Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A681AD63
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9gD-0006HF-Ei; Wed, 20 Dec 2023 22:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9gB-0005qV-2Y
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:59 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9g9-00014G-A5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:58 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f5c0be04cso2005876d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129096; x=1703733896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/GEZcRPVpt9/6h5hUfTMW+Fp//2MGdwY+0fJd25w8A=;
 b=rAv3uzvHZ9pR4bnxZXLal++ujEk/QaF2iz9cogBN80ovb3QAAvWOsYFJ0YwxCH9asM
 wPNizQMYvnFPxNNFhua+q+Rm+lukiRWgnfS7Uuc7ff7K/uF6vixw4SdV0KTI6iw6inC6
 1Ftn3zkzFexaE5/YgXJx7gKNSyYduLAfnad7PZrowqaznAaz79GRB97c8UTJuIKnvQiL
 6SjU1XvLVZOACByjNtTNB12EkcStWB1HHiWfNEtjFx4t5o6f8FdKFUzPzAlbby/Akd2Y
 anfBGtdBlZvZc6JmThHTq2laQzJee4BHXak4KMHTJdQBn0VdphdnMuCH+5aEdQMFncfR
 C7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129096; x=1703733896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/GEZcRPVpt9/6h5hUfTMW+Fp//2MGdwY+0fJd25w8A=;
 b=vd9MK7MmH/rb2ITC1frjKzsxHSMCMW9Yhty6CoMx5h4iQ0JO06DGCfiD4Yn/nNidIR
 jW3u0VA6YCIZImNo3EbOtGornibPeRjvkuyQ5ksKJKaz8nL575wwLcoLvFgE1j6wzPAI
 gJV2dXfTN2zXvrVr0haqEpQF6CfS+ebe33wNvDQvA2C1IFcDe5/2uU9K4q8m8H8FRtWf
 RWO9Q2MD82yUyDU9ipVqJNFJXI0FpSmg299WXjraoUPHJUDQMxmB49rJUgeIZJ0kjoTU
 8VXwJScnoO7sNmPPkcFSOEROqRyyj0izINxjMfd6U4YXWWqpgDymj43cjeB/2kGtZD0L
 Dapg==
X-Gm-Message-State: AOJu0YyyVPrfo/ooKAk91ETdPibHzPpRi5kI+1gilmRO1EqM/potS4uD
 wVMoU6JqGhp0NA20vmP/DAcx0CG1UyGGZ7fj1A/megq3
X-Google-Smtp-Source: AGHT+IGYBbd9M8GXDUQtrwiP9Qb4hATxZm0dwGTLVjCWStJdQrBqzuPYJ/v2pSd4dFuOmeBJ71cmPw==
X-Received: by 2002:ad4:5ec9:0:b0:67f:3d47:5a82 with SMTP id
 jm9-20020ad45ec9000000b0067f3d475a82mr10126600qvb.78.1703129096030; 
 Wed, 20 Dec 2023 19:24:56 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 71/71] docs: Constify VMstate in examples
Date: Thu, 21 Dec 2023 14:16:52 +1100
Message-Id: <20231221031652.119827-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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


