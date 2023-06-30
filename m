Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8417437CA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9tu-0006rj-Gc; Fri, 30 Jun 2023 04:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9tr-0006pD-Ar
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:43 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9tp-0007nN-Q1
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b8033987baso10041195ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688115280; x=1690707280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wQD0zN7sNnDH0LOt/HHz/hnxeVO1h+UX/MPPuV8oEyo=;
 b=h1Viv30sS4AeojmZJx2qxbOeeCbiymlBVccqXf+PDoghQXyeKJJ+hiYv3nGfMH4/ha
 q9jt1n6KHqbNtsww40SGccFHSL7ixLnDBQ+Bmjcz4XmLp9fLFRQHrFlVu9+PlhypJz0T
 AH0WEJATbneFHsNKPBAb8MVRUiyoKRIMUIIfXVFX3KFDFjtJQRq6X7A/qpkVMdYM3qH1
 OcF/7i6NR0OxzMm5q/I3qEI54E5VRoGJSl/bVfzBi2WjX8/w7iitqhQrpuridmgmRHnH
 qUXG1UBZq9rojrNZlVQb+rxicgKIVn6IcQRavyFfdanUwEfOnOKa49ZxCUhOSPqUNQGl
 bEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688115280; x=1690707280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wQD0zN7sNnDH0LOt/HHz/hnxeVO1h+UX/MPPuV8oEyo=;
 b=N8aNdl0XEk+N3UGDluMqmzldWgRUmXoSbuecUTCfiE6oUEopA6t8URzz/uw/Xz0KFK
 E2AAFPfMHvDt046b+fHk7UXiBqr0aHRkOpec9IOeRepfyt1ew3JK8KkKwo/SXMyI+XZC
 Bn3isoPpczxqy2mmH3ZLKdv/7xTglbI7EMndn4ORAivW/gPRdCOiwvJSdgq3jVP6/BSY
 9kBy2KOPCEA0zS2UbKINN2UtjwRjvc0LPCB61d/MhL1rOToQgUL9iIfEh4jx9+APiLI7
 4d2+TCvdXvUKQPw8gVmBy4jLWzGm0H0ED0FRG8YQo8Hrby/5M61MqC2igeDBmfBnEfez
 Sb/Q==
X-Gm-Message-State: AC+VfDyZsC47qzSzwYrmb4XKxo9zwBTWN/mTC+veyGsk3NQZQkzP6+RL
 t8lEOWcnONN5PKkjAIzLpdY=
X-Google-Smtp-Source: ACHHUZ66S8symLA6jMeGfL7TJ7tTfA/J0CxC5dWwVbGV7vTbm1a3TiLK0OI03ylpuxRQMnFboFO1JA==
X-Received: by 2002:a17:902:c411:b0:1b6:92f0:b6f5 with SMTP id
 k17-20020a170902c41100b001b692f0b6f5mr8955682plk.14.1688115279805; 
 Fri, 30 Jun 2023 01:54:39 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 fu14-20020a17090ad18e00b00262d079720bsm786549pjb.29.2023.06.30.01.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:54:39 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 0/2] vdpa: refactor vdpa_feature_bits array
Date: Fri, 30 Jun 2023 16:54:34 +0800
Message-Id: <cover.1688112025.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset removes the duplicated VIRTIO_NET_F_RSS entry
in vdpa_feature_bits array and reorganizes the vdpa_feature_bits array
in ascending order based on its value to avoid future duplicates.

Changelog
=========
v2:
  - resolve conflicts with the master branch

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01583.html

Hawkins Jiawei (2):
  vdpa: delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
  vdpa: order vdpa_feature_bits array

 net/vhost-vdpa.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1


