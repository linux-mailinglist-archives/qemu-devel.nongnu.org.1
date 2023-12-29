Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B407820199
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLA-0006vf-E8; Fri, 29 Dec 2023 16:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL0-0006sC-Lf
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:16 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKx-0006DL-QG
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:13 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so5597123a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885049; x=1704489849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BYi4NVrnMs7H/Gj4Nqxzy7vtCBJeOHIeFvnPCuOWVk=;
 b=lwygizmehueCII5/ENz3EqXOWkNrg4oVrc3BQfCUKWzzSDE8axGNnvHTvbq7ldunQs
 LUVU7h4PP+CaUgGxNhXWySis4v6aAvI7BNUdew4i2nT7d1R4E8NHhCq9zG66Iop7Ofzf
 UEeCKu2z24pp36hdXSQKhA7IINx/wiQq2L0FE0YYmCkVzyt3L834cEJp+dLbWXmyWmj2
 qlOUiLxm8dP8Im9xNaazUvGFtBDLs3ZP2hD/drunjnEujto6Y9c5FBzPoSiQbno09JxA
 mq3KxXNau1G71SYVvfHQ7PNOn6kKkVeT+5rs8JCXWeKwTg+6Ynk347lkeCy37OiJX/lb
 HmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885049; x=1704489849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BYi4NVrnMs7H/Gj4Nqxzy7vtCBJeOHIeFvnPCuOWVk=;
 b=HkotdTLE3gsWHlmyWEs/aSPmmfyNvpqYOmg2dBrVoGVi8+vazJeTp+EWsppFh4MjN2
 RNhTqWzkCBa9t6hKHp89qBaGu1HOrOkzKgFhpYSj+5b48CX6sGk96fPBXJ8vBia74R0y
 9Mkm+xI8BAifabD9lxolxkTUkchjEFmKyx/87Uw9adZozIvMs2Jq/MXJ1Cmnd7ljf91Z
 KtikaOPu/FqqKR0IXpctJyQ4DB4yySC4R/+yRabuPAZaK22MVOudWLmLj/+pfp0I5x3Z
 K4QuyiNqUjpq4//7F0eXbFzYWeIrylhK7tKFykVDC4FY/Ar8lAocIfar3izD/SAH5WWa
 nEfg==
X-Gm-Message-State: AOJu0YwT/P4qkzowkTUdg8zFUJCZDddwX6+dFm0KgMAUaZzdFftq2CWe
 qle7/Dqbi5V1V5XY4P9UaXlHehSYCZ6KHRJ9+Ih5kguSc/CFFw==
X-Google-Smtp-Source: AGHT+IGuJZXZz3TBkXjcJC7v/6hxnpW1zssRqwOpPlAydBirgZzdKs+jKTFTa9RlFRIGtMDTJGxAsQ==
X-Received: by 2002:a05:6a21:8185:b0:195:573:ce4f with SMTP id
 pd5-20020a056a21818500b001950573ce4fmr15107252pzb.20.1703885048800; 
 Fri, 29 Dec 2023 13:24:08 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/71] target/cris: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:41 +1100
Message-Id: <20231229212346.147149-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
Message-Id: <20231221031652.119827-7-richard.henderson@linaro.org>
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


