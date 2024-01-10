Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB58292E8
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 05:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNPnP-0003xI-IW; Tue, 09 Jan 2024 23:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rNPnH-0003wG-Vi
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:02:21 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rNPnF-0007vx-Kt
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 23:02:19 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d3fe03b6b7so6928775ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 20:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704859329; x=1705464129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9VYd6p2cowcyrY5xrLrsUO88JEYC9+34V/ihqnKpyM=;
 b=H4QxcRNK7OA3Yo1DCaia09aE043FPAArnW0J8d2K93GFd9rYL4zJXjjLd8l+bPJ6uk
 sxRo3UnQrARbvN1ApVH+kuitalrlxF5aQkn+BBqKRK0P/Byzofnq5GvRdq1SpZO3S3v9
 37lJ9YWBRGjuQV+ZkTdsPFtFEP99tdFrc9oyXhEHE9ujELSvFH0qrwMNfnC8nGq+MvH8
 0dFoAthWk2hUTJv+tsjBOmqtO9N6t+SiW6f3CGZ0BEL7k3sUgtWJDpz9b4ToaM4etMOt
 zjjim4iqhV1QRWE+PcKONy+jFeeAY5n7tc6i0HZf9wMKy2FdVlNYXHYwJGv7sRGQeLVW
 eS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704859329; x=1705464129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9VYd6p2cowcyrY5xrLrsUO88JEYC9+34V/ihqnKpyM=;
 b=u5YfuLy3Dd7XJSB1QbN9fPOfwDNYMZWVmHx8ULsTrjV9pRNmWDyrjBwtQzepAfYmsk
 JTVUHivMDyvU6u2AU6w9qgPkrICQVNJxmV51iCQG31GE2DryaK2RwzzI2WaXAZeY80rN
 QzQqOoe+aFWkyq14XiN5cc4T6si1ys1pxdyXH128NSt6XCRjEoe+J2CxpC68ldSlnHei
 0GYxh9sCp+JGBu2BEk6d0o9aBrhBX6EMpFqZqHcHf/mvYVwXoW5cOLnxLyk9b3Yyj8Am
 ruE6jSL7dXy+fzTsVTBBrtqCGZGX0CWrj2ghnrfK7qyP5w9pZoQSPa8WE5GAoPzHW33S
 O3pQ==
X-Gm-Message-State: AOJu0YxSzyQDph2Ugqv8KswSgD1lSMO/fQr6g7YctlKEteziyEkSzhcz
 Y2vnXfpuDmqbDp3ZjYqL9k2TlXt+azeTAQ==
X-Google-Smtp-Source: AGHT+IGw05qTTf15AGfRf3LPFAVuajEMrOsVuh5gmrfzDNnSeWkqC4lZNC8WZc9sKVX/PWgg2q5xnw==
X-Received: by 2002:a17:90a:fd03:b0:28c:fe8c:aa93 with SMTP id
 cv3-20020a17090afd0300b0028cfe8caa93mr615257pjb.1.1704859329142; 
 Tue, 09 Jan 2024 20:02:09 -0800 (PST)
Received: from brahaspati.localdomain ([152.58.210.84])
 by smtp.gmail.com with ESMTPSA id
 ca8-20020a17090af30800b0028cf4cb2c85sm313893pjb.40.2024.01.09.20.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 20:02:08 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] Export debug triggers as an extension
Date: Wed, 10 Jan 2024 09:32:01 +0530
Message-Id: <20240110040203.1920924-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x636.google.com
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

All the CPUs may or may not implement the debug trigger (sdtrig)
extension. The presence of it should be dynamically detectable.
This patch exports the debug triggers as an extension which
can be turned on or off by sdtrig=<true/false> option. It is
turned on by default.

"sdtrig" is concatenated to ISA string when it is enabled.
Like so:
rv64imafdch_zicbom_*_sdtrig_*_sstc_svadu


Himanshu Chauhan (2):
  target/riscv: Export sdtrig as an extension and ISA string
  target/riscv: Raise an exception when sdtrig is turned off

 target/riscv/cpu.c     |  2 ++
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

-- 
2.34.1


