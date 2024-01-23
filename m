Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C0838D13
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:12:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEgG-0003Ap-Bb; Tue, 23 Jan 2024 06:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfw-0002nq-FD
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rSEfs-0004NO-H6
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:10:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40eb0836f8dso14869295e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706008234; x=1706613034;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fCytg3gfOc0XDY/bxJCGmLh+2jXgROFQkX72DSdEFUo=;
 b=venBtmlwvE+QACYI1JwLZxF5zS6DqiMO96dfrLWx9s+tW7gmfNTtE7nMm7gLDEcbee
 RYMRpDDSRr2SoEePUKLsEOJhf4QYBNug6HAF76LyFDMfWdD8Sc4tG46bXkJrdlCwAkza
 f0pETaAJQ7YII1rh6ty1y/5HaFWbj6k/4gMKybBQlDqlcC51aPsFxNBEOQh6hNJrrhrJ
 lLnpXNjoqhT8NvqUd9NuogzfcKlhravqI9kCMfBmWXPWjNnDaGfAoxRl3xbL48VuBN5C
 YN71MH3NuxgEEKghT+IggyNZnGkYvppkMRjAPPkGXYbdiSnUysBEkL6Fwuq5GHAAe+CZ
 uL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706008234; x=1706613034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fCytg3gfOc0XDY/bxJCGmLh+2jXgROFQkX72DSdEFUo=;
 b=eRWC1BFRzimZgn/BoLVJzF28PdTlHigU7syTCDUoplCqJHpND0FZ/rKgtaRQmRIMFf
 clwzlRkOW2uOG6jXkB3Vl7dvB5W7n6PV23I+0QoLKO8iNcdWbPW4ZKcyn8ypApXfvlCK
 A2InpOsARa9evSJ03CE7cjAF6pQ/1CWtr2bkCqu8Zx0foYEFtV3L056xA2wCyyXfT+8h
 8awar5N8wMFF4x8AseCN4EJEzh6e+91og3Uoek9E7dqf2cslEWhrdnfVJ+13jYHjo4or
 VJdxqlOjHw2kinwSCfx73XrMgpKaAbuheQ7aLcwVx9cshatM+wMUIaIkcPD/XoB1IBrJ
 M8uQ==
X-Gm-Message-State: AOJu0YwTxSldYlBNTUnIm8dMkou+Ey9/ueMAPAK0HkRt2V0M3kMGaMPi
 mGeBIY8WYsFO1GxL5jZ0kPjrvG5pe1rcVE6Lywikdn/dariHBta3ie+ZbHICrzy+/bjNbMjvf9s
 Txo0=
X-Google-Smtp-Source: AGHT+IHFsDRP8iUYzLy+O/ifpDrSfz11r9z/o0Y5k1OwJVub0UZ1jnMUvwnvB2xViaDqEMTqwHYeqg==
X-Received: by 2002:a05:600c:358d:b0:40e:370b:4298 with SMTP id
 p13-20020a05600c358d00b0040e370b4298mr14945wmq.121.1706008233633; 
 Tue, 23 Jan 2024 03:10:33 -0800 (PST)
Received: from rockhopper.. (214.11.169.217.in-addr.arpa. [217.169.11.214])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b00337d6f0013esm12288013wrt.107.2024.01.23.03.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 03:10:33 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH v3 0/3] target/riscv: Add support for Zaamo & Zalrsc
Date: Tue, 23 Jan 2024 11:10:27 +0000
Message-ID: <20240123111030.15074-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x32c.google.com
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

Changes since V2:
- Split extension exposure from infrastructure (Alistair)

Changes since V1:
- Fix commit message that did not account for earlier fix (Daniel)

Rob Bradford (3):
  target/riscv: Add Zaamo and Zalrsc extension infrastructure
  target/riscv: Check 'A' and split extensions for atomic instructions
  target/riscv: Expose Zaamo and Zalrsc extensions

 target/riscv/cpu.c                      |  5 +++
 target/riscv/cpu_cfg.h                  |  2 +
 target/riscv/insn_trans/trans_rva.c.inc | 56 +++++++++++++++----------
 3 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.43.0


