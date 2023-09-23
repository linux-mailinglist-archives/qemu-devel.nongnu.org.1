Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F487ABEFD
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQ4-0002ll-HO; Sat, 23 Sep 2023 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ2-0002kr-OD
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ0-0000VE-3N
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBvt2Gw3G8Y3LRY3RDznSS56C94nCSjSXLWo+8OcDwA=;
 b=Ggu16NstSzMhmTjV1zBVjwxbmT/updLb0AoQPkiMo6YhqkPUuKmuT4+ul/Idh409Qf7XVj
 pjXliEEoe+XLSRB9p4wRNrfsO1uXvQ/oMoj/hG3200Z4UIs+miM2R37cXfEpZneo8tUuCH
 u+46C5PvEnq/3Qn7A0i+MQryRWkpvfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-DbFyomNvMYaSHTkuOiRoew-1; Sat, 23 Sep 2023 04:55:13 -0400
X-MC-Unique: DbFyomNvMYaSHTkuOiRoew-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-405334b0873so24601805e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459311; x=1696064111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBvt2Gw3G8Y3LRY3RDznSS56C94nCSjSXLWo+8OcDwA=;
 b=qP4rz2xv/oO1Z/7q7p/XqJ2ENA4Xn0AXJ2FTs1L/pUrEMIFelV9QX7O+AiXkkmQ9rE
 8YGFG6jX1KZkUgBg+pEzfCeZjXSRYuBlKrOTiCXM50b4v/+9Mg1CPyqJZ72qRikvx2Sa
 64HPJ+L2DO7iShsxMUdKYSYBUGZGCYqobdaV7Nj8XIjTvPvGh7hmHE+VEFUjdBc5yvzJ
 r/Ml51uNkWnzXvkN6+SOstm4Pwpbo6mZ2cHxS4AdsDOnZThA89ggzOFVwAJNauQTf3EP
 lqJoO4Gf0JBqlYQOSKomzBQ6eeXJ+4FCXfIUSntZsNbT+NUEQ/COJ+6D9JSj7l1twmC3
 w3IA==
X-Gm-Message-State: AOJu0YweSB34SrrTYcVznmK5ZSHXZ86agZtwzQ6VkfncQKaVUfdH3+qs
 ZVV4p/mP8nC3o2urMCKwRL0s5nhIwIYkIJxgJ70Y7TsbWlkDLahkFWDEAO4he70nvCXWfSoA6Me
 QG0QuAXNCcrbtN+zapQSx5znYVhGu/0Fr6mOyoja203zRnt5YNAYNtcYaD3Hgn1W6028FwN2bfi
 U=
X-Received: by 2002:a05:600c:ac6:b0:405:4a8c:d4f8 with SMTP id
 c6-20020a05600c0ac600b004054a8cd4f8mr1243135wmr.30.1695459311439; 
 Sat, 23 Sep 2023 01:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYq7E28IFj4/dTjI6CFRvmaK70gOTyzm+yN4PAk4VG0ll44UZmqvFTsS53ELs7pkgq2nnNtQ==
X-Received: by 2002:a05:600c:ac6:b0:405:4a8c:d4f8 with SMTP id
 c6-20020a05600c0ac600b004054a8cd4f8mr1243120wmr.30.1695459311040; 
 Sat, 23 Sep 2023 01:55:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c45c900b0040550c20cbcsm1688927wmo.24.2023.09.23.01.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 01/13] ui/vnc: Require audiodev= to enable audio
Date: Sat, 23 Sep 2023 10:54:54 +0200
Message-ID: <20230923085507.399260-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <a07513f1bf6123fef52ff5e7943f5704746b376b.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst       |  8 +++-----
 docs/about/removed-features.rst |  6 ++++++
 ui/vnc.c                        | 10 ++++++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8f3fef97bd4..c07bf58dde1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -45,13 +45,11 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help`` option can be used to convert
 the current values of the environment variables to ``-audiodev`` options.
 
-Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Creating sound card devices without ``audiodev=`` property (since 4.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 When not using the deprecated legacy audio config, each sound card
-should specify an ``audiodev=`` property.  Additionally, when using
-vnc, you should specify an ``audiodev=`` property if you plan to
-transmit audio through the VNC protocol.
+should specify an ``audiodev=`` property.
 
 Short-form boolean options (since 6.0)
 ''''''''''''''''''''''''''''''''''''''
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 97ec47f1d25..276060b320c 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -436,6 +436,12 @@ the process listing. This was replaced by the new ``password-secret``
 option which lets the password be securely provided on the command
 line using a ``secret`` object instance.
 
+Creating vnc without ``audiodev=`` property (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+When using vnc, you should specify an ``audiodev=`` property if
+you plan to transmit audio through the VNC protocol.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 6fd86996a54..cfa18bbd3e1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2508,11 +2508,17 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
             switch (read_u16 (data, 2)) {
             case VNC_MSG_CLIENT_QEMU_AUDIO_ENABLE:
                 trace_vnc_msg_client_audio_enable(vs, vs->ioc);
-                audio_add(vs);
+                if (vs->vd->audio_state) {
+                    audio_add(vs);
+                } else {
+                    error_report("audio not available, use audiodev= option for vnc");
+                }
                 break;
             case VNC_MSG_CLIENT_QEMU_AUDIO_DISABLE:
                 trace_vnc_msg_client_audio_disable(vs, vs->ioc);
-                audio_del(vs);
+                if (vs->vd->audio_state) {
+                    audio_del(vs);
+                }
                 break;
             case VNC_MSG_CLIENT_QEMU_AUDIO_SET_FORMAT:
                 if (len == 4)
-- 
2.41.0


