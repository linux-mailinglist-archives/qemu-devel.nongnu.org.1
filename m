Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECEF743CB6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:26:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE5N-0008JT-I4; Fri, 30 Jun 2023 09:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5C-00089j-I0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:42 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5A-0003XL-2t
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:42 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39eab4bbe8aso1297950b6e.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688131358; x=1690723358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+RD98o86NLZWo0o24Z6o8Je3693BJrn4fe0fvjv5oTw=;
 b=ezW4Fnbn7Uf3wFL9dKQxri0s1iDDeo8ZnoumXARkYNCDuSoGiZxQPcr67W5HQ69bCg
 gn+PxwH5RXFifY0ZKQkSrOaixb06tv9VmgzzZok73/00o9mWH3wE1S1lc6PT7n91TJ9e
 t/LAFXVbU9xiqV/4bM2cbHzWqWCfTcHt93NtFvRF0vj2IRvuMLuzCV3Q+Uc+uTs7sb6K
 q6VVokqjWzMjcSgpzlZOYgrNV2Y8w+ecno65zSrH9fSnvEuYikwzxLCHVVyG5UNVbwMg
 FlnwNmbgpXnMOgAl/F6yKEPbDSbRL9aCUIPYHyFAB3YHAew7k2CM/mEWxJdGSH6URtRd
 DD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131358; x=1690723358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RD98o86NLZWo0o24Z6o8Je3693BJrn4fe0fvjv5oTw=;
 b=NVWapzySSWEPvsgpkKE6m9Ha1ZjwIxcwtXUQhGumSMuQ9fxKpjYfK96YuFFksGalc/
 FEGf8pQv+PS/Do9BDRgfljVdxhx2JuDjiU47eDY+/XJPaIstNwA9mPhA/tcunfUHSRHY
 fmdIc2L6mzfPl+xn5hqIoWMNJI8qWeJpPGimmsmrXfjny0xLcn168jbb9Md67gkiBVLH
 y6aLo+q9dXeTz/ubLFJkvsF3WH38kgby1IzYtW/wAybvlqpU91KSSx/vz90SMH6Og6bV
 FWUSZINeRYKTuU0pM86U0vYvY6ECh5UbT3L2vBkA0/QkedP/YoD7hBoBxXIZUx3Sg39L
 kotw==
X-Gm-Message-State: AC+VfDzfCpt05qbBIaigqqHWbG0woX4oPrF+jyQjXz5ZjuR/EODm56U5
 VBa8AdrvvC6Azy04aP2Uymo=
X-Google-Smtp-Source: ACHHUZ70iROn5QZZ88W3/O6xgqZvgcgiCGf8kbW0tSBTxYQMmGP+5vYCG/txqfSlIoN9Hnc1e4Njng==
X-Received: by 2002:a05:6808:1917:b0:3a0:6949:c884 with SMTP id
 bf23-20020a056808191700b003a06949c884mr3516721oib.34.1688131357826; 
 Fri, 30 Jun 2023 06:22:37 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 j11-20020a63ec0b000000b00502f4c62fd3sm10547755pgh.33.2023.06.30.06.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:37 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, philmd@linaro.org
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/2] vdpa: Refactor vdpa_feature_bits array
Date: Fri, 30 Jun 2023 21:21:46 +0800
Message-Id: <cover.1688130570.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=yin31149@gmail.com; helo=mail-oi1-x236.google.com
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
in vdpa_feature_bits array and sorts the vdpa_feature_bits array
alphabetically in ascending order to avoid future duplicates.

Changelog
=========
v3:
  - sort array alphabetically suggested by Philippe

v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06764.html
  - resolve conflicts with the master branch

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01583.html

Hawkins Jiawei (2):
  vdpa: Delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
  vdpa: Sort vdpa_feature_bits array alphabetically

 net/vhost-vdpa.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

-- 
2.25.1


