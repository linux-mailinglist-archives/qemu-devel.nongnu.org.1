Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB4B71A1EF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:09:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4juw-0003Pf-0L; Thu, 01 Jun 2023 11:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jut-00035v-BH
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4jur-00082d-0Y
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685632117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKrE0cU6y/KvEa0jIUQsGcMo+tubjSZxaQI6tRZgCYg=;
 b=LtWMkYE6DZtmJubk81I8YEAGffzkCgjNJsLD+20WWbVuiM4WcftdceALGoj0ieKg4QJM8r
 doqJxkIE1vR41mj+Sob9suPPw8vy7YsgUfMRy2iwA0WdA59sOTWk9Y5/r5p75GsdSFjRuP
 SgJCn1Avedq+moaE2M/kgKVnKWAAoUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-mJyahbADPlCd1sqxogp_NQ-1; Thu, 01 Jun 2023 11:08:10 -0400
X-MC-Unique: mJyahbADPlCd1sqxogp_NQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19E4101B042;
 Thu,  1 Jun 2023 15:07:03 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 704B59E63;
 Thu,  1 Jun 2023 15:07:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 05/11] docs/deprecated: move QMP events bellow QMP command
 section
Date: Thu,  1 Jun 2023 11:06:43 -0400
Message-Id: <20230601150649.1591095-6-stefanha@redhat.com>
In-Reply-To: <20230601150649.1591095-1-stefanha@redhat.com>
References: <20230601150649.1591095-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alex Bennée <alex.bennee@linaro.org>

Also rename the section to make the fact this is part of the
management protocol even clearer.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20230526165401.574474-6-alex.bennee@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/about/deprecated.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e934e0a13a..7c45a64363 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -218,6 +218,15 @@ instruction per translated block" mode (which can be set on the
 command line or via the HMP, but not via QMP). The information remains
 available via the HMP 'info jit' command.
 
+QEMU Machine Protocol (QMP) events
+----------------------------------
+
+``MEM_UNPLUG_ERROR`` (since 6.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
+
+
 Human Monitor Protocol (HMP) commands
 -------------------------------------
 
@@ -251,15 +260,6 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
 
-QEMU API (QAPI) events
-----------------------
-
-``MEM_UNPLUG_ERROR`` (since 6.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Use the more generic event ``DEVICE_UNPLUG_GUEST_ERROR`` instead.
-
-
 System emulator machines
 ------------------------
 
-- 
2.40.1


