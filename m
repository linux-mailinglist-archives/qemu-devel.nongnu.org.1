Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA6838BAE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxC-0000N9-MY; Tue, 23 Jan 2024 05:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxA-0000MX-3M
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:24 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDx8-0004cA-BV
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:23 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6dd7c5437b0so274851b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005460; x=1706610260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KxhZwbZAcm1asBjHob1LgeGTJkXdHPPGTQpwmtvThw=;
 b=VDKntUHDe81VJEdB00Nl1mv1yloJGfFuvqU1j00MIgIaeXvAlZ04mK6jNUdjaDBEj4
 l+8d9p/0h6tJLdTYoNacGce4qwcFvTU7aiIAtSrQeKZF1gOZG3ZIc9mK7DloxXDocQVL
 /uOhBU62I2cqb8SP4LHV7K/Nw48A0INZ+kig1T6GoroYKkDCUn52pm724RcHdPFRaR34
 gtROoXWviTfpasy7fYgo2wqAHrMS9v0fqy9F1qKlLGgGrwBg0gtiVViIkiH17a4VP88r
 CfTYj1lnIdrk5C94eALwLTQzSgDfT51Zre1oG4wSbvasU8UPX4FHTtxMO2f/5PnjOxUN
 RcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005460; x=1706610260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KxhZwbZAcm1asBjHob1LgeGTJkXdHPPGTQpwmtvThw=;
 b=VZb6iJnnnIakva1VS5ipfWvtT12wr74BRANZB4wX18Pz2Dy5g4qOJbzIn0RPm+XD9Y
 EeW8BlrXuIwgvAeuus8VbkDRuDtxHW01Q1r8ZQZeDcFcUZ/xoBTY7hlu6wkf5Tmjtj+I
 iFC4kfZoaaQhYW3YM1hc0FEPyksLXIOAwrrZtxuAkVM23CWeG/xykNA/mRpGXANfYGGr
 adIg8MZgJxVGwEHa7ljBD88R/aBgngIEg7HKckTQ9vhsp+jbVBl0PkBScj3ny+PVduIf
 hpgD7m8+CKNCFF1M7tHwXMB6P2SK/H5HODB9OphB0eNTdSMDn8HU15fjYBBTv5b8st01
 a+pA==
X-Gm-Message-State: AOJu0YxraZFqkFicAqtJt+n/WMT+tuqqnrSCzASCvVIZhimvH5/ubyig
 odQkcC6HrLPtNQDga6zV592yH+d88TBep+WA36lQBP+O/9zkavc/lNdPwLbAiqaww8wUxsfrh39
 Fo/k=
X-Google-Smtp-Source: AGHT+IFbEITn4mA6lPyn6EPMoU5EJzjrqY6lMlUcma+KbLrF6SNmFFpxiU91cKUGgNpSwj5myZMDlA==
X-Received: by 2002:a05:6a20:da83:b0:19a:29a4:4994 with SMTP id
 iy3-20020a056a20da8300b0019a29a44994mr6959060pzb.84.1706005460639; 
 Tue, 23 Jan 2024 02:24:20 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 1/8] tcg: Remove unreachable code
Date: Tue, 23 Jan 2024 20:24:05 +1000
Message-Id: <20240123102412.4569-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

The `fail_rx`/`fail` block is only entered while `buf_rx` is equal to
its initial value `MAP_FAILED`. The `munmap(buf_rx, size);` was never
executed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2030
Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231219182212.455952-2-sam@rfc1149.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 86692455c0..467e51cf6f 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -597,9 +597,7 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
  fail_rx:
     error_setg_errno(errp, errno, "failed to map shared memory for execute");
  fail:
-    if (buf_rx != MAP_FAILED) {
-        munmap(buf_rx, size);
-    }
+    /* buf_rx is always equal to MAP_FAILED here and does not require cleanup */
     if (buf_rw) {
         munmap(buf_rw, size);
     }
-- 
2.34.1


