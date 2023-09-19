Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882437A6C07
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxt-00067g-89; Tue, 19 Sep 2023 16:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JOEJZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1qiezj-0005FL-NR
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:43 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JOEJZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1qiez4-00012i-FF
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:43 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-d81646fcf3eso6560826276.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146276; x=1695751076; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=NObwuov3ZRdtGHX72FWq7XIeEMuZCIm45IOHrfEILS4=;
 b=ZX+4Uh8LzkIxzS6jW59YTkKy/OB1ITli1Uc96/IY2fatAaDJ71TAxq3jbPfaHomwQp
 GMQVqicN/CzQiQVjTdi1oNtww7K7sX0WsZqvSfqeA0obFamk6BLK/MiOC/VZpym0R5Ng
 9vyguiJM4F5oAaVSjTbLpYZR+cgqCFgFksiDnaE6dNRbO4GRMUnS2jLqbYdtiREPp9w4
 bNccZdyLgHQcdr288xVxWmMOKfHTWkP0QGg7MOHmbXqdx6PRdQcLVzd9O/93uuED/rL1
 QgStqt8t2KOh4QLu5hl52Goa5sl66Dw4w+u+5kAMiLI3XMI+2NSwYchKpLy6H6W1VVaX
 OEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146276; x=1695751076;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NObwuov3ZRdtGHX72FWq7XIeEMuZCIm45IOHrfEILS4=;
 b=UV4QBJMOKaL/rHUPh83OMicpPHXZHmzqfDsVfhRKUf1jsgo58VE0UO7GCKvFwLeYq1
 pDAg0gvx1d3R6TWhaeG/Y5uY7OX3In+f4mUfLDUYTs2qDxZmSLOKRgqEm5Gn6m8BAqaW
 Hx471GdUrFBwcDDWq00W2WmDzfpT8iNj5IkU/JA/ZEBiN02am24AHBeBTBKCKes62MfG
 BR/gPT7BMPqkkgn9XMwX90iPDXVXX29lnFIEh2ZF8TKgnJ+vSLCloZpvw1cDYcw3X3xV
 Xj5zrvymV9atoF6KX1ZyIL+ujDmGvHr3/Jjy3LGd0ZSIU35d9cipgx5BvpESmaLZeJEu
 3mSQ==
X-Gm-Message-State: AOJu0YxtjXdltuwLxIEjee6RYk2E6qzBq0XW0m2jjQJbGVzuMBYGoQms
 1ildu9rm3tzhl8qeYyh9z4nI0714D474iXwSEic=
X-Google-Smtp-Source: AGHT+IFj5SjSuqUzWjL6aIxctnCm6mnJivLkMmgUoU6lCmnj/KRzQWWUh0w9uHfjZMIjkfymGb2UvoE8xUvIla5KeqM=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a25:db07:0:b0:d81:78ec:c403 with SMTP
 id g7-20020a25db07000000b00d8178ecc403mr5328ybf.12.1695146276243; Tue, 19 Sep
 2023 10:57:56 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:20 +0000
In-Reply-To: <20230919175725.3413108-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230919175725.3413108-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-10-nabihestefan@google.com>
Subject: [PATCH 09/14] include/hw/net: Implemented Classes and Masks for GMAC
 Descriptors
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3JOEJZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:51 -0400
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

 - Implemeted classes for GMAC Receive and Transmit Descriptors
 - Implemented Masks for said descriptors

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
---
 include/hw/net/npcm_gmac.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index 03529db1d6..067928fe0b 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -38,12 +38,19 @@ struct NPCMGMACRxDesc {
 /* RDES2 and RDES3 are buffer address pointers */
 /* Owner: 0 = software, 1 = gmac */
 #define RX_DESC_RDES0_OWNER_MASK BIT(31)
+<<<<<<< HEAD
 /* Owner*/
 #define RX_DESC_RDES0_OWNER_SHIFT 31
 /* Destination Address Filter Fail */
 #define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
 /* Frame length*/
 #define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
+=======
+/* Destination Address Filter Fail */
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
+/* Frame length*/
+#define RX_DESC_RDES0_FRAME_LEN_MASK extract32(rdes0, 16, 29)
+>>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
 /* Error Summary */
 #define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
 /* Descriptor Error */
@@ -84,11 +91,17 @@ struct NPCMGMACRxDesc {
 /* Second Address Chained */
 #define RX_DESC_RDES1_SEC_ADDR_CHND_MASK BIT(24)
 /* Receive Buffer 2 Size */
+<<<<<<< HEAD
 #define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
 #define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
     RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
 /* Receive Buffer 1 Size */
 #define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+=======
+#define RX_DESC_RDES1_BFFR2_SZ_MASK extract32(rdes1, 11, 21)
+/* Receive Buffer 1 Size */
+#define RX_DESC_RDES1_BFFR1_SZ_MASK extract32(rdes1, 0, 10)
+>>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
 
 
 struct NPCMGMACTxDesc {
@@ -125,7 +138,11 @@ struct NPCMGMACTxDesc {
 /* VLAN Frame */
 #define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
 /* Collision Count */
+<<<<<<< HEAD
 #define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 6)
+=======
+#define TX_DESC_TDES0_COLL_CNT_MASK extract32(tdes0, 3, 6)
+>>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
 /* Excessive Deferral */
 #define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
 /* Underflow Error */
@@ -140,7 +157,11 @@ struct NPCMGMACTxDesc {
 /* Last Segment */
 #define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
 /* Checksum Insertion Control */
+<<<<<<< HEAD
 #define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 28)
+=======
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK extract32(tdes1, 27, 28)
+>>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
 /* Disable Cyclic Redundancy Check */
 #define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
 /* Transmit End of Ring */
@@ -148,9 +169,15 @@ struct NPCMGMACTxDesc {
 /* Secondary Address Chained */
 #define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
 /* Transmit Buffer 2 Size */
+<<<<<<< HEAD
 #define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 21)
 /* Transmit Buffer 1 Size */
 #define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+=======
+#define TX_DESC_TDES1_BFFR2_SZ_MASK extract32(tdes1, 11, 21)
+/* Transmit Buffer 1 Size */
+#define TX_DESC_TDES1_BFFR1_SZ_MASK extract32(tdes1, 0, 10)
+>>>>>>> f17fd3e311 (include/hw/net: Implemented Classes and Masks for GMAC Descriptors)
 
 typedef struct NPCMGMACState {
     SysBusDevice parent;
-- 
2.42.0.459.ge4e396fd5e-goog


