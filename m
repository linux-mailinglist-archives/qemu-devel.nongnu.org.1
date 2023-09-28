Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 752597B2604
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwtk-0007y4-1e; Thu, 28 Sep 2023 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwti-0007vs-4j
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtf-0007xn-JL
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:05 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c724577e1fso34557915ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930122; x=1696534922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t5+OWaefyNNMkLVduE/VRJ4ajnCIurTsfMfEZxbDqbs=;
 b=MIr6p1nzHUqHrWCyQaevbx0xjJ5ps6OCYkxetj6rqwDRETUNqGcJ6jpAG2m5f+9u7t
 8I9kLr1GhTquXWFDv29jK4CivzsrZbzTGTh9RBE+8wqvZG3jGt576LZpFXNUIw7SwO5u
 6oWUB0bJI4zfXEWebjEDFl6epmLdpmCJ3YsSNOgLxza2Cn9JIM+tzirtwoGCOUNwungM
 1r1MeqLs/gD7xJH+tDk+0dwZpH4yMkHgIk02WFPcbOejxtRAOmQ9sIS7a2EKRWGmmWLe
 UbAxDWsfcM5862YmO9HheFbc+Xamh53HEFgHvnJJ2bPP+UPKA/MxxlwbKAoWWsy/Q8sW
 ulJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930122; x=1696534922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t5+OWaefyNNMkLVduE/VRJ4ajnCIurTsfMfEZxbDqbs=;
 b=OXIlW9m9QhXNpGIHLoxjjHBgi7OkS3uu1pTN0y51SCQ1VW1tvS33p3CEQgTmyOw7J9
 QbsyvZUZpeNWkb4yXr9slMug2aFSkxgkIiQcCtRg/07N0zAaAQx6YizN0+wMLUkkScyQ
 r6FnmThTruaLgeyt2kfFYqvfGHsursekXEXTAYkNKjb2dxcJH0Or0/UDZNDCNXBz7I6Q
 vQ3Y2NIExNmh+ythB7SNvnjzSpJSoWHJggrk/ymSeuXtMlVHA0u+Jh4HUuGEXiNHR4LC
 8+xWrsuUMmQfGwMeJURnL1x08Hok5tfrkjXVr3w19qe9rcuBGh6MYekZNz51eeZ1sC3g
 ldWg==
X-Gm-Message-State: AOJu0YwCYNVG0LJ5/uWb3e0/g67MFmzfnPwoDxvyZXOH0Gc8s/vRDsdk
 gZWZ+Ak3swut1DwZ9dY5pPZi/PpqT3E6K9q2RXk=
X-Google-Smtp-Source: AGHT+IE2cL82n53So+MqOZG6b5UrFbc9Z4gcZ7JqjB0DhfNCfeZL5HEHzq5De/pi8X33c2hY1rKMtQ==
X-Received: by 2002:a17:903:22cd:b0:1c6:2dbb:e5f4 with SMTP id
 y13-20020a17090322cd00b001c62dbbe5f4mr1974648plg.26.1695930121905; 
 Thu, 28 Sep 2023 12:42:01 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:42:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] accel/tcg: Improve setting of can_do_io at start of TB
Date: Thu, 28 Sep 2023 12:41:54 -0700
Message-Id: <20230928194156.237351-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Initialize can_do_io to true if this the TB has CF_LAST_IO
and will consist of a single instruction.  This avoids a
set to 0 followed immediately by a set to 1.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 850d82e26f..dd507cd471 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -87,12 +87,12 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
         /*
-         * cpu->can_do_io is cleared automatically here at the beginning of
+         * cpu->can_do_io is set automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
          * -icount, plus it would be very easy to forget doing it in the
          * translator.
          */
-        set_can_do_io(db, false);
+        set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
     }
 
     return icount_start_insn;
-- 
2.34.1


