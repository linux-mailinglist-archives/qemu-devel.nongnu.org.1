Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844A90E0DF
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 02:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjEf-0006tL-1D; Tue, 18 Jun 2024 20:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjEd-0006sZ-Ju
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjEb-0001R5-Sf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718757093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gtUtRTr0ns8EVnOWvZszpK56MSdOOIfvNba7TfLQpLI=;
 b=VgHjUuFOCHbi8ZqwH0jq4boO7LK1EyWuVBFMFKd1Jg83JGhbYh2860xTlPtcghAogkotA6
 nFk1ac0AbZR5HdpQuaQfij8//J0Csw1B41nNU1TezBOyhwivme8g10HfVBbqlBR2FszAEo
 85zSk5G1a6utCF1EbysP8xHEa13dscc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-7AAmCngNO5iDhe-8opDphQ-1; Tue,
 18 Jun 2024 20:31:30 -0400
X-MC-Unique: 7AAmCngNO5iDhe-8opDphQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C48C119560B0; Wed, 19 Jun 2024 00:31:27 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.16.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCA831956087; Wed, 19 Jun 2024 00:31:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 07/13] qapi: fix non-compliant JSON examples
Date: Tue, 18 Jun 2024 20:30:06 -0400
Message-ID: <20240619003012.1753577-8-jsnow@redhat.com>
In-Reply-To: <20240619003012.1753577-1-jsnow@redhat.com>
References: <20240619003012.1753577-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The new QMP documentation generator wants to parse all examples as
"QMP". We have an existing QMP lexer in docs/sphinx/qmp_lexer.py (Seen
in-use here: https://qemu-project.gitlab.io/qemu/interop/bitmaps.html)
that allows the use of "->", "<-" and "..." tokens to denote QMP
protocol flow with elisions, but otherwise defers to the JSON lexer.

To utilize this lexer for the existing QAPI documentation, we need them
to conform to a standard so that they lex and render correctly. Once the
QMP lexer is active for examples, errant QMP/JSON will produce warning
messages and fail the build.

Fix any invalid JSON found in QAPI documentation (identified by
attempting to lex all examples as QMP; see subsequent commits). Further,
the QMP lexer still supports elisions, but they must be represented as
the value "...", so three examples have been adjusted to support that
format here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/control.json   | 3 ++-
 qapi/machine.json   | 2 +-
 qapi/migration.json | 2 +-
 qapi/misc.json      | 3 ++-
 qapi/net.json       | 6 +++---
 qapi/rocker.json    | 2 +-
 qapi/ui.json        | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 6bdbf077c2e..10c906fa0e7 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -145,7 +145,8 @@
 #             },
 #             {
 #                "name":"system_powerdown"
-#             }
+#             },
+#             ...
 #          ]
 #        }
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 453feb93473..172b38e343e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1057,7 +1057,7 @@
 #            "vcpus-count": 1 },
 #          { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
 #            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
-#        ]}'
+#        ]}
 #
 #     For pc machine type started with -smp 1,maxcpus=2:
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 470f746cc5f..7d4b567eb59 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2087,7 +2087,7 @@
 # Example:
 #
 #     -> {"execute": "calc-dirty-rate", "arguments": {"calc-time": 1,
-#                                                     'sample-pages': 512} }
+#                                                     "sample-pages": 512} }
 #     <- { "return": {} }
 #
 #     Measure dirty rate using dirty bitmap for 500 milliseconds:
diff --git a/qapi/misc.json b/qapi/misc.json
index ec30e5c570a..4b41e15dcd4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -287,7 +287,8 @@
 #
 # Example:
 #
-#     -> { "execute": "get-win32-socket", "arguments": { "info": "abcd123..", fdname": "skclient" } }
+#     -> { "execute": "get-win32-socket",
+#          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
 #     <- { "return": {} }
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
diff --git a/qapi/net.json b/qapi/net.json
index 0f5a259475e..c19df435a53 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1003,9 +1003,9 @@
 #
 # Example:
 #
-#     <- { 'event': 'NETDEV_STREAM_DISCONNECTED',
-#          'data': {'netdev-id': 'netdev0'},
-#          'timestamp': {'seconds': 1663330937, 'microseconds': 526695} }
+#     <- { "event": "NETDEV_STREAM_DISCONNECTED",
+#          "data": {"netdev-id": "netdev0"},
+#          "timestamp": {"seconds": 1663330937, "microseconds": 526695} }
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5635cf174fd..f5225eb62cc 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -250,7 +250,7 @@
 #                       "action": {"goto-tbl": 10},
 #                       "mask": {"in-pport": 4294901760}
 #                      },
-#                      {...more...},
+#                      {...},
 #        ]}
 ##
 { 'command': 'query-rocker-of-dpa-flows',
diff --git a/qapi/ui.json b/qapi/ui.json
index f610bce118a..c12f5292571 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -361,7 +361,7 @@
 #                    "channel-id": 0,
 #                    "tls": false
 #                 },
-#                 [ ... more channels follow ... ]
+#                 ...
 #              ]
 #           }
 #        }
-- 
2.44.0


