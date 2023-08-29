Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0726278C102
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaul9-0000FP-FV; Tue, 29 Aug 2023 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaul5-0000Ea-RG
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qaul0-0000Tz-Vj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:11:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so3586464b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693300289; x=1693905089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32RrB/6DxRP4jj8jAR19Pzbha4yomQnSmFzk8B1lmWs=;
 b=hBYHw+S/ueDSwuXbvTE000YocUsUiXKBheDek7kTDvb0fKqGVgCnyfmhMAIaMo9+cI
 egsUqsb/JOW6VHssGJ6aZLuZ7MUfabOmGfFyO6stBjmay0zsgyVx0edfc4/tYUyGQmxN
 SkqhsXFYWiYCjJfDqF/vStfFvIqRUqIwhy5d8HQsFghnvp8JbS9+i0JhdaS08fQgXomJ
 QzbIy/I4TzS3Xv04cOi4SsJfm3g7qvVBQ+/0u2Gq/5FyACVR6Cg3oqq2BIylIKx8BCTg
 1HbnSwo8KfKrFAoF4467gWcN3/3h0EZgDtC24AaJevJfQrqfxsaihXmYT50LwELj+C2W
 0WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693300289; x=1693905089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32RrB/6DxRP4jj8jAR19Pzbha4yomQnSmFzk8B1lmWs=;
 b=UymUmdqcI/lMszFuUyoBqxdBy6enKq2YbFW38BinITRHmmyMr2r13fRLNzGBA+Lrtj
 t5r/DCInHlRGGJ0YTlFB0nbjZ/q87/2+P/cL/2smtu5qbc/St7JsmOVPecN2QPJksDDK
 Bx/mSrY5E/LPZDiJwnRwn+fHZlWpG/tfcLk1WeLZYTOZuvOkr42/T+qZModHRfYRZL+q
 +p7k9D/1H20CBrd7dTTINbeypQHKB9uJ5UFdy5QKkayejxrR1AzFHGLAX/CV98FTNlD0
 GxsIzvOLZSLYJAr5RynbB9b0KEct2pvnzOVYjjYeJgx36/RcLQIRctnnyuCW2h1Ify8I
 jBYw==
X-Gm-Message-State: AOJu0YwVRvVw8cIajEeWwyswB3Gs1D/IDX4+UpiCZi5LiUJaycxrPNsT
 iezq8O5xULEXKaWc6PypMvc=
X-Google-Smtp-Source: AGHT+IEUsPgDj6UWVxkKnrJcyVTErFrjexPEC8AZkP5ZHD9EV0cmSPJNjTEIzVBb+X+EMkrlfQPkOw==
X-Received: by 2002:a05:6a20:430d:b0:14c:a2e1:65ec with SMTP id
 h13-20020a056a20430d00b0014ca2e165ecmr13908010pzk.38.1693300288433; 
 Tue, 29 Aug 2023 02:11:28 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 c21-20020aa78c15000000b0068c023b6a80sm8315049pfd.148.2023.08.29.02.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 02:11:28 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/3] vdpa: Add SetSteeringEBPF method for NetClientState
Date: Tue, 29 Aug 2023 17:11:15 +0800
Message-Id: <30509e3c3b07bcadd95d5932aeb16820cb022902.1693299194.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693299194.git.yin31149@gmail.com>
References: <cover.1693299194.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x431.google.com
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

At present, to enable the VIRTIO_NET_F_RSS feature, eBPF must
be loaded for the vhost backend.

Given that vhost-vdpa is one of the vhost backend, we need to
implement the SetSteeringEBPF method to support RSS for vhost-vdpa,
even if vhost-vdpa calculates the rss hash in the hardware device
instead of in the kernel by eBPF.

Although this requires QEMU to be compiled with `--enable-bpf`
configuration even if the vdpa device does not use eBPF to
calculate the rss hash, this can avoid adding the specific
conditional statements for vDPA case to enable the VIRTIO_NET_F_RSS
feature, which reduces code maintainbility.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index b29f84f54c..11f89e7032 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -238,6 +238,12 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     }
 }
 
+/** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
+static bool vhost_vdpa_set_steering_ebpf(NetClientState *nc, int prog_fd)
+{
+    return true;
+}
+
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -400,6 +406,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1241,6 +1248,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
2.25.1


