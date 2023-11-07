Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C64947E3888
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J36-0003Dp-7U; Tue, 07 Nov 2023 05:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2g-00020G-0y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2e-0002T9-4B
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2OemcVYSlI5Erb95YCn87opEKILgO1gPwKsg30RdW0=;
 b=IL8wQoZYIMcDyPaCBBW5sUpQx4hEUac7dukCnTj7HQrbqS78t1iNeMZuvPRmdKxVMpszgi
 qH+Uli+uJ1sBcs7t7rUFg4eo2Gc8db1SKVKgzz4CiTCZz7SSobKHt7X0MykTqk/aAXZHjh
 Liqlm6EmWQkaNN5ETnqP0xNjCC8+tlU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Yrt-evhrOEWRlXaNUYsB1g-1; Tue, 07 Nov 2023 05:10:37 -0500
X-MC-Unique: Yrt-evhrOEWRlXaNUYsB1g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5091368e043so6170687e87.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351835; x=1699956635;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2OemcVYSlI5Erb95YCn87opEKILgO1gPwKsg30RdW0=;
 b=JbprlFiR+4loIJIgaZp5EsXmjKFj4Wd6hNJvQ3Po4wozEKCgsyW4AgSXQXwOJfF3/C
 YavVjVplX0nIO36tBvBb7ZRGX6IY5oT47gXWkqXzDlnQeuPgM+vu5mn4vC6w7r4zl4Nh
 Gqc/Be2xzYyJLZ7H1Tu9FyCO3OQXhTrjws8OgO/Nbx54y/WAwTc9+t0js8mjjxydjStl
 mQDnLAuxsiwmlrOOWyt3Gv0WV25BYCNaqMhDoDKWvLr2OpVtAEZq5SdkwnUK7om/m3kQ
 TKeUicLssGx94xqxHSol77dP6nL4hX8DJ1b1UsiLcN9mk3i2RxQjvOZOT1EEA73rWTJq
 inzg==
X-Gm-Message-State: AOJu0Yx1ogFexSU99rEhXtREi1lbQiaXUYnQKsRHBvYmYehhvxeIAOpj
 jUadbjFs2rE2+vbS1e0ikFGxiYBEA0sbhmZlzttCsCilmJnwYDn1XXguVdkgWP3vdsVjMkMk1NO
 /l/XuCTavntuMSizuMYu5k0S4yLeXg5rA9U5233Gm9gh/aly2YLa1pwLIZHlreRqD7Qqy
X-Received: by 2002:a19:ca49:0:b0:507:c9d5:39a9 with SMTP id
 h9-20020a19ca49000000b00507c9d539a9mr22125487lfj.52.1699351835016; 
 Tue, 07 Nov 2023 02:10:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4jLFGfoCiHifo0fv/LeBNTNe3GY+UGilDrY57nOBnP9mwntU/3M5nErHlX6Z9QcK2AwdwnQ==
X-Received: by 2002:a19:ca49:0:b0:507:c9d5:39a9 with SMTP id
 h9-20020a19ca49000000b00507c9d539a9mr22125464lfj.52.1699351834571; 
 Tue, 07 Nov 2023 02:10:34 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 b3-20020a5d5503000000b003233b554e6esm1902622wrv.85.2023.11.07.02.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:34 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 14/63] virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
Message-ID: <e5788b8fbf9361c978eb8347471d8f855580777f.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Handles the PCM prepare control request. It initializes a PCM stream
when the guests asks for it.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <c6a9c437ef48e45f083fc957dcf7fe18a028e657.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 084890e52b..31a1942754 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -478,6 +478,28 @@ static const char *print_code(uint32_t code)
     #undef CASE
 };
 
+/*
+ * Handles VIRTIO_SND_R_PCM_PREPARE.
+ *
+ * @s: VirtIOSound device
+ * @cmd: The request command queue element from VirtIOSound cmdq field
+ */
+static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
+                                          virtio_snd_ctrl_command *cmd)
+{
+    uint32_t stream_id;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               sizeof(virtio_snd_hdr),
+                               &stream_id,
+                               sizeof(stream_id));
+
+    stream_id = le32_to_cpu(stream_id);
+    cmd->resp.code = msg_sz == sizeof(stream_id)
+                   ? virtio_snd_pcm_prepare(s, stream_id)
+                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+}
+
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
@@ -569,6 +591,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
         virtio_snd_handle_pcm_set_params(s, cmd);
         break;
     case VIRTIO_SND_R_PCM_PREPARE:
+        virtio_snd_handle_pcm_prepare(s, cmd);
+        break;
     case VIRTIO_SND_R_PCM_RELEASE:
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
         break;
-- 
MST


