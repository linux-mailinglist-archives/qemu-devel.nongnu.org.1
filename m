Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71337C88FF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:45:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKL1-0001n6-BB; Fri, 13 Oct 2023 11:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKy-0001li-UW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrKKx-00054v-D1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:44:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32003aae100so2265656f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697211865; x=1697816665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfRHGZFwD1kKKwqi/x8G1mBNtBCk6DG4NW/2BEPqgNI=;
 b=Pbvay5F3LBbJAmyAVGfSsi0dGUaG56bWCtLmxwnwKsGm5539FLIAmNbbSqCf6yFASy
 cwHNahe0yUR46Up1g0b0X7IojHt5BMqM5l87R70g4T0zjnERfQggjZCF6jlbrrYcblZV
 4o691s05y3I/1Si3ERLtN34LgnD2wcOG7sdSfwe8iMuYZrtT9yrmJSrJ1HZBQtxKXJco
 6FfQ7ycCGJmrN+9FkLUgUc1fQmqbPGq39hsFp0VW88ZUcJTymhW6LIxAWlh4imUObOS5
 hUNwzi35Fvx3JWVwMF1p59yXloc8VOcZdAqDtOsAQKhsuvsf+6w1NMntgXn0a0nP/p8U
 nigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697211865; x=1697816665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfRHGZFwD1kKKwqi/x8G1mBNtBCk6DG4NW/2BEPqgNI=;
 b=M80buF257SWgNn5JH/RWbJ9oI9sOQ8RNPxMlIF/xMfNCztAwHnQF5rXUOZhgl+xDY9
 G5X9aHm1/c1LolDquw6bZSrkV36RP75qXB1u2H0rYwcMdE5ikuMJ04WmicWLdUc7P+hr
 bwACLolPzl3i2+EVNDEKWlJS6F35FKcszJMl44/swqFz1WE6o9WvpqqP0ExrPMnbEiBN
 u13/7oIx9Wo8mjxkOU7k6+/BUbbOzj29PNkRRVTYqZzxgUkSyh42UJv9guKaxV19CBhW
 dq7oFwkWNn/TRa9Iph2wUqZKRhWHeQ0wzvqx9P0mJ1qdEYiE3LZsAE5HF7TLgY4zn1FH
 PsBg==
X-Gm-Message-State: AOJu0Yz+ztKF1kXqCPGffRrKb1ljfp68GMlnQSFinWhFnrc3UmG31H4E
 YDelbauFw7kZav7dUxKkvWIu4zGb+r9tZkwTQNA=
X-Google-Smtp-Source: AGHT+IEwUgmo7ftsHhe9wHMIY1FFuYIx2s7PQX+1NLzS8c1vQcqxoS72NnX/F7Dz5PfgZVc7NIBDeA==
X-Received: by 2002:adf:c6c8:0:b0:32d:9b18:8f4e with SMTP id
 c8-20020adfc6c8000000b0032d9b188f4emr374774wrh.34.1697211865655; 
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bh6-20020a05600c3d0600b00406408dc788sm434340wmb.44.2023.10.13.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 08:44:25 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9A2561FFBE;
 Fri, 13 Oct 2023 16:44:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marc Zyngier <maz@kernel.org>
Subject: [PATCH 3/8] contrib/gitdm: add a group map for Google
Date: Fri, 13 Oct 2023 16:44:19 +0100
Message-Id: <20231013154424.1536392-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013154424.1536392-1-alex.bennee@linaro.org>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Long standing community contributors often use their upstream email
addresses when working on project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 contrib/gitdm/group-map-google | 5 +++++
 gitdm.config                   | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-google

diff --git a/contrib/gitdm/group-map-google b/contrib/gitdm/group-map-google
new file mode 100644
index 0000000000..8c53e0cf67
--- /dev/null
+++ b/contrib/gitdm/group-map-google
@@ -0,0 +1,5 @@
+#
+# Some Google employees contribute using their upstream email addresses.
+#
+
+maz@kernel.org
diff --git a/gitdm.config b/gitdm.config
index 06ac729c7b..c9d961dd23 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-amd AMD
 GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
 GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-facebook Facebook
+GroupMap contrib/gitdm/group-map-google Google
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-netflix Netflix
-- 
2.39.2


