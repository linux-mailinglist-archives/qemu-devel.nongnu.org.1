Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0E825FAA
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 14:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM6gi-0000aX-I3; Sat, 06 Jan 2024 08:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gd-0000Zn-HK
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:04 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gY-0005xe-IO
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:03 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-556aa7fe765so429349a12.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704547555; x=1705152355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+IptE/EiCtC5Mrf608TFF0t5HuRJGzY3/EkUV3YChM=;
 b=T3rAbHdTnuCzUW3DvRyFCFRDzTITTAdrBlbugVDx26VScr39QkSo0Tac1vPaQ1Vv/7
 tLakjtzF8LBn/YQ5daDn+am7luoqXBLcvNQ0Mu9F7efGYoD42jdHikGall+ufGBAn5dK
 NBj7UUoT57vp3HD9Tt42oATkkPVO33w/rGAjmy3HkdNyHg3VMsOeqoVhGUbvrzMFWxAt
 PeucFfZP1RsbHzfd9zc8rdBNS9oDmc75IEHMJVr/2S6IiVlcXpEy/tC4RjUxrrsp16VA
 9NqjmjI204pa0LmlnvkFu5p3Ybt78ZllvPQ+bSBe0Rv6QI7qvlvK2zySvoA9nl6j/qd2
 e08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704547555; x=1705152355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+IptE/EiCtC5Mrf608TFF0t5HuRJGzY3/EkUV3YChM=;
 b=BwumRpORND9jOsH9IPz+v5Y5w6avcTksz41E/8OPSI1X4avNNxhPZfTwTKQ0R7ih66
 8skGrYq1vsUX7j7yeJ8DZZPrjI8ISmVQcOIPO2TV7Re3R8HIsY+Wsw9vKx2vtXKXmJYD
 Gfc/iKGlQ9om1BruJ7AZKgyF/oNXwy1kh051ytGO9V//7MIsINkpjqeqc9OZE1Vl+AhA
 VQtut5mzrTNlXFd1iXfj6aMm4+J6bo14lqUDmZWD0dKoEzAM7hX0SEYIvjjV0FcK3Ogq
 6SnWD52/h21J7mqi45DHoqa3x4XeT6XG+wb/COBXxDF9ClY3syB25FAaWxHiPuSBHfZq
 1cCw==
X-Gm-Message-State: AOJu0YytrhhQ5K5x/i5rGalI1pgSLeZnm6ZP/3TB/P5tnHh+bs/QrllQ
 YcupUoX5n2U9lzmImHNTR6XKURUl23w=
X-Google-Smtp-Source: AGHT+IFxG/9sEGSf1u+pN4ltot3a7zUSL+dmpozeYrT1NvBN2JVaQ5GjSQLj+HZFqdLbd1TNfWAa9g==
X-Received: by 2002:a50:d710:0:b0:554:1072:d5de with SMTP id
 t16-20020a50d710000000b005541072d5demr549671edi.52.1704547555443; 
 Sat, 06 Jan 2024 05:25:55 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-174-094.77.11.pool.telefonica.de. [77.11.174.94])
 by smtp.gmail.com with ESMTPSA id
 3-20020a508e03000000b0055515b40464sm2159752edw.81.2024.01.06.05.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 05:25:55 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/3] Fix PIC interrupt handling of x86 CPUs if APIC is
 globally disabled
Date: Sat,  6 Jan 2024 14:25:43 +0100
Message-ID: <20240106132546.21248-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This series is part of my work emulating the VIA Apollo Pro 133T chipset in=
 QEMU=0D
[1] and testing it by running real-world BIOSes on it. The first two patche=
s fix=0D
an issue regarding PIC interrupt handling, the third one just fixes a typo =
in a=0D
comment.=0D
=0D
During testing, I've found that the boot process gets stuck for some BIOSes=
 that=0D
disable the LAPIC globally (by disabling the enable bit in the base address=
=0D
register). QEMU seems to emulate PIC interrupt handling only if a CPU doesn=
't=0D
have a LAPIC, and always emulates LAPIC interrupt handling if one is presen=
t.=0D
According to the Intel documentation, a CPU should resort to PIC interrupt=
=0D
handling if its LAPIC is globally didabled. This series fixes this corner c=
ase=0D
which makes the boot process succeed. More details can be found in the comm=
it=0D
message.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
=0D
v2:=0D
* Pick up R-b tag=0D
* Split and rework interrupt handling patch to consider i486 SMP systems. T=
his=0D
    required dropping Alex' R-b tag.=0D
=0D
[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t=0D
=0D
Bernhard Beschow (3):=0D
  hw/i386/x86: Reverse if statement=0D
  hw/i386/x86: Fix PIC interrupt handling if APIC is globally disabled=0D
  target/i386/cpu: Fix typo in comment=0D
=0D
 include/hw/i386/apic.h |  1 +=0D
 hw/i386/x86.c          |  8 ++++----=0D
 hw/intc/apic_common.c  | 13 +++++++++++++=0D
 target/i386/cpu.c      |  2 +-=0D
 4 files changed, 19 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

