Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAF7D3EA8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:10:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzMV-0005Oi-Gm; Mon, 23 Oct 2023 14:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com>)
 id 1quzMT-0005Nv-Ao
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:09 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com>)
 id 1quzMR-0006xs-C9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:09:09 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a7d1816bccso49163587b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698084546; x=1698689346; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1bEPckvIqK5pjR+MT9VQ4mF1aQy7+KJPepfi6dVmWBY=;
 b=A5RRpWmlfhBP58eBgg7uqoyj56PJZmcAzRTaaUH/mpWOdiJ4xpe/MtuM8HVSja6zQj
 Kc/OYmRDtW/b1zwysTcNocNRJ6w1vv8tF5OQuLV4s1J41SrDwHRJgtACkKj/+aYMbWJs
 9IOrbZWDzZXO+GwBRWeQhnYQHwy/4TNNNZkuIHFqgWjYSAteKbnMZzd8YKF+QxOMQIjP
 lGSmyHoCgTbl5LinCmElzI16Jqnl/LMOrB7QXZWHDBkfEh3MVNBKEPqGe1RnZ0u2WRIP
 T5iXAj5eNNdEI9VTq8HJSOBSd8Qb17gdjPp6BXEnQf9YJV6Lot4NSkbmV/w4VX4pMB9V
 h23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084546; x=1698689346;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1bEPckvIqK5pjR+MT9VQ4mF1aQy7+KJPepfi6dVmWBY=;
 b=cYoni5/gd74h2arOfgTQVUW5Br0PDIOuCCOzGsHlj5F9OAlCd4fhcZBzW/jvlbDDDP
 UXBMsuDaV4PsXINpFdPenmYDiQsxU2KIVPqjP8n3QG6FEJirYoZmA6A80qkEMwu5oviw
 bnL8QXUgiqr4f9magjw7jwoaMWdTtdQ6mGWFqC1IjIuiLmQVsMQ173458RydOmeKc4gA
 PDmD8IBJvceHgbHfUde31bOU2s190jdyHaZ1+eFnUIedEG6s+pje6XKMtUSBpf12PwpP
 W1eF0C3iwT+gbe1WtYO4j1VLNY2hFpafGt7sJZvdJDA2IXVyTZY4jNruhFxOk8JbHup6
 4s8Q==
X-Gm-Message-State: AOJu0YyrypvwgjSHAtVnWZmMkwT8BLkWenvjdsff9q8Ull+4NJa1PUxv
 EJHsEcHudIHs9jdj1PA2sFVvwX5t/aQ=
X-Google-Smtp-Source: AGHT+IFmF5ZwhCwtoBor82yht0A5USJSWK7SsYIyaaWm/OF+4tzsyc+/utBW6+3n9Q5KvNI09wGebpE0VAk=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:22b8])
 (user=titusr job=sendgmr) by 2002:a81:92c4:0:b0:57a:118a:f31 with SMTP id
 j187-20020a8192c4000000b0057a118a0f31mr220754ywg.7.1698084546023; Mon, 23 Oct
 2023 11:09:06 -0700 (PDT)
Date: Mon, 23 Oct 2023 18:08:33 +0000
In-Reply-To: <20231023180837.91785-1-titusr@google.com>
Mime-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023180837.91785-5-titusr@google.com>
Subject: [PATCH v3 4/8] hw/i2c: pmbus: add VCAP register
From: Titus Rwantare <titusr@google.com>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, minyard@acm.org, 
 philmd@linaro.org
Cc: Titus Rwantare <titusr@google.com>, Benjamin Streb <bstreb@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3wrY2ZQYKCjsqfqrpodlldib.Zljnbjr-absbiklkdkr.lod@flex--titusr.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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


