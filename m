Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AA742997
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtXb-0002go-TV; Thu, 29 Jun 2023 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtX2-0001mU-Rl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:26:08 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWy-0007SL-6k
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:26:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b7f68f1c9eso6514035ad.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688052356; x=1690644356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAagmwjvDf3XIktW/IyV1BnI4YKWPfBWXYBtjDR8Bhk=;
 b=LtSuNK0pO3V7jfhpE9VGa4POgeY/ma0P5bZz0+Rbp+jW5hVb9JYB0Cek7bnGw8Ta00
 axW+FDc9BvxI+56tVSOcd20pbFOXEfL+RzHxmvIQ0R1sPyQU5oyzviQ5BQq+2yo5qVVA
 JOXHcZC5yFwV4ac3+2B7KWUuVOLm835Elu9gcVq50V6OkXMIjYR45kdPDkTfkOGIOmPk
 YuaE77qWY3xwhGrX5HlbDFUJgdUvy0yGoCFXnBwuhNZGH1hWaAF7H0ZlLOY6MdduXqz2
 m/xQqmO1nnn5VPptheoAD+N1pqHqRrLAaRZm+cVCMyI/0tF/C5clS45eY/7gnS/QTi7c
 6w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052356; x=1690644356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAagmwjvDf3XIktW/IyV1BnI4YKWPfBWXYBtjDR8Bhk=;
 b=Jc7qhzqjrv/Reo9yUKk9TlmjsvuRaOan4inVaFjq/V7vv7VohjViL92B2S8fOFqyXd
 x7pIviQOlhw9KzrPezoozzsD8wRAvobkhZnqhK9qZNHOMROtlz6szvJH6J5m0VHPPAHt
 OWkGVzXKHzloLZDMCpAaWbTsnm8mqaIJrQq/LarVSzVojs38PPWjInJ4CpvfnvGtMahk
 S9Zy/SiFMgI9hOK5hlG7CoR7IS3EW2d8nA1KCyqjcmB+hBwm/RiQxyTU1Je6tATwPanK
 DuBdpolVIo1GBC00h3Mjn0LdpZp/W4Iv0oTnazwdPEK8chrORGSMLb0DSrg2m925o0UV
 0ZoQ==
X-Gm-Message-State: AC+VfDxzNzavJ6gM+wODgoF/ZllVpKjOhym4wURw1D/BTvgDZFvej5H6
 ZqReBKemCuqd+bCaxZ4Le+E=
X-Google-Smtp-Source: ACHHUZ6GvJljDZ7aQXkNsNO2Okbr86EC0OzfZWwTzJJUNtWDOJFTEVIpheBeq6SLWFo8XvHCs9CMtw==
X-Received: by 2002:a17:903:1105:b0:1b6:cafa:4d6a with SMTP id
 n5-20020a170903110500b001b6cafa4d6amr20020216plh.14.1688052356084; 
 Thu, 29 Jun 2023 08:25:56 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 j24-20020a170902759800b001ac591b0500sm9202467pll.134.2023.06.29.08.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:25:55 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 4/4] vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
Date: Thu, 29 Jun 2023 23:25:35 +0800
Message-Id: <bdfde850e6d26bb92e832dafd1e9a56934f57e9a.1688051252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688051252.git.yin31149@gmail.com>
References: <cover.1688051252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x630.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_RX feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 9d5d88756c..0410a52043 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -104,6 +104,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
-- 
2.25.1


