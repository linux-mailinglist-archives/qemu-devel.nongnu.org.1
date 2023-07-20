Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09775A46C
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 04:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMJTp-0005I8-Ft; Wed, 19 Jul 2023 22:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTn-0005CJ-BO
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tjeznach@rivosinc.com>)
 id 1qMJTj-0002KL-Ro
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 22:33:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1b8b4749013so2137915ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 19:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689820398; x=1690425198; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wamsYddTpBcl6Xw4nw2x0lwP/hBSjB+vs68gpVm/l/s=;
 b=M42PYenZzAPhv+TIQ87pQ1MxXYIwOb7xfuRFTX2HY+8MGk6oeeLMaGqu5jGcPjy/7a
 WKszFzCnDYaJorpRusCsaU8CSYT16zGY5bRJsVwASc86+xxQr8TePwU7x42O4bPO5ndg
 80F70yA1g+SzHvlLLyqY+hgtS7u17mCbLCfwVLZblvApAJ16V9A2Y9/5D1zgQ6vlIZUY
 LmEqP9OuW7mwAgBb5AXvmrjz+OAaRQyKGEafB9K4rSvLY9Mod1P/h9yhoUF5+kVtAEIa
 JMTEtaR3QWYVtJeDBpe2PwluTxhBLO5txAD/+xN/KRYtFNpcpT4/OLnQaLBS84snP3Ez
 Lb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689820398; x=1690425198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wamsYddTpBcl6Xw4nw2x0lwP/hBSjB+vs68gpVm/l/s=;
 b=guibBIBjTUnBn1ysfqxQT6KQq90vuf6cd7zj1hU4E4g9yGFYDmsm0i0eupulmIGBaw
 uM4V1vbXr79Z3+R5Nw1sg0a3FWzeOwoDKldr6J/xv1BlprUJRdBi0xA7X7uo2vxBO8VT
 QH/yxi+TXK+IbDui2ZQy8fYm1Yd4KnDyyprCadX6gzZheYjG4LVdodtOfzg675j1OnjL
 tZVLotHnq0I0nT0u1Gr1w1wsGorlqt70R7TBaqY1rsUxcQg2OR3QC1/wiNh3pOd7MSr9
 15XzwS6cjdhAgeX9VCnbj9CM9vZG/RCLizcTY2I2cHOXMBdnPtuAPe//G+O56j7s2/kp
 P5Ew==
X-Gm-Message-State: ABy/qLYJRGYPtceCWBk6hfctRBZnEH/MM3TVoOOONw26ET+MwZRXplIP
 QnYLtX7xEEl1gzevABqZzTxm3g==
X-Google-Smtp-Source: APBJJlEL7+g6ZcFLyRU1p8LVm6n5Ln/OVNUCaYYq4mr/HzErH9GhbY6fMzLl+4BF7u39o+eGpNhkfg==
X-Received: by 2002:a17:902:ea82:b0:1ad:f138:b2f6 with SMTP id
 x2-20020a170902ea8200b001adf138b2f6mr17557372plb.16.1689820398326; 
 Wed, 19 Jul 2023 19:33:18 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001b9e9f191f2sm4692032plp.15.2023.07.19.19.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 19:33:17 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, linux@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 3/5] exec/memtxattr: add process identifier to the transaction
 attributes
Date: Wed, 19 Jul 2023 19:32:56 -0700
Message-Id: <eed38091c00bf8869ad6c5dec734a0e7c59c1ea3.1689819032.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689819031.git.tjeznach@rivosinc.com>
References: <cover.1689819031.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=tjeznach@rivosinc.com; helo=mail-pl1-x62c.google.com
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

Extend memory transaction attributes with process identifier to allow
per-request address translation logic to use requester_id / process_id
to identify memory mapping (e.g. enabling IOMMU w/ PASID translations).

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 include/exec/memattrs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d04170aa27..61c2dfac14 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -64,6 +64,12 @@ typedef struct MemTxAttrs {
     unsigned int target_tlb_bit0 : 1;
     unsigned int target_tlb_bit1 : 1;
     unsigned int target_tlb_bit2 : 1;
+
+    /*
+     * PCI PASID support: Limited to 8 bits process identifier.
+     */
+    unsigned int pasid:8;
+
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.34.1


