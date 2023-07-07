Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8974B451
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:29:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNK-0000dj-HR; Fri, 07 Jul 2023 11:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNI-0000cZ-Tx
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:28:00 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNH-000787-H9
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:28:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-55b66ce047cso1179580a12.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743677; x=1691335677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rPLZi7gwDLQhd43vHXsmJLHjH8nb7EfPFKqI+x4wLCc=;
 b=UxEjEmCyhmcJG/AKqIcj6Z9HY9/ZumhB+cXj2ovRry13goOjT21pplfNLZl2GplVD8
 B9rn99bW1GtXTKTj4q4sxlos3blJL5c6nli3G3GjE/giQYYTobtZqTlqZOD3/Ny7unyI
 /DcsbO1rna8pfK+R3z0uRJcxwR84mvBf66qusrSRUYlybp65VtGtq6sEAExLmpd5Qawf
 4C8rEAbGTOcMymy3ZvmCNtA1mPV4QfjoJeWZ7ndgszsd6zoMnkTCMIKuTMvMthgoQAO4
 Yb9RzlhbZVI26r1GoMg+TsUAXTF2nbw8ddvxazrkbP6hdXskeoZE5DJg3PS5budFiNrJ
 Y+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743677; x=1691335677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rPLZi7gwDLQhd43vHXsmJLHjH8nb7EfPFKqI+x4wLCc=;
 b=fGrFznxrj+qV8HjY/nqXbhujRt6viNMIFTH1EzwH4YEyWdh3H5bXN5YA07k6zv9clM
 f8w+V/gJB6w/FhjHetVCotQs6jwfHV5Vg8tDxjPRCaUbSFBJhrkzHowsI67MBPqPR7tF
 TC6o7IhoS22FEz5MDUgcqmRhXXU0fbPOAGcuL18jWhgUpeLNbGq1OEPxqrrHRpKeuewP
 bHfd2QPTA+wJYDDTDFKQskAnjxwKswX8/GJ44T6OV6HEQed8roKQFe5ZWm/Lik7reQAJ
 fvucbbxM3xIvwbo5T03o2+Yh1wubjtc7VkN8TLVwgv/cbn7OiEe0ya3kEvhnQY7gLXIz
 vfrA==
X-Gm-Message-State: ABy/qLYrisBX0E/5CvfEGZnbRsU/0kQ7gfxcjk9mgW+9zw6kFEMtCjrW
 ChFSRB5fpA5/XVvmasSYkEQ=
X-Google-Smtp-Source: APBJJlGhuhs0dkdRQmuEJ/ZG0yfcw1NovYKWC/rC6vH6IRsxe3guw6Fp9kqF0JSMDQ4FqCCzHfCWdQ==
X-Received: by 2002:a17:902:724a:b0:1b8:903e:bcf3 with SMTP id
 c10-20020a170902724a00b001b8903ebcf3mr4117189pll.24.1688743677337; 
 Fri, 07 Jul 2023 08:27:57 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 l11-20020a170902d34b00b001b89bd40294sm3400256plk.226.2023.07.07.08.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:57 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 7/7] vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ
Date: Fri,  7 Jul 2023 23:27:34 +0800
Message-Id: <5d6173a6d7c4c514c98362b404c019f52d73b06c.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x52a.google.com
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
index a4ff6c52b7..0994836f8c 100644
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


