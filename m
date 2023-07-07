Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87A74B452
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnNE-0000ZY-AF; Fri, 07 Jul 2023 11:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnNA-0000Wk-Ew
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:52 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHnN8-00076G-Go
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:27:52 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34637e55d8dso7411455ab.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688743669; x=1691335669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXWfn4pycG91taiVTdMWYdNRBgsjQ7jyxitHpzV6nlc=;
 b=TaHGgFYRgbwHmjZKlbkTktvd8uZ3PVhxqJMAqb/s0oS6vQ8uOcSkdidoEh8uw99YgD
 YA1AzPM1zICiFqrvMo6FqJn9BU5g3cSL+Y9x5LHR0qeC3viHSNX2N7GuFunrNfTYZ3/y
 QKt/L0EoT72ZcG/qmhoGlU55UDcuS+aZFC07pfQB1LN/OwHXTRhGMje6Fsmw4jJSqXPZ
 PU4Gvvhrzq4aoyARN4DTca8srlivv6Qvf/UR+lc2zCltbC1XByndkuAgow8S7/hWDOY9
 ksTkF77lo/xVBzaBIHwCyO+4inpmmCHVubFmB9I24Pu75BQpYfXOC+fE438n4+nxdeRf
 9qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743669; x=1691335669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXWfn4pycG91taiVTdMWYdNRBgsjQ7jyxitHpzV6nlc=;
 b=EmKGLWNmOvirYwHlWmXFz7U5CGUWycl4Uxqzfe1jCVIyMj2Bc0sp/+n8Dhrn0EPN0C
 p0fMt2dY2gU1eUIJ9dhpiE5xwMr/AbSRnTREFehv5B2UhaLaAFxf1wfqPiLxWWz11ELO
 YBqkaeG/gvAzKnXbAPkakEvR1gorYBhI9G8fDHzu7Mte9dDX+q1BOLzaHGJcd2F13H9o
 3l5LkKaJWnv+1MuUy25BABgbEKB17Wsv9iXi8qRogesMbIRuW49985qGmOdj0ESYwi3h
 SYKozg+f4wCR+3AUicjyjpaDFSc7GTkCyWlYhwzaqBMgABNz/g7mleDtlBepBu1hS4Jb
 0GoA==
X-Gm-Message-State: ABy/qLZ0RY+9VLkXrpfzxc/xXGU1fqd8iyuz1FjiB19s4CFnOQo56meU
 fJ4Xt9tenk4sU4JAva7Hkog=
X-Google-Smtp-Source: APBJJlG8eQe1+tyARSNhi4wmXmQZDiFW0ndzmlm8nHVgNRWlCe8nhz2/G9x8epqCSD94edMcHIitHA==
X-Received: by 2002:a92:d486:0:b0:342:8d31:73e5 with SMTP id
 p6-20020a92d486000000b003428d3173e5mr5277149ilg.19.1688743669244; 
 Fri, 07 Jul 2023 08:27:49 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 l15-20020a63700f000000b0054fa8539681sm3073275pgc.34.2023.07.07.08.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:27:48 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 4/7] vhost: Fix false positive out-of-bounds
Date: Fri,  7 Jul 2023 23:27:31 +0800
Message-Id: <ee31c5420ffc8e6a29705ddd30badb814ddbae1d.1688743107.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688743107.git.yin31149@gmail.com>
References: <cover.1688743107.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=yin31149@gmail.com; helo=mail-il1-x129.google.com
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

QEMU uses vhost_svq_translate_addr() to translate addresses
between the QEMU's virtual address and the SVQ IOVA. In order
to validate this translation, QEMU checks whether the translated
range falls within the mapped range.

Yet the problem is that, the value of `needle_last`, which is calculated
by `needle.translated_addr + iovec[i].iov_len`, should represent the
exclusive boundary of the translated range, rather than the last
inclusive addresses of the range. Consequently, QEMU fails the check
when the translated range matches the size of the mapped range.

This patch solves this problem by fixing the `needle_last` value to
the last inclusive address of the translated range.

Note that this bug cannot be triggered at the moment, because QEMU
is unable to translate such a big range due to the truncation of
the CVQ command in vhost_vdpa_net_handle_ctrl_avail().

Fixes: 34e3c94eda ("vdpa: Add custom IOTLB translations to SVQ")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 1b1d85306c..49e5aed931 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -111,7 +111,7 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
         addrs[i] = map->iova + off;
 
         needle_last = int128_add(int128_make64(needle.translated_addr),
-                                 int128_make64(iovec[i].iov_len));
+                                 int128_makes64(iovec[i].iov_len - 1));
         map_last = int128_make64(map->translated_addr + map->size);
         if (unlikely(int128_gt(needle_last, map_last))) {
             qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.25.1


