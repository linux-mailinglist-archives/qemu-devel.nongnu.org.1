Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066EA706CA5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:26:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ25-0004Ks-Ff; Wed, 17 May 2023 11:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1o-0004IK-Eo
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1l-0000Ct-Lm
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMI7CZSXRo3W+b1jK1Xj5yQhN8tN2c5PtJoXQaigiHU=;
 b=A4NIZFksGEtfy0Hvt3cjcdSbTPiFo7gdhCiwhkZNylYKT4FKj42KnKEX+0iLjk8Z7HGjiu
 dlS+bFVLWrak9VRJkHAEqLs/4w2h/2iPxoM4D++nCglTD8Gv+ZZa/iXc7HXADmLWHYY2/L
 cvsX4n7dNf6/tqQkINx+w6mwsFLR8zA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-B3VozZW5PEC-UgY2rIQmCw-1; Wed, 17 May 2023 11:25:19 -0400
X-MC-Unique: B3VozZW5PEC-UgY2rIQmCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8CA01C12F91;
 Wed, 17 May 2023 15:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C9E663F7E;
 Wed, 17 May 2023 15:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29B2B21F9816; Wed, 17 May 2023 17:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 4/5] docs/interop: Delete qmp-intro.txt
Date: Wed, 17 May 2023 17:25:15 +0200
Message-Id: <20230517152516.1884640-6-armbru@redhat.com>
In-Reply-To: <20230517152516.1884640-1-armbru@redhat.com>
References: <20230517152516.1884640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

qmp-intro.txt is quite small and provides very little information
that isn't already in the documentation elsewhere.  Fold the example
command lines into qemu-options.hx, and delete the now-unneeded plain
text document.

While we're touching the qemu-options.hx documentation text,
wordsmith it a little bit and improve the rST formatting.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230515162245.3964307-4-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/qmp-intro.txt | 88 --------------------------------------
 qemu-options.hx            | 28 +++++++++---
 2 files changed, 22 insertions(+), 94 deletions(-)
 delete mode 100644 docs/interop/qmp-intro.txt

diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
deleted file mode 100644
index 1c745a7af0..0000000000
--- a/docs/interop/qmp-intro.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-                          QEMU Machine Protocol
-                          =====================
-
-Introduction
-------------
-
-The QEMU Machine Protocol (QMP) allows applications to operate a
-QEMU instance.
-
-QMP is JSON[1] based and features the following:
-
-- Lightweight, text-based, easy to parse data format
-- Asynchronous messages support (ie. events)
-- Capabilities Negotiation
-
-For detailed information on QMP's usage, please, refer to the following files:
-
-o qmp-spec.txt      QEMU Machine Protocol current specification
-o qemu-qmp-ref.html QEMU QMP commands and events (auto-generated at build-time)
-
-[1] https://www.json.org
-
-Usage
------
-
-You can use the -qmp option to enable QMP. For example, the following
-makes QMP available on localhost port 4444:
-
-$ qemu [...] -qmp tcp:localhost:4444,server=on,wait=off
-
-However, for more flexibility and to make use of more options, the -mon
-command-line option should be used. For instance, the following example
-creates one HMP instance (human monitor) on stdio and one QMP instance
-on localhost port 4444:
-
-$ qemu [...] -chardev stdio,id=mon0 -mon chardev=mon0,mode=readline \
-             -chardev socket,id=mon1,host=localhost,port=4444,server=on,wait=off \
-             -mon chardev=mon1,mode=control,pretty=on
-
-Please, refer to QEMU's manpage for more information.
-
-Simple Testing
---------------
-
-To manually test QMP one can connect with telnet and issue commands by hand:
-
-$ telnet localhost 4444
-Trying 127.0.0.1...
-Connected to localhost.
-Escape character is '^]'.
-{
-    "QMP": {
-        "version": {
-            "qemu": {
-                "micro": 0,
-                "minor": 0,
-                "major": 3
-            },
-            "package": "v3.0.0"
-        },
-        "capabilities": [
-            "oob"
-        ]
-    }
-}
-
-{ "execute": "qmp_capabilities" }
-{
-    "return": {
-    }
-}
-
-{ "execute": "query-status" }
-{
-    "return": {
-        "status": "prelaunch", 
-        "singlestep": false, 
-        "running": false
-    }
-}
-
-Please refer to docs/interop/qemu-qmp-ref.* for a complete command
-reference, generated from qapi/qapi-schema.json.
-
-QMP wiki page
--------------
-
-https://wiki.qemu.org/QMP
diff --git a/qemu-options.hx b/qemu-options.hx
index 30690d9c3f..e4566149ee 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4170,26 +4170,42 @@ DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
     QEMU_ARCH_ALL)
 SRST
 ``-qmp dev``
-    Like -monitor but opens in 'control' mode.
+    Like ``-monitor`` but opens in 'control' mode. For example, to make
+    QMP available on localhost port 4444::
+
+        -qmp tcp:localhost:4444,server=on,wait=off
+
+    Not all options are configurable via this syntax; for maximum
+    flexibility use the ``-mon`` option and an accompanying ``-chardev``.
+
 ERST
 DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
     "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
     QEMU_ARCH_ALL)
 SRST
 ``-qmp-pretty dev``
-    Like -qmp but uses pretty JSON formatting.
+    Like ``-qmp`` but uses pretty JSON formatting.
 ERST
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
     "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
 SRST
 ``-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]``
-    Setup monitor on chardev name. ``mode=control`` configures 
-    a QMP monitor (a JSON RPC-style protocol) and it is not the
-    same as HMP, the human monitor that has a "(qemu)" prompt.
-    ``pretty`` is only valid when ``mode=control``, 
+    Set up a monitor connected to the chardev ``name``.
+    QEMU supports two monitors: the Human Monitor Protocol
+    (HMP; for human interaction), and the QEMU Monitor Protocol
+    (QMP; a JSON RPC-style protocol).
+    The default is HMP; ``mode=control`` selects QMP instead.
+    ``pretty`` is only valid when ``mode=control``,
     turning on JSON pretty printing to ease
     human reading and debugging.
+
+    For example::
+
+      -chardev socket,id=mon1,host=localhost,port=4444,server=on,wait=off \
+      -mon chardev=mon1,mode=control,pretty=on
+
+    enables the QMP monitor on localhost port 4444 with pretty-printing.
 ERST
 
 DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
-- 
2.39.2


