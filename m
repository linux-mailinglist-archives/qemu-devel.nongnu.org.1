Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E892181FF56
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBeV-0007nw-Bi; Fri, 29 Dec 2023 07:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeP-0007mX-Py
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:41 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeG-0004xm-6K
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:39 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B0FB63F15B
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703851648;
 bh=tFjzcWXuE5DSXBUytMlng7Kt/kySHhmp0JIqujk7Ie8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cMZRxOl4Cbe5Mh6O2YEAQzRjwLEemLV6grb9si3e3vMEMe1s0kNUmt1HFgHKbAg0S
 GTv4yeY+XhiM9n1yY7EKd6kpcdl6mn6Pqp9X95sMV/K7RvP4bfUjAQQQ75z+yDtjbO
 WOFl9LPO9yAwUm/9O68pyg7Ok4ntb9txlICuu6PRJURMjxS9+QnjyPkqNTrIVUiRkL
 OhMzF5WBY3p5Ki2fEkY4rVK8YK6SA5vcILTGJCm2qSXRSUASNJrQ8MMYq/HnknNKSs
 sSIPs/gYDzQtmI5bFiDWoCRa+nTdcpqJF1eA4ps1CDp5dsrui5jqHbVuUU64RaIRSr
 rwoflskCHtKfA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-555bda8b4a1so231329a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 04:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851648; x=1704456448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFjzcWXuE5DSXBUytMlng7Kt/kySHhmp0JIqujk7Ie8=;
 b=ZYNslc7hkHKyDQxs0GGVlzuPIpnya30xbndl6Kgb7vJuzrDwnW4GNO3Lt/1QRylxsC
 WShuwrJGXbLFgWqO95HPThr7qz1a533EyZYw2dGOI/MIgiiVx3hDtIwbXLFUYHEDaX/p
 qMSdzaJCBhSd2KUAeef53UUC96BexYCDZSbKd4KZCY/J/Z1X2NZpnDujf8ijs5Vb+9RC
 eEtO3mokINtCdJmGNOYzIVY4pBeA+rERaWKcs6cXuxsm3Aqs3djuRk7/SYYWpUgDI3K1
 /HTM0zUbc/eJelnIih46zjXXnVZKWGSa8DcqbiVH1N5bhwA+0v4y9DSqSYRRYV7k4Asi
 UOsw==
X-Gm-Message-State: AOJu0Yzf3tfKLZ4+pxO+10z2fmEUXVycALUkLl6e37xKH3gGKxRmQ/vt
 48oYttsbEk3qRgTPiUwcivcbMZLn8Y228LGYzZ2ANgAqMQXmgso2B9DFKwy/cQB51CSXuDow/xQ
 8CaB/FrAT76LstdND6aRufQ8XFG+fpKzsAHuqhFw=
X-Received: by 2002:a50:d7d7:0:b0:553:739e:bfac with SMTP id
 m23-20020a50d7d7000000b00553739ebfacmr7732601edj.8.1703851648217; 
 Fri, 29 Dec 2023 04:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYwKsRQBh2evsx0Q9HgRecFYtkUacRQZ1dFs5S8toVVatnvK9PEr9WMTwV2D/Vu1PaF2YmUw==
X-Received: by 2002:a50:d7d7:0:b0:553:739e:bfac with SMTP id
 m23-20020a50d7d7000000b00553739ebfacmr7732592edj.8.1703851647910; 
 Fri, 29 Dec 2023 04:07:27 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 j20-20020aa7c0d4000000b005527de2aecfsm10943344edp.42.2023.12.29.04.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 04:07:27 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Fri, 29 Dec 2023 13:07:20 +0100
Message-ID: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.

With the series the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Add processor-family to the '-smbios type=4' command line options.

Heinrich Schuchardt (4):
  smbios: add processor-family option
  smbios: function to set default processor family
  target/riscv: SMBIOS support for RISC-V virt machine
  qemu-options: enable -smbios option on RISC-V

 hw/riscv/Kconfig             |  1 +
 hw/riscv/virt.c              | 42 ++++++++++++++++++++++++++++++++++++
 hw/smbios/smbios.c           | 20 ++++++++++++++--
 include/hw/firmware/smbios.h |  1 +
 qemu-options.hx              |  6 +++---
 5 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.43.0


