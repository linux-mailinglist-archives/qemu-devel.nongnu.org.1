Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3978B729F04
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cnq-0002M5-LD; Fri, 09 Jun 2023 10:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cnn-0002L3-AY; Fri, 09 Jun 2023 10:09:19 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cni-0000FE-Hn; Fri, 09 Jun 2023 10:09:17 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f61b45ee0dso2305469e87.0; 
 Fri, 09 Jun 2023 07:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319752; x=1688911752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:dkim-signature:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1Fqkrl7UDXmonoxDtBH8mU2gjHZZdApn9BUS7kN7w8=;
 b=XcDsJ3COEVVwaA5HbzL4BK5mtR3xQ30shdeh+815axhLbvHjbpt/7nbnpvsqoH/nRH
 prFMyVj/Dk5lRud1DWZaATdR6B+h8iIOxRGMHros0d+zaYFy0FAM7mnvt//Towyvs+An
 MPzB/oT+pqSWvKPvCuhSvrnjg9U7gkuJhyaMHd10DpurE3rDtJQtGzwPfv3Lfd+b5Wyt
 zvPRtwtpGr9Du1xRGslGlu/7Q8YzHuWC3vaKx9OLUKrEi7JUXgeJbON0TTlnIW7e2qv4
 q33NyOQ19/kJYI7EJGFo0RUXyQzDLedzevQH+u+H532lmjTJaXJHcKDrCHbn5oInwelH
 ZzYg==
X-Gm-Message-State: AC+VfDwEaJN3UQG17M0uNcHWJXWG/T794Hj8ojWrFmN++xebWhLGkPvH
 +LOmtqYcUKZU1DxMWjv6pncIkMQCjXiAqxaI
X-Google-Smtp-Source: ACHHUZ7k7U2RDCCslqjccyyCV2oUfkcJahgeShFvV9NRLeCwUFm+J8BtTCL65MIP3uDK0dMZXEOs6A==
X-Received: by 2002:a05:6512:205:b0:4f2:74d3:8996 with SMTP id
 a5-20020a056512020500b004f274d38996mr915516lfo.8.1686319751745; 
 Fri, 09 Jun 2023 07:09:11 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 r13-20020ac25a4d000000b004f3a79c9e0fsm557255lfn.57.2023.06.09.07.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:09:11 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 72EB319EB; Fri,  9 Jun 2023 16:09:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319749; bh=N4kiXFTgZHCX/JZKdOPGrMBPxbfBCt7yrPHw0sZmuUA=;
 h=From:To:Cc:Subject:Date:From;
 b=jnNHBsxlINFIFnHkwX8k2o8GCm1zsABVAoOIb4iQcjjmsUzb4lkrnTp59Gl0WQKOO
 7QFkmmRKHxyn8zdrMiJAT2mdzTYH88+5W2JDU404SR6BOlipLOobEFXWLlRLjTwHXF
 4OFoMnzRP4m0qfwnb+JS3/yLEykXbFxnNnaM+lzY=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id C3F031746;
 Fri,  9 Jun 2023 16:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319740; bh=N4kiXFTgZHCX/JZKdOPGrMBPxbfBCt7yrPHw0sZmuUA=;
 h=From:To:Cc:Subject:Date:From;
 b=is54Tpo2AYx6RBiNTWYLpOJUY0aN4X8+joCMuhgBIypUd0sDMlb87PHWlhOjUuCPZ
 zfSZjDkFH7vI2MwFIdExZrB/TK4VtNN35FF27uv1L8IvaElKiHzgowVNnbIDiByWZ3
 0HybIEZXG8S8qcUc2cgWMHEZs90ARlEH6rYa61eQ=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v3 0/8] misc AHCI cleanups
Date: Fri,  9 Jun 2023 16:08:36 +0200
Message-Id: <20230609140844.202795-1-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Hello John,

Here comes some misc AHCI cleanups.

Most are related to error handling.

Please review.

Changes since v2:
-Squashed in the test commits that were sent out as a separate series into
 the patch "hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set",
 and reordered some of the patches, such that each and every commit passes
 the ahci test suite as a separate unit. This way it will be possible to
 perform a git bisect without seeing any failures in the ahci test suite.


Kind regards,
Niklas

Niklas Cassel (8):
  hw/ide/ahci: remove stray backslash
  hw/ide/core: set ERR_STAT in unsupported command completion
  hw/ide/ahci: write D2H FIS when processing NCQ command
  hw/ide/ahci: simplify and document PxCI handling
  hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
  hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
  hw/ide/ahci: fix ahci_write_fis_sdb()
  hw/ide/ahci: fix broken SError handling

 hw/ide/ahci.c             | 112 +++++++++++++++++++++++++++-----------
 hw/ide/core.c             |   2 +-
 tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------
 tests/qtest/libqos/ahci.h |   8 +--
 4 files changed, 164 insertions(+), 64 deletions(-)

-- 
2.40.1


