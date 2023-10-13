Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD87C81C2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEI7-0002GU-E0; Fri, 13 Oct 2023 05:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrEI3-0002Fi-Bg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:17:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrEI1-000637-8s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:17:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32003aae100so1992397f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697188619; x=1697793419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/qR6c6xdtLZGOn1xkvozkK1KVvB2uENXpYzTOdqsmPM=;
 b=qHSucJQBaXNkmGoiLjEi8DZhqNUraMigVABAFxsu2FzVRsLize/9nkdQh9Eqacuzea
 Sb1BtfMY0+jAIwe5nr3asxTGIUz/1Clc5C8SQSerrsap6B8zG/yyqb9rEPsfMszAv9Mj
 nNn5X6O5dMMBFMCPaXpA45JEl0rWTwc8T7FwRy2iGV8aWPhSVBqTz0FRKg649oezl7u1
 ECYyQpI0mvyoVNYZIDDTxAxCOY596bqNYW1MJE/aW1DK44GfveuT0J7rQhDjq7o0Uv0U
 A3zw3Mw7TNMH8DPBK14f+ifqONxq2LfKiVO3OICjf8fs8zGjUDiNWTfdJn/883KKI+BY
 XNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697188619; x=1697793419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/qR6c6xdtLZGOn1xkvozkK1KVvB2uENXpYzTOdqsmPM=;
 b=o8Id5KhEk8jn/OFZr2HAEI5ofFsy666hX0qPjngP690om8GoYel5wfY9Ef75SePxP1
 GMn0ipfbSmIrT+Vf0qvK3xg8Io8eHzNHjgnMgEpRdsopkTXpflIvWOwD/pymJf7GaAQ+
 cN16hpUpRatzJrF0eXa6vpJxc+C6Acr1p98S2Cc+y6oS3oXCvIG/+GKwBb5X3vz1wbaf
 My6alIC5BydN02lEviw7CaFOMN7nEgqtTBI38Lxap4C/h9headYbAlZMEWjmFXbU7FW7
 Jh5p5mli0g9IraBs2zhEgwJdLn/7uFvdna6J2+QXlbverrUj/SA3qggDzk2ANlPhLaZ8
 aWdg==
X-Gm-Message-State: AOJu0YyuPu+ir1jWg0KyXyAGLQMZSHiTEliP7zYCUgVCMrkia21rMsbH
 fYcsDMVzVOfnckVJ9rK7MDqfe+tXUb403ee/r7s=
X-Google-Smtp-Source: AGHT+IE87e9nEPmXlgwChDr0WVgALuMWNbzzWbFS7S8LPy/c0PFL956OTLd7s+77/56EeH18tvZ3QQ==
X-Received: by 2002:adf:f9c8:0:b0:32d:8c67:be05 with SMTP id
 w8-20020adff9c8000000b0032d8c67be05mr3951074wrr.22.1697188618895; 
 Fri, 13 Oct 2023 02:16:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a056000119000b00323287186aasm761457wrx.32.2023.10.13.02.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 02:16:58 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] scripts/get_maintainer.pl: don't print parentheses
Date: Fri, 13 Oct 2023 12:16:28 +0300
Message-Id: <20231013091628.669415-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

When called from git-send-email, some results contain unclosed
parentheses from the subsystem title, for example:

    (cc-cmd) Adding cc: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...) from: 'scripts/get_maintainer.pl --nogit-fallback'
    (cc-cmd) Adding cc: qemu-devel@nongnu.org (open list:All patches CC here) from: 'scripts/get_maintainer.pl --nogit-fallback'
    Unmatched () '(open list:PowerNV (Non-Virt...)' '' at /usr/lib/git-core/git-send-email line 642.
    error: unable to extract a valid address from: qemu-ppc@nongnu.org (open list:PowerNV (Non-Virt...)
    What to do with this address? ([q]uit|[d]rop|[e]dit): d

This commit removes all parentheses from results.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 02fa828100..00a0870b26 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -907,6 +907,7 @@ sub get_subsystem_name {
     if (length($subsystem) > 20) {
 	$subsystem = substr($subsystem, 0, 17);
 	$subsystem =~ s/\s*$//;
+	$subsystem =~ s/[()]//g;
 	$subsystem = $subsystem . "...";
     }
     return $subsystem;

base-commit: 63011373ad22c794a013da69663c03f1297a5c56
-- 
2.39.2


