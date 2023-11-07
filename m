Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB617E3878
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2v-0002SI-Tz; Tue, 07 Nov 2023 05:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2H-0001Sq-75
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J27-0002Of-3x
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fdk3Bbk2ygBigMnmlg+/ceuCimXYtURlgtx7u8r0kG4=;
 b=HcwWXcBIveDmmWI3fsOXlgZCivZKvUvpQpFH4dPbo1qcxUQ4XCqIcAPhSiaPbG+GdbtJXh
 WugY6PL9CKLsp0RHVCV3bqju+6UNF9D2zUVwp+HPDIFMVRFf94xG26OSWkX8oL00OYRmrf
 KGqO7G8veGpZ9IjIiOEGDTqikvpCDgo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Zk3MAzJ7M_W2M8j9UDw-eg-1; Tue, 07 Nov 2023 05:09:44 -0500
X-MC-Unique: Zk3MAzJ7M_W2M8j9UDw-eg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so2626894f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351782; x=1699956582;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdk3Bbk2ygBigMnmlg+/ceuCimXYtURlgtx7u8r0kG4=;
 b=gnRC42ovzaZ7IEfrDADwMOci1iINDK9O3WC7Pw/EJMflnrLt8KeFwRnMG2JOhyqc6K
 cNmBsAXfefgLuTFTLeyKP+0aBWK8bH3/z+LOM5RilhoF7chsD+DZGUyxfVo5OKprJhud
 tDxYYVKD2RZQmo1b29xB+GzEqOSJQYPvPOFg+84Jg/OXQWgBlc1ppEkrlV5DfntVwVno
 TdpUUcuX5a0jLbX5vxz2yjNOMF3UW4HZfbCXb4Z0DxmUakB/3ZPBvgMl/Qpjglx+qbp0
 5PmzkjOInmbVh9cgVCXOAkJ5agJdHB79hLh837uygsCgGIau8EttiWyFDlmml0UXXK7G
 x3XQ==
X-Gm-Message-State: AOJu0YzSNhfYQpijuIjtWwD/l5R9S9a6nLVR0zG8kETg2CYcozRyS+8u
 81N2cuS047NXY6hViuhAlpFycBms4SGzY7Q/ReyOD2MCgHqvDpVCfGIi8xNNUVpY4ok9bKFx1XD
 aIZsPggu6pqZNt44H89sEkRn9tSauHzQWXOW1URQD3Rgze3ZKKy3wMZrSe61bmXJ3TedV
X-Received: by 2002:a05:6000:548:b0:32d:967d:1baf with SMTP id
 b8-20020a056000054800b0032d967d1bafmr23511936wrf.1.1699351782161; 
 Tue, 07 Nov 2023 02:09:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr5L896pwP5bqSY39ejRGZe6dqCKmxCznHAarXfvgcW4vUZRzAigeBK1FmoRDI6cCV2LqHGA==
X-Received: by 2002:a05:6000:548:b0:32d:967d:1baf with SMTP id
 b8-20020a056000054800b0032d967d1bafmr23511915wrf.1.1699351781775; 
 Tue, 07 Nov 2023 02:09:41 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 z6-20020a5d4406000000b003196b1bb528sm1894354wrq.64.2023.11.07.02.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:41 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/63] vhost-user.rst: Introduce suspended state
Message-ID: <a6e76dd3c3b98db86802b4b08984f2ac5ec1faea.1699351720.git.mst@redhat.com>
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

From: Hanna Czenczek <hreitz@redhat.com>

In vDPA, GET_VRING_BASE does not stop the queried vring, which is why
SUSPEND was introduced so that the returned index would be stable.  In
vhost-user, it does stop the vring, so under the same reasoning, it can
get away without SUSPEND.

Still, we do want to clarify that if the device is completely stopped,
i.e. all vrings are stopped, the back-end should cease to modify any
state relating to the guest.  Do this by calling it "suspended".

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-4-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index e5a04c04ed..035a23ed35 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -442,6 +442,19 @@ back-end must enable all rings immediately.
 While processing the rings (whether they are enabled or not), the back-end
 must support changing some configuration aspects on the fly.
 
+.. _suspended_device_state:
+
+Suspended device state
+^^^^^^^^^^^^^^^^^^^^^^
+
+While all vrings are stopped, the device is *suspended*.  In addition to
+not processing any vring (because they are stopped), the device must:
+
+* not write to any guest memory regions,
+* not send any notifications to the guest,
+* not send any messages to the front-end,
+* still process and reply to messages from the front-end.
+
 Multiple queue support
 ----------------------
 
@@ -529,7 +542,8 @@ ancillary data, it may be used to inform the front-end that the log has
 been modified.
 
 Once the source has finished migration, rings will be stopped by the
-source. No further update must be done before rings are restarted.
+source (:ref:`Suspended device state <suspended_device_state>`). No
+further update must be done before rings are restarted.
 
 In postcopy migration the back-end is started before all the memory has
 been received from the source host, and care must be taken to avoid
@@ -1123,6 +1137,10 @@ Front-end message types
   (*a vring descriptor index for split virtqueues* vs. *vring descriptor
   indices for packed virtqueues*).
 
+  When and as long as all of a device’s vrings are stopped, it is
+  *suspended*, see :ref:`Suspended device state
+  <suspended_device_state>`.
+
   The request payload’s *num* field is currently reserved and must be
   set to 0.
 
-- 
MST


