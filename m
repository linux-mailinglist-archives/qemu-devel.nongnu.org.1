Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FC7779E6D
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUkeq-0007hK-Nq; Sat, 12 Aug 2023 05:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUkeY-0007f5-Sy
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:11:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUkeX-0006mU-2p
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:11:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686daaa5f1fso1957577b3a.3
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691831478; x=1692436278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rhmue/BjU41UiF+ApjC5nebRdrNKPT4LzJBrsOT2z1A=;
 b=CjubmK/+b4ou9GDj+qeFp4DN/sb/3yhlY6tF3A360F4V1n/cUXb8cx3sJNKW/zNBwb
 ag4N9V1X/T0d/EzUiB9y0PRtLNdt1ME87ivWkxd4SPFMLUw1bk+9yJmrlouAKGTCxEML
 sXS08aVjmHN6iWfy4QALm7nc5a+OsZC1uXKa42WVNKryXx+lFrPSW3kvF/2cSmm+VVGI
 NU5onyrNA8jpzji/XAxaWGrpIS7W7nke4LNNO95ZIWCLnJ6O5qSCI3VqItlbj9YfFDzp
 s5OGpCEbhwHjz4L5dTAZyNFXDnkh61nl0Spu3eov3uoJduHCtfZ9FKomtdJIXkDxOBQU
 Mh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691831478; x=1692436278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rhmue/BjU41UiF+ApjC5nebRdrNKPT4LzJBrsOT2z1A=;
 b=Z+i3SGts75+FCNBLC2GDHBzft2ObVWKDs/MzKcibE2/S5x2XO5eQP3FdOXFP8Q1zHP
 n4f6qiNiMoKYHrJYSjvybA8pTe7Vs+qRoMoBmavpaUdy1lLXkqquEWa/y/yAzv55X7jl
 qyo4GjU80Xo7gx74jNFGZl1T24AZSUmAvtLP40QFOULa+gVP7CJDQ7+Qj7nG2A7obPJx
 jcovQsuyjivhrZcw+vCzOzl8/ciTsHCN+h3bb/q/Wt7a8GeSHbObAR0j/VvG+cVnATqn
 NQUrhWb2Q6F7/pufy5cwMHYD8zvyDeRcTsgp02U7PH7nTErQk31xsgCzSJQzfVtzLzyJ
 8NVw==
X-Gm-Message-State: AOJu0YyvvCOAjauaGiRL4R9orrl7OOft8o7yu13CV4WTIEZ6CSUGr8RG
 9KNx512nrWHlzIo2nt4O+bI2VzL4lIGcvV8b2eE=
X-Google-Smtp-Source: AGHT+IEq2QCdWrCff4jez3Sx0wpIB1XY+O0k+6WrbZEZVr3Uen8pBLjjcNtgXas2xNAbW4pFVxgxMw==
X-Received: by 2002:a17:903:22cd:b0:1b9:c207:1802 with SMTP id
 y13-20020a17090322cd00b001b9c2071802mr3892215plg.0.1691831478171; 
 Sat, 12 Aug 2023 02:11:18 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a1709026b0c00b001bbc9e36d55sm5322714plk.268.2023.08.12.02.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Aug 2023 02:11:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] meson: Use subprocess.check_output()
Date: Sat, 12 Aug 2023 18:11:09 +0900
Message-ID: <20230812091111.13411-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

subprocess.check_output() is a more concise way to execute a subprocess
here.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
("[PATCH] meson: Fix MESONINTROSPECT parsing")

 scripts/symlink-install-tree.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
index b72563895c..56d603588f 100644
--- a/scripts/symlink-install-tree.py
+++ b/scripts/symlink-install-tree.py
@@ -15,8 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
     return str(PurePath(d1, *PurePath(d2).parts[1:]))
 
 introspect = os.environ.get('MESONINTROSPECT')
-out = subprocess.run([*shlex.split(introspect), '--installed'],
-                     stdout=subprocess.PIPE, check=True).stdout
+out = subprocess.check_output([*shlex.split(introspect), '--installed'])
 for source, dest in json.loads(out).items():
     bundle_dest = destdir_join('qemu-bundle', dest)
     path = os.path.dirname(bundle_dest)
-- 
2.41.0


