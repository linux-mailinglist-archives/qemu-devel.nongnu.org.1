Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42559BB90AF
	for <lists+qemu-devel@lfdr.de>; Sat, 04 Oct 2025 19:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v56Mr-0003rV-Eb; Sat, 04 Oct 2025 13:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v56Mk-0003r9-TI
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:48:18 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v56Mj-0007UD-3W
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:48:18 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-57933d3e498so4568303e87.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759600091; x=1760204891; darn=nongnu.org;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vuzm8FeLO84xvcLhr8EGDm+15bWYBkiXGDkQ3fYG9w8=;
 b=Ybpfp4seDpVzIUtnBPcLSTsPfnd1UO3aKNaAd8MbSiYAJ94KWUc4qHIBUsD/E9GqmR
 ZrN0wlSUMzU3W5btZFVyx40ssPYurz/cUsY7rfA9PNzilXV99VcI+lDxj9VmND6BWU+/
 IS/1FcKJC3SqshYRuLJN1wUypHltPeX5IFIx11AOOLq78I9GvIAK/m4ym0p6/ZhczNeI
 6hm7FnCkpdHhATNd78sSsUH1ERu7JY22raVPCcXdJXG3FJEn0hjyRobLnt/hIU9YULNN
 h54mmgAYiEloNczs/64ORb5GmxrDqc/ulvpc2tXERADfT9pSjfYbTEHMn48MN3d4utR4
 Nj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759600091; x=1760204891;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuzm8FeLO84xvcLhr8EGDm+15bWYBkiXGDkQ3fYG9w8=;
 b=pzWsA7j2nEkUN+YC21Zu3H2Eh34apdETOsmcpqHc8lq6+f/cnulR3ti5XeVtq5DdIa
 dvseuETF3s5gQ/ffzKgy5/UiXBhk25PRh3gz66IhIBX6LNNfV5NP1lha8hgiA9Ve0A+h
 lwoVOlsi5Ld/4zi0k7/+tqx+J61Ko/Mk9wLs0i07HKzd6ICERuAk82RFZSrTQ1goQPPF
 4YnkhEErGnZosII6Eo5N7PTrKOevzHRNKSmQz/Ke4zspJMuOFkpF6tfgpiWfY8BFD93c
 Mb80m9v8RG5rWCricvRPBWe1nAmqMtBUQvv6LbdjZnjCYeP8PfTj/8XAA28F9w/PSUoc
 oiQA==
X-Gm-Message-State: AOJu0Yz2Z5nwpBbVBsZLcL3b1WiolX2krn3KEEwo9R9ZFdWp/Qu/6+lY
 m6Z+73I1f6YblhjIggj07KT7028kdpso5RuJsAMLUaF/FyPZdhpC2PuZ7U/2GYi0ZcE=
X-Gm-Gg: ASbGncszTiL3xmzz8WdSGXtfzGXf/DNV2IbA3PdaOTlt5F2tSzo+QWFc3uUUBct97bY
 7lJn8C3rUuXNREyhoPt12e1Ecmo9lnH3SRgXCzGRcEfAzTNhpwskPne/Keqjqyt7aR/Py1tGw3Z
 JCM03l5RevGtwuYsCYegql0hgu4MdIWSVGBIMU/x6CmvUrqx9EUN0R5l35l5VnUoHeRgSFsPnQf
 9dv99bcSNYmyjOxG26UPRPnRtslloO0h08S/rQ16vC+5qd+b0OKSm1YvCjizB7q1mAwrDiNZujn
 6jXtu50u6dL49COCR9rYVcgXioZ+9m3IM7Xxkz1XVf11emKl9Aci7yn3uJH9GEUNnVrXPQBPPQ5
 jax5q1UaHQycuwucKU1F7RtpjLStGU6u9Bot2Md2zqG8A87w5
X-Google-Smtp-Source: AGHT+IHiOkNR+s7Ffelj60WmPq4+KOPES10Pfvf3mEbBnOm2mk2kCFxZmOLzT+IKidFAKkJW/vif4Q==
X-Received: by 2002:a05:6512:23a9:b0:58b:6f:719e with SMTP id
 2adb3069b0e04-58cba6c1968mr2335972e87.17.1759600090581; 
 Sat, 04 Oct 2025 10:48:10 -0700 (PDT)
Received: from smtpclient.apple ([2a02:6bf:8080:446::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-58b0118d258sm3042216e87.66.2025.10.04.10.48.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 04 Oct 2025 10:48:10 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: [PATCH] system/runstate.c: Add a newline character to correctly log
 guest errors
Message-Id: <32D0DF37-A1B3-4532-B350-082E19E4EABB@gmail.com>
Date: Sat, 4 Oct 2025 20:47:56 +0300
Cc: qemu-trivial@nongnu.org,
 =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCT0YDRj9C90LrQvg==?= <xpahos@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3776.700.51.11.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The pvpanic handler calls the qemu_system_guest_panicked
function with a NULL parameter, which results in the absence
of a newline character in the guest error log.
The qemu_system_guest_crashloaded function has no additional
logic, but also omits the newline character.
The qemu_system_guest_pvshutdown has no reporting in the
guest error log.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
system/runstate.c | 5 ++++-
1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..8b4bf75cd6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -674,18 +674,21 @@ void =
qemu_system_guest_panicked(GuestPanicInformation *info)
        }

        qapi_free_GuestPanicInformation(info);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "\n");
    }
}

void qemu_system_guest_crashloaded(GuestPanicInformation *info)
{
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded\n");
    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
    qapi_free_GuestPanicInformation(info);
}

void qemu_system_guest_pvshutdown(void)
{
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest shutdown requested\n");
    qapi_event_send_guest_pvshutdown();
    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
}

---
base-commit: 81e3121bef89bcd3ccb261899e5a36246199065d
change-id: 20251004-add-newline-guest-error-log-62d68638b28c

Best regards,
--=20
Alexander Gryanko <xpahos@gmail.com>


