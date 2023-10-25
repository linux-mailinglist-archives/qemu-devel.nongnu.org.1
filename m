Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBB27D5F57
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSO1-0000WH-O1; Tue, 24 Oct 2023 21:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNt-0000VR-Et
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:33 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNr-0008JM-Q3
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:33 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d087c4276so3548420a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698196110; x=1698800910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBAfQJoNOLA2k1XG7ov4Fhdok3Ts6/T1ZYrkGPufFZc=;
 b=Geux26xtUMlTv0nIZIPWJrL9HEJIb14H8KI2Of5HKzXXverqSpdoeh0PmaEGYYDS+B
 uUiv56EBK0nADwuovCa13bBnj7yHsPSnsIpULwjtpdixua2kEsvU9kCK5XUnueHLX2p7
 eFbQkIacXyYZhDKxK2AalyULaoX9sukvkNZuYA+mFL9i7uOTkvi7yYhUNMux/K36n8ZU
 EC0cnUzeDS01e86/OAJQcgV9gK3wfpQpt8OUOky3YLpWYayHIQpNB42M31lafrZg4LLL
 e7rCKPc9F9R0Ic+xnzM5y67vDK4wfx05Mk22j+H3+AjraYYs0qM+CQLOW45fRxh7XHoJ
 EMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196110; x=1698800910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBAfQJoNOLA2k1XG7ov4Fhdok3Ts6/T1ZYrkGPufFZc=;
 b=RBxDcZp81c9bfctckJISZXwyzQis5Pk98VxW0CCbf2jmywciD5kLZs1IOGCs22Q4jW
 vQfs5p02UGNKGdyCX4VPtV9OYXPXNS1UZGInPHiVh5GJM1ZDn1I3jyRm8pt9TEw0IRIX
 f/hJaBwQ7UvSPu7JryYdUJ2w2UqshDDAROeZcb3yJTDBMuhyjafyFaMRknqBgANxRK6s
 G1i1Kzsfphft+aGHqAPG04ryojVc+nTsQwvrPDdX9M6+LXXLPyP2vcmj7XDhRXR5GgWi
 pqtFSL4+hFO1QyeYktAUvaOz7vIQ1F883ebL6wvHCwd30ns+M/CKv4MTKPrnZ/MbCgR8
 YS6g==
X-Gm-Message-State: AOJu0YxGbdu60JP2pfETBPfI/maJ2NVXtv13bvPI2J6BZn91gMUPqq9J
 rPn/OO5OTudfYFvNSPfYcfw=
X-Google-Smtp-Source: AGHT+IE6eFvdN4xBWhQIrqYUozO+T75UF6cJtg7IYXDUiQT9rrp2fz8kHF5idhwb3O5RN9Lkiq6XUw==
X-Received: by 2002:a17:90b:2b46:b0:27d:882f:e6c5 with SMTP id
 rr6-20020a17090b2b4600b0027d882fe6c5mr11647889pjb.9.1698196110185; 
 Tue, 24 Oct 2023 18:08:30 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 gj6-20020a17090b108600b0027ce34334f5sm7509481pjb.37.2023.10.24.18.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:08:29 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Date: Wed, 25 Oct 2023 09:08:06 +0800
Message-Id: <626449eb303207de408126b3dc7c155cd72b028b.1698195059.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698195059.git.yin31149@gmail.com>
References: <cover.1698195059.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102a.google.com
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

Enable SVQ with VIRTIO_NET_F_RSS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v5:
  - no changes

v4: https://lore.kernel.org/all/4ee7f3f339469f41626ca2c3ac7b1c574ebce901.1697904740.git.yin31149@gmail.com/
  - no code changes

v3: https://lore.kernel.org/all/2d2a378291bfac4144a0c0c473cf80415bb580b3.1693299194.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a4cc1381fc..d0614d7954 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -122,6 +122,7 @@ static const uint64_t vdpa_svq_device_features =
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
     BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
+    BIT_ULL(VIRTIO_NET_F_RSS) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


