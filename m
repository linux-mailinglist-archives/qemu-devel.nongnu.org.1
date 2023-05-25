Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B67711056
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DPD-0002p5-Qy; Thu, 25 May 2023 12:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cutelizebin@gmail.com>)
 id 1q2D92-0002Ry-HM
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:44:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cutelizebin@gmail.com>)
 id 1q2D90-0003A0-Pe
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:44:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d247a023aso1800388b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685029489; x=1687621489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oN98ufDFLRMeeqRbE+OEGNNXm6F9IaWbaCm6cjd2EXs=;
 b=n1XUQCg97fm/cZgkVo++R+Ei85tWy5+P5IFKNSWaYlrix3mDbzVkVM1TuIBM98IEyR
 h4ZC970ngAFZ1df6T3cDYtmDaMyb+5RMp7yIslAwB1Qlw2mFkiNLz8XShejL0nKvOPfS
 SkSt4KLx8DmGTQEvtF9I4PHMTIyy9quh0chRb+I0FkGcjZMCtLbmcq0axKy9lRn426o6
 Skpv2ObCXj/qyM06UU/p4KImJsdMPqAlt01loHOWeq3bnkbg/RFq0cbiUSPrUYkP/htC
 Rp2nP3zcxB6hhjBhIGUGGvD33XKXRA3zEWMDePqtD4gidANlkPnyAIPUGWmktjRdAyR/
 o0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685029489; x=1687621489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oN98ufDFLRMeeqRbE+OEGNNXm6F9IaWbaCm6cjd2EXs=;
 b=JmcmAr9RNGMUuQV65x5xcl0X4oC8JBWU+ggPNzx0y8tAOke8pz4FDpqF/1oO1ZHp5n
 c0Vwcl5b3Q6eue8YWkA19n3QrE20x64qR282iSbaUVvTlMIEagSAk8TMbpjkVTfW8sNs
 RiBFtYOk/Cy9TM/6fa7B/vuLY7apGBM6WSgJZGqDeLGMkU9YBhVoZmSUtOqJ4fVToRXI
 en/Yab01rPBbfDKQ4DVZtrTgYxrhjf23UCy5lDGAfkll1U4FpvjqYb/cAyEbR0j/nDva
 t/pMWAtbQQfNAeWDfaf1LIpfU+w7yiQm67OHoHYh+FvW4qfjR/1C4r+d4jEsdvWPVnkU
 nbhw==
X-Gm-Message-State: AC+VfDwpdCzvfv/JCIK5pnP0NxYXPQoAUySjLVxTbug49biVAoEhwozP
 wo1yBxELCp/syGqfzvr+g2/H2z5tutvbOWWiw20=
X-Google-Smtp-Source: ACHHUZ7Ye7TA+A7LL8dsefBJfSVwJF1DDs5QLDoeoSrE/rYNtZ95k95vBDSulYXaJ+iSRzF6RUaKFw==
X-Received: by 2002:a05:6a00:178f:b0:645:ac97:5295 with SMTP id
 s15-20020a056a00178f00b00645ac975295mr9564293pfg.9.1685029488506; 
 Thu, 25 May 2023 08:44:48 -0700 (PDT)
Received: from cutebbb.localdomain ([101.86.204.163])
 by smtp.gmail.com with ESMTPSA id
 a24-20020aa78658000000b0064d74808738sm1322400pfo.214.2023.05.25.08.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 08:44:48 -0700 (PDT)
From: Li Zebin <cutelizebin@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	Li Zebin <cutelizebin@gmail.com>
Subject: [PATCH] libvhost-user: Add new VhostUserRequest ID.
Date: Thu, 25 May 2023 23:44:42 +0800
Message-Id: <20230525154442.16497-1-cutelizebin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=cutelizebin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 25 May 2023 12:01:30 -0400
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

Signed-off-by: Li Zebin <cutelizebin@gmail.com>
---
 subprojects/libvhost-user/libvhost-user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 8fb61e2df2..725de6fba2 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -161,6 +161,8 @@ vu_request_to_string(unsigned int req)
         REQ(VHOST_USER_GET_MAX_MEM_SLOTS),
         REQ(VHOST_USER_ADD_MEM_REG),
         REQ(VHOST_USER_REM_MEM_REG),
+        REQ(VHOST_USER_SET_STATUS),
+        REQ(VHOST_USER_GET_STATUS),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
-- 
2.25.1


