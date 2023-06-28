Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CF7415BB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXTz-0005wJ-WE; Wed, 28 Jun 2023 11:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXTx-0005u9-MJ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXTv-0007tr-Rg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d97ba7c01so4346922a12.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967602; x=1690559602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eShSRmy/GqoDH/FhCcesT7q/quPV3TAXq83nQ07WWaA=;
 b=FQ/MBrRNMp4nnOnwYZhH7DeLsuzgZf4Y/DG/Vugzpptbjxz5HGHyc5tb9j7ZBGNP67
 q0KQBm0df4jnFgFBqY7GPlE2gPxe2jLmNo3jIpP9tSGIUkEC9vhuqyByo2fz7me3Hzg8
 98J0U2GHhsyxAY1OAB8AIN9bDnuQgW2IKpiOraSvuswXVmJueNleJbK0ZEAkADU5Ayog
 1mpxhdSOvVuT244IFUQOJB6LykS5MIq/lA0KSnrRJJRUvg6CYETic2j26qvr5HWe8+Tf
 yJ5DFN6CAjmzHpILVhHqcZoblWAZvpKWC7a64SQBWyJKBsztcWmdjcdm5wd6grbjxB6X
 IcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967602; x=1690559602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eShSRmy/GqoDH/FhCcesT7q/quPV3TAXq83nQ07WWaA=;
 b=GxtyU9b0yPCe62cUYJMl3WyUbT6mE+1OJnoy5LL7BTuysLIbTsH7inO0MU0ajjr/rT
 ihFE/nez6ecVy8/RAcJEi+QsONLstFo3RHJI2Gfv7DRilifyIh2tJIGDw7yCtYYMLGN0
 BncjRhHyzpOfYdnjSwigktr+m6NwtP7fovwbkkmI/c8mU//bF59ZkBDiN0uqObnGjF1a
 hauufAwjsUj6ALe+f/+ySrFnosdlIZ0oHoeHufNso2godCH43LVdxY956kMXT0ndGu7O
 a2QMhPFMtvnRY+FjLPSZmosb2iONsnxiMukk4xvGQ0P0CyLqpkMXgARzmkw6YR8NIaJH
 0r9g==
X-Gm-Message-State: AC+VfDzsmxgdXiWiEL0O/vqyf7CnU0qtvzz0NVazgd7a36Z3Rko+q+rT
 /OkXzjKs8XhMrAdU0gT6UCrAFsG8r++odArvIF0=
X-Google-Smtp-Source: ACHHUZ7qTu7lr1d8DHP9YWR00sXm98zKjQ+96l2Lt/uEUuI7/SFw7CyDgXrEOgqlU13/jHK04A/cSA==
X-Received: by 2002:a05:6402:1290:b0:51d:a237:d45b with SMTP id
 w16-20020a056402129000b0051da237d45bmr5566897edv.36.1687967602044; 
 Wed, 28 Jun 2023 08:53:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 m16-20020aa7c490000000b005187d2ba7c1sm4859551edq.91.2023.06.28.08.53.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PULL 01/30] MAINTAINERS: Update Roman Bolshakov email address
Date: Wed, 28 Jun 2023 17:52:44 +0200
Message-Id: <20230628155313.71594-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

r.bolshakov@yadro.com is bouncing: Update Roman's email address
using one found somewhere on the Internet; this way he can Ack-by.

(Reorder Taylor's line to keep the section sorted alphabetically).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>
Message-Id: <20230624174121.11508-2-philmd@linaro.org>
---
 MAINTAINERS | 4 ++--
 .mailmap    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21a587ce4b..aba07722f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -498,14 +498,14 @@ F: target/arm/hvf/
 
 X86 HVF CPUs
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: target/i386/hvf/
 
 HVF
 M: Cameron Esfahani <dirty@apple.com>
-M: Roman Bolshakov <r.bolshakov@yadro.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
 W: https://wiki.qemu.org/Features/HVF
 S: Maintained
 F: accel/hvf/
diff --git a/.mailmap b/.mailmap
index b57da4827e..64ef9f4de6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,9 +76,10 @@ Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
+Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
-Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
+Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
-- 
2.38.1


