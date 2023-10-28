Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFED7DA619
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 11:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwfQk-0004b0-KI; Sat, 28 Oct 2023 05:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQY-0004Ws-TW
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQX-0007Kw-2Z
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so5852319a12.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698484573; x=1699089373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pmYD97aXV+ckX7s46FjfDA6Z8YKMDOfKWcH+UK25tnM=;
 b=CJse/clh4iKA/bDZZs5O/K1GtYDXp5bYjktsdGJQ69MVXUgk+krJC3ONGNWAeykBs5
 v6Ro0M6Xyn50tO4ifr/bOW5NkCcNgn/K8XX5ceHPW/BtLHqRU+347mzE2YLKNIfXpPQe
 hDCSIWmG2pp3Nzieg8iKthGdG2kPY5QG2kbhXK0Q0RfC4bu8bOuLMnCjIX9UaOQa13cr
 lt5yqVOCDHKkePZLQHSOTql4z4jnZL6eSdGQMoZtRPPFbvPZejBnT3NIs1bESxpG657a
 kNxd2ePT6J2Q3mYW8QnOHolLZ8goGXMgsjlN2c+jZ1ky9KWyf/pKrHDqm3KXIjlfhqLy
 NR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698484573; x=1699089373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmYD97aXV+ckX7s46FjfDA6Z8YKMDOfKWcH+UK25tnM=;
 b=GAmD8oT2LDcC7DDa8QO03aJD13cZEaTM98yFNCzLB1qiFiVYVlmaxzt6gBIlECyD+I
 1VHqPehKDGCEp2++S8LcabCCZQLDycUwjaw+jaZVbb9ho3ZBrJoEgvEiw+7R3WAzneUb
 1S66gZpfnQVujKYzKgRFKGsMiiHY06852C+54xGjYTC5xcSh6OBa0eRlIMpzfiIqyrL4
 B3L9qiLpJyfwGtNUzdfBRmSG1pja7KamSXkWa447YGYbZ4jSDgZ6pbQMUHwG1IlLEwlc
 +AvDr52jHehG0JFuIxg0cL05dhXiLobwuYsBq6GwCXTIyvPtTXi9GLIO6G4YIvQf3SJO
 uIyA==
X-Gm-Message-State: AOJu0YzwsGo57ZzApPyWjBG39E5nHO78Wa7VQyGwFlaNrXtojJfptxWo
 rbMgh4WIV/PpwrJKXRBjdTdneCxTs1E=
X-Google-Smtp-Source: AGHT+IGQ5j5ryDUr/Oqo1jiSUf+aMwSTJuaHKm2jlSTcZUon+nHPQy/Uuqo/+VkuUiGGVZinyKaC1Q==
X-Received: by 2002:a50:fa83:0:b0:52a:38c3:1b4b with SMTP id
 w3-20020a50fa83000000b0052a38c31b4bmr5146786edr.15.1698484573401; 
 Sat, 28 Oct 2023 02:16:13 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-012-044-170.89.12.pool.telefonica.de. [89.12.44.170])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a50c357000000b00542df4a03d0sm571444edb.16.2023.10.28.02.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:16:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 0/5] VIA PM: Implement basic ACPI support
Date: Sat, 28 Oct 2023 11:16:01 +0200
Message-ID: <20231028091606.23700-1-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series is part of my work to bring the VIA south bridges to the PC mac=
hine=0D
[1]. It implements missing ACPI functionality which ACPI-aware x86 guests=0D
expect for a smooth experience. The implementation is heavily inspired by P=
IIX4.=0D
=0D
Further quirks are needed in order to use the VIA south bridges in the PC=0D
machine. These were deliberately left out for a future series. The idea for=
 now=0D
is to get the device model in shape for adding support for it in SeaBIOS.=0D
=0D
The series is structured as follows: The first patch fixes ACPI events to b=
e=0D
signalled by SCI interrupts. The next three patches implement typical ACPI=
=0D
event handling. The last patch adds software-based SMI triggering which is =
the=0D
mechanism used in ACPI to transition the system into ACPI mode.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
* `qemu-system-ppc -M pegasos2 \=0D
                   -device ati-vga,romfile=3D"" \=0D
                   -cdrom morphos-3.18.iso \=0D
                   -bios pegasos2.rom`=0D
=0D
[1] https://github.com/shentok/qemu/tree/pc-via=0D
=0D
v5:=0D
* Implement software-based SMI triggering and handling of ACPI events based=
 on=0D
  v3=0D
=0D
v4:=0D
* Alternative proposal (Zoltan)=0D
=0D
v3: https://patchew.org/QEMU/20231005115159.81202-1-shentey@gmail.com/=0D
* Rename SCI irq attribute to sci_irq (Zoltan)=0D
* Fix confusion about location of ACPI interrupt select register (Zoltan)=0D
* Model SCI as named GPIO (Bernhard)=0D
* Perform upcast via macro rather than sub structure selection (Bernhard)=0D
=0D
v2:=0D
* Introduce named constants for the ACPI interrupt select register at offse=
t=0D
  0x42 (Phil)=0D
=0D
Bernhard Beschow (5):=0D
  hw/isa/vt82c686: Respect SCI interrupt assignment=0D
  hw/isa/vt82c686: Add missing initialization of ACPI general purpose=0D
    event registers=0D
  hw/isa/vt82c686: Reuse acpi_update_sci()=0D
  hw/isa/vt82c686: Implement ACPI powerdown=0D
  hw/isa/vt82c686: Implement software-based SMI triggering=0D
=0D
 hw/isa/vt82c686.c | 179 ++++++++++++++++++++++++++++++++++++----------=0D
 1 file changed, 142 insertions(+), 37 deletions(-)=0D
=0D
-- =0D
2.42.0=0D
=0D

