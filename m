Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E003D7B07E1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD2-00038b-Hq; Wed, 27 Sep 2023 11:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCz-00031v-Qm
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCu-0005kF-UW
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso11180518f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827527; x=1696432327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSnhc0CklelNgkmSRPVk3KnPHMoyc2Bo643vA0S7/JU=;
 b=v5dF06VyJEvy55h9pmEb53op8AF6J3wL/EA0gqlH1PnlY7RrymqmGEh2lotnzsiUCq
 2ayxunDXY9/1xbukt/hPkkFr5SlDVEqxZOIT3BlH24L45BZpmG1yn9hlvLGzHO4apAjq
 /nKZ+i6l2ZisjcaSeBQ9YLw/3nNBDJLhBCasfmn03fXg8gLsL5kclbfwlTWaoI+M8F/V
 imiNYUhmwePVslBQtcFjd6onPiNbNNjg+4qugEzTebbb8FGGg4B78AK0h3ek3ebEoPG8
 U3NI4S+YUacxqdk6oZSXdyDOAsktGNFePUbeg5PiAFkzLPRqza29LWZ0pWwSwuU82Lzn
 kKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827527; x=1696432327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSnhc0CklelNgkmSRPVk3KnPHMoyc2Bo643vA0S7/JU=;
 b=BEqu72gS8p35TDNt+jwcD6xNwiLaR8t4036d5GmTQ+skSb6/zGt6h8X9QY9GqrdP8e
 rqplRWtzbqQZFx6fTg8wl7NeoXIGTg5/ufhKKRApOqeYPvPgGHbeJFEM3dq9Hz7GVZBR
 /6nswgIxG20yZ9URXJsbzlSjblPhNW04bGNWESw7E78Wowhg5yITbnFqJzyiu4PwhpKh
 Li5mfquuO+zkUXapawoWrEoJBMWp1G8gLbfBQCr9gduIiqkBLUNZUrvrSnQLCsgcr/mg
 Rs+1D2FyklZ+hl3FcPXSqoUr7BpO4vahvTOQfCScwj3tRQt+tVoqDCTY4AqF1xvoqfxL
 pd2w==
X-Gm-Message-State: AOJu0YxOcsCpqOq9iLa4RMaf8eY7Xju4bNyJPJKMYAeMJxzCDNtn0V1l
 GJvT3J/+ekm0PmjxP/GK3oyWm/scYp61RJudD38=
X-Google-Smtp-Source: AGHT+IGoxq9VTNaMMbTplfedgJKiKnLxA/EYtCx9GGlqj2R3kW5N4T4rxEViQh3jIifmnlUBh5KTqQ==
X-Received: by 2002:a05:6000:18a:b0:31d:da10:e471 with SMTP id
 p10-20020a056000018a00b0031dda10e471mr1781714wrx.69.1695827527335; 
 Wed, 27 Sep 2023 08:12:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] docs/specs: Convert txt files to rST
Date: Wed, 27 Sep 2023 16:11:57 +0100
Message-Id: <20230927151205.70930-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patchseries converts most of the remaining .txt files in
docs/specs to rST format and integrates tem with our documentation.
(The one remaining .txt file is rocker.txt, which I left to do
later because at over 1000 lines it is much bigger than these.)

These are mostly simple conversions with not too much effort
put into the formatting/markup. In a few cases I dropped
parts of the text already covered elsewhere or made light
fixes for grammar/spelling; see individual patch commit
messages for more detail.

thanks
-- PMM

Peter Maydell (8):
  docs/specs/vmw_pvscsi-spec: Convert to rST
  docs/specs/edu: Convert to rST
  docs/specs/ivshmem-spec: Convert to rST
  docs/specs/pvpanic: Convert to rST
  docs/specs/standard-vga: Convert to rST
  docs/specs/virt-ctlr: Convert to rST
  docs/specs/vmcoreinfo: Convert to rST
  docs/specs/vmgenid: Convert to rST

 MAINTAINERS                                   |   5 +-
 docs/specs/{edu.txt => edu.rst}               |  84 +++---
 docs/specs/index.rst                          |   8 +
 .../{ivshmem-spec.txt => ivshmem-spec.rst}    |  63 ++---
 docs/specs/pci-ids.rst                        |   2 +-
 docs/specs/{pvpanic.txt => pvpanic.rst}       |  41 ++-
 docs/specs/standard-vga.rst                   |  94 +++++++
 docs/specs/standard-vga.txt                   |  81 ------
 docs/specs/{virt-ctlr.txt => virt-ctlr.rst}   |  12 +-
 docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} |  33 +--
 docs/specs/vmgenid.rst                        | 246 ++++++++++++++++++
 docs/specs/vmgenid.txt                        | 245 -----------------
 docs/specs/vmw_pvscsi-spec.rst                | 115 ++++++++
 docs/specs/vmw_pvscsi-spec.txt                |  92 -------
 docs/system/devices/ivshmem.rst               |   2 +-
 hw/display/vga-isa.c                          |   2 +-
 hw/display/vga-pci.c                          |   2 +-
 17 files changed, 595 insertions(+), 532 deletions(-)
 rename docs/specs/{edu.txt => edu.rst} (64%)
 rename docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} (88%)
 rename docs/specs/{pvpanic.txt => pvpanic.rst} (64%)
 create mode 100644 docs/specs/standard-vga.rst
 delete mode 100644 docs/specs/standard-vga.txt
 rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)
 rename docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} (50%)
 create mode 100644 docs/specs/vmgenid.rst
 delete mode 100644 docs/specs/vmgenid.txt
 create mode 100644 docs/specs/vmw_pvscsi-spec.rst
 delete mode 100644 docs/specs/vmw_pvscsi-spec.txt

-- 
2.34.1


