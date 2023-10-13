Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C57C803B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFn-0000H8-2f; Fri, 13 Oct 2023 04:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFb-00007B-Fu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFZ-0001rE-A1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:27 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-690f7d73a3aso1657916b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184623; x=1697789423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tI+lfuziwEyYFXJ3qwkvyQxuBIsy3m5tpBIVpjJo/cg=;
 b=ZKi8gfiFhbwZExOCDsN8srxrcoT4J4VrUXkVzF5smkjNGR8Vzkwt+Bflx3Irsyh+wY
 RiiPRS4WhDRZeKqP/LvjZdWqA41Yn9kTCSKy3J7+BVG2eOjszocse/4k0IAsDXEBpaDk
 dICuqsnmx4SD9c3MiwkRoCGO7dRycebcZnzVlMB09qxbsoDqiNrAWLqrKnxbbTznNY/2
 hr1Yi5jH3igLF3eEnaD2BP9dlkf4tLbK71eJ3UrXtYgLvhTqb/tNL41At9nMjby0s+rE
 lNbgvTNxw30nldXdbhv3got4yEgg+hS2GOaAlIvWJtg6q4t/L1j8L1wDBik+XwYbmAMu
 2/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184623; x=1697789423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tI+lfuziwEyYFXJ3qwkvyQxuBIsy3m5tpBIVpjJo/cg=;
 b=hY6EcltXJ8bpudqlwi+O6BciYq7pBfKLMrJfZx8EJldfGapEAT1q+UkBE/gIWFFSpo
 JXEAlD2rZPmwpeB9WrfgRjKCbZtUaHwerfQiqp4m5y4oEl5eNzppGyPh72Gepni+wtP4
 FdWMEdvV9HHpS4Xf2sAN56saDS/xDlJBeR7xhGinXHfdr3uegh4c6tMaRjpgxn+LTKuI
 CyAviJz2WoNGG2NESPZLzXBZhSVxVauPd/s9l3NEYDseW+1HwTkPNYGwltQF72ftqsuH
 7Xj/kAZNVRsNXfW9VqqHvczgNa6NcNaMJQAYjBRb/tSadh6pPu7N+qH6IkAeY59NBWlj
 ASYA==
X-Gm-Message-State: AOJu0YxNk14RRFZUK3TK5GeKDWnzcEKuiedLF78OdrJAvRxouTKiO31H
 dRsnrnnyn18O6aRB1i9TDs8=
X-Google-Smtp-Source: AGHT+IG0nBr72JaEbCJmWX+Yorqog/m5Nc6Fh6Mv3+ggkSQ0pxrB0y3GFSSrG/TsyDxOsOC9TxGjxw==
X-Received: by 2002:a05:6a00:1912:b0:690:d2b0:1b37 with SMTP id
 y18-20020a056a00191200b00690d2b01b37mr33179132pfi.10.1697184622786; 
 Fri, 13 Oct 2023 01:10:22 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 k64-20020a632443000000b0057c44503835sm640219pgk.65.2023.10.13.01.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:10:22 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 6/7] vhost: Expose vhost_svq_available_slots()
Date: Fri, 13 Oct 2023 16:09:41 +0800
Message-Id: <25938079f0bd8185fd664c64e205e629f7a966be.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Next patches in this series will delay the polling
and checking of buffers until either the SVQ is
full or control commands shadow buffers are full,
no longer perform an immediate poll and check of
the device's used buffers for each CVQ state load command.

To achieve this, this patch exposes
vhost_svq_available_slots(), allowing QEMU to know
whether the SVQ is full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v5:
  - inline the vhost_svq_available_slots() in the caller and remove the
helper function from this patch suggested by Eugenio

v4: https://lore.kernel.org/all/13b3a36cc33c443a47525957ea38e80594d90595.1693287885.git.yin31149@gmail.com/

 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 hw/virtio/vhost-shadow-virtqueue.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e731b1d2ea..fc5f408f77 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  *
  * @svq: The svq
  */
-static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
     return svq->num_free;
 }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 5bce67837b..19c842a15b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
 
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
-- 
2.25.1


