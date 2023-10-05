Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D397B9B14
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHoU-0002l3-IK; Thu, 05 Oct 2023 02:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHoR-0002jK-LP
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:26:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoHoO-0003BK-6s
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:26:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-405524e6769so3359045e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696487172; x=1697091972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3/r4VZNrsW0ONaI2SQTSA/+I8zRyGoURM6aYaimAEiQ=;
 b=BLRNrM71LuXeHPJ1K0jOCkx7gTsCr/aDVsQFZZL3aXSDljE0T+Jy3togtGajo4xRkz
 ZaxDt7XFi1C9kIRIwqcb5Ayg7pj/cNUDxa5w5yBvBOjyE/uiYIPzFLP66FXT1Uc/ShZe
 MzhfHsH06flMnwQHbPHeHDCKS4MEEDlDIHmnBcH42VSWtDjx5Ze5qpnwtxm+lHmNwcDB
 0D9wv+/N97WmHTghYns+NyK3XN5uqhMXwa2txMICDs0s9Bp5tXDcA19L+5rKC1LHkCob
 SCr4a5G4NqAOeo3hMxG24BVFrs9EHGcEVsXA0VmE+1sTOuiPyxOUkGadVQy8rRaQx2vg
 FjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696487172; x=1697091972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/r4VZNrsW0ONaI2SQTSA/+I8zRyGoURM6aYaimAEiQ=;
 b=HnltF0arj44mp/Gbvlox+PIJw2UllUTq6znmKu0VVmdbZX4vewaN3GcMQgrM3xsOaN
 ydvw8/JN2KowB/2SNw6BUM9rpCc6o/rsk//Eq/BCqOYFbpxyuFnrq+3ckCVi0K2BDlho
 kNdIZaQIrvPH9RuxKLzjRKrikmg84/JxvYfzpjvy4wIju+YJKJuenGmunGm9ryUb8odm
 KvX4V4b6jdqVCb/chx2xH57oVEoamOlM046MSRe0bFcYB7xZA18TQb+QCDo/hfopiJOi
 EQ2wXVMo0KlJBR7eJbeq9HFYVTxI8aDcNzY8mb04QNzCb8jeyYxBRhhqSPGWIUk5gHU/
 2LKA==
X-Gm-Message-State: AOJu0YxlCucNMaRqb+xzdplgqUyrHlhXtB8QnYInIT2cHm8XBNyZQFyx
 XcPS6a+ZPENvreDp1N7Suwuhnurk6WCY2qgxKrM=
X-Google-Smtp-Source: AGHT+IF1buY/zVbLlCcd7dSxagx39mIRqdwnPjahjGR+BBM4G5jH5rjt+l/sBYVy6P2yb+vvZixdig==
X-Received: by 2002:a7b:cd06:0:b0:406:80ac:3291 with SMTP id
 f6-20020a7bcd06000000b0040680ac3291mr1201260wmj.13.1696487172569; 
 Wed, 04 Oct 2023 23:26:12 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 bd5-20020a05600c1f0500b004030e8ff964sm3028893wmb.34.2023.10.04.23.26.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 23:26:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
Date: Thu,  5 Oct 2023 08:26:10 +0200
Message-ID: <20231005062610.57351-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Per the "Semihosting for AArch32 and AArch64" spec. v2 (2023Q3) [*]:

  6.5   SYS_EXIT (0x18)
  6.5.2   Entry (64-bit)

    On entry, the PARAMETER REGISTER contains a pointer to
    a two-field argument block:

    . field 1
      The exception type, which is one of the set of reason
      codes in the above tables.

    . field 2
      A subcode, whose meaning depends on the reason code in
      field 1.

    In particular, if field 1 is ADP_Stopped_ApplicationExit
    then field 2 is an exit status code, as passed to the C
    standard library exit() function. [...]

Having libc exit() is declared as:

  LIBRARY
       Standard C Library (libc, -lc)

  SYNOPSIS

       void
       exit(int status);

the status is expected to be signed.

[*] https://github.com/ARM-software/abi-aa/blob/2023q3-release/semihosting/semihosting.rst#652entry-64-bit

Fixes: 7446d35e1d ("target-arm/arm-semi.c: SYS_EXIT on A64 takes a parameter block")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20231004120019.93101-1-philmd@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 0033a1e018..c419d0c33a 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -725,7 +725,7 @@ void do_common_semihosting(CPUState *cs)
     case TARGET_SYS_EXIT:
     case TARGET_SYS_EXIT_EXTENDED:
     {
-        uint32_t ret;
+        int ret;
 
         if (common_semi_sys_exit_extended(cs, nr)) {
             /*
-- 
2.41.0


