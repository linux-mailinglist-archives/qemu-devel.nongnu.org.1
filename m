Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8879EBAF8
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 21:45:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL75S-00072y-Cz; Tue, 10 Dec 2024 15:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75L-0006xG-GC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:43:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tL75F-0001yU-9y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 15:43:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434f09d18e2so34933675e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733863431; x=1734468231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZ8UT6jHrgv7BkeIPE8IB1TgPopOqtqdb8E+kOWH8C0=;
 b=m4FezAroc9LTsGuGWJaCdWOCZOBj6QghtMd7yRTe78GuuseyKGvhQlvQWUfTvXLdsI
 AmxGJFGwoL6OdOGHovsGfBVngCZVsrGiV6aKNzVZI6EvXsfxrq86LloguyTvgRI9uAfc
 AIVKVsyCDRGzfTQl86cPCD1nC0hEhBf+anVRJ0V43dUs8eI6Fx9MuIB7KjNKvs4Kpptw
 kl4YOtdwkrDdcSA/FGfEnv/h919usf3ZeYETxOd4SSKInKPiKV+L6XyJhG/2VTW5KHK8
 vSCbqphF7mdzkVyWAaJFKe2Fwyx9+X8guiy+gwi/mQu6jRcjZUTuSQEYUoZOgS9GBA4R
 jxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733863431; x=1734468231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZ8UT6jHrgv7BkeIPE8IB1TgPopOqtqdb8E+kOWH8C0=;
 b=wJR+UDHbUoUlh37sNSdp8v9ePMpNXOZqfMLIaC6ZWWnyp5y1wlejouZ1KMqchmhyz/
 GxT33V+j3e9Hhife64RbZChfC47+NxDWu0PtNlHJI8t+CROvxOsSfPavFDmMPk9zmWId
 zYdAjl9QmnvQFX4oYztK8WLsXvnQo5sPTSQ0iv4JJRMJ+1BkSC5myY66JbsSaQFRMlpV
 GmTid4V7CBsgMNb4SHlCg0W3ijn18GcXPxZ8iSMCYoGQpp0u0ec/2gNW5C56vmZ9oul4
 v4DdvQeMwn0dpJubMuqvhF6oXSkyMeT/ZjfTdqB6TIuGOZwjQlRck41UkyEesPHfrtAt
 Xxhw==
X-Gm-Message-State: AOJu0YxOfgi23O9ZIrGYPPlf87eFprFT204ueObrdf3m4ohoAmfPUVrR
 DgoAUBa1HOVInFBIVO/2d0+i/RU7bCmXi1CaB1CJEaFFBXWtWyViMAeFAfgboSU=
X-Gm-Gg: ASbGncvHA0xacGTL19Pn9hFWFuQ4gN7tdWX7F4GGieb75rXAuMy6XwHI8Oxu87YEqvv
 WtHdpP3KClga+o+jATf48AeUeVxcIfCUwgbgbFsq6bcY//VA4zcMQjo1SFJU8qQpXuUhxWOB93Q
 jXR46UicehBE8Wm8aTNNjePyi82MPPG1lJCq4htYVxw7IxmDGz0okYLiyYG/U4PWdFtajsfTrYL
 qdfE5m3ubeacFmjhhfbJqF8fxLI3J6sdMxdxJU0M4yfOya/Z6Rm
X-Google-Smtp-Source: AGHT+IEv984KTOXeqfbTnyAxgtffmo4Wa/qBUhv3yPj1U86OaYVBP72NRyJUNCq3u/nSy59YZgGmJg==
X-Received: by 2002:a05:600c:4f11:b0:435:23c:e23e with SMTP id
 5b1f17b1804b1-4361c3ab01fmr1884725e9.12.1733863431408; 
 Tue, 10 Dec 2024 12:43:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4350159f6a4sm44457575e9.21.2024.12.10.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 12:43:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF2E45FABD;
 Tue, 10 Dec 2024 20:43:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 04/20] tests/functional: update the mips32 tuxrun tests
Date: Tue, 10 Dec 2024 20:43:33 +0000
Message-Id: <20241210204349.723590-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210204349.723590-1-alex.bennee@linaro.org>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-25-alex.bennee@linaro.org>
---
 tests/functional/test_mips_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/test_mips_tuxrun.py
index 6fec44c2bf..6771dbd57e 100755
--- a/tests/functional/test_mips_tuxrun.py
+++ b/tests/functional/test_mips_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMipsTest(TuxRunBaselineTest):
 
     ASSET_MIPS_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/vmlinux',
-        'bfd2172f8b17fb32970ca0c8c58f59c5a4ca38aa5855d920be3a69b5d16e52f0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/vmlinux',
+        'b6f97fc698ae8c96456ad8c996c7454228074df0d7520dedd0a15e2913700a19')
     ASSET_MIPS_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips32/rootfs.ext4.zst',
-        'fc3da0b4c2f38d74c6d705123bb0f633c76ed953128f9d0859378c328a6d11a0')
+        'https://storage.tuxboot.com/buildroot/20241119/mips32/rootfs.ext4.zst',
+        '87055cf3cbde3fd134e5039e7b87feb03231d8c4b21ee712b8ba3308dfa72f50')
 
     def test_mips32(self):
         self.set_machine('malta')
-- 
2.39.5


