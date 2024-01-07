Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203B8263F4
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 12:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMRkY-0001cB-9l; Sun, 07 Jan 2024 06:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkW-0001ba-AL
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:28 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rMRkU-0004oo-QD
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 06:55:28 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3606f507efeso6578895ab.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 03:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704628405; x=1705233205;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfCEURHfoJYyEJ96UVfChxnBswBuLiHx6tLxG6w0IME=;
 b=bxVFomnYV3FcC2Dq69Ar9+jikZlqYC5fh/XhSbj0cgEvNXXCIKpLUfZECGq2ZExJk+
 e5EIPv/HlIZNfY6fpd7fgh6L2UJXO1xoy3Qc7SzirUKnG2Au9kPrP3XByG+BjlnZj5Sv
 3I2RzmKuVHDQ+TpL+FpPRUlzjOj0IVzjKABBzHZ/0G8e0WASdxteksiUAt/QNuvgddht
 xgh2kS2S3VJJbXxJ3f8aIcwIykTrifFlRnH0X9NHonoc9b8mZ5QmtTDSK55bO6ryGj+w
 VgZijlgOHEfCLs4Lb/4Ukn6IEEWzMdpUjwSly3PM+3vPZIX7yUynMyRywy6bNtUdDtcg
 Be0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704628405; x=1705233205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfCEURHfoJYyEJ96UVfChxnBswBuLiHx6tLxG6w0IME=;
 b=bGX8niGCVF3eDUF5zbikSX3QIy6f/5QtKESOoQA7r3PuG38HgTtNnP9YsoDNBA19fT
 ZpYh+LMYzGFiF2w8voAPjqfIvQ9yaa1fg2O1u7Bw/Un6B2kW0kglDg7pU4L5WYrSIi09
 fetMqBexQ/uSIL+CYjjdl1XxPSD/lw5UhTmhWZm17+9bG0YuUyvc/+sR+7j2XPs6bFBi
 UDyp1wRMI/tyVHMDkEouW2CoJ7u37YjWq457MnBDG7Mp1VHqVUI+VnB3YtmesKbAqtom
 zHo+OXjwuP/RNonCsiOp30gFQW0dlNjJIClMdrLUlT0VQYZlmuqqE7HlZbcoOj6Pq8Dt
 Lg3A==
X-Gm-Message-State: AOJu0YylHOWmEjXe6Gq2oPRW++FBVHHDcnhK4VSGqjVPXISOvASK4eAO
 ReWm1ibMgLwwcmEX+Ul/uKXPREnCroRjRO/MnuRd9vawLHwI0w==
X-Google-Smtp-Source: AGHT+IFfUNYsnm2Bn8zu/P/Vjm4bVutG//muG7PXoQMluMBQb0PV4u9qT3NkuSBOaayeuZNeCH5OCQ==
X-Received: by 2002:a05:6e02:19c5:b0:35d:6121:3794 with SMTP id
 r5-20020a056e0219c500b0035d61213794mr4215127ill.54.1704628405012; 
 Sun, 07 Jan 2024 03:53:25 -0800 (PST)
Received: from localhost.localdomain ([171.216.79.156])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a1709027c0500b001d4ea1b6a2csm4082694pll.32.2024.01.07.03.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 03:53:24 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 2/2] i386/sev: Nitpick at the error message's output
Date: Sun,  7 Jan 2024 19:53:11 +0800
Message-Id: <af66b40fe05eae1b641df92e73605e84412f926d.1704626686.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1704626686.git.yong.huang@smartx.com>
References: <cover.1704626686.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=yong.huang@smartx.com; helo=mail-il1-x129.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <c5033954155dfe256f650fc9ca2084c688356317.1704469721.git.yong.huang@smartx.com>
---
 target/i386/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 96eff73001..3fef8cf163 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1023,7 +1023,7 @@ int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 err:
     sev_guest = NULL;
     ram_block_discard_disable(false);
-    return -1;
+    return ret;
 }
 
 int
-- 
2.39.1


