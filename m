Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B528708752
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhmV-0002Lp-Kj; Thu, 18 May 2023 13:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmS-0002IE-VL
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:12 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mchitale@ventanamicro.com>)
 id 1pzhmQ-0001fM-TO
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:51:12 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-54f8b7a4feeso667202eaf.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684432269; x=1687024269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ruaX81lcewPWbISG1VbfmYqGcrj7LG5k7xeyff7fcJc=;
 b=D8rbvNu8PJIqslBSsQAkHZX185aWVexnTZPOE/A8bmbigznzgoFZ2iBZCTWPu3/A63
 SE/zeHeDPcwqKymnVon2zxfZjVAPMy+hq85hdLApEGS5sTCfKRrWaceWwCNRvZs/rgW7
 bFCZDSUOGiWZVa3vWzT5sMcA5i+9g76Z/9CfEVrzGHpqqUvROWqNcUSnSfw7PzyVh66q
 iiacFS2ku+XUPVKlyP37uQte1Ud4Y/zuGa0BzLp5kzPq0Ao+9+LYu3QtueiVlOYycQof
 wpayzCiRrgpQTp0w27ML51+VbnDsieeeH75I2T4JLa0GD4KshntQwsKc/FV+rZPiH3k1
 RVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684432269; x=1687024269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ruaX81lcewPWbISG1VbfmYqGcrj7LG5k7xeyff7fcJc=;
 b=MzymXDoYmfj0e29rV2+H16ySa4p2L48RFU0K8Gz5opRubZQ319iAmNivdwdmNTJXwC
 QQ4NNz762anZlMfr4aRh65+F1BuSCz3kfk49IxMNIKWUFnlAZ/7mGcr7lIW4+nATP0s8
 L0XfMs8+aPoB5/XBbdfAOIcmPaOeYRkWfMDXBTIqEuWK+WRaEcizhXfNY5Ze9FOmmVTy
 U4f1zx494N5t7q7yq2XUFsR14GOrjXTbryqLRy2QYyfd25YABKaw4G4SEWZT1COngj9f
 EeH7cJVG7vaICKK3BWQvsAk9H59uyf3i10oAx5a6/KQO2wTx0xv2R2M8CVjCeDDQq7si
 9E/Q==
X-Gm-Message-State: AC+VfDx51KMf0XtmpxJfdHSiFNKwRgYTcHhEez3h5Ho993pY0tpEe+et
 erF80bV0CULXsHjo3ytxVChRtfHhjqA2b/CpPDoN9g==
X-Google-Smtp-Source: ACHHUZ5fQAwDu6ympZVsI72T4TK4fShTDl5EA8smcAFfy87v61Ipobka13v2sSR/O02yiUZq+j0a7Q==
X-Received: by 2002:a4a:ea06:0:b0:54b:ce85:490a with SMTP id
 x6-20020a4aea06000000b0054bce85490amr15280723ood.0.1684432269559; 
 Thu, 18 May 2023 10:51:09 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t13-20020a05683014cd00b006ab22bb324asm890832otq.10.2023.05.18.10.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 10:51:09 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	alistair.francis@wdc.com
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Barboza <dbarboza@ventanamicro.com>, liweiwei@iscas.ac.cn,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 0/3] Smstateen FCSR
Date: Thu, 18 May 2023 23:20:55 +0530
Message-Id: <20230518175058.2772506-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=mchitale@ventanamicro.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Patch 4 and 5 of the smstateen series need to be re-submitted with
changes described in the email below.
https://lists.nongnu.org/archive/html/qemu-riscv/2022-11/msg00155.html
Hence splitting the patch 4 of the original series into three and
re-submitting along with the original patch 5.

Changes in v5:
- Ammend patch 1 commit message
- Add reviewed-by tag

Changes in v4:
- Drop patch 3 
- Add reviewed-by tag

Changes in v3:
- Reuse TB_FLAGS.FS (instead of TB_FLAGS.HS_FS) for smstateen as HS_FS bits been removed.
- Remove fcsr check for zfh and zfhmin

Changes in v2:
 - Improve patch 1 description
 - Reuse TB_FLAGS.HS_FS for smstateen
 - Convert smstateen_fcsr_check to function
 - Add fcsr check for zdinx

Mayuresh Chitale (3):
  target/riscv: smstateen check for fcsr
  target/riscv: Reuse tb->flags.FS
  target/riscv: smstateen knobs

 target/riscv/cpu.c                      |  3 ++-
 target/riscv/cpu_helper.c               |  6 ++++++
 target/riscv/csr.c                      | 15 +++++++++++++++
 target/riscv/insn_trans/trans_rvf.c.inc |  7 ++++---
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.34.1


