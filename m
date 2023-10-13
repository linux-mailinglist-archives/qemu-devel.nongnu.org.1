Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5437C88FD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL0-0001mC-Cq; Fri, 13 Oct 2023 11:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKy-0001lU-JD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKw-00054s-Vl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405524e6769so14616425e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211865; x=1697816665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2GV5+BWuYseEPnCIlqVoxBjH3V+PPhqPZVQ374dx5g=;
 b=AcDB6BExquI+UYZSBOoMXbIE6T9dC7FyTSAxSBIjqrCnQXQKyvel4FO5htu6A/BwkK
 RXPgUS7R5JGYn9B40lZRfULyl1mv7oSRp05Idf9nmWAfxWhAhB+YOMS6qhb4/AqjACcI
 sxHTLX2zzJ0luJ0S9eriRZMNFDePXlIhfYKa5w520WDcw4K28g3WxbzvliIr9uprbkit
 fNo8z/f5DA8XZLB5YIsp0gAI0OkgVbXNw/U/PUyc9q0g9r2NfHrhYRJKRSLo+qp0IJtW
 OVwLh9LdW9mFyyHOrHDauLvg+NJMRY2CVhrUKzzwnNtF1OtgPPsNJgQ5rYsGq6C8RB1Z
 HB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211865; x=1697816665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2GV5+BWuYseEPnCIlqVoxBjH3V+PPhqPZVQ374dx5g=;
 b=fKCaKTO9yj6XnW8LdonZUi2pIfhRNf73GXH5kWLDLQCF5sKm92Yt7B95eOxlmMojCD
 voK9B00s0+UEyYPSf0yU+aOoVJa+MDwF4JmYSSVUq43aG3xpvdpK1fGM4UwZ4Ctc6MR6
 9ufyXDjnraUcsXoYbH4Dbx7nBlTNOm3mpBVN1IM7DKqQeXQhXrnmJaS/bkBYhILHHqkt
 k5Glb/VzEuFktvF0jkYHdw5aRB1KQgLzvxPgAhWeeo7q6uCFSEfUMs9ExtBELetaXfco
 yDTdtMH3LU9+GIqUxuLCFRT0d3Hx6qPo4a8EIp7C2PbGGiwVXd7G7LNbrlBPRDpoc6P3
 QEWQ==
X-Gm-Message-State: AOJu0Yxgk2rbZYkCWYpnCkJc0yUktp60DfB/p6Z4XPirajVad025w1F5
 dhX08yle7ggkUGgvpejX81lwHn9lQuSZihMEW/c=
X-Google-Smtp-Source: AGHT+IF5bsyMhjobiw7NVWSfyrpeaSiw6r8HMcKuj9YyegjglhljCJ6w8LfEk3SqQTCt+qLYLzFNNg==
X-Received: by 2002:a05:600c:4fd4:b0:405:3622:382c with SMTP id
 o20-20020a05600c4fd400b004053622382cmr402589wmq.17.1697211865491; 
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a5d534b000000b003232380ffd5sm21099803wrv.106.2023.10.13.08.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8199B1FFBD;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 eopXD <yueh.ting.chen@gmail.com>
Subject: [PATCH 2/8] contrib/gitdm: add a group map for SiFive
Date: Fri, 13 Oct 2023 16:44:18 +0100
Message-Id: <20231013154424.1536392-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some SiFive contributors use there personal emails. Add a group map
for those developers. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: eopXD <yueh.ting.chen@gmail.com>
---
 contrib/gitdm/group-map-sifive | 5 +++++
 gitdm.config                   | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-sifive

diff --git a/contrib/gitdm/group-map-sifive b/contrib/gitdm/group-map-sifive
new file mode 100644
index 0000000000..6ba761eb22
--- /dev/null
+++ b/contrib/gitdm/group-map-sifive
@@ -0,0 +1,5 @@
+#
+# SiFive contributors using non-corporate email
+#
+
+yueh.ting.chen@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 9db43ca142..06ac729c7b 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -40,6 +40,7 @@ GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-netflix Netflix
 GroupMap contrib/gitdm/group-map-redhat Red Hat
+GroupMap contrib/gitdm/group-map-sifive SiFive
 GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
 
 # Also group together our prolific individual contributors
-- 
2.39.2


