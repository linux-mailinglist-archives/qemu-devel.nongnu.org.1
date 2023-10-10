Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436937BF2ED
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 08:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq69G-0000kP-5N; Tue, 10 Oct 2023 02:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loyou85@gmail.com>) id 1qq69E-0000jj-Cv
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:23:16 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loyou85@gmail.com>) id 1qq69C-0001iP-R3
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 02:23:16 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c4bf619b57so3641939a34.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696918993; x=1697523793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rphDbyUQdsVRGWPVUUo4v9CZ2qJ5BooAyebZjPEJ3zk=;
 b=D7roEc1/fWmCP07kHOySRqTaUFdc/ybuJQOO01hgREdp03DUyxnVskHdlKLru+mYrW
 tteYg4iJVNOmgEweFxLZLp5GHtKXXNg5NHwHL1xsLiV83AZHVKwJOhTzSMzjJZmaA7Wf
 4JVbZ+YsdWS1JcanA15GZte3V3jcYKK2Q9SmACzRm1h7lb9dNcIfPgHJxibDtIjH4q55
 GerNErw7xv1HNLs8Xe0xIlMjlCBL6ErigBGtbopX/AS6FwlZevk5po5U5/ko/oMGOMEm
 GwcYIA4odeW+hRq+pcesBsrizao2ye1eF4FQ2M+ULkLDfTESWgOlm0uRoN28qdZww59X
 fmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696918993; x=1697523793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rphDbyUQdsVRGWPVUUo4v9CZ2qJ5BooAyebZjPEJ3zk=;
 b=on8uZl1Qh4pJciVV94JTyPS9KXFJJSPdZRV7s/GYQL5Hshed9fuXzDsPp1RfZxZ/BG
 yh1AhVbDK32y0ZmkTJU7yVgV1I2UBAXW3QL57vYUyKv5HXvspcLb0mcvCQZoghEdAVx1
 tvPFCOL/lL3ic/vDMd1JCyiAUGYKIsR0TNf/p687uQiMlHqcKd81dofhxHNsj4/KegFd
 nq0T1bmd/dz3miBaLbo25il+V2y8jXp+cbyyjpmg6S+DR2ZGYNyJ147DWf310TUDhMU5
 WGiRyiOZ6b5QAeLvPxRQS/erutBLqp3ZTrmJ2wzND9lcGomiZNsMhSppZhb9bwksuS1o
 qfYg==
X-Gm-Message-State: AOJu0Ywc/nKqOnTaGuqb1MgI8tls9BCjP6QyJVibB+RW3E1QQhhN+OPE
 2LbHZypydtfSiVOcK+NtTuo=
X-Google-Smtp-Source: AGHT+IEH1lgiS1WQUFpXtsU2Yi+xJCR3ebLk1qA21xTvH/Dqhb1MfBcNyDFTtdRSMfLTjlsOqta4kw==
X-Received: by 2002:a05:6870:63aa:b0:1bf:61e3:df1 with SMTP id
 t42-20020a05687063aa00b001bf61e30df1mr21841254oap.50.1696918992922; 
 Mon, 09 Oct 2023 23:23:12 -0700 (PDT)
Received: from localhost.localdomain ([111.164.178.89])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a62ee04000000b006889664aa6csm7358311pfi.5.2023.10.09.23.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 23:23:12 -0700 (PDT)
From: Sun Feng <loyou85@gmail.com>
To: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	Sun Feng <loyou85@gmail.com>
Subject: [PATCH] virtio-serial-bus: Discard throttled VirtQueueElement when
 virtio-serial closed
Date: Tue, 10 Oct 2023 14:22:16 +0800
Message-Id: <20231010062216.16144-1-loyou85@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=loyou85@gmail.com; helo=mail-ot1-x331.google.com
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

With commit d4c19cde("virtio-serial: add missing virtio_detach_element() call"),
when virtio serial is throttled and closed by host, port->elem should be discard with virtqueue_push,
otherwise virtqueue will not rewind, guest will blocked finally and cannot write anymore data.

It can be reproduced with following steps:
Create a vm with virtio-serial device through libvirt:

    <channel type='unix'>
      <source mode='bind' path='/tmp/test'/>
      <target type='virtio' name='com.test.channel.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='1'/>
    </channel>

Host run:
watch -n0.5 'timeout 0.5 nc -U /tmp/test'

Guest run:
hexdump -C -v /dev/zero > /dev/vport1p1

After sometime, guest can not write any data to serial.
We can see vq->last_avail_idx - vq->used_idx = 128 with gdb.

(gdb) p *(struct VirtQueue *) 0x565161c5c788
$4 = {vring = {num = 128, num_default = 128, align = 4096, desc = 4316049408, avail = 4316051456, used = 4316051776,
    caches = 0x7fc530067e60}, used_elems = 0x565161c88dc0, last_avail_idx = 7929, last_avail_wrap_counter = true,
  shadow_avail_idx = 7929, shadow_avail_wrap_counter = true, used_idx = 7801, used_wrap_counter = true, signalled_used = 7801,
  signalled_used_valid = true, notification = true, queue_index = 5, inuse = 0, vector = 1,
  handle_output = 0x56515da8aea0 <handle_output>, handle_aio_output = 0x0, vdev = 0x565161c54e30, guest_notifier = {rfd = 0,
    wfd = 0}, host_notifier = {rfd = 74, wfd = 74}, host_notifier_enabled = true, node = {le_next = 0x565161c5c6f0,
    le_prev = 0x565161c5c8a8}}

Fixes: d4c19cde("virtio-serial: add missing virtio_detach_element() call")
Signed-off-by: Sun Feng <loyou85@gmail.com>
---
 hw/char/virtio-serial-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index dd619f0..30b00a4 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -151,7 +151,7 @@ static void discard_vq_data(VirtQueue *vq, VirtIODevice *vdev)
 static void discard_throttle_data(VirtIOSerialPort *port)
 {
     if (port->elem) {
-        virtqueue_detach_element(port->ovq, port->elem, 0);
+        virtqueue_push(port->ovq, port->elem, 0);
         g_free(port->elem);
         port->elem = NULL;
     }
-- 
2.7.4


