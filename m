Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A47DCF85
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpyV-0004nq-Dc; Tue, 31 Oct 2023 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyU-0004nV-5P
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxpyR-00029C-F5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:44:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso45083485e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763446; x=1699368246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImR5F0hSRNXtIQCqeTGtlhuroRWrhdD1r/ZlguXGn6k=;
 b=doLZq1OLUnbo6rGs6xL0cs5G0bsLnV9tqkZcUXykXk2onpRtKhPfQOOyVgeEkx+nhv
 nX62JIYWVmkonLYb+AMpLoPMoQnAAhk2Q8bSbM9PmSt0wUF4bE0GPSn0EEEykAMyGtDQ
 Seb+r5V+OGCCKSIsdMjT2c9szxiW9y2l00FKCCEpe/walVFzZkxCP3Wviee4NK3If70B
 DHZ+FZHljs2FDZQSvTPK/sjwVeb22BEPA1/dpru1JHMlEflR9gU0jx40D8QpRHE/TgmI
 QOgq260kALPA6UKSj8ALawo7Cf6ywmlw/Rvpn7bQIpj7eoia9U/FeT9wUPF0ELEBHuTg
 hIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763446; x=1699368246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImR5F0hSRNXtIQCqeTGtlhuroRWrhdD1r/ZlguXGn6k=;
 b=PAdO128EUwLwKDqjqTLmZgqijmAYxUXGmIFqw10cqhwtjf2bWnU4rByGVKoZkGiTVu
 h6lDjPCFPwSksEubgKKX+LjfDgbled52u911YGCBr2fgRVHxC0sEI+lS2rEVgIsrSYXN
 91HlNU4EeuXIeS3xGXDJHCUI2Tt4Ro8bjdiUcUMtTJaPvRiURhEOrvQFpSfbyBN+91Bf
 YO2wx7sx67uSmSvtecXqdBQvg5ZKZKMYtkhisVtSac4PKkUxLuV2Zr+qTwBhQ/A1kbrM
 5kK5S2FHy9UqdQCuSDJqcSJl2V05X4ugqiixLS1+geOjtOlqrsKjJQQVarua7CnlUVKu
 2g5Q==
X-Gm-Message-State: AOJu0YwWy4GfMScUIyQd8DAKY3AGwHIdL0HVPVIXYotNoW+VoibqGDrJ
 1EC/M0xqkc4qIse1wz5oMdrV4Q==
X-Google-Smtp-Source: AGHT+IF0rmYRO/mTUEzU0YIxuSSPNaGJ15UtWeKcmJy668F076nGS50Bk5zOBBkkU4wtVyKUMe+ORQ==
X-Received: by 2002:a5d:6d0d:0:b0:32f:7d5a:87ab with SMTP id
 e13-20020a5d6d0d000000b0032f7d5a87abmr9094101wrq.53.1698763445827; 
 Tue, 31 Oct 2023 07:44:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4cc3000000b0032d886039easm1664306wrt.14.2023.10.31.07.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:44:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CE5B65724;
 Tue, 31 Oct 2023 14:44:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 04/19] gitlab: clean-up build-soft-softmmu job
Date: Tue, 31 Oct 2023 14:43:46 +0000
Message-Id: <20231031144401.1238210-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Having dropped alpha we also now drop xtensa as we don't have the
compiler in this image. It's not all doom and gloom though as a number
of other targets have gained softmmu TCG tests so we can add them. We
will take care of the other targets with their own containers in
future commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-5-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index bb24e052f6..5e9cbf9385 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -290,7 +290,9 @@ build-user-hexagon:
     CONFIGURE_ARGS: --disable-tools --disable-docs --enable-debug-tcg
     MAKE_CHECK_ARGS: check-tcg
 
-# Only build the softmmu targets we have check-tcg tests for
+# Build the softmmu targets we have check-tcg tests and compilers in
+# our omnibus all-test-cross container. Those targets that haven't got
+# Debian cross compiler support need to use special containers.
 build-some-softmmu:
   extends: .native_build_job_template
   needs:
@@ -298,7 +300,9 @@ build-some-softmmu:
   variables:
     IMAGE: debian-all-test-cross
     CONFIGURE_ARGS: --disable-tools --enable-debug
-    TARGETS: xtensa-softmmu arm-softmmu aarch64-softmmu
+    TARGETS: arm-softmmu aarch64-softmmu i386-softmmu riscv64-softmmu
+      s390x-softmmu x86_64-softmmu
+    MAKE_CHECK_ARGS: check-tcg
     MAKE_CHECK_ARGS: check-tcg
 
 # We build tricore in a very minimal tricore only container
-- 
2.39.2


