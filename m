Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56B70D191
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I29-0007SV-C3; Mon, 22 May 2023 22:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1n-00065f-4b
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1i-0004XY-AC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2553b0938a9so1855246a91.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809928; x=1687401928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzPAbEmJEB50Ysp/pj8sTC2FsTwLihV0BgZPulCV70A=;
 b=G1IGJwkezi9qMAXkLAHJRkl4gV6pJWGuL/vIr+BEK+zTgcasvv9X3UwsLnKLuuDWXs
 QusxjKu8CHNbjxzPF5RJ0Q2uusgiN66nb39AiIKasKo0eIfn3WZJ3XWUiFiESrWkrUkU
 S9QQqksGuM5njhcUQdRQKkGqfT4aZzjgaHvQhn3bGtBZkZHPpFaMFLFqtR8FQMvNadD0
 TcT7G8pPbnx7bBJ11g8ZzSxgsedMpy/eC+f0BOyV+qQuchzX6AG0EZZfgUBnwJdtwwjr
 P7uggc5GWWy/PpfqxtLarP3LA+RXD5SXwugMySL2lVEMxid6zwwN/A8xBMMzQ4Mkv4OP
 cEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809928; x=1687401928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzPAbEmJEB50Ysp/pj8sTC2FsTwLihV0BgZPulCV70A=;
 b=C8H07EfGTKNGo4yjJYGf8zlsfaNDvlRYOVF/FYxdXDLt8VY9hVYLusK3rHsKafCIxK
 7uDEzjWEgIJGvSYMdvXzyUCIs5NXKMwAiwtXg6r7uRavIr+lA08N9xYMBl9+arWsdIyd
 a0j00DwFhYuPi/chCmhXE26anZlXE9T9OHQ1DIILXjRT8QES50qzNTX2OoBLiJBjC1dm
 eTQsxPrZ5oKtmTLIY+S9lLagR6jmx9cGeILzri39V9IHxjzwHvkIe05b7May7BHo0H5R
 8ibpJFe+fCaHuY/eTyY5rz7/ILQyUM04cAvlxC8WMaK0DVbRefwIz984Jy/9dJHlXkVy
 KDaA==
X-Gm-Message-State: AC+VfDzi26m67ARlp3+o9DfQ4RLgcD+GV/t0Q/cUrUhHn6vIIPmMSuRE
 15J+k38aJovKaDsBePjY0NTx4g==
X-Google-Smtp-Source: ACHHUZ5qnWtaQClkZaVy5x6Ho3BcHygWABNpAxpdE1w11toj6iiHUkfNFbeRltSXVJv+XXh4GSt0Sg==
X-Received: by 2002:a17:90a:648e:b0:255:7e1b:ca6d with SMTP id
 h14-20020a17090a648e00b002557e1bca6dmr3687449pjj.7.1684809928420; 
 Mon, 22 May 2023 19:45:28 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:27 -0700 (PDT)
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
Subject: [PATCH v5 28/48] e1000e: Rename a variable in
 e1000e_receive_internal()
Date: Tue, 23 May 2023 11:43:19 +0900
Message-Id: <20230523024339.50875-29-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

Rename variable "n" to "causes", which properly represents the content
of the variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/e1000e_core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 7dce448657..aea70b74d9 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1650,7 +1650,7 @@ static ssize_t
 e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
                         bool has_vnet)
 {
-    uint32_t n = 0;
+    uint32_t causes = 0;
     uint8_t buf[ETH_ZLEN];
     struct iovec min_iov;
     size_t size, orig_size;
@@ -1723,32 +1723,32 @@ e1000e_receive_internal(E1000ECore *core, const struct iovec *iov, int iovcnt,
 
         /* Perform small receive detection (RSRPD) */
         if (total_size < core->mac[RSRPD]) {
-            n |= E1000_ICS_SRPD;
+            causes |= E1000_ICS_SRPD;
         }
 
         /* Perform ACK receive detection */
         if  (!(core->mac[RFCTL] & E1000_RFCTL_ACK_DIS) &&
              (e1000e_is_tcp_ack(core, core->rx_pkt))) {
-            n |= E1000_ICS_ACK;
+            causes |= E1000_ICS_ACK;
         }
 
         /* Check if receive descriptor minimum threshold hit */
         rdmts_hit = e1000e_rx_descr_threshold_hit(core, rxr.i);
-        n |= e1000e_rx_wb_interrupt_cause(core, rxr.i->idx, rdmts_hit);
+        causes |= e1000e_rx_wb_interrupt_cause(core, rxr.i->idx, rdmts_hit);
 
         trace_e1000e_rx_written_to_guest(rxr.i->idx);
     } else {
-        n |= E1000_ICS_RXO;
+        causes |= E1000_ICS_RXO;
         retval = 0;
 
         trace_e1000e_rx_not_written_to_guest(rxr.i->idx);
     }
 
-    if (!e1000e_intrmgr_delay_rx_causes(core, &n)) {
-        trace_e1000e_rx_interrupt_set(n);
-        e1000e_set_interrupt_cause(core, n);
+    if (!e1000e_intrmgr_delay_rx_causes(core, &causes)) {
+        trace_e1000e_rx_interrupt_set(causes);
+        e1000e_set_interrupt_cause(core, causes);
     } else {
-        trace_e1000e_rx_interrupt_delayed(n);
+        trace_e1000e_rx_interrupt_delayed(causes);
     }
 
     return retval;
-- 
2.40.1


