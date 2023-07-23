Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA41275E0FA
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVTx-0005FO-Ia; Sun, 23 Jul 2023 05:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNVTv-0005Ei-St
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:27 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qNVTu-0003Kw-C0
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:34:27 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1b03ec2015fso2495717fac.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104865; x=1690709665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F01cjutPSexbn9f5LLBdof2a7Xg4vGD8NgTtjy+HYfI=;
 b=mLgrXCqbcaqGajX88pBPXAW6VeB6arenMtnBWsItqa3UAvleS13CrPzJUb0U1ynMgl
 oioXJZQLp2j+X4g2FtBjUSZ63GrlzZOLtZY83XqMzZVR7uM13QGVvkviw/CKnm+qSCL3
 CGNc7y+vMpSTKDLckytesKU3EPQk4i4Ny6RfdRIjm+SenYQZflCkGU8HWbyLm2EoLI2/
 U4EQYtojwbjMgDUMWCnIomUn00y0q7Ajd43yoXQvDlN2n0K/mq+Eubn+PP7Dyi38+f6x
 Gi+y5rthnmbNurOIutl53m2HseduDCknFi3mUAyQLsxN6ZJ0Vndw7R/My76SfDsDgnUv
 4sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104865; x=1690709665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F01cjutPSexbn9f5LLBdof2a7Xg4vGD8NgTtjy+HYfI=;
 b=GBfTlGnhKNW54qo8DtA6HPlJd5PpmmJkJSLBlBTlh08GGmv66dp4ZzCb29D8wslrPO
 aa95EDXzbJvZtAhXkejFn3ssSkNbMKZPvIBKNVpMp6LoZDOAXyMXon+UzY7G1ToAQI8X
 n1wMwkOoZcWc+8muBDqHTyjvXlXaF+738moQvL2h0eWg2WDGgTPWJBwQzQYxZMxMdrS0
 0cSFbOMbG16IOOivgIKbP5TPlLX28Pf/yJwIE4XVjlJNZ1BolzlDaUet9GIooVGwRFQj
 SJO8ykm902F40ZnGzVNfSm/qNUBrcHiBLURiy8mSJBy2rSySnITIqFPngvP6/DEpawLY
 Qbkg==
X-Gm-Message-State: ABy/qLYAZRQTSqgTosue/EY03UtpEvriMMbeMnLvyUCGINRw5osU8YtL
 DQBJLJc7ZSCuUxe+aP42kWVy4n4E9pOaTQ==
X-Google-Smtp-Source: APBJJlFKL6i+P5HgcOmVxfCX70B42CxzXukwWGrCn2B5eiUlfAAOC/ib2ol9PfXjti8B77dD1iJY8g==
X-Received: by 2002:a05:6871:10c:b0:1b0:7c30:7baf with SMTP id
 y12-20020a056871010c00b001b07c307bafmr8337077oab.42.1690104864825; 
 Sun, 23 Jul 2023 02:34:24 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a5-20020aa78645000000b0064f76992905sm5647475pfo.202.2023.07.23.02.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:34:24 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 0/1] riscv-to-apply queue
Date: Sun, 23 Jul 2023 19:34:13 +1000
Message-Id: <20230723093414.859532-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:

  Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230723-3

for you to fetch changes up to dcaaf2bf9bfd2c664dbeff0069fcab3d75c924d3:

  roms/opensbi: Upgrade from v1.3 to v1.3.1 (2023-07-23 19:32:02 +1000)

----------------------------------------------------------------
Fifth RISC-V PR for 8.1

* roms/opensbi: Upgrade from v1.3 to v1.3.1

----------------------------------------------------------------
Bin Meng (1):
      roms/opensbi: Upgrade from v1.3 to v1.3.1

 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 135344 -> 135376 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 138304 -> 138368 bytes
 roms/opensbi                                   |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

