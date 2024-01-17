Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46737830B5A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:44:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ906-0001uW-2g; Wed, 17 Jan 2024 11:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQ904-0001u9-9A
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:42:48 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQ902-00083S-JD
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:42:48 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42C20221D0;
 Wed, 17 Jan 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705509764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TO02vwI+QShdMSvO+cZePxxIm4LvPYMmjakg9J9y48=;
 b=seMzsOH7LBpDje0ksXUdp/9ZA1CSXUuWOX79bqagqdEKtFjrTvdo0BfasvzU6qcQVEDtf9
 /DIxCgJXfTwRlbUhwSkb2OP1eHpO1bK3IaiBHTKKHAXdH+eAX9CNRQNoIwewSFryzcJSes
 X1hheN2Nfkj8hY/F9zgIU1y73kN6Iiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705509764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TO02vwI+QShdMSvO+cZePxxIm4LvPYMmjakg9J9y48=;
 b=WDf9hpcorLZocqEEL6q7QM2v1p41uUP5px+cA7fYklABrjUrD+bL+JgZ5VHomkrrLGggUg
 X24W0psQ9tk8JTCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705509764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TO02vwI+QShdMSvO+cZePxxIm4LvPYMmjakg9J9y48=;
 b=seMzsOH7LBpDje0ksXUdp/9ZA1CSXUuWOX79bqagqdEKtFjrTvdo0BfasvzU6qcQVEDtf9
 /DIxCgJXfTwRlbUhwSkb2OP1eHpO1bK3IaiBHTKKHAXdH+eAX9CNRQNoIwewSFryzcJSes
 X1hheN2Nfkj8hY/F9zgIU1y73kN6Iiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705509764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8TO02vwI+QShdMSvO+cZePxxIm4LvPYMmjakg9J9y48=;
 b=WDf9hpcorLZocqEEL6q7QM2v1p41uUP5px+cA7fYklABrjUrD+bL+JgZ5VHomkrrLGggUg
 X24W0psQ9tk8JTCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 764F213751;
 Wed, 17 Jan 2024 16:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lSycDoEDqGXEMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 16:42:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2] tests/docker: Add sqlite3 module to openSUSE Leap container
Date: Wed, 17 Jan 2024 13:42:27 -0300
Message-Id: <20240117164227.32143-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Avocado needs sqlite3:

  Failed to load plugin from module "avocado.plugins.journal":
  ImportError("Module 'sqlite3' is not installed.
  Use: sudo zypper install python311 to install it")

From 'zypper info python311':
  "This package supplies rich command line features provided by
  readline, and sqlite3 support for the interpreter core, thus forming
  a so called "extended" runtime."

Include the appropriate package in the lcitool mappings which will
guarantee the dockerfile gets properly updated when lcitool is
run. Also include the updated dockerfile.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/docker/dockerfiles/opensuse-leap.docker | 1 +
 tests/lcitool/mappings.yml                    | 4 ++++
 tests/lcitool/projects/qemu.yml               | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index dc0e36ce48..cf753383a4 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -90,6 +90,7 @@ RUN zypper update -y && \
            pcre-devel-static \
            pipewire-devel \
            pkgconfig \
+           python311 \
            python311-base \
            python311-pip \
            python311-setuptools \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 0b908882f1..407c03301b 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -59,6 +59,10 @@ mappings:
     CentOSStream8:
     OpenSUSELeap15:
 
+  python3-sqlite3:
+    CentOSStream8: python38
+    OpenSUSELeap15: python311
+
   python3-tomli:
     # test using tomllib
     apk:
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82092c9f17..149b15de57 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -97,6 +97,7 @@ packages:
  - python3-pip
  - python3-sphinx
  - python3-sphinx-rtd-theme
+ - python3-sqlite3
  - python3-tomli
  - python3-venv
  - rpm2cpio
-- 
2.35.3


