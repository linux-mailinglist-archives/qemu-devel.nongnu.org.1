Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CE37D4375
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4dY-0002sg-46; Mon, 23 Oct 2023 19:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39QU3ZQYKCg47w7865u22uzs.q204s08-rs9sz121u18.25u@flex--titusr.bounces.google.com>)
 id 1qv4dV-0002qh-4F
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:05 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39QU3ZQYKCg47w7865u22uzs.q204s08-rs9sz121u18.25u@flex--titusr.bounces.google.com>)
 id 1qv4dT-0002mW-5f
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:47:04 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5a7bbe0a453so48683737b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698104821; x=1698709621; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=303iPeC6VLFDXurUY29qkpPl/6cL6vaKoSkHpfuH/uM=;
 b=HVZ4p1iNAk2E+cruAg62FhYAv7TnersQQvZ9c5etP9NkiiHZYzmaQqXlHS1OqENkh1
 qCHepygT+wiB75b0Qdd0pc87JfFRkQc8QN6BhsMAvFiBiSdAhkJST47u93aF7Ah2VSWu
 YwRjwtxw+cEhEFI31hPlJxgAGraqSuz+oK58GghKDSj0quJypW2euKRiR2exiTECDmR5
 8fRk9Ij3xnXx7pVC7uI56j6OGZ9d8FkhdJstY4XmwPlbCgRj813yG1Ap0L9iehnoyUgO
 WhfghUNqGJ/b1Lch+CyUGGfbnF6Q/Z8MOpADJgnzTlw6w4e+ZjN6t1BaaAMId+oEqPvx
 L8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698104821; x=1698709621;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=303iPeC6VLFDXurUY29qkpPl/6cL6vaKoSkHpfuH/uM=;
 b=MDDLwyR8LihICDsqHAMAS6Shll7QXTzbegh/a+R8wBMSLl24aqOS03YP4mNEImpeVu
 0z+nf7KU8SejkwXfCi/XtrHIwYOEMCus5XON3GquV8aEjDnJaL9kKSLAFj9LL0B3tOnQ
 eI97pnjGY1PkNlXcGh723UUd+K4XiwnzjDa3QMsyJLP+kTHGQuX0yFSOCzDqWp2b5TOi
 xTTeh3EJBPBrzoksk2eQ8M4tap7vNoQ5/qyTsRHeqk3Xj/8eotNoVuu7fE4FZeatZLEd
 HeFHe6rbtcI++u4CXyMKeyUSJ9agfL4BMwq7LicCclI6rMCat06uLVMTZjgx3dLMJWzM
 fdQQ==
X-Gm-Message-State: AOJu0YxQW1A7CwfQ39OGgdJOV/rk0ULpdNinCd4BDE1VyyytYljBXRk2
 D+bluiEPwUvE9LRCCk+rze9HlyczUos=
X-Google-Smtp-Source: AGHT+IHnaCcgaahOvDN/4JU4FHtRrxlkmBinU1yQjbvfrgeQa5lj+EJ9gaCybpGLq2/J0ra1MWZj+dHL4Ow=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a25:2f94:0:b0:d9a:6633:a799 with SMTP id
 v142-20020a252f94000000b00d9a6633a799mr189907ybv.13.1698104821566; Mon, 23
 Oct 2023 16:47:01 -0700 (PDT)
Date: Mon, 23 Oct 2023 23:46:43 +0000
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Mime-Version: 1.0
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
X-Developer-Key: i=titusr@google.com; a=openpgp;
 fpr=228BD42BAD6A2BCD3865AEA6C41200175CD21E30
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=titusr@google.com;
 h=from:subject:message-id; bh=n97rpZwK0i4oWF9iNxYFr4kpVaKZTUXQ3O7PLD7S2I4=;
 b=owEB7QES/pANAwAKAcQSABdc0h4wAcsmYgBlNwXug+zQskA05Rb4QwH8fIdqaks9Hf3kb5U1f
 5uQjCgfjrOJAbMEAAEKAB0WIQQii9QrrWorzThlrqbEEgAXXNIeMAUCZTcF7gAKCRDEEgAXXNIe
 MPTqDACmh+ROsnXlUogZ90xqoZu/8IRvuyeopZyW4yNBQcq6f8m/vY3R/b8ug/CT6DfTkLvq+hD
 wqR2jpAJEh4/mcSQs6iaBaAuHO3+aMq9TMhFQGlCo/cNO2G5ZssImmlPbftJ1HPip+cKcDH0nlW
 WbcGvj9td4pCSewLMx4Q9LZtXRBxay3pmOBuCdG9R92h5cKzmY2KoJYMMm807Wk4ixXqa2eLYYH
 VqqGIZqac6Hghzo/naU+3tUhEogZmpLd2M3M/z2rFEsCFERRDOoup/FmlKjCqEsLdrFwqshwf2i
 CGnMb+TY5nHztgahzoHsnCyUlKjTFotR5iq7AeD4l3SrAkeDwiSiNOJxF5paWPg4SrO/0oqCe5r
 QohyX3rPekeab3zTpkF8MyVtwqFEJnIPjyLFWpk7ecsfn71NcIOurmJelVjO1l8wjhCG272UUCj
 xw1xriOfxd1dwCWe/TLt1q0/1uHQy/wa2GN7wl6HzkH4u4qdWC+poEto2YfNMR1uobycY=
X-Mailer: b4 0.12.2
Message-ID: <20231023-staging-pmbus-v3-v4-4-07a8cb7cd20a@google.com>
Subject: [PATCH v4 4/8] hw/i2c: pmbus: add VCAP register
From: titusr@google.com
To: philmd@linaro.org, minyard@acm.org
Cc: Titus Rwantare <titusr@google.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Benjamin Streb <bstreb@google.com>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=39QU3ZQYKCg47w7865u22uzs.q204s08-rs9sz121u18.25u@flex--titusr.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

VCAP is a register for devices with energy storage capacitors.

Reviewed-by: Benjamin Streb <bstreb@google.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/i2c/pmbus_device.c         | 8 ++++++++
 include/hw/i2c/pmbus_device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index c1d8c93056..3bce39e84e 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -906,6 +906,14 @@ static uint8_t pmbus_receive_byte(SMBusDevice *smd)
         }
         break;
 
+    case PMBUS_READ_VCAP:                 /* Read-Only word */
+        if (pmdev->pages[index].page_flags & PB_HAS_VCAP) {
+            pmbus_send16(pmdev, pmdev->pages[index].read_vcap);
+        } else {
+            goto passthough;
+        }
+        break;
+
     case PMBUS_READ_VOUT:                 /* Read-Only word */
         if (pmdev->pages[index].page_flags & PB_HAS_VOUT) {
             pmbus_send16(pmdev, pmdev->pages[index].read_vout);
diff --git a/include/hw/i2c/pmbus_device.h b/include/hw/i2c/pmbus_device.h
index ad431bdc7c..f195c11384 100644
--- a/include/hw/i2c/pmbus_device.h
+++ b/include/hw/i2c/pmbus_device.h
@@ -243,6 +243,7 @@ OBJECT_DECLARE_TYPE(PMBusDevice, PMBusDeviceClass,
 #define PB_HAS_VIN_RATING          BIT_ULL(13)
 #define PB_HAS_VOUT_RATING         BIT_ULL(14)
 #define PB_HAS_VOUT_MODE           BIT_ULL(15)
+#define PB_HAS_VCAP                BIT_ULL(16)
 #define PB_HAS_IOUT                BIT_ULL(21)
 #define PB_HAS_IIN                 BIT_ULL(22)
 #define PB_HAS_IOUT_RATING         BIT_ULL(23)

-- 
2.42.0.758.gaed0368e0e-goog


