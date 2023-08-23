Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2EB78615B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOf-00008h-6E; Wed, 23 Aug 2023 16:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L6-8t
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Tu-W5
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:56 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so41364445ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822215; x=1693427015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAp8kyXyMTKWzGhsCmv8dMp5tljJJ11V4daC8NGaro0=;
 b=mzX0pG9AV67RhAnia5Zj4ucDOEi5xZITeXhD4t7QsqPQ8NiJdlYGX1fyHYvcGj4yfM
 dajr3TQ5M7WYgFUYvinzQomMp9z+3i3ZCou97yE0nce7Ezsu/ILQ5Vm6mrqVAxsGgMrj
 A86la6yxp+jUkp85TB9P/C8BwuL/6IMwUa9HYVgSAqYbQg/CggntgUSbD8aG8Y6cL7tE
 sqA4yI1lqryhkVRkfsu39qEhLVggb5HtlCzsAgzG0L1JwliE1WkUOahG0KqArOoLa9ol
 NJJS3tkRpcvfm+5SC7htE0aAJw33ng8jlXwHQzgTr4OBkOccqggwxDj/bSZm4LrSp53x
 u5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822215; x=1693427015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAp8kyXyMTKWzGhsCmv8dMp5tljJJ11V4daC8NGaro0=;
 b=lnGAABhkP5FU1jlwg/ATSjgRIdsIF8DubnHnOmp9GtDqKfdPVWXUT36an19Ara2edD
 vmY8iRRbkZHB0595mK65PE2RTdbwan3JCN3uWcdVHUsYw+dFtAHOXz43U5irZAeUWqO+
 RHHViia781dlgvlKjVCmQsWon9N/ct0z8Ar05vzDgq36Je7tgrT9+z/Fg9nDFdZO1Z7I
 LKH9gHwGjKNTtiyatDTBnsxeaurZ1b8LbfH7Gi52VUTyVVdU7KdfBLcfZdRCd/lnhrMm
 fYvIfTkWCc6m3Fo2TigDZkvhpVtro5o6tdVZUEjUXtErfvXM7E7G6OeFR9y4U15h7xi+
 STOw==
X-Gm-Message-State: AOJu0Yw91TTYHW87ZNuENFJEDNuQ6543aQDSBHupOOC31iJ7aovEXIBh
 IKfAckAyI6b8jO/CPrcK3mdSoRg97v/0VHZHnDk=
X-Google-Smtp-Source: AGHT+IFN5Y4Cuuu2b4tTKO84Vm7u0KeZpH1drQAS49Gb1QUWe61HMVrGLTy3jTydOJEGWhUZwGzfDA==
X-Received: by 2002:a17:903:32ce:b0:1bc:56c3:ebb7 with SMTP id
 i14-20020a17090332ce00b001bc56c3ebb7mr14508997plr.20.1692822215710; 
 Wed, 23 Aug 2023 13:23:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 08/48] accel/tcg: Widen address arg in tlb_compare_set()
Date: Wed, 23 Aug 2023 13:22:46 -0700
Message-Id: <20230823202326.1353645-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anton Johansson via <qemu-devel@nongnu.org>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-9-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 11095c4f5f..bd2cf4b0be 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1108,7 +1108,7 @@ static void tlb_add_large_page(CPUArchState *env, int mmu_idx,
 }
 
 static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
-                                   target_ulong address, int flags,
+                                   vaddr address, int flags,
                                    MMUAccessType access_type, bool enable)
 {
     if (enable) {
-- 
2.34.1


