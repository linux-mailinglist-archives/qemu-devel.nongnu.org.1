Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE685711A1E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJv-00027t-EM; Thu, 25 May 2023 18:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Kt9vZAgKCtEGx8H9yxH3BB381.zB9D19H-01I18ABA3AH.BE3@flex--talumbau.bounces.google.com>)
 id 1q2JJt-00026C-CQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:29 -0400
Received: from mail-io1-xd4a.google.com ([2607:f8b0:4864:20::d4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Kt9vZAgKCtEGx8H9yxH3BB381.zB9D19H-01I18ABA3AH.BE3@flex--talumbau.bounces.google.com>)
 id 1q2JJr-0004Sm-Ss
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:29 -0400
Received: by mail-io1-xd4a.google.com with SMTP id
 ca18e2360f4ac-76c63aadc10so22417739f.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053226; x=1687645226;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=dXTJKsxDTe67YZh46ME8kW+SA4qfuw4NaZ0bmQilNWE=;
 b=UOu2xcjFJYAQuNiI7eLotxMiEeM3EaSyQY01FvDz1ndyblg897FZXJNyFvPS/5/F+O
 5Djubuq+huZGzB7g+6pVqUTd1RgUmfs3sexIHtS5HYSZDvhr+HedFKzXsV1fjtbW1P9Z
 Z1Bw5nHw3pNuZ6QCBjpfd+dLgE3hZYx5F12UVhONpIeN5Qn9PNUuq0wsScyvhIZdQb0a
 FotNn3cvSfRu6RsIPXHMS/NgislhRtbldTyBX6+cnHiYWJ7YjkpVM4FAF72aPmifPX3+
 A28ocO3erReX32C6XmCfnKXxURIYjNSHC69dOQ1/2oFT9lxDttP+nTfGDPYWUeD1FY2S
 jOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053226; x=1687645226;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXTJKsxDTe67YZh46ME8kW+SA4qfuw4NaZ0bmQilNWE=;
 b=LYDAR4SRK6d0wyFcJq2BatSXeBIRaaAaPryye7584jy1Jiki3zbPyP/eIEGiJUYmTI
 68ZoriwkTavN3SryF2gRnPERym5ODA/EN4XVQrt2hKUp1UD4Xp3OH+w1OwHd6l9OgS20
 yP5/RmyI0tUJfjO6YdCDfsUlkhA6N/0FFxSLjIZ5B+ermUNwhtYLRull2E/Gyqc1Itp9
 WmbpBpbJdm6ZxBnHbzOZLUaWiEhFNxibKZcd1QVS+Z1FRODKO6Dd2TVkZ3TqxEZXyLbR
 ftzZSwgLpGEtUxyL5inuTdYMV3lUb8zeKreryJqwU6Bsm+kkMXFAlcw5szECJDCEl4Gp
 vrqw==
X-Gm-Message-State: AC+VfDyINCt36j9AhMbpFy9KWNOJdz/MMhtvPqpGc7HAZ7e+bSr9/IOL
 RFj1/43euq2HzJCNwHhqnLOvGxiti/3FoYxI6EJtiDyhv2gqpOikI/PoUiko9hfJOWKuNHW+dxJ
 MJeLsrgMaTJ8ldmYbG6klOucw13huaIic0II3NMOGTnnDxBGA5WeHLb+WzZC+shH/fQ==
X-Google-Smtp-Source: ACHHUZ4E1/FJae49eWgTywoEBwfGC/2mWQAU+7bv29m97Dhc3Q88IAbO6poIfSPDN5nYV5V7sVkmOvDNhGqXyg==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a6b:8d57:0:b0:774:89bd:c6cc with SMTP id
 p84-20020a6b8d57000000b0077489bdc6ccmr879670iod.2.1685053226152; Thu, 25 May
 2023 15:20:26 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:16 +0000
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
Message-ID: <20230525222016.35333-6-talumbau@google.com>
Subject: [RFC PATCH v2 5/5] virtio-balloon: Migration of working set config
From: "T.J. Alumbaugh" <talumbau@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, 
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eric Blake <eblake@redhat.com>, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d4a;
 envelope-from=3Kt9vZAgKCtEGx8H9yxH3BB381.zB9D19H-01I18ABA3AH.BE3@flex--talumbau.bounces.google.com;
 helo=mail-io1-xd4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Migrate working_set_num_bins through VMStateDescription.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 hw/virtio/virtio-balloon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a124d95534..6e1646abfd 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -1022,6 +1022,17 @@ static const VMStateDescription vmstate_virtio_balloon_page_poison = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_balloon_working_set_reporting = {
+    .name = "virtio-balloon-device/working-set-report",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_working_set_reporting_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(working_set_num_bins, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device = {
     .name = "virtio-balloon-device",
     .version_id = 1,
@@ -1035,6 +1046,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
     .subsections = (const VMStateDescription * []) {
         &vmstate_virtio_balloon_free_page_hint,
         &vmstate_virtio_balloon_page_poison,
+        &vmstate_virtio_balloon_working_set_reporting,
         NULL
     }
 };
-- 
2.41.0.rc0.172.g3f132b7071-goog


