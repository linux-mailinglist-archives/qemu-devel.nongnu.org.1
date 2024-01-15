Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482C82DD8F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 17:26:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPPmJ-0005n9-Sx; Mon, 15 Jan 2024 11:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rPPmH-0005m3-0f
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:25:33 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rPPmF-00050w-61
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 11:25:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e775695c6so9767385e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705335928; x=1705940728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9D00xa+XSCxC87F1u0Bt2vd0mnLwvfxAGy7bIuFsaVk=;
 b=yQcnb0x7dmd/K8b+dnx22MzyONkDClqb9cX3dST0XoNjU7FOJHFy5TT3TfymiynwaU
 63L6ZII1Ji0TezOrKd3U7fkSW7ud15KohcvyjeRylGduNbYRSavwGnbbNo+PAA4K/Jdf
 7b1IcdyKqbNxCLwtQF5SwuRMqYFujtH2OnND0jfejw6j4PgG8ZTgxhJ3Z/RdGYP0/Mt6
 8qQYl5vS9XubDLpLR4zVzGy4xWfO/kUpKIzF8dHkB9PoHRPb25J2HJLDRj7q8VfveJp0
 OIUfqVf7/1dp1+js75/6EWza5J5cDSU5v9VWdHCZwfbeqXBrXQ8RSAehMbpPTgjgyOx8
 8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705335928; x=1705940728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9D00xa+XSCxC87F1u0Bt2vd0mnLwvfxAGy7bIuFsaVk=;
 b=WvEOqudFo44Ivwl0SoKZ9mhjOvFxBlvl1uqyDyP4tJZlnNzt6+Sl9rcqC/ENDVmJ0o
 qAIPMHMZG8PITOdcAkAHylH5gwqS/CYqbsWbwnjDjuTA2bJcTtTJLNExtpb9lPQ9zLYK
 hE+wJjaLVcxTXgcySVwY+NHCMTJ9gU5xD8JegMmsp1m0TDNsR+yBh8R9aIH9k5Yy6jHG
 BAq/+3lO7lc5nXxjW0mQS/EnrvfINRBbkKaua9ypSJEqB9H9vEBD/cKURL9h5ZasOYZd
 WHD6gj1tKsdx6A62EuEZwq4eDR4ekS8i7p56R8JVwDuCHw/4vwfdswP14pgXaR1kwLSA
 h7fA==
X-Gm-Message-State: AOJu0Yz/3sMgDiQUA75QxAsiO5u5rWPTIL689ZarH2Vx+PirI/qySxvB
 cC7orcAHhR2faMYmwnkJso47SplCs59JPqDOibWCw9s8sc6PgQ==
X-Google-Smtp-Source: AGHT+IGXA0z+9mf2JktUwdNKNF2ls6r9p9A+RCWbyaqAO90hhFaE8jU/mscLyeZA3n024YbtUwQUxw==
X-Received: by 2002:a7b:c453:0:b0:40e:42b4:23b6 with SMTP id
 l19-20020a7bc453000000b0040e42b423b6mr3758905wmi.55.1705335928187; 
 Mon, 15 Jan 2024 08:25:28 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 n16-20020a05600c4f9000b0040d62f97e3csm20274444wmq.10.2024.01.15.08.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 08:25:27 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 0/2] target/riscv: Add support for Zaamo & Zalrsc
Date: Mon, 15 Jan 2024 16:25:23 +0000
Message-ID: <20240115162525.63535-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introduce support for the proposed new (fast-track) Zaamo and Zalrsc
extensions [1] which represent the AMO and LR/SC subsets of the A
extension.  

The motivation for the subsets being available separately is that
certain classes of CPUs may choose to only implement a subset for
architectural convenience.

Since this extension is not frozen these are advertised by "x-zaamo" and
"x-zalrsc" options. Beyond adding the extension infrastructure the only
changes required are to allow the atomic instructions under either A or
the appropriate subset extension.  To ensure compatibility enabling the
A instruction does not enable these two extensions - future hardware may
choose to advertise support for A and both these extensions for maximum
software support.

This patch is based off riscv-to-apply.next due to conflicts with
existing patches.

Cheers,

Rob

[1] - https://github.com/riscv/riscv-zaamo-zalrsc

Rob Bradford (2):
  target/riscv: Add Zaamo and Zalrsc extensions
  target/riscv: Check 'A' and split extensions for atomic instructions

 target/riscv/cpu.c                      |  5 +++
 target/riscv/cpu_cfg.h                  |  2 +
 target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
 3 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.43.0


