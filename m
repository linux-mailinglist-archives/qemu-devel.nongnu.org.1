Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C767AAE27
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVy-0004nA-BI; Fri, 22 Sep 2023 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVv-0004lx-2w
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVr-0003Oj-SB
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHGnTNyq5XgSc0eYIq2gK8em2cLFaeZOxfGizLjP/Ko=;
 b=GzOPjlQVAJsZymTsFW3jjSXK30rRE5p5Zw0pybzJ0XES9NT+BTszJGf+ZfDrxSeBqdOlD/
 cg2FiWLx/iaUk5XjoK6Qj6SR7ZYwhYpw6dBwfC8Y+ejM7VNUqF5EnJD1KkAQIT7DrtF3Km
 ceTTfXUkgbA2m7/2Il2mW2Yu6GjulXM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Np_830xuMv-pL90EwqzXAw-1; Fri, 22 Sep 2023 05:31:49 -0400
X-MC-Unique: Np_830xuMv-pL90EwqzXAw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so14914425e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375108; x=1695979908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHGnTNyq5XgSc0eYIq2gK8em2cLFaeZOxfGizLjP/Ko=;
 b=BYXO+4rop/aUcmAAf5WXxGdkKohw7AziJugOsC3T3jtKDqss1yckzlrTs8uuoQPjFM
 +Mzsf4aifSIyQsm+e08BA7FYhoZiHsKcDJgL8D04qGK1AWm2Cvbp/SCPkDfmm+yrW0UO
 0Fi/YVQTIU2687fnxmUSxMmQBNmEA8Ve5Zis3bgnSCY5kDDXsp5tHbEPIysyhY/VgTa0
 Q7d0hSWa+Ca20wzWNhz0w7Y2/uNStZcU1KN02AbSPxH4eT3q6ZUT7kJGCy4oLia0/hn2
 g4erjzmBONLFhGo2ocOEd436rhoqHc6FSaPcwZS8IFf8kpABasqDuYfPKZ8Cuax1q8Tu
 ZXDA==
X-Gm-Message-State: AOJu0YzhvgXCDffP3qN6nYzmCLuTw3tvlnRCKdMUH2qrbFsta+jG7FvO
 FeNW/+DC6OWWbJeaJZj9hP74+3l/dS3AksgUpw67027jV/7Rkv125dY0uQeUjfgQ4Yr0Rg0B/El
 G3kSks6pfVi4pbPZHecQFMhQdpI+Pl0cHqx4upJtNF9Rv5PNCfBGtFke91Ythom4hgues4pjAQd
 Q=
X-Received: by 2002:a1c:7404:0:b0:3fe:1b4e:c484 with SMTP id
 p4-20020a1c7404000000b003fe1b4ec484mr7533553wmc.5.1695375108119; 
 Fri, 22 Sep 2023 02:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUZQRmF3a2AeX+5yqmH/TvV9/HPl4enjNxqA8PBzZVYBwhm6espJ+WsxHu8WstlFji/go9A==
X-Received: by 2002:a1c:7404:0:b0:3fe:1b4e:c484 with SMTP id
 p4-20020a1c7404000000b003fe1b4ec484mr7533539wmc.5.1695375107749; 
 Fri, 22 Sep 2023 02:31:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a056000114800b0031fe0576460sm3981624wrx.11.2023.09.22.02.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 11/12] ui/vnc: Require audiodev= to enable audio
Date: Fri, 22 Sep 2023 11:31:24 +0200
Message-ID: <20230922093126.264016-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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
index b9cdd2dd03b..40845b3fcb7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -37,13 +37,11 @@ coverage.
 System emulator command line arguments
 --------------------------------------
 
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
index 63458736ee1..7668ddef178 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,6 +442,12 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
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


