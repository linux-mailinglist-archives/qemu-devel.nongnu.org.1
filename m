Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C88257D3
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:12:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmnw-00022Y-7N; Fri, 05 Jan 2024 11:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLmns-00021k-5f
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:12:12 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLmno-0005Yo-WE
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:12:11 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso508281b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704471004; x=1705075804;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/7U3N1q9t3eqN97CARt0M7fKQLGvH1bvRELfLfvv34=;
 b=Qq/hfLlI4F6IUKTiQLLiogGWzCCoKX4qr0N+siEZIUMgTNffOafIPkSYSY6B6XuWnL
 iWSa9NHHlP1vpIYTPtT3TNJ+oqh/XohydZ12nUSE9Eb8egKXSVxhAtgZamvdmS4dOkNl
 RBwa2IfkAP8pFDP7BiahDVWAp6LmZgcDoh7g8kxWHxDpMNyTPvg2qf//aZflaOkQu/Ao
 YZ4Lp8dsywUGDC1Jv8g4gUjWJAKLjCns41wHXcRY+zO3zjyovhgyJBsptVrXXXYyi41g
 IJwc0PTWTE3l3Qp1KVgYnyi0kw3+11yPExk8+ErYII9/JOKj3CejweXu10XIY/klxWCI
 86pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704471004; x=1705075804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/7U3N1q9t3eqN97CARt0M7fKQLGvH1bvRELfLfvv34=;
 b=KWCiBXYEQ1M7BGBaXkiLCIsQ+mJiEzzoCiS4DR8NAojmjUBUU20x4vrp89UIPPIqTF
 XkUx5FlSPLPJtlM84i4ylNipGgf+zBk+H4XUQadPZ+uuJnLR/KZuPDwFBYd1iz2jXLYH
 kdn731wGRfrUFwY+EJN/hN8Oko19KJHrEp5A6YcJByZ39+8Cuz0Zno9LTzvuzwYXxe6F
 IqRODHaEAWDAlVBSwFN04nqkzPH0OG/m4TdtiPPGwI9ohRT6YXrR2Xrsomcdum06iikL
 6T+tgKi/vb6xk7cHvUIwCHsl7Dt5gFcPYxLOO0FVHTW4BosTfcxEjWkcFq6P1FKDbW7/
 Q3uQ==
X-Gm-Message-State: AOJu0YyM6w/J16zcwwft+8uCe6OCXeRh15TuPqBMEIneLWSZ6FaZHL73
 ykaws9TkbsUo6/N06o+FbBJvwbD1/+QUOBrOSgBE9HHiV0xJwM4z
X-Google-Smtp-Source: AGHT+IH7Tajpf3Pz55z8XjkzMDT7Y2GanIj3o+3rYrRDczAFeZ2aN0/W/nZ2T/WWb/XRRq/QrpWngg==
X-Received: by 2002:a05:6a00:10cb:b0:6d9:a856:eec2 with SMTP id
 d11-20020a056a0010cb00b006d9a856eec2mr2882838pfu.14.1704471003525; 
 Fri, 05 Jan 2024 08:10:03 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.173])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a056a0026c300b006da19433468sm1570127pfw.61.2024.01.05.08.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:10:02 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH] i386/sev: Nitpick at the error message's output
Date: Sat,  6 Jan 2024 00:09:55 +0800
Message-Id: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x429.google.com
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

The incorrect error message was produced as a result of
the return number being disregarded on the sev_kvm_init
failure path.

For instance, when a user's failure to launch a SEV guest
is caused by an incorrect IOCTL, the following message is
reported:

kvm: sev_kvm_init: failed to initialize ret=-25 fw_error=0
kvm: failed to initialize kvm: Operation not permitted

While the error message's accurate output should be:

kvm: sev_kvm_init: failed to initialize ret=-25 fw_error=0
kvm: failed to initialize kvm: Inappropriate ioctl for device

Fix this by returning the return number directly on the
failure path.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9a71246682..4a69ca457c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1019,7 +1019,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 err:
     sev_guest = NULL;
     ram_block_discard_disable(false);
-    return -1;
+    return ret;
 }
 
 int
-- 
2.39.1


