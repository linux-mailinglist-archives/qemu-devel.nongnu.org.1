Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72565800744
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:39:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zx3-0003ud-QP; Fri, 01 Dec 2023 04:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwz-0003r7-6d
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:45 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8zwv-000473-Ej
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:36:44 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50abbb23122so2654207e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701423399; x=1702028199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2mKYaqQwRPyOn+b0fzZNJnY6rsKfn5mWX6d/74jDLg=;
 b=DooEn7I5+el7NsJXelnMCt73JPXdY9tu6QCs/dc7mAFi4QBxxjpnxHdkowtawrkXTG
 Qag2gkC7GpirsYOjUnD156kTBehmubcBiyZtAE40vIbXFOBRAoEsIluhtKR9TTY8fPb1
 gRef1bnCd85bGbRqe4z4o7tMeiQooJi9dDRIZteBAUc+i8fIEET0qjlZknn+VrwsMlSS
 KdYy4ZVO1qsPLVhKgQF0iI7QnYlDUZvtcaHEJwfBN9vjJf7VkpwVFTwxpqZJdU+GzTnW
 aWGUqSrCzc49duo23H/58LG9uIWGnYWYyIITOCx+5vQQP3+HfTuyV4WmHMf4NGR+NdT5
 Rz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701423399; x=1702028199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2mKYaqQwRPyOn+b0fzZNJnY6rsKfn5mWX6d/74jDLg=;
 b=FcR+pGmGUmewC9GnAycNPU5VDGDNR85eiMKy2SV0F+zyWdRfquM0qBxIqh8blaDh6k
 1IV+zyLykaT+R3m5YE51IDswV7w+48Z2SkpXzTG7SBuTH19obrvFOxJ/gXOF9wSAtDB2
 Zak6OVW8ErnfCI10wvicUTYKYxdpv9zkVSXhF3R7snOLqKAHTyTHhHsISKTzQ2qW8nvc
 ArGQmvkylJ+aI+WXDmhcYjV8XlVPpDINDC4ZDKjLM+iQvSTy/EFhnPi1uXK3ur7tyFl2
 wMMSSPUqORYYJ0FApiqIjKr8WPnk1/cjVBWjveAjGR5l/y/8mjoXcTtmemdEevgZl7SW
 7Uuw==
X-Gm-Message-State: AOJu0Yw5BKB0XV7/Mm1UQstAJewI6MG1FUmn2m8QmdcI8wruk7QDPBJa
 0k8aIF1isBp+H4E2HDeAdhPF/A==
X-Google-Smtp-Source: AGHT+IHrRm8DuyhmQuyxSyjOm/het5dGuh07U0eMAeCC1SuHzlsB1iiP0egWpBM8h58oUjRUwe3icA==
X-Received: by 2002:a05:6512:142:b0:50b:c194:d413 with SMTP id
 m2-20020a056512014200b0050bc194d413mr418108lfo.55.1701423399512; 
 Fri, 01 Dec 2023 01:36:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f12-20020adfdb4c000000b00332d3b89561sm3710366wrj.97.2023.12.01.01.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 01:36:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 658B65FB69;
 Fri,  1 Dec 2023 09:36:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/7] tests/avocado: tag sbsa tests as tcg only
Date: Fri,  1 Dec 2023 09:36:31 +0000
Message-Id: <20231201093633.2551497-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201093633.2551497-1-alex.bennee@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

As firmware runs at a higher privilege level than the hypervisor we
can only run these tests under TCG emulation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index bdd1efc768..c25a691b64 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -20,6 +20,7 @@ class Aarch64SbsarefMachine(QemuSystemTest):
     """
     :avocado: tags=arch:aarch64
     :avocado: tags=machine:sbsa-ref
+    :avocado: tags=accel:tcg
     """
 
     timeout = 180
-- 
2.39.2


