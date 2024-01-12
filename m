Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C1082BEDF
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLH-0005eV-9n; Fri, 12 Jan 2024 06:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL9-0005YL-OO
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL7-0008Ti-EU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-337984681bcso178155f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057476; x=1705662276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVkGVh4+t2FoCEclQT7GEoG8hF9yqJD2PFyFB5dun20=;
 b=Ft726suPnc+qdcegNw7nAJEK8QwjMlqySyHLzqaj2PFpKo1huAlc7qEZ+i9iJ9eKTa
 R4uaW/SJTRecba2pRXpU9LzZoyPOgzjaoiPf+cDNYL2iyp5BB5QieiltbIC5l4vdNCLJ
 G1xNSyXtwzIPRf6G9kf7boznTPGNJ8ZWfMUpeCbaRPOXKQkRQ5JpEdygFKBsa/m4xeZB
 pXknwNKuQroNbmXz66ekMTdHTYGQN8PhPeMXY5TVS316TXvUXZnnGro8dHROj2YBB5ks
 TjZaGTsESJZ0260vLU+A0w38RcaWPvUPws85iG4i+nII6uThixLHdZswEJP2MbXWG3Gj
 EeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057476; x=1705662276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVkGVh4+t2FoCEclQT7GEoG8hF9yqJD2PFyFB5dun20=;
 b=tj0mql7x9KlvOkQBanSqKhSK5rplkf157DVWTSryVxfw5nyLSpMjIaCimH093N5eLx
 GWorPUf7R7AB7QD5mOMApTdjPyThlR9ZSLZlE/RQZ0Qc+6wFngFANqAhjLZ4SXceACDk
 we+Uf2+eOY2340kklefmOBPvDdq0UPDZ+g6bv6Bk+ZAWj17y2Ha6nlr7azaOBE4QPtR2
 PhOzqDOtUO7yu/3PaWbNXDmFwALhoaxmOCLCgO0QF9tD7P04kzuGuZ0yriwfhO3KQngv
 cY+7C1gwgoVURAdSBtNWgBJlDbWu2jDxWvHr2JVVdFYk19nvDxTXVexK7jZ2n1tj0L6H
 Ib9w==
X-Gm-Message-State: AOJu0YwXrpV0BcZZINcwoxyT2AvJnS9+BsCJ8mxVL6apJzU2lr1KUpXV
 YKSuwRTYhjWIZMlarIcr2FCi4Ce7rzDoug==
X-Google-Smtp-Source: AGHT+IEJD/Ikzddtq12/6blXn+jBN1O+shYqhoqRugzK5ywVVkS06g7Ueko4hTBm5E1K5b0vU/ZL+w==
X-Received: by 2002:a05:600c:4496:b0:40e:5534:728c with SMTP id
 e22-20020a05600c449600b0040e5534728cmr706949wmo.136.1705057476199; 
 Fri, 12 Jan 2024 03:04:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm3595945wra.44.2024.01.12.03.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F7565F944;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/22] gitlab: include microblazeel in testing
Date: Fri, 12 Jan 2024 11:04:16 +0000
Message-Id: <20240112110435.3801068-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

This reverts aeb5f8f248e (gitlab: build the correct microblaze target)
now we actually have a little-endian test in avocado thanks to this
years advent calendar.

Message-Id: <20240103173349.398526-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91663946de4..ef71dfe8665 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -41,7 +41,7 @@ build-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs
-    TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
+    TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
 check-system-ubuntu:
@@ -61,7 +61,7 @@ avocado-system-ubuntu:
   variables:
     IMAGE: ubuntu2204
     MAKE_CHECK_ARGS: check-avocado
-    AVOCADO_TAGS: arch:alpha arch:microblaze arch:mips64el
+    AVOCADO_TAGS: arch:alpha arch:microblazeel arch:mips64el
 
 build-system-debian:
   extends:
-- 
2.39.2


