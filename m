Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C986673F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 01:12:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOT8-0006sE-B0; Sun, 25 Feb 2024 19:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOT0-0006ld-V0; Sun, 25 Feb 2024 19:03:34 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOSz-0000Sg-8H; Sun, 25 Feb 2024 19:03:34 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-608fb59fe4aso3112767b3.0; 
 Sun, 25 Feb 2024 16:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905811; x=1709510611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0Jk5tssg+pczQf+sURfDosRQjtzzg5NlLkdIkk5IGA=;
 b=mUjXgKU3iedDt8iewT93cJxtT3LzebF5G2gHjLfe875NfzdUwhdRhx5guxgKLHEghA
 QPrFCh0yk6GSZtsTkjtH8kbh6AWTz9PiN+nT0YmxLH2gwlqALu5zrIGh4ecBzpyn6vX0
 TvCgvRuvKzJCq5S2X1lwHp5drPnDXIBvqkz8tHgGExz6HgaVGH79b6NHENWHlKkz5Yif
 qI3gwuqeqi/7HgskXElyKJx5JmH1eJExvHWCD85I9ZeiSrDfaKTP3/jA628B/1ArhTD1
 W2yxqz7VUN58H9A0xLEkLUoWKhKXL+A3m/h301kyTpIXd4VHgDaJdhZ7U5wYm7Lk1axr
 45WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905811; x=1709510611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0Jk5tssg+pczQf+sURfDosRQjtzzg5NlLkdIkk5IGA=;
 b=ve4G4ox2LjLfomomNPiPv8uyZ+eIlV3iqm3hDD6C/E8T7aJaWOhzIGJ+lbjgzIqIA3
 xJ5rejyKbKGDo7y4dp+bR0VkdYAlN8eEp9mCzXGPInYuugBLnLUipap2cnyE9/+Nz5iB
 5aAbGgjmVyrXJKNvs2EF8hDieUStW97u3BO0vgzbRi7I/LmKxj6b/tOnzAXMaJb0EoRP
 fb1LVMdYzGRcfJZREOLUTjT7KX//2SlUrutdkN4VDMFwRoYwoxt5i67Rh13y5c4DdzOg
 fDcaTIsAc638UqIK43kyoGeg3d6JPt5vRXgWOoSDndvBu8+fzgxRh3GDGcbeVq6BcVFc
 2UHw==
X-Gm-Message-State: AOJu0YyQE2u77d9UPxHO+UfX9G5C1NWCtIjzSQR0eIPcZksfA90gEJYf
 qQOZWuf5UMGA4IM8TQxjBspnqCwzY8DlEobGlZKUNp3ifvpRU8erhzOwe1QhcfFhGQ==
X-Google-Smtp-Source: AGHT+IEoX7LXxrFf+pq00FdE4vnknJXpjdSelUnlxFu7lAJ9Ei8QtT+4rkFjzIzzuBLcA+jqkgRu9Q==
X-Received: by 2002:a81:b662:0:b0:5ff:bb43:2a69 with SMTP id
 h34-20020a81b662000000b005ffbb432a69mr4734164ywk.40.1708905811648; 
 Sun, 25 Feb 2024 16:03:31 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:31 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 24/41] Add GENET register access macros
Date: Sun, 25 Feb 2024 18:02:42 -0600
Message-Id: <20240226000259.2752893-25-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 94c2f3ebca..e7a76cda81 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,9 +22,85 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_REGS     offsetof(BCM2838GenetRegs, hfb)
+#define BCM2838_GENET_HFB_FILTER_REG(reg) (BCM2838_GENET_HFB_FILTER_REGS \
+                                           + offsetof(BCM2838GenetRegsHfb, reg))
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_INTRL0_REG(reg)   (offsetof(BCM2838GenetRegs, intrl0) \
+                                        + offsetof(BCM2838GenetRegsIntrl0, reg))
+#define BCM2838_GENET_INTRL0_SET        BCM2838_GENET_INTRL0_REG(set)
+#define BCM2838_GENET_INTRL0_CLEAR      BCM2838_GENET_INTRL0_REG(clear)
+#define BCM2838_GENET_INTRL0_MASK_SET   BCM2838_GENET_INTRL0_REG(mask_set)
+#define BCM2838_GENET_INTRL0_MASK_CLEAR BCM2838_GENET_INTRL0_REG(mask_clear)
+
+#define BCM2838_GENET_INTRL1_REG(reg)   (offsetof(BCM2838GenetRegs, intrl1) \
+                                        + offsetof(BCM2838GenetRegsIntrl1, reg))
+#define BCM2838_GENET_INTRL1_SET        BCM2838_GENET_INTRL1_REG(set)
+#define BCM2838_GENET_INTRL1_CLEAR      BCM2838_GENET_INTRL1_REG(clear)
+#define BCM2838_GENET_INTRL1_MASK_SET   BCM2838_GENET_INTRL1_REG(mask_set)
+#define BCM2838_GENET_INTRL1_MASK_CLEAR BCM2838_GENET_INTRL1_REG(mask_clear)
+
+#define BCM2838_GENET_UMAC_REG(reg)     (offsetof(BCM2838GenetRegs, umac) \
+                                         + offsetof(BCM2838GenetRegsUmac, reg))
+#define BCM2838_GENET_UMAC_CMD          BCM2838_GENET_UMAC_REG(cmd)
+#define BCM2838_GENET_UMAC_MAC0         BCM2838_GENET_UMAC_REG(mac0)
+#define BCM2838_GENET_UMAC_MAC1         BCM2838_GENET_UMAC_REG(mac1)
+#define BCM2838_GENET_UMAC_MDIO_CMD     BCM2838_GENET_UMAC_REG(mdio_cmd)
+
+#define BCM2838_GENET_TDMA_REGS         offsetof(BCM2838GenetRegs, tdma)
+#define BCM2838_GENET_TDMA_REG(reg)     (BCM2838_GENET_TDMA_REGS \
+                                         + offsetof(BCM2838GenetRegsTdma, reg))
+#define BCM2838_GENET_TDMA_RINGS        BCM2838_GENET_TDMA_REG(rings)
+#define BCM2838_GENET_TDMA_RING_CFG     BCM2838_GENET_TDMA_REG(ring_cfg)
+#define BCM2838_GENET_TDMA_CTRL         BCM2838_GENET_TDMA_REG(ctrl)
+
+#define BCM2838_GENET_RDMA_REGS         offsetof(BCM2838GenetRegs, rdma)
+#define BCM2838_GENET_RDMA_REG(reg)     (BCM2838_GENET_RDMA_REGS \
+                                         + offsetof(BCM2838GenetRegsRdma, reg))
+#define BCM2838_GENET_RDMA_RINGS        BCM2838_GENET_RDMA_REG(rings)
+#define BCM2838_GENET_RDMA_RING_CFG     BCM2838_GENET_RDMA_REG(ring_cfg)
+#define BCM2838_GENET_RDMA_CTRL         BCM2838_GENET_RDMA_REG(ctrl)
+
+#define BCM2838_GENET_TRING_REG(reg)    offsetof(BCM2838GenetTdmaRing, reg)
+#define BCM2838_GENET_TRING_WRITE_PTR BCM2838_GENET_TRING_REG(write_ptr)
+#define BCM2838_GENET_TRING_WRITE_PTR_HI BCM2838_GENET_TRING_REG(write_ptr_hi)
+#define BCM2838_GENET_TRING_PROD_INDEX BCM2838_GENET_TRING_REG(prod_index)
+#define BCM2838_GENET_TRING_CONS_INDEX BCM2838_GENET_TRING_REG(cons_index)
+#define BCM2838_GENET_TRING_RING_BUF_SIZE BCM2838_GENET_TRING_REG(ring_buf_size)
+#define BCM2838_GENET_TRING_RING_START_ADDR BCM2838_GENET_TRING_REG(start_addr)
+#define BCM2838_GENET_TRING_RING_START_ADDR_HI BCM2838_GENET_TRING_REG(start_addr_hi)
+#define BCM2838_GENET_TRING_RING_END_ADDR BCM2838_GENET_TRING_REG(end_addr)
+#define BCM2838_GENET_TRING_RING_END_ADDR_HI BCM2838_GENET_TRING_REG(end_addr_hi)
+#define BCM2838_GENET_TRING_RING_MBUF_DONE_TRESH BCM2838_GENET_TRING_REG(mbuf_done_tresh)
+#define BCM2838_GENET_TRING_RING_FLOW_PERIOD BCM2838_GENET_TRING_REG(flow_period)
+#define BCM2838_GENET_TRING_RING_READ_PTR BCM2838_GENET_TRING_REG(read_ptr)
+#define BCM2838_GENET_TRING_RING_READ_PTR_HI BCM2838_GENET_TRING_REG(read_ptr_hi)
+
+#define BCM2838_GENET_RRING_REG(reg)    offsetof(BCM2838GenetRdmaRing, reg)
+#define BCM2838_GENET_RRING_WRITE_PTR BCM2838_GENET_RRING_REG(write_ptr)
+#define BCM2838_GENET_RRING_WRITE_PTR_HI BCM2838_GENET_RRING_REG(write_ptr_hi)
+#define BCM2838_GENET_RRING_PROD_INDEX BCM2838_GENET_RRING_REG(prod_index)
+#define BCM2838_GENET_RRING_CONS_INDEX BCM2838_GENET_RRING_REG(cons_index)
+#define BCM2838_GENET_RRING_RING_BUF_SIZE BCM2838_GENET_RRING_REG(ring_buf_size)
+#define BCM2838_GENET_RRING_RING_START_ADDR BCM2838_GENET_RRING_REG(start_addr)
+#define BCM2838_GENET_RRING_RING_START_ADDR_HI BCM2838_GENET_RRING_REG(start_addr_hi)
+#define BCM2838_GENET_RRING_RING_END_ADDR BCM2838_GENET_RRING_REG(end_addr)
+#define BCM2838_GENET_RRING_RING_END_ADDR_HI BCM2838_GENET_RRING_REG(end_addr_hi)
+#define BCM2838_GENET_RRING_RING_MBUF_DONE_TRESH BCM2838_GENET_RRING_REG(mbuf_done_tresh)
+#define BCM2838_GENET_RRING_RING_XON_XOFF_TRESH BCM2838_GENET_RRING_REG(xon_xoff_tresh)
+#define BCM2838_GENET_RRING_RING_READ_PTR BCM2838_GENET_RRING_REG(read_ptr)
+#define BCM2838_GENET_RRING_RING_READ_PTR_HI BCM2838_GENET_RRING_REG(read_ptr_hi)
+
+
+#define BCM2838_GENET_PHY_REG(reg)      (offsetof(BCM2838GenetPhyRegs, reg) / 2)
+#define BCM2838_GENET_PHY_BMCR          BCM2838_GENET_PHY_REG(bmcr)
+#define BCM2838_GENET_PHY_AUX_CTL       BCM2838_GENET_PHY_REG(aux_ctl)
+#define BCM2838_GENET_PHY_SHD           BCM2838_GENET_PHY_REG(shd)
+#define BCM2838_GENET_EXP_DATA          BCM2838_GENET_PHY_REG(exp_data)
+#define BCM2838_GENET_EXP_SEL           BCM2838_GENET_PHY_REG(exp_ctrl)
+
 #define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
 #define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
 
-- 
2.34.1


