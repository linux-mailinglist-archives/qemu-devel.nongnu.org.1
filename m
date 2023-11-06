Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6E7E1A90
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:59:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZJ-0004R2-Mm; Mon, 06 Nov 2023 01:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZE-0004P3-2z
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:36 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZC-0001Mt-HZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:35 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso37338895ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253913; x=1699858713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAxlb+v5oT1RfgnsB+jkcdJG03SMU3CF/Nmn+Cw3MRg=;
 b=F1yLXjH8AJ4f0sEm5X8i2oQPf0shEFoz6qDjkZ4s0zFacN/3DIRKiSrno7ckCwDJqf
 z1lY97qHTwyuIC7uV2gODKk1maar5QTQT/lfjV8pSJ8WTC3NQ+05+hGf2ykdImPLFOrF
 l4UKjgIbX4BsrROsk9m1A1PSksn5tX/TvGmGSYcrstpBE25QqhFZPKo6yCnHHrAYg1wD
 vYjCBY9GR9chKfTIyap7aHFzCv5F0wdWf1LJuGxvp6tQvI3llv0XFBxVFqMI4gCbylAu
 ee2S6/hjmC5r97J3w1VOhXe16YjysnzcFa7h9+agR6j0h6Pi3+4yVPBNsHVQs81flAMq
 iaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253913; x=1699858713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAxlb+v5oT1RfgnsB+jkcdJG03SMU3CF/Nmn+Cw3MRg=;
 b=hL1QaxbpW8Bc9fhQaY4vnCJSwk8JN9gN7Q9/+v0bUn3kmg2ILZS47YhE4+kdDpkDTO
 m2Bdb1hUrHbgYBUHGoi1hRfhrkCqUen5N+abWH6wNOf5brCl7jawgpUbDtbxmyBCzf+2
 li62mPpcaharTNCh6nnBAb+Br7Xiq3OQIP4orfMvW35NOu1H9NA3of/uBVEzjGqgfqaP
 ZyNa0UX/hRreq652ClgF3t3NZHg/RgXYugDbt52FY1LU3PjVdAjkv9bDrP7nPPQo7VsK
 bGt+yksYY9NHSUYXdahDiZVRPNFJFANWporzCYIVnj2RsO3ShaY0rPEZj8FkjQduTVd/
 BZSg==
X-Gm-Message-State: AOJu0Ywo63TQy+yVASrt5EPuTWaEzenrdgFP5R/IhevYX84smghuvert
 BJ8VD62XPW/9uRk13ZyuVDW1YfvS9dBiP7g2eG4=
X-Google-Smtp-Source: AGHT+IGtzKB6t+0H+EL2Lbm3c7iAgdGMDfkYlliJMruewOm5W8BaebVUVsfkKEN0bZgBKIUtPk6hHA==
X-Received: by 2002:a17:902:c1cb:b0:1cc:29ed:96ae with SMTP id
 c11-20020a170902c1cb00b001cc29ed96aemr26844348plc.41.1699253913228; 
 Sun, 05 Nov 2023 22:58:33 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 05/71] target/avr: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:21 -0800
Message-Id: <20231106065827.543129-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 target/avr/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 16f7a3e031..4402862fb9 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -100,7 +100,7 @@ const VMStateDescription vms_avr_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.pc_w, AVRCPU),
         VMSTATE_UINT32(env.sp, AVRCPU),
         VMSTATE_UINT32(env.skip, AVRCPU),
-- 
2.34.1


