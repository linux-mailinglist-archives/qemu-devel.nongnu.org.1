Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3C76DE6A
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 04:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qROJL-0004Jc-6i; Wed, 02 Aug 2023 22:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJD-0004IJ-CQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJB-0007df-2B
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso400103b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691030601; x=1691635401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFS656qehoguGU0F5qCeRDwoRCBJULcMiUGsu71GKMc=;
 b=RfYfO8ywXgKR9kDMNZo3jLjQD6mK4tm5gZXWJ1KeXxS+YmScrWrMZZyi1qcB8fxU/P
 NyRC09968RwSXTjJgAK2eG46qE0Fcr2j58G33Iu7izIM9l0mdZouEkec+R1jXkpMZLXO
 ZS+ymNhwjTqFAVdj/sfqD8oksL0MGFhKgIkxQrr8Bzxa3F4R8AT/v4dZR+06WwGyxny1
 EC2B75Gg4nGF7K94Fghj7XmysuhjqcrMSw96/H63UuW8WdiSPaUUFt1bbOTPDLY6WOlw
 Qhl6rrBZ2MMflxdvvKHHRhhbDeIZzSBh7RddL7GhgKAOZD4IpuAPjHxsefnXbTl6RFcL
 f1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691030601; x=1691635401;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFS656qehoguGU0F5qCeRDwoRCBJULcMiUGsu71GKMc=;
 b=SbW43FV8wLSmlnS06p8+pJ39OLLR7nLskVqeEdrp9reWsD5L2beCDM4Q7bpnZAai6k
 sm7WII5Y4XL9OGO2mfwX7ORvCB/nZSKLd5BfCpOH97KGyxSOEYALXqj39WkSSH8H0efJ
 8Iy4a2S67HTXyLf2zMT0H+k9Tb4CTWl5JQSjI1vDjRbNfh5Jf4aiQQMIWEToAVfk3Al+
 tgEbAAHcsA9N1MuSSkh77SCVVGaaXpHB7f74NVVwienyelIZcGxqo8ulz+p6/TaUVn9N
 TuBqwcHVVJH3n3QnsFkkwfWZxffWlhp6g35RhqBCj1EExfMinOrSzi3aqqk8WvW6o0Fu
 /sFQ==
X-Gm-Message-State: ABy/qLYjkMSTTq95/C38TMa4qnAxZDO6FJLleLqxcO0XxRfh0ejeCixH
 C8dFEjNjwd5BhYWeNEW80t2ugw==
X-Google-Smtp-Source: APBJJlGULvUJLid/2cQakhXQW6rXeS44FDSmbzaRClHsJyAPYFm2R7c8JQXubdt32YKVDHMKVnGBYg==
X-Received: by 2002:a05:6a00:194f:b0:680:2b80:8479 with SMTP id
 s15-20020a056a00194f00b006802b808479mr23407770pfk.19.1691030601329; 
 Wed, 02 Aug 2023 19:43:21 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa78016000000b006862b2a6b0dsm12090578pfi.15.2023.08.02.19.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 19:43:20 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, taoym@zju.edu.cn, kangel@zju.edu.cn,
 nop.leixiao@gmail.com, mcascell@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 0/2] CEV fixes for virtio-crypto
Date: Thu,  3 Aug 2023 10:43:12 +0800
Message-Id: <20230803024314.29962-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Michael, Lei,

Yiming Tao, Yongkang Jia, Xiao Lei(from Zhejiang University) reported
issuses and CVEs in the past days.

This series fixes a CVE and a BUG for virtio-crypto/cryptodev.

Zhenwei Pi (2):
  virtio-crypto: verify src&dst buffer length for sym request
  cryptodev: Handle unexpected request to avoid crash

 backends/cryptodev.c      | 10 ++++++++++
 hw/virtio/virtio-crypto.c |  5 +++++
 2 files changed, 15 insertions(+)

-- 
2.34.1


