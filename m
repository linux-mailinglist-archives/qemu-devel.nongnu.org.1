Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B855B919A98
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jun 2024 00:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb4H-00008N-9E; Wed, 26 Jun 2024 18:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3l-0007u2-Qi
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3k-0002yd-4L
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+rIw2vWBIY8VwB4GBJ19a+kqcJbUHlMpFk9pr7No22Y=;
 b=GMxl+wsxO/kx9i7pi+8qMOD9tjPfcoIgB+ly5Z92ug5touYD7jWCoWLg8el6akwFmb0/nN
 x6E41m9ILAygstKIiN8NvZ2l/XFi1yk+kwKfcecxj7Ru6WaLNCm5LIiox/iFCVc/Ij/qnZ
 qV8WNNlis1raI+/kDv+JZM15AVI9ds4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-V9-20THaPjC3k47UA2J8UQ-1; Wed,
 26 Jun 2024 18:24:07 -0400
X-MC-Unique: V9-20THaPjC3k47UA2J8UQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4135C195608B; Wed, 26 Jun 2024 22:24:05 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C42919560BF; Wed, 26 Jun 2024 22:23:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Harmonie Snow <harmonie@gmail.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 17/21] docs/sphinx: add CSS styling for qmp-example
 directive
Date: Wed, 26 Jun 2024 18:21:23 -0400
Message-ID: <20240626222128.406106-18-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

From: Harmonie Snow <harmonie@gmail.com>

Add CSS styling for qmp-example directives to increase readability and
consistently style all example blocks.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index c70ef951286..f3223af62b2 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -87,6 +87,52 @@ div[class^="highlight"] pre {
     padding-bottom: 1px;
 }
 
+/* qmp-example directive styling */
+
+.rst-content .admonition-example {
+    background-color: #fcfcfc;
+    padding: 0px;
+}
+
+.rst-content .admonition-example > .admonition-title {
+    background-color: #338254;
+    margin: 0px;
+}
+
+.rst-content .admonition-example > div[class^=highlight] {
+    border-top: 1px solid #d7f0d7;
+    border-bottom: 1px solid #d7f0d7;
+    border-left: 3px solid #d7f0d7;
+    border-right: 3px solid #d7f0d7;
+}
+
+.rst-content .admonition-example .highlight {
+    background: linear-gradient(#d9f1d9 1%, #ecf8ec 10%,
+                                #ecf8ec 90%, #d9f1d9 99%);
+}
+
+.rst-content .admonition-example > .admonition-title:before {
+    content: "🧩";
+}
+
+.rst-content .admonition-example > .admonition-title p {
+    margin: 0px;
+}
+
+.rst-content .admonition-example p {
+    padding: 15px 10px;
+    margin: 0px;
+    background-color: #fafafa;
+    border-left: 1px solid #ededed;
+    border-right: 1px solid #ededed;
+}
+
+.rst-content .admonition-example > .admonition  {
+    background-color: #fcfcfc;
+}
+
+/* end qmp-example styling */
+
 @media screen {
 
     /* content column
-- 
2.45.0


