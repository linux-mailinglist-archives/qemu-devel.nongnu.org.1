Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1947DEA2D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXq-0005l6-Jq; Wed, 01 Nov 2023 21:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXa-0005YZ-Ez
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXW-0001Ww-9q
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso500087b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888629; x=1699493429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGcbTt26SgxS0ytgFRjc8lzuW9J4z1MRxuXRCSnc66o=;
 b=jxrfuVutmwWCVj810h/jVmNUT6D6EF4lotCL7AYsnxfBsPlJy1kDYwMfFurAkPVaJ5
 TH15rkIIwtXqRSdE6n65Eb+IO9ZCG0Swk1tuOTR7isLB2XfoI6eG9lGV3tkxDqoAyR1g
 YJ73UPLzrQ89eW9MSl5iv94A6DJ3XzkpbNWQmxn4dJR+8hO+9zt8x3NOXaWdHY6Q6Iir
 zEAY78rY//5d7n71iI/fPzxz9BgGgmax0A2P0LsRz5RUn/Zz83Rq0vEQTDIaIGNRPgV5
 jFiErKqtga5buZ3o7uoF2Ab6vSdvwSvPg6+2zqX8ylzUfbQVVNkizThPDpxP61V3g13t
 inEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888629; x=1699493429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGcbTt26SgxS0ytgFRjc8lzuW9J4z1MRxuXRCSnc66o=;
 b=dc5eIvxBJXG1RGIBDy+aKx0nK87Quma1o6/6bxjH2uj17zLCnsGEtNO7vXEAp5PHzY
 qGQE7T3I/Vic7WBw9G3yKVlA5KZM98/uN6nZZ9W/zRo+3LyWfARCESQ4BWOBvShtIDr9
 4tTVBoayq+KRMZl2Bb53D3DGx7vAj9JJvtYlOPFKQl2VM0bthbUTGjaJNRvS3DQOFO2n
 x3POCf4xSmwK1TGGjwJIAu5eMTIeDc4Xfee0ZVPmKUKYFVq90mMwrl7c1PgvG7GJ2fvL
 2LuYf+mgQ0ILTpCd/rhj7v3jOLD6ZtGTLqUoFBYlCT+VVVE05r2g/y1uaTHlEzMh/8fD
 /ahg==
X-Gm-Message-State: AOJu0YwnON/Dqr7hi3GwmXiz7/7QgPN34b2P6A31i/LYZdrlsEq2Wbnc
 jh2pJZt45Hh+ddfBET6mz6ox1/LGhM7jTmyr0kQ=
X-Google-Smtp-Source: AGHT+IE7Y3mOYyrrCQ/3OQVZx7xKIcEBZiy4IwpG13hL3GKeztRuVKSN1UBtgXT0zNlU+F7+MNb5+A==
X-Received: by 2002:a05:6a00:16ce:b0:6bc:62d0:fff6 with SMTP id
 l14-20020a056a0016ce00b006bc62d0fff6mr21933584pfc.32.1698888628054; 
 Wed, 01 Nov 2023 18:30:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 12/88] target/hppa: Fix hppa64 case in machine.c
Date: Wed,  1 Nov 2023 18:29:00 -0700
Message-Id: <20231102013016.369010-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Typo of VMSTATE_UINTTR_V and VMSTATE_UINTTR_ARRAY_V macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index ab3e8c81fa..61ae942ff1 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -24,9 +24,9 @@
 #if TARGET_REGISTER_BITS == 64
 #define qemu_put_betr   qemu_put_be64
 #define qemu_get_betr   qemu_get_be64
-#define VMSTATE_UINTTL_V(_f, _s, _v) \
+#define VMSTATE_UINTTR_V(_f, _s, _v) \
     VMSTATE_UINT64_V(_f, _s, _v)
-#define VMSTATE_UINTTL_ARRAY_V(_f, _s, _n, _v) \
+#define VMSTATE_UINTTR_ARRAY_V(_f, _s, _n, _v) \
     VMSTATE_UINT64_ARRAY_V(_f, _s, _n, _v)
 #else
 #define qemu_put_betr   qemu_put_be32
-- 
2.34.1


