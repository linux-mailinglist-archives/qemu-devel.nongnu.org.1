Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE39AA5435
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 20:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWP-0003rj-FH; Wed, 30 Apr 2025 14:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWN-0003oH-AD
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uACWL-0008LA-NV
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746039061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZvW2RNky95DizNFkoHrcOHvUETO94KZq32Qqt4f62s=;
 b=Xh2vekSjnDr1MlVkEnFUpcBUv5fWretJW6ta1aX1AMmwoqv7fNoA+sOelRPCdthP6TPGLm
 1EjcmVsxVWVhw6QQ4RovwM2+T515/2tXVJqA3OJM15HEQEJ77oZ2kBBRyaeB/hMuBiCNMv
 V20VpgAM52IhJ6kjAlFmG1kQcv9ln7E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-SvkHwoCfO52CUvkJlTSkcw-1; Wed,
 30 Apr 2025 14:50:57 -0400
X-MC-Unique: SvkHwoCfO52CUvkJlTSkcw-1
X-Mimecast-MFC-AGG-ID: SvkHwoCfO52CUvkJlTSkcw_1746039056
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5249D180036F; Wed, 30 Apr 2025 18:50:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78ADA19560A3; Wed, 30 Apr 2025 18:50:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 7/9] meson.build: Put the D-Bus summary into the UI section
Date: Wed, 30 Apr 2025 20:50:33 +0200
Message-ID: <20250430185035.724919-8-thuth@redhat.com>
In-Reply-To: <20250430185035.724919-1-thuth@redhat.com>
References: <20250430185035.724919-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We've got a dedicated section for UI options nowadays, so the
D-Bus display should get reported here, too.

Message-ID: <20250325055125.253669-1-thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ccd6c71577d..6c61e1dcaec 100644
--- a/meson.build
+++ b/meson.build
@@ -4619,7 +4619,6 @@ summary_info += {'Trace backends':    ','.join(get_option('trace_backends'))}
 if 'simple' in get_option('trace_backends')
   summary_info += {'Trace output file': get_option('trace_file') + '-<pid>'}
 endif
-summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'QOM debugging':     get_option('qom_cast_debug')}
 summary_info += {'Relocatable install': get_option('relocatable')}
 summary_info += {'vhost-kernel support': have_vhost_kernel}
@@ -4802,6 +4801,7 @@ summary_info = {}
 if host_os == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
 endif
+summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'SDL support':       sdl}
 summary_info += {'SDL image support': sdl_image}
 summary_info += {'GTK support':       gtk}
-- 
2.49.0


