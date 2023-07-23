Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61D75E1B7
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXuT-0006kN-Cb; Sun, 23 Jul 2023 08:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuR-0006k9-C8
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuO-0008Ap-Sv
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-666e6541c98so3294369b3a.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 05:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114195; x=1690718995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqDYe0wtYfLpN2tqp42QO/VtGC9R8rwe6ys1M/nbgpg=;
 b=bp43bR8Odq8vREets1p2StaYvEkHSQbUrCTHlaTBzMak3SwvBp2BXOMigyeEqbvQ6t
 p9ej0OfkBrAj7Ckfqp7uWDG4UjY8gJAHOTZP+wLtU/75OKdkAHRZDzp8EqPpgejMY8F/
 A3Km/RA21ByDKxeAcNKzwmZdEB2951mBtN1rpg6Fvx1BIPpjZln5yFWFXvJLSifzS0uM
 4BLKVeGQV6DQSdLCnXe6WN1ybPFr5MAFFHtMX/JSp+lxxknsW3AKmv8vKF8PITLVIZtQ
 uhu9AFmP4PLl+Tck2Wys12OKZ8+xhqRK96l0N+Pml43KVJ/Wm7IXpqxEeKVdBenk2oQW
 miTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114195; x=1690718995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqDYe0wtYfLpN2tqp42QO/VtGC9R8rwe6ys1M/nbgpg=;
 b=buTOJrmkoSIxge0E0ORpnBLyRkGit1GaPL8331amQXcf6kvD3CwyIrH7FIfBqhfgYk
 x0O5Tgmkz/4V67/sFjZyx1gh91LjhW1B0BYWbuUHt/ihV0Ol5Hw5rtzkMYNG33TYPAXE
 L4d6vePG5Q/gFfihd6bJQIQrUIEeR5Tg3BNXgpBjozbvILnQbSoMSqEN9qOCbpdgzMdK
 m47BYH+mh4RUyTFCHfeJNuuBGe00vJUdf33TuvMKgiarriDuPMOZ1UiFfS+X9LauPfJE
 AKXE2L9gjbl8tYCWUUBvpM2qzeY5AhfxSZwep7lJ8LWmuiTkDC0ocYst1qtiQuwCDxHP
 txkQ==
X-Gm-Message-State: ABy/qLZJJCa2058vSv9iUU519uxEq9lrUbjRmsIGeYGI/qtcKssrtrqF
 aiLKToV5/vLfr4O6F40BBis=
X-Google-Smtp-Source: APBJJlGMkDaoxr5DiAqqGU75+rhJKOoF9cOfjrUMm3oDLm7qA5yr44exIQ+xp+hAiAX1znHCAwQQYg==
X-Received: by 2002:a05:6a00:2407:b0:668:9fb6:b311 with SMTP id
 z7-20020a056a00240700b006689fb6b311mr6835282pfh.32.1690114195349; 
 Sun, 23 Jul 2023 05:09:55 -0700 (PDT)
Received: from localhost ([223.104.38.215]) by smtp.gmail.com with ESMTPSA id
 k11-20020aa792cb000000b00682868714fdsm6083558pfa.95.2023.07.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 05:09:55 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 4/4] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
Date: Sun, 23 Jul 2023 20:09:14 +0800
Message-Id: <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690106284.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690106284.git.yin31149@gmail.com>
References: <cover.1690106284.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42c.google.com
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

Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 347241796d..73e9063fa0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -111,6 +111,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
-- 
2.25.1


