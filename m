Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB128038C5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:27:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAq1-0004Bu-JY; Mon, 04 Dec 2023 10:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAApt-00044g-JV
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:26:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAApr-0005Ua-Nm
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:26:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso45795295e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701703574; x=1702308374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FOPF54Ts8pAoe2u+mRITxVWTs2rKpGlxkYcxd5nZGU=;
 b=unhO0vPOPsQV3moEqnMZVbwn65CO8XyEKgM1NzWHs7HilesFr6SPvFpUvCdDufLrNT
 /eaaiUedKax2jnR5Hk2IyZXTBQqXLGvtbIA85mM+ELvKVI0bFeurBZTHXkodpvDWQ1/S
 LCMSVM2Rh2gQNY4YY9UxnSeWggU1KTFWdKYuv23raIZ/ZT6W5udpQzfASrtakXvoma1v
 YrBJp+Bs6QcOZ6dG3Zf0Yc+rw+rlwJAZWd89CJXlF9buTBaZ6rm8EALCH5Z9aDzFwUHZ
 VvOdG9quBLkb3UglbFFBy2xaAaeHyySxhnxTy3mo50lOpEN8iMwZR420Ni+uwa60LdzN
 0XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701703574; x=1702308374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FOPF54Ts8pAoe2u+mRITxVWTs2rKpGlxkYcxd5nZGU=;
 b=bNSNpL5xQQ83QwE0Ms39GmvU9MdIPebcHPzkypyPkY0qcnXIwJItJMSch/Zghnizmq
 7AkdMBvf2LWpgxraisUaQri5hJHQm0IdNoYg+8hpL6DSwGXVOfVoNz7gfuQS/oYLgyju
 CrGQiA84N2NBbgrxOWSojUlb3ZY8yRNwvKCzGnGXHYR7NHoKXQA6SNlvH/i5fGZjv081
 p9MGVKcIMCb/ASjvfbqZjjNYpEOtE/jDEwMv5cQ5KC71QQKq88/U47OxNGYZn3PFSZvc
 9cfVgdNhJYLtbJUz49GrKqUAolENkrE4x3D/SaC7qrzA9/rbRtz/HB+tbS88q3+Isy/+
 8hig==
X-Gm-Message-State: AOJu0YzeZPxzjcSIUC9rbKUFne1xYB2LJQ3SQehEZ5HBvaBAYXcohBap
 lTqdRbgLUrEB9mCWZz+paOe6l29HQFZLbD1lQn8=
X-Google-Smtp-Source: AGHT+IHX+CPEIaEpuFbgoGNu1DuFkQK9sEDxOVnHsarn5RwVqTxFiaafONykOxKvWdzchz6EXCOIcg==
X-Received: by 2002:a5d:60cf:0:b0:333:3c99:7d28 with SMTP id
 x15-20020a5d60cf000000b003333c997d28mr2476076wrt.75.1701703574003; 
 Mon, 04 Dec 2023 07:26:14 -0800 (PST)
Received: from m1x-phil.lan ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a5d6e53000000b00333423ffcd6sm4629412wrz.51.2023.12.04.07.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Dec 2023 07:26:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 3/4] tests/avocado: Update yamon-bin-02.22.zip URL
Date: Mon,  4 Dec 2023 16:25:23 +0100
Message-ID: <20231204152524.37803-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231204152524.37803-1-philmd@linaro.org>
References: <20231204152524.37803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

http://www.imgtec.com/tools/mips-tools/downloads/ redirects
to https://mips.com/downloads/yamon-version-02-22/ then points
to an invalid path to a s3 bucket. Use the correct path. The
site will eventually be fixed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231201205630.10837-1-philmd@linaro.org>
---
 tests/avocado/machine_mips_malta.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 99bee49e9a..8cf84bd805 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -128,8 +128,9 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
 class MaltaMachine(QemuSystemTest):
 
     def do_test_yamon(self):
-        rom_url = ('http://www.imgtec.com/tools/mips-tools/downloads/'
-                   'yamon/yamon-bin-02.22.zip')
+        rom_url = ('https://s3-eu-west-1.amazonaws.com/'
+                   'downloads-mips/mips-downloads/'
+                   'YAMON/yamon-bin-02.22.zip')
         rom_hash = '8da7ecddbc5312704b8b324341ee238189bde480'
         zip_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-- 
2.41.0


