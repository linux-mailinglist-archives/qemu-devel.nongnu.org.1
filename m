Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301F87455A2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDPZ-0004rh-O9; Mon, 03 Jul 2023 02:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDPU-0004qh-FT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:51:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDPS-0005Q0-PE
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:51:44 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-666eba6f3d6so1889166b3a.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688367099; x=1690959099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e63LUN2MX3UDbXlATSNpXqyFEEGweQfaWJR0WFhGky4=;
 b=JrGjGNMdkiYhozhVlqO9X4F92NqfsggkNwAyiAw28qnhi+X3zBl6oMW7vWWWQdI3oL
 1d+nA99o2ldQUP14514INJ8XPmgCKV/f2wcICk991suSm2Xy59Of4q6NWq+PeztAw12x
 3Lm4z1KWtCa73CzHeYZbQyUf+Zqr8GLqXjIwqQJUmy0zARsE+IeBVMTDnzGCUFxXJhte
 fZ/p68uItpvFwpvCZ1fAHNw1ZSHUkF+CZMipmtBr37dkcaAoAYPprAJOscIk8/Xj10PW
 kAdL60ls4BlAOOq7H9smHkqRdaWfaKFPgNCYYkljL/nS8EDDw/XzAhskP6YUvd3wn115
 anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688367099; x=1690959099;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e63LUN2MX3UDbXlATSNpXqyFEEGweQfaWJR0WFhGky4=;
 b=g+GaJI+By3lIqchvW4rAIahr2uBTXk/VFJZWLGrVo/WBuOBe8Cp5cHVsqH/I7EGZVN
 HijCjT/d1Lno4cUF7FxlF6eqnSX5WQiXwuXwvSLLm5oS9+/Dpbts/x2HmCj+a0idYtY9
 nUbpp3d3daRfALMhFUT+CkOdG1r+qk7snlVpsYX7pLsCpTBMiMB5Tpq2SBef756bKbOb
 a3BJ08Sf4YoGxZ5Bsu0B58hwBnjU2AG609akmZIrw5QAWMidEO+F/6GlcOS2f7UL6ZMl
 RKeYhwCq4T+7CNOT/ZyCU2hB9tfbr3ZoWQUBScADfzLW8iqCoqKwaQ0pOaouWh9UgRfb
 VyEw==
X-Gm-Message-State: ABy/qLbQoUnWCGZJTs9PTUifnP6CCIoJAeKGppEP8cbJi+DewKBzmmMC
 Ibl1DXGFyPiG97z3QdCmMmg=
X-Google-Smtp-Source: APBJJlE07H9jBrr34GzB/sOh6Ry9QPJaGiCcYhY8Fi45SRhNz+Omhau7VfuBjggy9vuJaoTO0dqT3Q==
X-Received: by 2002:a05:6a00:b92:b0:680:fa5f:4ed6 with SMTP id
 g18-20020a056a000b9200b00680fa5f4ed6mr11061496pfj.27.1688367098884; 
 Sun, 02 Jul 2023 23:51:38 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 c26-20020aa78e1a000000b0063f2a5a59d1sm13505710pfr.190.2023.07.02.23.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 23:51:38 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 0/2] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX_EXTRA
 commands support
Date: Mon,  3 Jul 2023 14:50:09 +0800
Message-Id: <cover.1688365324.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX_EXTRA feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

To test this patch series, one should modify the `n->parent_obj.guest_features`
value in vhost_vdpa_net_load_rx() using gdb, as the linux virtio-net
driver does not currently support the VIRTIO_NET_F_CTRL_RX_EXTRA
feature.

Note that this patch should be based on [1], which has not
been merged yet. I will submit the new viersion patch after it is merged.

[1]. https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06559.html

Changelog
=========
v2:
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04956.html

Hawkins Jiawei (2):
  vdpa: Restore packet receive filtering state relative with
    _F_CTRL_RX_EXTRA feature
  vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ

 net/vhost-vdpa.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

-- 
2.25.1


