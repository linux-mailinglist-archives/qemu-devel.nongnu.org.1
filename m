Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D299830796
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:08:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6aB-0006ku-MI; Wed, 17 Jan 2024 09:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6a9-0006gn-OV
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:07:53 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6a8-0001rg-24
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:07:53 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559edcee495so282496a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705500469; x=1706105269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t7kwpiXo36c4SIx90VlKYxfoHr1q8vMvAXlXSskB1x0=;
 b=v8HdfLc1lG7Cjs9+lC1fgqP46Y6lnnwcWYVIas8NjRFU4+GclxEZrqLyLsJOk5l8D3
 eEFwSU8S2OC98WyktlvxUW413IbkOPGKSpevfb4vQaSLQhMD9uGYUEI0bBnU9ZC8H+o3
 tJavLlNhIZI5HTLRBzNTmpJCUY59C7EsztXvdNxskN7nshV5sQK5NMPZeOnTafXxPTvi
 qCkNrL5cqq+C9fe4e59sq6PFFCTMIRIwF2xGsHDd4NbDH3c3md0hrO7wqxSeXJY/3XxQ
 dgBHA0qnSIVZXpHPkLCfqhR8V3KK9kd7UbC05RAc6VlmiNGVqHgidjQalz3r87Zf8ofj
 ERVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500469; x=1706105269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7kwpiXo36c4SIx90VlKYxfoHr1q8vMvAXlXSskB1x0=;
 b=SBs5ssy/+ghtAU1nq7wp3yj8GSjDiutQnGYt2QeDo+EZ76EWJBJE4wGRpXX3uKgqzd
 CtowFkNo7Tb1jEhnA9oeGcmfv18PTL1UX13ccDkb4SReZMwsCKFeI8R03neEbKvJmy0a
 /arW9R+yfwXA4iAUXjSR4RD3yun0RBR0kPt0zm5Ci6NYoyv97bKZYNH2GSfPo+0gWFWN
 PViYbrmmjkvQnHeYbJThmfum2zuLz9uMwSfmc9iT9DUbf0nAZrjugKEbEWWTzqewb7II
 wAZlrk1t0If+iZcAToZnNTOh8sZ38lmYqi2JPBCxDCM20P6p6NGrzSXKQg/MwAXk5SBN
 ri6g==
X-Gm-Message-State: AOJu0YyEo1zxSGbB/nWf3gkpKeN1StgSuRAtpiwJWHbyZ7d6lYNuR2jY
 cf6OVVj+3uGVxQA2Cn4mWFkjiy/HkZTzlh11OgkcjSf6u0U=
X-Google-Smtp-Source: AGHT+IGseLekQmSKXo4ZjbctpQcpXjbgqPAYUb5Kb97xfviYH13tYzYgCWgwWefMxUQim0vnY0qOCA==
X-Received: by 2002:aa7:cb54:0:b0:559:e80c:6316 with SMTP id
 w20-20020aa7cb54000000b00559e80c6316mr317980edt.62.1705500469363; 
 Wed, 17 Jan 2024 06:07:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a056402321100b005594e177032sm3869987eda.52.2024.01.17.06.07.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 06:07:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Ryo ONODERA <ryoon@netbsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2] tests/vm/netbsd: Remove missing py311-expat package
Date: Wed, 17 Jan 2024 15:07:46 +0100
Message-ID: <20240117140746.23511-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Since the pkgsrc-2023Q3 release [*], the py-expat package has been
merged into the base 'python' package:

 - Several packages have been folded into base packages.  While the
   result is simpler, those updating may need to force-remove the
   secondary packages, depending on the update method.  When doing
   make replace, one has to pkg_delete -f the secondary packages.
   pkgin handles at least the python packages correctly, removing the
   split package when updating python.  Specific packages and the
   former packages now included:

     * cairo: cairo-gobject
     * python: py-cElementTree py-curses py-cursespanel py-expat
       py-readline py-sqlite3

Remove py311-expat from the package list in order to avoid:

  ### Installing packages ...
  processing remote summary (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
  database for http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is up-to-date
  py311-expat is not available in the repository
  ...
  calculating dependencies.../py311-expat is not available in the repository
  pkg_install error log can be found in /var/db/pkgin/pkg_install-err.log

[*] https://mail-index.netbsd.org/netbsd-announce/2024/01/01/msg000360.html

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/netbsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 649fcad353..a3f6dd6b3c 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,7 +31,6 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python311",
-        "py311-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.41.0


