Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685BF779DA3
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 08:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUhv4-0004No-A4; Sat, 12 Aug 2023 02:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUhur-0004JV-DZ
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 02:16:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUhup-0000jd-Os
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 02:16:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso18737475ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 23:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691820958; x=1692425758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zpRXX0MOvFzeoXEBWluDwa8bnkmvIKfq1Ck9DtAohE8=;
 b=FJRhCE3Ki2i5aMuTCNkJuXD3lPaXZIJzsaFhZ3vt/HXvTRpL1nx+Onvo7s12vNpSuZ
 kML5Ahg5EPEpeP0HSECfKR2R1HjAU1KC3AcGycRZd+jn7ryrTBw19oESWagUrZN92efK
 ADfT8FS5EyK6t+CcCDRxeUJxWOw3TcEyiynLAy+S2U0zJsbgMo+ku/AfFvXZJXe+rdyr
 rCtkNEqlQ2da3URR4PRwzepP4ApGtXKja5/OgBAdjpZpwCdu695DQlYSP9SApe6PWpEP
 BSpKMuYOD+oqNEARALWIqp980eWG0/3pNKBvtcP5h8YNKA26sITCPlwLDofFLRJcpo6Q
 H3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691820958; x=1692425758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpRXX0MOvFzeoXEBWluDwa8bnkmvIKfq1Ck9DtAohE8=;
 b=TQkARyCKNTQZkc38Q7RgmWN/A/6o/UVLe4P/D/9jNf9GetMsT9nmrAfI50XV0ijHQg
 EtPOu3FrO+vyFc/0saBNEvLgFAq9NRdawupHaKi9Ovurolh/YTu6YsykrmetUQI0OHM9
 5Sbk1vpOmYWWduyzk6XGEw4so0seL37wUJdGUsHozz6gRH9gSwemKEXhKBusDzvP08Ui
 z1C4k/BfSbDiUfk9uBreBjgpRYy9eOHmLcEgnEb+Aa8iK0ArFRLU57k3ZQyAxBiIrzyZ
 t1xqKZXmWxtuURA8UgpoatnQ3BcpKkSYHCDsadgmcnmWUOvGKa/M17ta5xJn+1nF4gn3
 Jc7A==
X-Gm-Message-State: AOJu0YyGKkfwyMhuVoemsAuDcGXnuPXxZB8elfSRPlOhzPM2VKdqKZpC
 Bvf/S54tyagNhkk/RRkZhPpw3CiOEdeJlKl159k=
X-Google-Smtp-Source: AGHT+IEpFj5WK7/vcLTJR0XeqmgTUWDO26bmnmUxQXVfEJf7egH3tAdUd/VawGvXilKceLps+ra4Vg==
X-Received: by 2002:a05:6a20:3255:b0:13b:d080:aa03 with SMTP id
 hm21-20020a056a20325500b0013bd080aa03mr3469564pzc.60.1691820957666; 
 Fri, 11 Aug 2023 23:15:57 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 kg14-20020a170903060e00b001bdcc3a09c3sm450068plb.256.2023.08.11.23.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 23:15:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] meson: Fix MESONINTROSPECT parsing
Date: Sat, 12 Aug 2023 15:15:38 +0900
Message-ID: <20230812061540.5398-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
must be parsed with shlex.split().

Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 scripts/symlink-install-tree.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
index 8ed97e3c94..b72563895c 100644
--- a/scripts/symlink-install-tree.py
+++ b/scripts/symlink-install-tree.py
@@ -4,6 +4,7 @@
 import errno
 import json
 import os
+import shlex
 import subprocess
 import sys
 
@@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
     return str(PurePath(d1, *PurePath(d2).parts[1:]))
 
 introspect = os.environ.get('MESONINTROSPECT')
-out = subprocess.run([*introspect.split(' '), '--installed'],
+out = subprocess.run([*shlex.split(introspect), '--installed'],
                      stdout=subprocess.PIPE, check=True).stdout
 for source, dest in json.loads(out).items():
     bundle_dest = destdir_join('qemu-bundle', dest)
-- 
2.41.0


