Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D1800E3E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:14:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95CV-0004t6-Sr; Fri, 01 Dec 2023 10:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95C0-0004qm-Lt
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95By-0003tD-Kq
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:12:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b595bf5d2so18221265e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443551; x=1702048351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTrDNbYJOBcXJe0QIsla+RGqqidagZ/wagIa9X/ca1U=;
 b=lQ0UGDdsVNJG2WGR7RUw95wjbmZfd9A3ORuVSilG/27w62yrkpEKOrKUBEkIPYxIae
 DaXav+08hmjhdwccp8RgonWA/qqBEUeZf5j5vz/qvz/iaCTKkNYgSBV22RNooEdAe/xq
 fnhxsBjKXrRuGYAjJHtJRuVxW38X7xwC9HjIiqSQFe9kEgSOX3yDH2i/5Zfcnyc0PU1E
 0HERjNNFEntYO1sp7Uzfbbl15ZLkQe/y9WmwRfKM9D5XI3kmGkrTqjaZ48ufKcnGQJS9
 3+x7+3OJO2IJubpfid2ySVuFU7AZ3lvOmUmKF3+oD+TMY5N3nJ+ntqFdpufj5lkTPS3h
 Ubxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443551; x=1702048351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTrDNbYJOBcXJe0QIsla+RGqqidagZ/wagIa9X/ca1U=;
 b=G/VnmTyIKhqfGb90c3kBnoDSZQthiZ+S8lX84rG+yLQKaXUsiRXQ16Yv61a8fnkrRR
 FiGEOa04wCEelqE1Wp19nRnEm3Y+1zMncKJVWo6ACuO1pBFHpnryK6V15bCw4P8oYP5d
 /HY1OJG6P19VRGOdlG5mzgB/PZdGNSQ7MLhMgZomX0PrnrnMpuF09Vm5/cbmxNqCMoFI
 I22+v2ne4Rv4g4iiXUiMI5Q1P1Ic3kY8/ydVkTA9jKf0355sjqg5TlG2D4QYfKlNTiH6
 N9ACsmG50DTMIzxN/YNxqzm9a2sjhBR4YntaI+XxnZFI9rr36F5g6ild5Z1kgXVZ7uyn
 Mpng==
X-Gm-Message-State: AOJu0YxWe7CM4sVM4IB/uZzUQVwIRgjH+2YXhs4NsA4dKXyVa9IhyDrA
 E1mdDeLJ1csK5WfIH8LujW0azg==
X-Google-Smtp-Source: AGHT+IFIXGsAnlt/Y2TNLGMkoYJVTHmE6Bb5mgXSldoqSHN+PXzG6tO17uyxxO6NLD8iHdCTOmLBqA==
X-Received: by 2002:a5d:540b:0:b0:333:2fd2:3c0c with SMTP id
 g11-20020a5d540b000000b003332fd23c0cmr648167wrv.197.1701443551790; 
 Fri, 01 Dec 2023 07:12:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p8-20020adfcc88000000b0032f9688ea48sm4432922wrj.10.2023.12.01.07.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:12:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 453C65FB67;
 Fri,  1 Dec 2023 15:12:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 4/6] tests/avocado: tag sbsa tests as tcg only
Date: Fri,  1 Dec 2023 15:12:26 +0000
Message-Id: <20231201151228.2610209-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231201093633.2551497-6-alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index bdd1efc768..528c7d2934 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -20,6 +20,10 @@ class Aarch64SbsarefMachine(QemuSystemTest):
     """
     :avocado: tags=arch:aarch64
     :avocado: tags=machine:sbsa-ref
+    :avocado: tags=accel:tcg
+
+    As firmware runs at a higher privilege level than the hypervisor we
+    can only run these tests under TCG emulation.
     """
 
     timeout = 180
-- 
2.39.2


