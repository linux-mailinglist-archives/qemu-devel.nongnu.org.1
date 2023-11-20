Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03637F16C4
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:10:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tm-0006T4-37; Mon, 20 Nov 2023 10:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tQ-0005sf-W3
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tC-0001EZ-RB
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:52 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso16963245e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492921; x=1701097721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Am29rNstmoBjPWHdKzUHbk8KZyMNjdmqHD061pd8s4=;
 b=xvpDD/VqOy5u8dMnxMvewAW6XKwA+xGG16bTSKvRO/u9Inu1Wy1HZphlrm/XPAhHRO
 IXwtUQclud/8Uas5SIx084VffpX8bCiFlGdLnWsJEFtbgQeGhxAhtPjiQAVSDiAejTEf
 6gnhgjXOwDsiOYB0oKlltEurluvovnv0DnGb3yTaLpjJM0CPv+9HIwavoXuN3Ab63t/4
 BVT1yqcglWEI9mlxo6yqnrq66hNnsO3t1ITvxI/3uJ7I9KWy63oLy1YYHAwnfiN13wHz
 LChe92hArzydqrA1w2YYe2aieOI74/Rih9jNPOAUmONZVOhcLrPK0ohUfYv+E5wjPg7e
 VwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492921; x=1701097721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Am29rNstmoBjPWHdKzUHbk8KZyMNjdmqHD061pd8s4=;
 b=sJnz7m5yM9hah0qmm5uif5O8DGEEQBJXXJJGgQSwmVfn35VcNVlVRBPXJKoVEKx/JG
 UsYxq4GYmMONnByE6aa4UoL7K+4md9Osp8W7J3V6GQsm1w5MRCoDmmUFvaf0BB0hm4kN
 QoQfakd0NZU965PLCwL0HrsxgSe6pWxQ9/mpxOtSdJsOecGMVGqo9UnjhBnV4UFiz1Ru
 keGMgtriRmlTxka/xqGxsWhwGi+vT2TQ+vBqBkuqrsJyNBQMu9Q3ldFqyp74aU/7zo+2
 ym+aIBgwkApGJFMu1eIPkJGpmsRtSxYoMdnyoqEbmzw0xLppxrZ+fPIo1xn+y0eICY6m
 PcKQ==
X-Gm-Message-State: AOJu0YwEz0ADR8azdqaaSbCuDy5IMjTie9YJ8qcdEi4tAHDsH3G6fyKD
 HFxXcnhwC7XECH/TBzwdo1R9Kw==
X-Google-Smtp-Source: AGHT+IGXKd2U+WEIncOd5SP1kVcLtYZr5FJl/EL76EFXdswtHcZ2pP6rvl7lvX1ZkKAGW+XfP2QXqA==
X-Received: by 2002:a7b:c342:0:b0:40a:4a7d:606b with SMTP id
 l2-20020a7bc342000000b0040a4a7d606bmr6547024wmj.40.1700492920613; 
 Mon, 20 Nov 2023 07:08:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y4-20020a5d4ac4000000b003316c8ad545sm10450206wrs.76.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0DC365775;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 07/14] docs/emulation: expand warning about semihosting
Date: Mon, 20 Nov 2023 15:08:26 +0000
Message-Id: <20231120150833.2552739-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A surprising feature of calls like SYS_READC is this can cause QEMU to
indefinitely block as there is no handling for EOF.

Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1963
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 0ad0b86f0d..a2eefe3f3f 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -129,8 +129,9 @@ causing most hypervisors to trap and fault on them.
 .. warning::
    Semihosting inherently bypasses any isolation there may be between
    the guest and the host. As a result a program using semihosting can
-   happily trash your host system. You should only ever run trusted
-   code with semihosting enabled.
+   happily trash your host system. Some semihosting calls (e.g.
+   ``SYS_READC``) can block execution indefinitely. You should only
+   ever run trusted code with semihosting enabled.
 
 Redirection
 ~~~~~~~~~~~
-- 
2.39.2


