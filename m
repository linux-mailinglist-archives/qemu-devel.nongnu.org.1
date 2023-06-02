Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A36720843
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58QK-00018k-Ir; Fri, 02 Jun 2023 13:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QJ-00018U-1o
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q58QH-0004BG-C0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685726324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZaDvFY2FRnXAXI00kRKULAR0scvgsgG8LW3uG7Gj5SY=;
 b=A8yzgs7pO42PbO+S5uLrUrWlFp2ln/V+IZ8vYFW0QkErjK7WQvp2in/d1Muaw3FE0E60by
 mwFpc52ai5TS615FIMNqE88Vociw2YX1n+k1ShgmH1O+7bl7KKeVCO5wMxr55GyU0WSxw/
 RUJdJnm2LYI4OSsABI+pvMwNnz3GQS8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-ecDNi87nNM-nc5EirQVe0A-1; Fri, 02 Jun 2023 13:18:41 -0400
X-MC-Unique: ecDNi87nNM-nc5EirQVe0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6400811E85;
 Fri,  2 Jun 2023 17:18:40 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29E662166B25;
 Fri,  2 Jun 2023 17:18:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/3] meson.build: Group the network backend entries in a
 separate summary section
Date: Fri,  2 Jun 2023 19:18:31 +0200
Message-Id: <20230602171832.533739-3-thuth@redhat.com>
In-Reply-To: <20230602171832.533739-1-thuth@redhat.com>
References: <20230602171832.533739-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

Let's make it easier for the users to spot network-related entries
in the summary of the meson output.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 4a20a2e712..c64ad3c365 100644
--- a/meson.build
+++ b/meson.build
@@ -4267,13 +4267,19 @@ summary_info += {'curses support':    curses}
 summary_info += {'brlapi support':    brlapi}
 summary(summary_info, bool_yn: true, section: 'User interface')
 
-# Libraries
+# Network backends
 summary_info = {}
 if targetos == 'darwin'
   summary_info += {'vmnet.framework support': vmnet}
 endif
-summary_info = {}
 summary_info += {'slirp support':     slirp}
+summary_info += {'vde support':       vde}
+summary_info += {'netmap support':    have_netmap}
+summary_info += {'l2tpv3 support':    have_l2tpv3}
+summary(summary_info, bool_yn: true, section: 'Network backends')
+
+# Libraries
+summary_info = {}
 summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
@@ -4295,9 +4301,6 @@ if targetos == 'linux'
 endif
 summary_info += {'Pipewire support':   pipewire}
 summary_info += {'JACK support':      jack}
-summary_info += {'vde support':       vde}
-summary_info += {'netmap support':    have_netmap}
-summary_info += {'l2tpv3 support':    have_l2tpv3}
 summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
-- 
2.31.1


