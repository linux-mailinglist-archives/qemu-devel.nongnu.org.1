Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA417F66FF
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:16:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6FB1-0008ND-9H; Thu, 23 Nov 2023 14:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FAs-0008DB-Vl
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r6FAr-0003gL-7M
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cf8b35a6dbso7355205ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700766938; x=1701371738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GrYzRirtxiVg/t6CSlHKPCL8rk+Wg535kK3qZ8hWrqE=;
 b=Fc02RAyMs5GVob2cabdk9TMoqzuOxBvIquk2FFHXkFyZ5ItOplFHFx4GFIMxMNAY3V
 iVp1kG/J6iK2TDmn6xKgtCBizYOhVhjr6FK/SWptf087seRNWEH4cPoAa+0U8psX5V3b
 wdapKRD69TGK55WNxv/Jb6KNqPWNxuBz69K9oSJmJD/wmOSqkbLLvYuY0e3ZUzBj1+Xh
 EliNVhkdFSYg1xsFZaym3lOC77hTx7zOOpUUg5ddpbEL7YCufWwzH+cVF5u+UJr9f/7Z
 EyvkO1FweMC7aQ8WNE/DlskwlqEMVymz7EyguBNYuoJArAAIBc76LzGMp/JCAtmjT695
 HsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700766938; x=1701371738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GrYzRirtxiVg/t6CSlHKPCL8rk+Wg535kK3qZ8hWrqE=;
 b=cXsjEMEl7PPFPwJuytkpwkNHGlSaY1WhB2uM8UpyOVwaLQzuqostsu9iQf29bladKm
 Vk5yBkmArzXQIb84IuaX+rhRv+lbBtNqqhco+TJxhDb94gKG5kUDIrTX/mTMryIUYZjA
 moxEytkF9ZiIPkZDeaS/ZyHrRjYrUdmiKf4pOmsKxQa1yS82Iqe+6HO3aLa0W4MtkBre
 luTHKiiZZx+iK95XdPB3Ndz6bEHl+AGL7y5iW5a+ChXLsnDFhOMuc5OxrG793bh4JdSq
 avJSi7HYFFXxBTqFrkKYrEUh5erWgppS/rvx46mWKBg/LIUtoeYREWqOuLHynHnZww5a
 Vs5w==
X-Gm-Message-State: AOJu0Yxz4cp/h0ogqyN1CGA6KuwRC4mwudDzkAZ4PRjLeXaovVEYndM0
 kmHg5lvpvr80xPCJUYJ+EDm8LBdEyBmfyKqEXOo=
X-Google-Smtp-Source: AGHT+IHh3ViVUxkTGSUCjH3g9uO/EgJn7o6IHLaJUNR6vDlFRdphsMpVkA380vdXd+M3a0GPhzpj/g==
X-Received: by 2002:a17:902:c713:b0:1cf:9ebf:8c with SMTP id
 p19-20020a170902c71300b001cf9ebf008cmr340862plp.56.1700766938580; 
 Thu, 23 Nov 2023 11:15:38 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902eed500b001bc21222e34sm1680760plb.285.2023.11.23.11.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 11:15:38 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 0/7] target/riscv: implement RVA22S64 profile 
Date: Thu, 23 Nov 2023 16:15:25 -0300
Message-ID: <20231123191532.1101644-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Based-on: 20231123185122.1100436-1-dbarboza@ventanamicro.com
("[PATCH for-9.0 v11 00/18] rv64i and rva22u64 CPUs, RVA22U64 profile support")

Hi,

This series builds upon the RVA22U64 support to add the supervisor mode
profile RVA22S64 [1].

Patch 1 adds a new named feature called 'svade', which is a glorified
way of telling "we do not want svadu". More info in the commit message.

Patches 2, 3, 4 and 5 adds additional wiring to support supervisor
profiles. We need support for priv_ver and satp_mode requirements.

Patch 6 describes the profile. After all the work done previously in
RVA22U64 we just need a profile description and we're set.

Patch 7 adds a new rva22s64 CPU in similar fashion as the rva22u64 CPU
added previously.

[1] https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc

Daniel Henrique Barboza (7):
  target/riscv: implement svade
  target/riscv: add priv ver restriction to profiles
  target/riscv/cpu.c: finalize satp_mode earlier
  target/riscv/cpu: add riscv_cpu_is_32bit()
  target/riscv: add satp_mode profile support
  target/riscv: add RVA22S64 profile
  target/riscv: add rva22s64 cpu

 target/riscv/cpu-qom.h     |  1 +
 target/riscv/cpu.c         | 74 ++++++++++++++++++++++++++++++-----
 target/riscv/cpu.h         |  4 ++
 target/riscv/cpu_cfg.h     |  1 +
 target/riscv/tcg/tcg-cpu.c | 80 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 9 deletions(-)

-- 
2.41.0


