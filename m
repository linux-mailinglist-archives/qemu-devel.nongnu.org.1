Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EC98014DB
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 21:58:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9AYy-0003Px-Qs; Fri, 01 Dec 2023 15:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9AYw-0003Pj-Jf
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:56:38 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9AYu-0004Mi-Ld
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:56:38 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a0029289b1bso348673666b.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701464193; x=1702068993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6jP5N4oDTNf+1rPB+v1FHJMicKMXluF1YLQYlJ/khXA=;
 b=NyJBk+pCh/4S+BDGWBlOQh6+yo0WAPSwxqAH/k1teHz7z7yOuLcVOYCdsMsmCR36Ok
 trIKjdYbRXzjz4IuTfUHN6fp7ZxHHXq5tGoMpxvhft8xxQxNQGQcQamlcbgsTxJvv8RE
 Pdnc7mMpqqydSSpd1m1VTbtXB79iiJH/McZbju5cEBNVLCN1zHr4PbQVECfyKObp+Bt5
 5YNjr7tzK+oJHc3AZaqUSlDzyjCNEKWsfY/PpKTVR+2SaNvVoZMuhLeQbIVdCl3uUTfF
 V963VYN7XrUeGXG97AeGi0lmPJ7dGb6FTnbbpF6YMnV0cwJ68yAYb9hhpaoKQNLcnWIn
 q8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701464193; x=1702068993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jP5N4oDTNf+1rPB+v1FHJMicKMXluF1YLQYlJ/khXA=;
 b=AjIZU1TKoqrIYu++T3t/q6v5FRIfKSJTz//K5wGbdzkYbSivKgEqeZtoOes17rMOkH
 gPQ7NPnrGgHscE47+uKP7m1pplncs4YHiPjZXq3xSqZMbln1R6SYbyoxf2e3H/lyCAHd
 IE0zzDcjBJCwCeku2E7XUYdz1bGjV7Yb8Ihdyk0ldTeeZ7AfV37y6e7uxRgGA7aSHTHA
 4qQ70CfWn1zghJT9nxRQvXn9/QFEX9ktVB7PnpXHu0Ibi6rqUnFTOVg7zZTR20/Hl3mB
 r5xiZ3B/Nt/G7s1Q/Q46iIhbFoL5A5uXUYqe9q8k1LZRVM9ceLChzpAqzb71INsUux4A
 4H2Q==
X-Gm-Message-State: AOJu0YxOg60u7wzd3QM+AzMgqwqSvR7Uq0TQKnZ9KB3U6KpRtBZA6nXf
 DA0aZXI068Aha7L3ajWS8MQlyqgcTGK4LkV6WIo=
X-Google-Smtp-Source: AGHT+IF3yZsAR0g2Muyx+g8PfTFCVm8hbSFfHtVpcIrHNNpvl04lCEVUAJv9YLEXbTj6wPZI8Kg00A==
X-Received: by 2002:a17:906:208d:b0:a18:c31e:c126 with SMTP id
 13-20020a170906208d00b00a18c31ec126mr1377778ejq.75.1701464193304; 
 Fri, 01 Dec 2023 12:56:33 -0800 (PST)
Received: from m1x-phil.lan ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170906580600b00a101edb159csm2344944ejq.18.2023.12.01.12.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Dec 2023 12:56:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-8.2 v2] tests/avocado: Update yamon-bin-02.22.zip URL
Date: Fri,  1 Dec 2023 21:56:30 +0100
Message-ID: <20231201205630.10837-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
---
Supersedes: <20231201142139.39816-1-philmd@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
---
 tests/avocado/machine_mips_malta.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 9bd54518bf..8e1ee120f4 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -124,8 +124,9 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
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


