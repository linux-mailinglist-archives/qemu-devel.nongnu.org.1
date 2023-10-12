Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E17C63EF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn5T-0000pX-EO; Thu, 12 Oct 2023 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5R-0000pA-Iv
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn5Q-0002uL-32
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:14:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-692eed30152so438687b3a.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697084050; x=1697688850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrzk1iKYYVh9HnbJXuW+vPf4UVnHoBYB9oQ+N7odbeY=;
 b=lEpjmyqRiogIbdRe/5XTmhlLKdmbussoSo/SP0+/NHWiksu8wA28b3QNcrAZOzlkJG
 W5UyNx+llOyO5P7ND7ajebB7irB6fNH0zduaAiBZndCB1EkiQvC5TAhe3b7qTRt3ksWx
 9IqXy06ONrCfced/Aw8bNgIQgklvsiu4bgEUImQxDL+pcoia7l5a9HHKp0mNwUCvfOCm
 Fgzzw2oTInKqFtSMLoTkDuMwGLNEXLrVhRsTjCq4+4FokV5dW7XGp078DLKQrSUN2XXc
 pSLTf+WiG9/TPOcLaZ6PhvvspyCxJ8f0sZfLmFJdK/YX5aDyE2g9BSs3wPwGZi5HBluy
 EV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697084050; x=1697688850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrzk1iKYYVh9HnbJXuW+vPf4UVnHoBYB9oQ+N7odbeY=;
 b=dMSmCZ9isw70ZFuKdXkqJqnJletHdzSHOLZM2qkueXt/Rxpf0w1idKURH2n69yiFAh
 GQSLDxqG7I/NaHnMbMGRahmC0QvdLrJn/c+UJ3IPspjbnv050izTJHjmCdc+ySr+j/mu
 +7I8K44eVfhrAukOomuSFNNQ6g64Rcf7aIiiAF5f0TyKAsP+g9hQn2Ph2ebfK6/KGqI+
 OdNdy8KpUUhAM+I53vDLAyt0gRDCga24QP030oPN5ANs44/Qx93EV28pGt/oNZ+25KI/
 EqeSmWiFojWpzO8hhJWPVRD+YqB2Vqr1tRJPhjV85vvGwEhmn8MZbISuCykZlR8gOFIB
 7OBQ==
X-Gm-Message-State: AOJu0YwzlMW6V+QOjn3ZN8TzGrsqn5VS9EdHmDG95JORHaHBxdKnTp6a
 mNc8oWeiLGURTbeToiIcQpGNaYxbZQQgyQ==
X-Google-Smtp-Source: AGHT+IHgypxNRX6lESZXB66/HLyQmMT12nx4TmimJVA697I7YWCqQFKIkRgfHREuIjF7Ct+BupPbQw==
X-Received: by 2002:a05:6a20:6a0a:b0:15f:b5:bfee with SMTP id
 p10-20020a056a206a0a00b0015f00b5bfeemr25621788pzk.5.1697084050395; 
 Wed, 11 Oct 2023 21:14:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:14:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/54] target/riscv: Fix vfwmaccbf16.vf
Date: Thu, 12 Oct 2023 14:10:51 +1000
Message-ID: <20231012041051.2572507-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

The operator (fwmacc16) of vfwmaccbf16.vf helper function should be
replaced by fwmaccbf16.

Fixes: adf772b0f7 ("target/riscv: Add support for Zvfbfwma extension")
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231005095734.567575-1-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c9b39fb67f..c1c3a4d1ea 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3361,7 +3361,7 @@ static uint32_t fwmaccbf16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 
 RVVCALL(OPFVV3, vfwmaccbf16_vv, WOP_UUU_H, H4, H2, H2, fwmaccbf16)
 GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
-RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmacc16)
+RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmaccbf16)
 GEN_VEXT_VF(vfwmaccbf16_vf, 4)
 
 static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
-- 
2.41.0


