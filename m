Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 642617E3876
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2Z-0001Fb-Fd; Tue, 07 Nov 2023 05:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1f-00010O-5D
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1d-00029c-BY
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeT9trR7h5e0mt3T72UGK2kZ1Wd+DrRHHhGgZvqMeCU=;
 b=QCI7f7ASvGHyjjrZZJtALym4t0MK+hrtjmNMmaRR0WssVx1cmy2UjXjy17DrCLNtAhDh6d
 7aLdqqHXOHv6rlbFn/pX52Zs2bHv5ictS6oMHu4PqEE9EjqJu8HhGvXp8WCh0E2khlT9BP
 gTZ6uTSDop88FB5ZR8D6cEhvr8fmxfk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-kKwni7kBNEGXNr59FblkFw-1; Tue, 07 Nov 2023 05:09:35 -0500
X-MC-Unique: kKwni7kBNEGXNr59FblkFw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5093a1a0adcso6167172e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351773; x=1699956573;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DeT9trR7h5e0mt3T72UGK2kZ1Wd+DrRHHhGgZvqMeCU=;
 b=uLkqq95CwrHO/2P0GaLItDFV3eYZlEcdHmvSkeF2iZf8wlOGWPe3DCDv8jFZnumWVF
 VIbDERjykUL8dyOO3xIOE4V9/BRmfA5PHN2GHdIkdASzNTvxzYRJcKWFeoUuX2ArcCU8
 FiZ3Cr/52mAwKGFDy5azpekH66BD2qfOIVj2hCCDtbix303xTf55NWBc/kReXk4nSITf
 dwyTBtzlgs9POuXdnGkx+Xn3h9muMBAiovXi7Syf3A7Y21MrMSwPGKOOA0+eE/O+AIj5
 t0XneQsjcNpME1oQKJZZGr9uLhACCpF9lAn2szq+ygzUth1scgdKJ1Jj1W8+6NWav3tJ
 GkPQ==
X-Gm-Message-State: AOJu0Yzlos3r8YBDMWxUn2/J5K1METUpPjn0JRtqZpN7394LO+OlSK7L
 I0lrBcaLxX3ddYkQdCt7TNxSOxuVBEjhXVAsP6ECgXuIve8ufKxa+UnD3s946j3g+8mGldYPSeG
 j7nqoRyYSnHeZ8/urkbXGpyjZ1sNtX+hQbLyFDw+/bxh3gu5yr812xrVdvS8gVOlhh3v2
X-Received: by 2002:a05:6512:3e1a:b0:500:7a23:720b with SMTP id
 i26-20020a0565123e1a00b005007a23720bmr29179045lfv.55.1699351772990; 
 Tue, 07 Nov 2023 02:09:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqhPMdFekfI3h0XME1AiiBJ1hG+KzAc6hF17BRpUj+A15LT9SLMbOAEqhwRtn64O8XvIF0NA==
X-Received: by 2002:a05:6512:3e1a:b0:500:7a23:720b with SMTP id
 i26-20020a0565123e1a00b005007a23720bmr29179020lfv.55.1699351772465; 
 Tue, 07 Nov 2023 02:09:32 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a11-20020a05600c348b00b0040813e14b49sm15542037wmq.30.2023.11.07.02.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:31 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 01/63] vhost-user.rst: Improve [GS]ET_VRING_BASE doc
Message-ID: <c7f21816612879efdae3d9b67f024a6671494c62.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

GET_VRING_BASE does not mention that it stops the respective ring.  Fix
that.

Furthermore, it is not fully clear what the "base offset" these
commands' documentation refers to is; an offset could be many things.
Be more precise and verbose about it, especially given that these
commands use different payload structures depending on whether the vring
is split or packed.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-2-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 77 +++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 768fb5c28c..9202b167dd 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -108,6 +108,43 @@ A vring state description
 
 :num: a 32-bit number
 
+A vring descriptor index for split virtqueues
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+---------------------+
+| vring index | index in avail ring |
++-------------+---------------------+
+
+:vring index: 32-bit index of the respective virtqueue
+
+:index in avail ring: 32-bit value, of which currently only the lower 16
+  bits are used:
+
+  - Bits 0–15: Index of the next *Available Ring* descriptor that the
+    back-end will process.  This is a free-running index that is not
+    wrapped by the ring size.
+  - Bits 16–31: Reserved (set to zero)
+
+Vring descriptor indices for packed virtqueues
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
++-------------+--------------------+
+| vring index | descriptor indices |
++-------------+--------------------+
+
+:vring index: 32-bit index of the respective virtqueue
+
+:descriptor indices: 32-bit value:
+
+  - Bits 0–14: Index of the next *Available Ring* descriptor that the
+    back-end will process.  This is a free-running index that is not
+    wrapped by the ring size.
+  - Bit 15: Driver (Available) Ring Wrap Counter
+  - Bits 16–30: Index of the entry in the *Used Ring* where the back-end
+    will place the next descriptor.  This is a free-running index that
+    is not wrapped by the ring size.
+  - Bit 31: Device (Used) Ring Wrap Counter
+
 A vring address description
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -1042,18 +1079,50 @@ Front-end message types
 ``VHOST_USER_SET_VRING_BASE``
   :id: 10
   :equivalent ioctl: ``VHOST_SET_VRING_BASE``
-  :request payload: vring state description
+  :request payload: vring descriptor index/indices
   :reply payload: N/A
 
-  Sets the base offset in the available vring.
+  Sets the next index to use for descriptors in this vring:
+
+  * For a split virtqueue, sets only the next descriptor index to
+    process in the *Available Ring*.  The device is supposed to read the
+    next index in the *Used Ring* from the respective vring structure in
+    guest memory.
+
+  * For a packed virtqueue, both indices are supplied, as they are not
+    explicitly available in memory.
+
+  Consequently, the payload type is specific to the type of virt queue
+  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
+  indices for packed virtqueues*).
 
 ``VHOST_USER_GET_VRING_BASE``
   :id: 11
   :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
   :request payload: vring state description
-  :reply payload: vring state description
+  :reply payload: vring descriptor index/indices
 
-  Get the available vring base offset.
+  Stops the vring and returns the current descriptor index or indices:
+
+    * For a split virtqueue, returns only the 16-bit next descriptor
+      index to process in the *Available Ring*.  Note that this may
+      differ from the available ring index in the vring structure in
+      memory, which points to where the driver will put new available
+      descriptors.  For the *Used Ring*, the device only needs the next
+      descriptor index at which to put new descriptors, which is the
+      value in the vring structure in memory, so this value is not
+      covered by this message.
+
+    * For a packed virtqueue, neither index is explicitly available to
+      read from memory, so both indices (as maintained by the device) are
+      returned.
+
+  Consequently, the payload type is specific to the type of virt queue
+  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
+  indices for packed virtqueues*).
+
+  The request payload’s *num* field is currently reserved and must be
+  set to 0.
 
 ``VHOST_USER_SET_VRING_KICK``
   :id: 12
-- 
MST


