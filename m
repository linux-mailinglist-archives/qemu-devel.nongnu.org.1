Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3E7F5E0D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r684g-0005w2-4p; Thu, 23 Nov 2023 06:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r684d-0005vC-AN
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r684X-0004II-OU
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700739641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU+mWXdvCG/zKRvuLfb9OFK0nSxAvYHF8L24T7DhUtU=;
 b=dLHzGvP9CrmhiDyYMX3RTpGE2WkJw6zAcx1ItE9yUwwKtThdBE338GNIAKYQYB1qYZhXgf
 tKCspYy9wpKc0EXo/TyqFmU6oX/xDHbyZzpDhD6o9vwGYeMC0psL1A1D0LM0tx0kogRzzo
 dYaIIrOGjTGtCP2xSxBmVOeiMeuJVkk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-vYD_6QCPN2aA-EgEvlgnzg-1; Thu,
 23 Nov 2023 06:40:37 -0500
X-MC-Unique: vYD_6QCPN2aA-EgEvlgnzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5B123806702;
 Thu, 23 Nov 2023 11:40:36 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E64B72166B26;
 Thu, 23 Nov 2023 11:40:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
Date: Thu, 23 Nov 2023 11:40:26 +0000
Message-ID: <20231123114026.3589272-3-berrange@redhat.com>
In-Reply-To: <20231123114026.3589272-1-berrange@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

There has been an explosion of interest in so called "AI" (LLM)
code generators in the past year or so. Thus far though, this is
has not been matched by a broadly accepted legal interpretation
of the licensing implications for code generator outputs. While
the vendors may claim there is no problem and a free choice of
license is possible, they have an inherent conflict of interest
in promoting this interpretation. More broadly there is, as yet,
no broad consensus on the licensing implications of code generators
trained on inputs under a wide variety of licenses.

The DCO requires contributors to assert they have the right to
contribute under the designated project license. Given the lack
of consensus on the licensing of "AI" (LLM) code generator output,
it is not considered credible to assert compliance with the DCO
clause (b) or (c) where a patch includes such generated code.

This patch thus defines a policy that the QEMU project will not
accept contributions where use of "AI" (LLM) code generators is
either known, or suspected.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index b4591a2dec..a6e42c6b1b 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -195,3 +195,43 @@ example::
   Signed-off-by: Some Person <some.person@example.com>
   [Rebased and added support for 'foo']
   Signed-off-by: New Person <new.person@example.com>
+
+Use of "AI" (LLM) code generators
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+TL;DR:
+
+  **Current QEMU project policy is to DECLINE any contributions
+  which are believed to include or derive from "AI" (LLM)
+  generated code.**
+
+The existence of "AI" (`Large Language Model <https://en.wikipedia.org/wiki/Large_language_model>`__
+/ LLM) code generators raises a number of difficult legal questions, a
+number of which impact on Open Source projects. As noted earlier, the
+QEMU community requires that contributors certify their patch submissions
+are made in accordance with the rules of the :ref:`dco` (DCO). When a
+patch contains "AI" generated code this raises difficulties with code
+provenence and thus DCO compliance.
+
+To satisfy the DCO, the patch contributor has to fully understand
+the origins and license of code they are contributing to QEMU. The
+license terms that should apply to the output of an "AI" code generator
+are ill-defined, given that both training data and operation of the
+"AI" are typically opaque to the user. Even where the training data
+is said to all be open source, it will likely be under a wide variety
+of license terms.
+
+While the vendor's of "AI" code generators may promote the idea that
+code output can be taken under a free choice of license, this is not
+yet considered to be a generally accepted, nor tested, legal opinion.
+
+With this in mind, the QEMU maintainers does not consider it is
+currently possible to comply with DCO terms (b) or (c) for most "AI"
+generated code.
+
+The QEMU maintainers thus require that contributors refrain from using
+"AI" code generators on patches intended to be submitted to the project,
+and will decline any contribution if use of "AI" is known or suspected.
+
+Examples of tools impacted by this policy includes both GitHub CoPilot,
+and ChatGPT, amongst many others which are less well known.
-- 
2.41.0


