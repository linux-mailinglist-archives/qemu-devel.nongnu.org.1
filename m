Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102857ACE35
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSn-0003Hp-74; Sun, 24 Sep 2023 22:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSj-0003GJ-0U
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSh-00005G-HM
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so4501387f8f.3
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609397; x=1696214197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNQ9mDc3plWciIdjeE5Tzw1D9iur6gZpe1I8Oy7Sjl4=;
 b=d6LdvbsFJW48LbOkCx/pSXY+7i6dUymN47yD/OF6UUGTUDYtN3bB+mM3sHeR2ODBhW
 X0akd98XVMXraaVoM5e9jyQwethu3swTcF1+edQELGB3hpUEtym1Q0RJFqr18WuUmEOP
 nr42F8SsE02QhrVW8DIY/IA6qaD1DPk7/d3w+T4SI/TUQZkAdPUj53ftB9mso1AdpGtF
 dLVfQv30eff976g5RDRX4ANwR3DrVDOA2xWgCJtju9YFoTCDT2ZYWEKlgmpW6DLy2ftG
 MnKiD6rQCGCDdwhE3dmCkyDy2Y+JzanEybMaOaBHrrRpJPuoMU006ywfc53dHcF4y+dX
 KsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609397; x=1696214197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNQ9mDc3plWciIdjeE5Tzw1D9iur6gZpe1I8Oy7Sjl4=;
 b=jVT0Rjj0x/xDXSq8wacRiq42WkxoEdNkxowOYXbV2l9zejO0dTMhxKKU4YKSRXuS+2
 D4czHieuDaNOjeScFEvri9tkliNjzWUFLG4od5nQv6xJYJ+Hsq+oWwAaMEm43zl+CHuM
 HGfkwTJISr7nMt606qbwiujzB3eURHUk3P02iA1C/Q/AGPXtKvS1ElSVxZwCxA5phpj4
 48QyIK4mD7n/sRB/hcGBqhFUEvRyGJL/BQQSK+FvbR/11cOe9hlZLuj/feMpze99UbCg
 h0UvpFA58kqrDpTBtQWD+0dkWvFwzHqk7Gf78O8OfPeRw/KWmULenfZiNtbk9b6uDuzr
 zOIw==
X-Gm-Message-State: AOJu0Yx6YXOplvXgfEZgilmIrjih2NKTi7dp4HzvQAZdu0mTjkqM5dcJ
 ORU4mZ/gtsHwFf5lkABCPA2msm9O6o8=
X-Google-Smtp-Source: AGHT+IFhz2G7GozwqvYHlwccfXooAUAFOB8WjHlmQ1/MdEB6xiH2yTcEVPMd4fVJj5Qu1UL3+nDA2g==
X-Received: by 2002:a5d:4390:0:b0:31f:b79a:c4b7 with SMTP id
 i16-20020a5d4390000000b0031fb79ac4b7mr5058070wrq.24.1695609397676; 
 Sun, 24 Sep 2023 19:36:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 07/28] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Mon, 25 Sep 2023 00:01:15 +0300
Message-ID: <20230924210136.11966-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 68410a0aa9..19e39a2f76 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)
     return code;
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    return tswap64(target_rlim);
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    return tswap64(rlim);
+}
+
-- 
2.42.0


