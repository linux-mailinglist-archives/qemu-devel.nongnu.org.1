Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 273397F57EA
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 06:59:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r62iM-0003gS-MW; Thu, 23 Nov 2023 00:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62iA-0003eh-Jf
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:15 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1r62i6-0005QN-9C
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 00:57:14 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2802e5ae23bso477422a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 21:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700718905; x=1701323705;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=owiN7RCrq+8qS6GsElPTpL9dz3ve9GFF7qZWoXMpTUU=;
 b=JE5pAE1kz/oQwRHdfcc+ayMksyF0t/aXG7g1qOVmSpn0QCebLULs7heWhYm1fHzyf+
 p6VrVyZXN6RSzFjDjgQvHX50QnCWeh96AlkYKED/0Wt6w/9ZqVRlccVARaCN0zA658fC
 Rt4igIUZfRWEqqw96Zt6icKP8/SV5qvp5I2hQ6JkxWLqZUMxDYfOxSR/IF418OoVmypE
 tquZxjF9xacxNg5kC7/wEQ01yUwZz0IkGNJuN3JMWRgVjeE4E6uVcfS4da1TElPQgkYj
 cnIWBEFLt2Y0/HLs25u9mC+LS/+1//e7SjZX/0dNrWfPzOlPK73Bh+GVMSRjmKd1YkFc
 L7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700718905; x=1701323705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owiN7RCrq+8qS6GsElPTpL9dz3ve9GFF7qZWoXMpTUU=;
 b=wL0Rs+ALlpLovq0Wqr/sSE0qtH6butt13imzos+TRxbRCGA2YNI71pim0IUb7Iqxlb
 NnIqjYmZPdyY2J4fPjQF2qtA5dbUwzSp5z5lI10NXtKvdhCYImD2EjaNM9YBs2cVPbXx
 w1rTZ9Qt0JJ975cJ57VE2OnX+vs2BDwMxual8XBUCP1p6xa0PcpPObTQbMbj3JvrgeWt
 +pWUdUvcZ6zXJ8nSjl0pBvdbkEwFipctLpiiCknBYVub43y/qny7Wr2UVV1kK4zs87fQ
 qwA3S2fBmJd39ZeUztsKzzoJtqjyECWFvlfaXmlZJhONXgsmsT92P6fOc6GijCSs6h4G
 i42g==
X-Gm-Message-State: AOJu0YxQsWkj2TGmbufi9+BHUvS5peXMwCA+MFoBpY6PAwjrox2WtQgM
 FdLp75Jn9+3AUSKclzgvizXMIg==
X-Google-Smtp-Source: AGHT+IERaizVAjL6qJOd08qLi9MuwZ4LaX0ysGIyecSM1wt4MLEmcDZeH7hic73YmqJq6OpH3BlWoQ==
X-Received: by 2002:a17:90b:3eca:b0:27d:241a:dd89 with SMTP id
 rm10-20020a17090b3eca00b0027d241add89mr4569988pjb.40.1700718904446; 
 Wed, 22 Nov 2023 21:55:04 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jl14-20020a170903134e00b001cf6453b237sm417071plb.236.2023.11.22.21.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 21:55:04 -0800 (PST)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH 0/2] fix some vhost-user issues
Date: Thu, 23 Nov 2023 13:54:10 +0800
Message-ID: <20231123055431.217792-1-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


Li Feng (2):
  vhost-user: fix the reconnect error
  vhost-user-scsi: free the inflight area when reset

 hw/block/vhost-user-blk.c   |  8 +++-----
 hw/scsi/vhost-user-scsi.c   | 19 ++++++++++++++++++-
 hw/virtio/vhost-user-gpio.c |  3 ++-
 hw/virtio/virtio.c          |  2 +-
 4 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.42.0


