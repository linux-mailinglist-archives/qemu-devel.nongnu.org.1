Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAC7E057B
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:22:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvzT-0005E5-Ky; Fri, 03 Nov 2023 11:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyvzQ-00058w-MT
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:21:40 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyvzB-0002li-7O
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:21:39 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so30973721fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699024883; x=1699629683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K/q/6Fpok48r78qGBxR1lQWjm+mwOuYuSt34cZz3H8s=;
 b=bJxqZGi+9xsSHZYWttfS+pTAtTBMBQu4liNFXWo3g4MqL+Wwox7Qmf47MPLbEH6Cfr
 fKzl8Mk9nedR36Q4zp5tImOVguAxtFu/IFmHIwDWLpWyb4oVIahLJXQjPcl1O3x8wQ8V
 3FKie/f291VdGCguKkkhwB8gDhsmcIe4/ivL396ceFzodA96EkaSuLCaYcx2munR/1y2
 uaYD4xauULfubB390mRG9tNHGQwkBaQWey3A9WKzO11Qydt4KF10xUwH4U2mwqBGomYZ
 Gq4weQXsMeZMascyvc09qbqz3rycyKfNAJ7FBafflPq4meuZ7/dF2qewEWDj0k/eIOXa
 zwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699024883; x=1699629683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/q/6Fpok48r78qGBxR1lQWjm+mwOuYuSt34cZz3H8s=;
 b=eSEWJMfrVwbJ7m4+dvgzPr+ZveFHRWRiXULwb2R8RP//8rKF/hE7cLCQopqeLToOAR
 t9a/w7+lu14VGd8P+MeeTEBAV7fhWvCOGEjoUytuN34UFovx5wqClmGG8sYh2+PjkKWs
 dkENWaOsq2WRWvKo8ReT0Qv3lR0BIFAP65WrUne9cMXqnuvAO8E8vr+tUkkslOpEY0hC
 CmNedpWd/cNH/tJ8r90Zyu3M4jp3fUyOsxgfUM7srOuZRLTbbTRrsPeD/6RAYGMxZjb1
 pYG7AY6HoTIE2dkmrPgX9vwXcaxQTLCD5SX9tMyoXL8EaepF3vPZAL+0gFU43O24KDaY
 Tj+w==
X-Gm-Message-State: AOJu0Yxv88PJnJU+anjYy3X8kOpmEbaPGh5HVrSHPTzto/2SnMmh9ucE
 QWTTvApADyn3SZducqP+vFtSBz0wWbj5LWW22PA=
X-Google-Smtp-Source: AGHT+IF2R0VgXiL+JhbsMGjRWwWPIY+1lxTKLC63sdaaLfj0Fs1LvixUYPw3H0oJ7Q1G30tnh+TFZw==
X-Received: by 2002:a2e:88c2:0:b0:2c5:1df1:ac1 with SMTP id
 a2-20020a2e88c2000000b002c51df10ac1mr17966154ljk.20.1699024882686; 
 Fri, 03 Nov 2023 08:21:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a7bc8d0000000b0040684abb623sm2712165wml.24.2023.11.03.08.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:21:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Subject: [PATCH v3 0/3] virt: Report UART correctly in ACPI DBG2/SPCR
Date: Fri,  3 Nov 2023 15:21:17 +0000
Message-Id: <20231103152120.829962-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

This patchseries is Udo's patch, plus the necessary extra patches
that update the golden-reference files for bios-tables-test so that
'make check' continues to pass.

Changes v2->v3:
 * report the UART as requiring 32-bit accesses, not 16-bit;
   it turns out that Linux has a bug where it fails to enable
   the console if the ACPI table reports 16-bit access width
 * ACPI table binaries regenerated to match that

thanks
-- PMM

Peter Maydell (2):
  tests/qtest/bios-tables-test: Allow changes to virt SPCR and DBG2
  tests/qtest/bios-tables-test: Update virt SPCR and DBG2 golden
    references

Udo Steinberg (1):
  hw/arm/virt: Report correct register sizes in ACPI DBG2/SPCR tables.

 hw/arm/virt-acpi-build.c  |   4 ++--
 tests/data/acpi/virt/DBG2 | Bin 87 -> 87 bytes
 tests/data/acpi/virt/SPCR | Bin 80 -> 80 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


