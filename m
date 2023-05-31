Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26167718AD4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S8N-0005Xq-Ag; Wed, 31 May 2023 16:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8L-0005We-HU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8J-0006pS-TX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f623adec61so881645e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563762; x=1688155762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjep5DzSWsJXmCBCJKwibVhQeOvg54d0JGWzz1UBQt4=;
 b=sl4ztxn/Q3h+5Y7CffKhkGNliaqVEY5rNcTXxm9NsaiTwpbrx+J1iK1H/XDAzg/SnN
 JfnnHyC8Qke5w9D5IFOLUT4ZeKydknpTr2WbekPXkN+bYNDzv5MXkVBCBPS2zRDCNli/
 553KXmD9eq3u4H7IqPGqQyNJ0fAWMhiiqI+ByNPVKeinzuuG2icpm1++KYjrMVKe30wz
 OQz2aq5PWsEfOpaA9v57znCjqZkUzIrK7pl5uPgq2//39t4QGD99WkfO2qqSKdtP5LDv
 nr8k95t7VKrMxg6FIFC5GFAbsy/BkeZE2QHea6Mn6TBePFXrJueDXlRWvTuyUX/C3V63
 vH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563762; x=1688155762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjep5DzSWsJXmCBCJKwibVhQeOvg54d0JGWzz1UBQt4=;
 b=h5fQ72/28/+cNFUSL7DkekPUmIp4JdK8uvpRGjZz0hNnsk9rzCNOJEJ9b57yLzLX0J
 5zqAtySC8RpooANABLPZj/jxytdSZpsj9Jq/tebdBjuBFqwo8o2orEbzxu2Lejr4ADN6
 /FpsY3rfRhf86vokCPuocNSlxdodjvKJVeWfUrUmtkssP8VWXNyrKelFg1DCoxGQmzdS
 oi4H4tu+Cf3+OYCtt7MNqB5MH8utQOPuq0HUaS6v8eaUk3Q+SgACUg6pGKgpjYYS9F4K
 u6EDr3zgiDlwdWzLcwJMYFnge7xhVd+6NaBwZ6x+hlaVlg2jIXW92Jl/5km4+1HOs4rC
 FY8Q==
X-Gm-Message-State: AC+VfDxUONccBEnaZTj3k0JGP8mOXkhchHHmQh6ct+AuM2bHANZmG+3n
 KLuEIyPNKQ6wW6NvsYxnCCqfHA==
X-Google-Smtp-Source: ACHHUZ4WRV0O7fEbGOtk3mCr+cNpLTfxg9LsQTzL0vP2OZshQULWMmhP3r7lbcjEnRiHtAmxddxLgQ==
X-Received: by 2002:adf:dd51:0:b0:30a:e5bc:547c with SMTP id
 u17-20020adfdd51000000b0030ae5bc547cmr156746wrm.9.1685563762459; 
 Wed, 31 May 2023 13:09:22 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 j28-20020a5d6e5c000000b0030aea925fbesm7946726wrz.50.2023.05.31.13.09.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:09:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH 2/3] tests/vm: Introduce get_qemu_packages_from_lcitool_vars()
 helper
Date: Wed, 31 May 2023 22:09:05 +0200
Message-Id: <20230531200906.17790-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531200906.17790-1-philmd@linaro.org>
References: <20230531200906.17790-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The 'lcitool variables $OS qemu' command produces a file containing
consistent environment variables helpful to build QEMU on $OS.
In particular the $PKGS variable contains the packages required to
build QEMU.

Since some of these files are committed in the repository (see
0e103a65ba "gitlab: support for FreeBSD 12, 13 and macOS 11 via
cirrus-run"), we can parse these files to get the package list
required to build a VM.

Add the get_qemu_packages_from_lcitool_vars() helper which return
such package list from a lcitool env var file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/basevm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 8ec021ddcf..2632c3d41a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -522,6 +522,12 @@ def get_qemu_version(qemu_path):
     version_num = re.split(' |\(', version_line)[3].split('.')[0]
     return int(version_num)
 
+def get_qemu_packages_from_lcitool_vars(vars_path):
+    """Parse a lcitool variables file and return the PKGS list."""
+    with open(vars_path, 'r') as fd:
+        line = list(filter(lambda y: y.startswith('PKGS'), fd.readlines()))[0]
+        return line.split("'")[1].split()
+
 def parse_config(config, args):
     """ Parse yaml config and populate our config structure.
         The yaml config allows the user to override the
-- 
2.38.1


