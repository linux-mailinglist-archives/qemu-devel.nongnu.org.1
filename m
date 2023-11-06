Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B67947E1A98
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:00:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaB-0005aV-IG; Mon, 06 Nov 2023 01:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZk-0004hE-LP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:10 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZi-0001Sw-Ep
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:07 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3388621cso39856505ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253943; x=1699858743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GK0r0bvGCZ9eQqWkzgeODTyST+S/GfSxl8+D4j9zUNc=;
 b=c9COxtpxhL5xCJIbmpNemZir7TiFq8fRYxfT2kGRUPj7aOo6uAf4nxwwNK69sEkyFR
 s12h0PyTae2xFHM6UJUMS595fg5onl0xNO7DyUssj90H7fS89884Qg1gQ8QR8cJeHjDY
 qYX69X4vVFN2qdTHQlayq27u6bDmJk7h52qFHO7rimO+h5e/yUDTS5aYR2QSiRg6VUth
 iriX22sZWdba+tEVw1L9wUpEfo7fu/23AnXY2/kt3+KXZLCYQkUCkiXgPHZu86KpzRlO
 ZA0fNxpUyVAuxhHEvIpI+RWIVVYxJHjdZOYPz+Ejy8oMytyOnMojVbilZ6x7Wc5c5m8s
 IovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253943; x=1699858743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK0r0bvGCZ9eQqWkzgeODTyST+S/GfSxl8+D4j9zUNc=;
 b=EQpL2KFF+UvbLzlKrW8bqkEKtxKT2iAt6RNfOnfqynrYsvgsgL/I6ViI8yQfI/D+Bg
 jE6cILEiOK3b0um8E/TvaRzin6TcfyQZCO2ZAyXT4c/io2VLNSPf1vPlB5E1Vl2m4rJS
 rP8+KyNS9HrZH4GY0GMvcNoDkojNMnrcWk+P33T+zERJk7zBsRMU7XPGGc3ppBt91w5N
 0r+8AcAklvpGcqF6pMmeUVwuIMYeeAobnQqQ/kkfwU92a8FvWEoapyRYSnecKU38vw7D
 n16BvFmTa+t3Ug0rohGGd0BD0moCzPjEQooR0s6KhGlU2eA+irplj7iRWrWcWqCDkndT
 a8oA==
X-Gm-Message-State: AOJu0YytuRjbsg+BGWcwGAaLzdmoJIqIlHAlytN85gPe0fGbSvsS2usL
 BC9obtDTloLLWQ0exM3Lnn376m38FPi7Q1Dsn0Q=
X-Google-Smtp-Source: AGHT+IHRBASwSCRj6zQuyGrgTSTu5gZ55oxRgbDcDPgvz7PCgDXBYgo9u+K157R2vXitHaQuhG1EuQ==
X-Received: by 2002:a17:902:e544:b0:1ca:b8d3:f880 with SMTP id
 n4-20020a170902e54400b001cab8d3f880mr12264150plf.20.1699253943399; 
 Sun, 05 Nov 2023 22:59:03 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:59:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 39/71] hw/m68k: Constify VMState
Date: Sun,  5 Nov 2023 22:57:55 -0800
Message-Id: <20231106065827.543129-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 hw/m68k/next-cube.c | 4 ++--
 hw/m68k/q800-glue.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index fabd861941..baca38bf39 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -996,7 +996,7 @@ static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
         VMSTATE_UINT8(command, NextRtc),
         VMSTATE_UINT8(value, NextRtc),
@@ -1011,7 +1011,7 @@ static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index f413b1599a..b5a7713863 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -189,7 +189,7 @@ static const VMStateDescription vmstate_glue = {
     .name = "q800-glue",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ipr, GLUEState),
         VMSTATE_UINT8(auxmode, GLUEState),
         VMSTATE_TIMER_PTR(nmi_release, GLUEState),
-- 
2.34.1


