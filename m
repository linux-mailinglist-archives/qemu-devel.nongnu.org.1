Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCD47BD9C9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoRA-0006hb-J2; Mon, 09 Oct 2023 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qpoR5-0006cf-26
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:28:32 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qpoR1-0000OS-2a
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:28:30 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57d086365f7so2573910eaf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696850904; x=1697455704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NmUj66uLSsE0KdjySEtBHBduHxy3GwkU/G2edSmHWZk=;
 b=hPI3JmkQQ87RAqSEcFL6Foksxa48R+RfG5HFIbqLVUvjDVkOZmM8RjxM7BBvhUM/Hf
 0oC3XBaGqKqdxFsL52t21OzWPtNDzRZqF82VRcGdFXglnQgE+AHnAMtkstab0KXERfOT
 9jyhQpr5D3jXkSJhxXa3tPDtPcF632loY6i8R0xcBg0V83TejNtFLbGFZEQ9NWFlBXeK
 tCnRqeYr8o5ZT75L6UWaiMBptcdnaj0Wli4P/c4hpIpncno0Ew3wIRtBgYidoCrzG2Bf
 WNWyvazyFrUkVR+k+kGwewz82MYWiHG69O8ToEOwZVpB10oXcMEEnqTiZNcrlTcIdh41
 PWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696850904; x=1697455704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmUj66uLSsE0KdjySEtBHBduHxy3GwkU/G2edSmHWZk=;
 b=tp0Af8yNgyS/SS2+StEty5z9UK1+yUepxImzz29tSy2LBPLE7M1MyrKDDYlqxp3yTK
 KJQc+4vI+PwKlJK08xXnWkX62bKB5lN1H6TjEU150Fr2xIsGSTof8uO+uWlNAXwfyKFc
 sibSDIR1tyO5ByULoywjhcPBYCLqVSAg6GqBnzKowVhZp8TMMu7G3GFzEKI/rN2vKguc
 Jxv9uIqWeE7pZSQYorRs9IPeQTaEkAooK2qtH7Fy6Gs8S8o5F29WQq5CvJZH/SSL9khp
 SPWhyh9ran7u7IU8GlozU4yHp9D+3n7qPoFeYXubIQDB7T63eOpDwR0hKjhGoFUqE/bj
 GCkA==
X-Gm-Message-State: AOJu0YzfaA9qw2Lu5tNI45Vj0mW4iXTBdYOx7aKPNPm4FkF3zpthMdVT
 S5SaXEb+dIQm9f+sX2LdVRu9MfDjoU33ThyPmhQ=
X-Google-Smtp-Source: AGHT+IGOZu/kU4O1EPrvNZPWXu4sC6PJ/mFCvaCnkpD1n++JFLik/vhpi6EmIm/s9lHPe6ZKNhAz1A==
X-Received: by 2002:a05:6358:528f:b0:13f:411:c1a9 with SMTP id
 g15-20020a056358528f00b0013f0411c1a9mr20004362rwa.17.1696850904243; 
 Mon, 09 Oct 2023 04:28:24 -0700 (PDT)
Received: from grind.. ([177.94.42.196]) by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b002791d5a3e29sm8830705pja.6.2023.10.09.04.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 04:28:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/1] riscv: deprecate capital 'Z' CPU properties
Date: Mon,  9 Oct 2023 08:28:16 -0300
Message-ID: <20231009112817.8896-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
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

Hi,

This second version of the patch fixes a 'with with' typo in the
deprecated.rst document. No other changes made.

Patch already acked.

Changes from v1:
- remove 'with with' from docs/about/deprecated.rst
- v1 link: https://lore.kernel.org/qemu-riscv/20231007171427.1210117-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (1):
  target/riscv: deprecate capital 'Z' CPU properties

 docs/about/deprecated.rst  | 23 ++++++++++++++++++++++
 target/riscv/cpu.c         | 39 +++++++++++++++++++++++++++-----------
 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 12 deletions(-)

-- 
2.41.0


