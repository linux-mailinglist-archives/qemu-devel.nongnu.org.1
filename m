Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355E70D1AE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2Y-0002mh-O1; Mon, 22 May 2023 22:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2U-0002VC-4T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:18 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2S-0004j8-Bk
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-25374c9be49so4272464a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809975; x=1687401975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhgEeoNzHaAQ3+Hy2XkMNJ23JVd+hysJOoUJ6HBrD5Q=;
 b=15dss0H3sHtDOQNHHZ/77yjfPdYJF5uNcX/0+JXdkkuNJon9cMqMeP4amXv5iDW/Vr
 qcSiGZja2O5flEX88/ivCc/JLoWEEhJMKR1lrPZ6QTuaXdOFLPXfH03aoSnRs3ic5eRP
 gQ52wjyesyB7k9lzhiJzNrGSrhuf0Vk7x3oeNc5982qbSVHEBrZ+OidEauxQ3p/s9jAg
 ILyL1R3YYHHvdPjVl7LqxEr0NxRlLoVlRETbnDQGDVbcS30LTW3u9PnBLwma35l+RbKa
 uVC2M878rkRlXYogpW/Boqm8sGKPncUgfOflPq1uYidMs8gVK5FzV8hlQ6tMQTuFoQIY
 IERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809975; x=1687401975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhgEeoNzHaAQ3+Hy2XkMNJ23JVd+hysJOoUJ6HBrD5Q=;
 b=PRNTme2NYRyfFCA1BDlSsEe//BvZ14+OJ/fdKzT87kJ4o/yX8tbgaR68C+wqba6gPh
 yfsEAJ/jBXyfK3vulHR+IZPrvTDN7tASZHRL0iXDI/MUKGJVeI9SVPOMe/CTi/j1NJn8
 pm64DBea2KcjgL43qqFvfMhQigdAcO77WiwwiSUhhcOS+oarJvebTmE2qHqlT8E+IahK
 Irklul22kGFFwC7rdjqUh5BIiAj86MIKdWRsc2tyFX083n9fiABIf/yr49HMm7ShmoPt
 XjNeEWps5lWefuF8tSqtK14ytm1fiGvAUUPzJtg+vUXDQ1GEDMcWSyAtjDtgJiHnQdiK
 +BaQ==
X-Gm-Message-State: AC+VfDy97IDXJUc1anQl3aVaD1IO3gXqckkIjG8EAEV8dwpKci8/MaZp
 075gkQIvYTLJDuMsIhbcEWd9eg==
X-Google-Smtp-Source: ACHHUZ4iQltnRa4YJvlWmIxgG4qUjqnPC550GF4GmEwXoaleoxrvXnOHkV2Mj67CmQiPkVTBw0x1ug==
X-Received: by 2002:a17:90a:982:b0:255:8802:937a with SMTP id
 2-20020a17090a098200b002558802937amr2511981pjo.11.1684809975120; 
 Mon, 22 May 2023 19:46:15 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 42/48] igb: Implement Tx timestamp
Date: Tue, 23 May 2023 11:43:33 +0900
Message-Id: <20230523024339.50875-43-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_regs.h | 3 +++
 hw/net/igb_core.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 894705599d..82ff195dfc 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -322,6 +322,9 @@ union e1000_adv_rx_desc {
 /* E1000_EITR_CNT_IGNR is only for 82576 and newer */
 #define E1000_EITR_CNT_IGNR     0x80000000 /* Don't reset counters on write */
 
+#define E1000_TSYNCTXCTL_VALID    0x00000001 /* tx timestamp valid */
+#define E1000_TSYNCTXCTL_ENABLED  0x00000010 /* enable tx timestampping */
+
 /* PCI Express Control */
 #define E1000_GCR_CMPL_TMOUT_MASK       0x0000F000
 #define E1000_GCR_CMPL_TMOUT_10ms       0x00001000
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 43d23c7621..49d1917926 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -659,6 +659,13 @@ igb_process_tx_desc(IGBCore *core,
                 tx->ctx[idx].vlan_macip_lens >> IGB_TX_FLAGS_VLAN_SHIFT,
                 !!(tx->first_cmd_type_len & E1000_TXD_CMD_VLE));
 
+            if ((tx->first_cmd_type_len & E1000_ADVTXD_MAC_TSTAMP) &&
+                (core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_ENABLED) &&
+                !(core->mac[TSYNCTXCTL] & E1000_TSYNCTXCTL_VALID)) {
+                core->mac[TSYNCTXCTL] |= E1000_TSYNCTXCTL_VALID;
+                e1000x_timestamp(core->mac, core->timadj, TXSTMPL, TXSTMPH);
+            }
+
             if (igb_tx_pkt_send(core, tx, queue_index)) {
                 igb_on_tx_done_update_stats(core, tx->tx_pkt, queue_index);
             }
-- 
2.40.1


