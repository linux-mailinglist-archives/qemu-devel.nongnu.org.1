Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698482FDA6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 00:11:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPsYz-00058D-9e; Tue, 16 Jan 2024 18:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPsYw-000585-Nf
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:09:42 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rPsYv-00053r-1u
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:09:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E58591FB8D;
 Tue, 16 Jan 2024 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705446570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqhiPA2ltJb1pWPy41oGaP6CywXePBUK3eyFuzKAqlY=;
 b=pORuoMcGN55o7/8jIgJW0qtP+f3r0u1dfxdFZm7fy4KQrhUC0ayMZqUABOrBcdgL8boxy+
 XjMU09Vz7WqdiCBEp52/mBYir6KAyNo3XS0uw64Spy7UqJbAIv+UkS4IBpjaQkEqrNWYDj
 PiDsGUAOf7rC/jmRPHcajlSz2erF9nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705446570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqhiPA2ltJb1pWPy41oGaP6CywXePBUK3eyFuzKAqlY=;
 b=7eumgzB8CcXSUddjqJRvgDRlZxBnTAtOjbKBFIp9iu9UTadLltRFK8TKdePAQS1ZfTEbhN
 ESm/eJ4BDHI/H0Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705446569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqhiPA2ltJb1pWPy41oGaP6CywXePBUK3eyFuzKAqlY=;
 b=Zqz7h3FPjON2+dvK22SrsGE5W7pnbQMdVEtRcpxr7MBm53MIxtozJnyVN+NYXQz2L7lQNu
 0tEMfZr7K/ukf5ikgibN4jaKdMMzxvQc6+QjNE4lkbch0f0CEcvn4E+cXboMwhY0Y/j0Fi
 rKjyGcBcZ1woMPP8jDESTH5dXdscop4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705446569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=rqhiPA2ltJb1pWPy41oGaP6CywXePBUK3eyFuzKAqlY=;
 b=eHjpHL8HfRyw/GYkeSoiWaDoMX+gqPShB9OPt2K6tmPs+oY+8rzjmy5/wqn8S+b6g9QTQL
 ygYi1QjxIgmmhNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6224B132FA;
 Tue, 16 Jan 2024 23:09:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 41X9CacMp2X9BwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Jan 2024 23:09:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH] tests/docker: Add sqlite3 module to openSUSE Leap container
Date: Tue, 16 Jan 2024 20:09:24 -0300
Message-Id: <20240116230924.23053-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.79)[99.09%]
X-Spam-Score: 2.11
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Include the appropriate package in the dockerfile.

From 'zypper info python311':
  "This package supplies rich command line features provided by
  readline, and sqlite3 support for the interpreter core, thus forming
  a so called "extended" runtime."

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/docker/dockerfiles/opensuse-leap.docker | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.35.3


