Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BED82C110
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:47:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHry-0001M5-Oa; Fri, 12 Jan 2024 08:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOHrx-0001Lp-Gt
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:46:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOHrv-0006BY-OK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:46:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3376555b756so3730820f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067201; x=1705672001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J94tv17PtRv1hNA8+TxHl9ooGYVoxDm6RnNrgCEkkwM=;
 b=qXIp0LeYwg5UaB8N6WqZl+wQT5uUDnhqCPVYtxx3nxIICRG8QxZQ6vsy1dHUWsPbkV
 IbFB0Xl2/DpK/NKvlTlliVW3d+AHPK/QJXdkcGRfHgSS5CWPNC1zoVJ2ohiWRHiD93Uh
 L0nIvgcqIONF/o/6Gt9gMiIyTs/nOdqByqh6kkMeQwbevdX35z5DE89uii3SL30LcMta
 uJVNBSC33MdwGyCyfCiU5I/+OIZ3rJk7WB66zslZvuFEMnlMoWe45BBlN62RPIEIX92k
 YwoduYJ3VT5kAdRVEaC9iSFaKS3H4HC5lDl7t2P+wYu1rx8CC+4jv8cidrh2oNi3S2oZ
 yolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067201; x=1705672001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J94tv17PtRv1hNA8+TxHl9ooGYVoxDm6RnNrgCEkkwM=;
 b=lrfDbhBtVeVVC5rsN4fptdmypaNLOCC7MskYqi1ug4fwAlZtZjBJKqbN9uNxuw8L1z
 wcjTu1R5dtGBj3yHoX/CAw/2wijpr/GzwbpcxOCTLmYzgW5ACujcQkkFvO2b7gMuncIa
 DZ8GKU8Bew3jCIbVX0n4WtxrQEWf0IVYyfz5EgA8bgbxBFriDhQLh9oEJ8WBP5zvsuct
 Iw/ycl0IP3cfF5MldKnhqotbkaKXfZenSNNisovXggvt/d9paO668KfN8LKytJkwOMDX
 UAnigNR1Nljz2WyikoWFmzXFWBsv90tpDHJScaAs3BIlcU2X0FWwvXrynCZW0G8z6NlV
 VXGg==
X-Gm-Message-State: AOJu0Yw/R1zJrGhE0fqH6kWd1gzhallld9iO61b/RmckM0i8+mL/hO6u
 BCd+0j/Adkf//pC2rP78BgtaO/wcfmZRNE3/3eb+A9Wwyy8=
X-Google-Smtp-Source: AGHT+IESgUZlv0Bpdng1pRGBEa/aSbwNM4/K6fTvDTHC+wHJ8cwFpO1vWHdwC0/GSgNULpNyFA9wbw==
X-Received: by 2002:adf:8909:0:b0:336:58e8:d444 with SMTP id
 s9-20020adf8909000000b0033658e8d444mr1266713wrs.30.1705067201465; 
 Fri, 12 Jan 2024 05:46:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h16-20020adffd50000000b003372befd19bsm3948357wrs.104.2024.01.12.05.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
Date: Fri, 12 Jan 2024 13:46:40 +0000
Message-Id: <20240112134640.1775041-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

The raven_io_ops MemoryRegionOps is the only one in the source tree
which sets .valid.unaligned to indicate that it should support
unaligned accesses and which does not also set .impl.unaligned to
indicate that its read and write functions can do the unaligned
handling themselves.  This is a problem, because at the moment the
core memory system does not implement the support for handling
unaligned accesses by doing a series of aligned accesses and
combining them (system/memory.c:access_with_adjusted_size() has a
TODO comment noting this).

Fortunately raven_io_read() and raven_io_write() will correctly deal
with the case of being passed an unaligned address, so we can fix the
missing unaligned access support by setting .impl.unaligned in the
MemoryRegionOps struct.

Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted by code inspection: I was looking for devices whose behaviour
might be changed by a patch I'm reviewing that adds that missing
support for unaligned accesses in the core memory system. But even
if we do implement it there, it's more efficient for the raven MR
to correctly mark it as handling unaligned accesses itself.

Tested with 'make check' and 'make check-avocado' only.
---
 hw/pci-host/raven.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c7a0a2878ab..a7dfddd69ea 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -200,6 +200,7 @@ static const MemoryRegionOps raven_io_ops = {
     .write = raven_io_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.max_access_size = 4,
+    .impl.unaligned = true,
     .valid.unaligned = true,
 };
 
-- 
2.34.1


