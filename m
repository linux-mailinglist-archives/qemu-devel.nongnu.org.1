Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B91706CA9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ1v-0004JY-1r; Wed, 17 May 2023 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1o-0004IM-MQ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1k-0000Cj-S8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0pr2ChHQLJbsFM0R9hKUAxOGLGa4aWmEdcxjnP+Nm0=;
 b=g9bl7P8d7ZAB2PjQ1TLu/ZxmUupMYWSaGEbqDQvyqkKGIPFkEBt3mAPBp6lcYkbqapUJoO
 Ivebw0vmnb0UoaZcNfPX5sAkFcJ94ddHuc3S/MLjkOdT3PXU0Dx0II4v1pF3KkOW2w3NYz
 hiuOQiGr+yu4OIYlKU/s0E74bLj6+Z8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567--DNpaDKdP32r0YXkHoxH3Q-1; Wed, 17 May 2023 11:25:18 -0400
X-MC-Unique: -DNpaDKdP32r0YXkHoxH3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B209E1C12F95;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB2863F7E;
 Wed, 17 May 2023 15:25:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 251CB21E669C; Wed, 17 May 2023 17:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 2/5] docs/interop: Convert qmp-spec.txt to rST
Date: Wed, 17 May 2023 17:25:13 +0200
Message-Id: <20230517152516.1884640-4-armbru@redhat.com>
In-Reply-To: <20230517152516.1884640-1-armbru@redhat.com>
References: <20230517152516.1884640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert the qmp-spec.txt document to restructuredText.
Notable points about the conversion:
 * numbers at the start of section headings are removed, to match
   the style of the rest of the manual
 * cross-references to other sections or documents are hyperlinked
 * various formatting tweaks (notably the examples, which need the
   -> and <- prefixed so the QMP code-block lexer will accept them)
 * English prose fixed in a few places

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230515162245.3964307-2-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst                |   3 +-
 docs/interop/index.rst                      |   1 +
 docs/interop/{qmp-spec.txt => qmp-spec.rst} | 337 +++++++++++---------
 qapi/control.json                           |   4 +-
 qapi/qapi-schema.json                       |   3 +-
 qobject/json-lexer.c                        |   2 +-
 python/qemu/qmp/models.py                   |   8 +-
 python/qemu/qmp/qmp_client.py               |   4 +-
 8 files changed, 199 insertions(+), 163 deletions(-)
 rename docs/interop/{qmp-spec.txt => qmp-spec.rst} (55%)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 5618a80378..7f78183cd4 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -545,7 +545,8 @@ Member 'allow-oob' declares whether the command supports out-of-band
  { 'command': 'migrate_recover',
    'data': { 'uri': 'str' }, 'allow-oob': true }
 
-See qmp-spec.txt for out-of-band execution syntax and semantics.
+See the :doc:`/interop/qmp-spec` for out-of-band execution syntax
+and semantics.
 
 Commands supporting out-of-band execution can still be executed
 in-band.
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 6351ff9ba6..ed65395bfb 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -15,6 +15,7 @@ are useful for making QEMU interoperate with other software.
    dbus-display
    live-block-operations
    pr-helper
+   qmp-spec
    qemu-ga
    qemu-ga-ref
    qemu-qmp-ref
diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.rst
similarity index 55%
rename from docs/interop/qmp-spec.txt
rename to docs/interop/qmp-spec.rst
index b0e8351d5b..bfad570a16 100644
--- a/docs/interop/qmp-spec.txt
+++ b/docs/interop/qmp-spec.rst
@@ -1,24 +1,26 @@
-                      QEMU Machine Protocol Specification
+..
+    Copyright (C) 2009-2016 Red Hat, Inc.
 
-0. About This Document
-======================
+    This work is licensed under the terms of the GNU GPL, version 2 or
+    later. See the COPYING file in the top-level directory.
 
-Copyright (C) 2009-2016 Red Hat, Inc.
 
-This work is licensed under the terms of the GNU GPL, version 2 or
-later. See the COPYING file in the top-level directory.
+===================================
+QEMU Machine Protocol Specification
+===================================
 
-1. Introduction
-===============
-
-This document specifies the QEMU Machine Protocol (QMP), a JSON-based
+The QEMU Machine Protocol (QMP) is a JSON-based
 protocol which is available for applications to operate QEMU at the
 machine-level.  It is also in use by the QEMU Guest Agent (QGA), which
 is available for host applications to interact with the guest
-operating system.
+operating system. This page specifies the general format of
+the protocol; details of the commands and data structures can
+be found in the :doc:`qemu-qmp-ref` and the :doc:`qemu-ga-ref`.
 
-2. Protocol Specification
-=========================
+.. contents::
+
+Protocol Specification
+======================
 
 This section details the protocol format. For the purpose of this
 document, "Server" is either QEMU or the QEMU Guest Agent, and
@@ -30,9 +32,7 @@ following format:
     json-DATA-STRUCTURE-NAME
 
 Where DATA-STRUCTURE-NAME is any valid JSON data structure, as defined
-by the JSON standard:
-
-http://www.ietf.org/rfc/rfc8259.txt
+by the `JSON standard <http://www.ietf.org/rfc/rfc8259.txt>`_.
 
 The server expects its input to be encoded in UTF-8, and sends its
 output encoded in ASCII.
@@ -45,83 +45,89 @@ important unless specifically documented otherwise.  Repeating a key
 within a json-object gives unpredictable results.
 
 Also for convenience, the server will accept an extension of
-'single-quoted' strings in place of the usual "double-quoted"
+``'single-quoted'`` strings in place of the usual ``"double-quoted"``
 json-string, and both input forms of strings understand an additional
-escape sequence of "\'" for a single quote. The server will only use
+escape sequence of ``\'`` for a single quote. The server will only use
 double quoting on output.
 
-2.1 General Definitions
------------------------
-
-2.1.1 All interactions transmitted by the Server are json-objects, always
-      terminating with CRLF
-
-2.1.2 All json-objects members are mandatory when not specified otherwise
-
-2.2 Server Greeting
+General Definitions
 -------------------
 
+All interactions transmitted by the Server are json-objects, always
+terminating with CRLF.
+
+All json-objects members are mandatory when not specified otherwise.
+
+Server Greeting
+---------------
+
 Right when connected the Server will issue a greeting message, which signals
 that the connection has been successfully established and that the Server is
 ready for capabilities negotiation (for more information refer to section
-'4. Capabilities Negotiation').
+`Capabilities Negotiation`_).
 
 The greeting message format is:
 
-{ "QMP": { "version": json-object, "capabilities": json-array } }
+.. code-block::
 
- Where,
+  { "QMP": { "version": json-object, "capabilities": json-array } }
 
-- The "version" member contains the Server's version information (the format
-  is the same of the query-version command)
-- The "capabilities" member specify the availability of features beyond the
+Where:
+
+- The ``version`` member contains the Server's version information (the format
+  is the same as for the query-version command).
+- The ``capabilities`` member specifies the availability of features beyond the
   baseline specification; the order of elements in this array has no
   particular significance.
 
-2.2.1 Capabilities
-------------------
+Capabilities
+------------
 
 Currently supported capabilities are:
 
-- "oob": the QMP server supports "out-of-band" (OOB) command
-  execution, as described in section "2.3.1 Out-of-band execution".
+``oob``
+  the QMP server supports "out-of-band" (OOB) command
+  execution, as described in section `Out-of-band execution`_.
 
-2.3 Issuing Commands
---------------------
+Issuing Commands
+----------------
 
 The format for command execution is:
 
-{ "execute": json-string, "arguments": json-object, "id": json-value }
+.. code-block::
+
+  { "execute": json-string, "arguments": json-object, "id": json-value }
 
 or
 
-{ "exec-oob": json-string, "arguments": json-object, "id": json-value }
+.. code-block::
 
- Where,
+  { "exec-oob": json-string, "arguments": json-object, "id": json-value }
 
-- The "execute" or "exec-oob" member identifies the command to be
+Where:
+
+- The ``execute`` or ``exec-oob`` member identifies the command to be
   executed by the server.  The latter requests out-of-band execution.
-- The "arguments" member is used to pass any arguments required for the
+- The ``arguments`` member is used to pass any arguments required for the
   execution of the command, it is optional when no arguments are
   required. Each command documents what contents will be considered
-  valid when handling the json-argument
-- The "id" member is a transaction identification associated with the
+  valid when handling the json-argument.
+- The ``id`` member is a transaction identification associated with the
   command execution, it is optional and will be part of the response
-  if provided.  The "id" member can be any json-value.  A json-number
+  if provided.  The ``id`` member can be any json-value.  A json-number
   incremented for each successive command works fine.
 
-The actual commands are documented in the QEMU QMP reference manual
-docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
+The actual commands are documented in the :doc:`qemu-qmp-ref`.
 
-2.3.1 Out-of-band execution
----------------------------
+Out-of-band execution
+---------------------
 
 The server normally reads, executes and responds to one command after
 the other.  The client therefore receives command responses in issue
 order.
 
-With out-of-band execution enabled via capability negotiation (section
-4.), the server reads and queues commands as they arrive.  It executes
+With out-of-band execution enabled via `capabilities negotiation`_,
+the server reads and queues commands as they arrive.  It executes
 commands from the queue one after the other.  Commands executed
 out-of-band jump the queue: the command get executed right away,
 possibly overtaking prior in-band commands.  The client may therefore
@@ -129,8 +135,8 @@ receive such a command's response before responses from prior in-band
 commands.
 
 To be able to match responses back to their commands, the client needs
-to pass "id" with out-of-band commands.  Passing it with all commands
-is recommended for clients that accept capability "oob".
+to pass ``id`` with out-of-band commands.  Passing it with all commands
+is recommended for clients that accept capability ``oob``.
 
 If the client sends in-band commands faster than the server can
 execute them, the server will stop reading requests until the request
@@ -140,57 +146,61 @@ To ensure commands to be executed out-of-band get read and executed,
 the client should have at most eight in-band commands in flight.
 
 Only a few commands support out-of-band execution.  The ones that do
-have "allow-oob": true in output of query-qmp-schema.
+have ``"allow-oob": true`` in the output of ``query-qmp-schema``.
 
-2.4 Commands Responses
-----------------------
+Commands Responses
+------------------
 
 There are two possible responses which the Server will issue as the result
 of a command execution: success or error.
 
-As long as the commands were issued with a proper "id" field, then the
-same "id" field will be attached in the corresponding response message
+As long as the commands were issued with a proper ``id`` field, then the
+same ``id`` field will be attached in the corresponding response message
 so that requests and responses can match.  Clients should drop all the
-responses that have an unknown "id" field.
+responses that have an unknown ``id`` field.
 
-2.4.1 success
--------------
+Success
+-------
 
 The format of a success response is:
 
-{ "return": json-value, "id": json-value }
+.. code-block::
 
- Where,
+  { "return": json-value, "id": json-value }
 
-- The "return" member contains the data returned by the command, which
+Where:
+
+- The ``return`` member contains the data returned by the command, which
   is defined on a per-command basis (usually a json-object or
   json-array of json-objects, but sometimes a json-number, json-string,
   or json-array of json-strings); it is an empty json-object if the
-  command does not return data
-- The "id" member contains the transaction identification associated
-  with the command execution if issued by the Client
+  command does not return data.
+- The ``id`` member contains the transaction identification associated
+  with the command execution if issued by the Client.
 
-2.4.2 error
------------
+Error
+-----
 
 The format of an error response is:
 
-{ "error": { "class": json-string, "desc": json-string }, "id": json-value }
+.. code-block::
 
- Where,
+  { "error": { "class": json-string, "desc": json-string }, "id": json-value }
 
-- The "class" member contains the error class name (eg. "GenericError")
-- The "desc" member is a human-readable error message. Clients should
+Where:
+
+- The ``class`` member contains the error class name (eg. ``"GenericError"``).
+- The ``desc`` member is a human-readable error message. Clients should
   not attempt to parse this message.
-- The "id" member contains the transaction identification associated with
-  the command execution if issued by the Client
+- The ``id`` member contains the transaction identification associated with
+  the command execution if issued by the Client.
 
-NOTE: Some errors can occur before the Server is able to read the "id" member,
-in these cases the "id" member will not be part of the error response, even
+NOTE: Some errors can occur before the Server is able to read the ``id`` member;
+in these cases the ``id`` member will not be part of the error response, even
 if provided by the client.
 
-2.5 Asynchronous events
------------------------
+Asynchronous events
+-------------------
 
 As a result of state changes, the Server may send messages unilaterally
 to the Client at any time, when not in the middle of any other
@@ -198,44 +208,45 @@ response. They are called "asynchronous events".
 
 The format of asynchronous events is:
 
-{ "event": json-string, "data": json-object,
-  "timestamp": { "seconds": json-number, "microseconds": json-number } }
+.. code-block::
 
- Where,
+  { "event": json-string, "data": json-object,
+    "timestamp": { "seconds": json-number, "microseconds": json-number } }
 
-- The "event" member contains the event's name
-- The "data" member contains event specific data, which is defined in a
-  per-event basis, it is optional
-- The "timestamp" member contains the exact time of when the event
+Where:
+
+- The ``event`` member contains the event's name.
+- The ``data`` member contains event specific data, which is defined in a
+  per-event basis. It is optional.
+- The ``timestamp`` member contains the exact time of when the event
   occurred in the Server. It is a fixed json-object with time in
   seconds and microseconds relative to the Unix Epoch (1 Jan 1970); if
   there is a failure to retrieve host time, both members of the
   timestamp will be set to -1.
 
-The actual asynchronous events are documented in the QEMU QMP
-reference manual docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.
+The actual asynchronous events are documented in the :doc:`qemu-qmp-ref`.
 
 Some events are rate-limited to at most one per second.  If additional
 "similar" events arrive within one second, all but the last one are
 dropped, and the last one is delayed.  "Similar" normally means same
 event type.
 
-2.6 Forcing the JSON parser into known-good state
--------------------------------------------------
+Forcing the JSON parser into known-good state
+---------------------------------------------
 
 Incomplete or invalid input can leave the server's JSON parser in a
 state where it can't parse additional commands.  To get it back into
 known-good state, the client should provoke a lexical error.
 
 The cleanest way to do that is sending an ASCII control character
-other than '\t' (horizontal tab), '\r' (carriage return), or '\n' (new
-line).
+other than ``\t`` (horizontal tab), ``\r`` (carriage return), or
+``\n`` (new line).
 
 Sadly, older versions of QEMU can fail to flag this as an error.  If a
 client needs to deal with them, it should send a 0xFF byte.
 
-2.7 QGA Synchronization
------------------------
+QGA Synchronization
+-------------------
 
 When a client connects to QGA over a transport lacking proper
 connection semantics such as virtio-serial, QGA may have read partial
@@ -243,86 +254,106 @@ input from a previous client.  The client needs to force QGA's parser
 into known-good state using the previous section's technique.
 Moreover, the client may receive output a previous client didn't read.
 To help with skipping that output, QGA provides the
-'guest-sync-delimited' command.  Refer to its documentation for
+``guest-sync-delimited`` command.  Refer to its documentation for
 details.
 
 
-3. QMP Examples
-===============
+QMP Examples
+============
 
 This section provides some examples of real QMP usage, in all of them
-"C" stands for "Client" and "S" stands for "Server".
+``->`` marks text sent by the Client and ``<-`` marks replies by the Server.
 
-3.1 Server greeting
--------------------
+.. admonition:: Example
 
-S: { "QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
-     "package": "v3.0.0"}, "capabilities": ["oob"] } }
+  Server greeting
 
-3.2 Capabilities negotiation
-----------------------------
+  .. code-block:: QMP
 
-C: { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
-S: { "return": {}}
+    <- { "QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
+         "package": "v3.0.0"}, "capabilities": ["oob"] } }
 
-3.3 Simple 'stop' execution
----------------------------
+.. admonition:: Example
 
-C: { "execute": "stop" }
-S: { "return": {} }
+  Capabilities negotiation
 
-3.4 KVM information
--------------------
+  .. code-block:: QMP
 
-C: { "execute": "query-kvm", "id": "example" }
-S: { "return": { "enabled": true, "present": true }, "id": "example"}
+    -> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
+    <- { "return": {}}
 
-3.5 Parsing error
-------------------
+.. admonition:: Example
 
-C: { "execute": }
-S: { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
+  Simple 'stop' execution
 
-3.6 Powerdown event
--------------------
+  .. code-block:: QMP
 
-S: { "timestamp": { "seconds": 1258551470, "microseconds": 802384 },
-    "event": "POWERDOWN" }
+    -> { "execute": "stop" }
+    <- { "return": {} }
 
-3.7 Out-of-band execution
--------------------------
+.. admonition:: Example
 
-C: { "exec-oob": "migrate-pause", "id": 42 }
-S: { "id": 42,
-     "error": { "class": "GenericError",
-      "desc": "migrate-pause is currently only supported during postcopy-active state" } }
+  KVM information
+
+  .. code-block:: QMP
+
+    -> { "execute": "query-kvm", "id": "example" }
+    <- { "return": { "enabled": true, "present": true }, "id": "example"}
+
+.. admonition:: Example
+
+  Parsing error
+
+  .. code-block:: QMP
+
+    -> { "execute": }
+    <- { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
+
+.. admonition:: Example
+
+  Powerdown event
+
+  .. code-block:: QMP
+
+    <- { "timestamp": { "seconds": 1258551470, "microseconds": 802384 },
+        "event": "POWERDOWN" }
+
+.. admonition:: Example
+
+  Out-of-band execution
+
+  .. code-block:: QMP
+
+    -> { "exec-oob": "migrate-pause", "id": 42 }
+    <- { "id": 42,
+         "error": { "class": "GenericError",
+          "desc": "migrate-pause is currently only supported during postcopy-active state" } }
 
 
-4. Capabilities Negotiation
-===========================
+Capabilities Negotiation
+========================
 
 When a Client successfully establishes a connection, the Server is in
 Capabilities Negotiation mode.
 
-In this mode only the qmp_capabilities command is allowed to run, all
-other commands will return the CommandNotFound error. Asynchronous
+In this mode only the ``qmp_capabilities`` command is allowed to run; all
+other commands will return the ``CommandNotFound`` error. Asynchronous
 messages are not delivered either.
 
-Clients should use the qmp_capabilities command to enable capabilities
-advertised in the Server's greeting (section '2.2 Server Greeting') they
-support.
+Clients should use the ``qmp_capabilities`` command to enable capabilities
+advertised in the `Server Greeting`_ which they support.
 
-When the qmp_capabilities command is issued, and if it does not return an
-error, the Server enters in Command mode where capabilities changes take
-effect, all commands (except qmp_capabilities) are allowed and asynchronous
+When the ``qmp_capabilities`` command is issued, and if it does not return an
+error, the Server enters Command mode where capabilities changes take
+effect, all commands (except ``qmp_capabilities``) are allowed and asynchronous
 messages are delivered.
 
-5 Compatibility Considerations
-==============================
+Compatibility Considerations
+============================
 
 All protocol changes or new features which modify the protocol format in an
 incompatible way are disabled by default and will be advertised by the
-capabilities array (section '2.2 Server Greeting'). Thus, Clients can check
+capabilities array (in the `Server Greeting`_). Thus, Clients can check
 that array and enable the capabilities they support.
 
 The QMP Server performs a type check on the arguments to a command.  It
@@ -337,12 +368,12 @@ However, Clients must not assume any particular:
 
 - Length of json-arrays
 - Size of json-objects; in particular, future versions of QEMU may add
-  new keys and Clients should be able to ignore them.
+  new keys and Clients should be able to ignore them
 - Order of json-object members or json-array elements
 - Amount of errors generated by a command, that is, new errors can be added
   to any existing command in newer versions of the Server
 
-Any command or member name beginning with "x-" is deemed experimental,
+Any command or member name beginning with ``x-`` is deemed experimental,
 and may be withdrawn or changed in an incompatible manner in a future
 release.
 
@@ -350,8 +381,8 @@ Of course, the Server does guarantee to send valid JSON.  But apart from
 this, a Client should be "conservative in what they send, and liberal in
 what they accept".
 
-6. Downstream extension of QMP
-==============================
+Downstream extension of QMP
+===========================
 
 We recommend that downstream consumers of QEMU do *not* modify QMP.
 Management tools should be able to support both upstream and downstream
@@ -363,23 +394,25 @@ avoid modifying QMP.  Both upstream and downstream need to take care to
 preserve long-term compatibility and interoperability.
 
 To help with that, QMP reserves JSON object member names beginning with
-'__' (double underscore) for downstream use ("downstream names").  This
+``__`` (double underscore) for downstream use ("downstream names").  This
 means upstream will never use any downstream names for its commands,
 arguments, errors, asynchronous events, and so forth.
 
-Any new names downstream wishes to add must begin with '__'.  To
+Any new names downstream wishes to add must begin with ``__``.  To
 ensure compatibility with other downstreams, it is strongly
-recommended that you prefix your downstream names with '__RFQDN_' where
+recommended that you prefix your downstream names with ``__RFQDN_`` where
 RFQDN is a valid, reverse fully qualified domain name which you
 control.  For example, a qemu-kvm specific monitor command would be:
 
+.. code-block::
+
     (qemu) __org.linux-kvm_enable_irqchip
 
-Downstream must not change the server greeting (section 2.2) other than
+Downstream must not change the `server greeting`_ other than
 to offer additional capabilities.  But see below for why even that is
 discouraged.
 
-Section '5 Compatibility Considerations' applies to downstream as well
+The section `Compatibility Considerations`_ applies to downstream as well
 as to upstream, obviously.  It follows that downstream must behave
 exactly like upstream for any input not containing members with
 downstream names ("downstream members"), except it may add members
diff --git a/qapi/control.json b/qapi/control.json
index 6a7c5af882..a91fa33407 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -27,7 +27,7 @@
 # Notes: This command is valid exactly when first connecting: it must
 #     be issued before any other command will be accepted, and will
 #     fail once the monitor is accepting other commands.  (see qemu
-#     docs/interop/qmp-spec.txt)
+#     docs/interop/qmp-spec.rst)
 #
 #     The QMP client needs to explicitly enable QMP capabilities,
 #     otherwise all the QMP capabilities will be turned off by
@@ -46,7 +46,7 @@
 # connection, used for agreeing on particular QMP extension behaviors.
 #
 # @oob: QMP ability to support out-of-band requests.  (Please refer to
-#     qmp-spec.txt for more information on OOB)
+#     qmp-spec.rst for more information on OOB)
 #
 # Since: 2.12
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 31e0b36454..6594afba31 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -29,7 +29,8 @@
 #   -> data issued by the Client
 #   <- Server data response
 #
-# Please, refer to the QMP specification (docs/interop/qmp-spec.txt)
+# Please refer to the
+# :doc:`QEMU Machine Protocol Specification </interop/qmp-spec>`
 # for detailed information on the Server command and response formats.
 ##
 
diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 632320d72d..51341d96e4 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -139,7 +139,7 @@ static const uint8_t json_lexer[][256] =  {
          * bytes '\xFE', '\xFF'.  Structural characters and line
          * endings are promising resynchronization points.  Clients
          * may use the others to force the JSON parser into known-good
-         * state; see docs/interop/qmp-spec.txt.
+         * state; see docs/interop/qmp-spec.rst.
          */
         [0 ... 0x1F] = IN_START | LOOKAHEAD,
         [0x20 ... 0xFD] = IN_RECOVERY,
diff --git a/python/qemu/qmp/models.py b/python/qemu/qmp/models.py
index de87f87804..da52848d5a 100644
--- a/python/qemu/qmp/models.py
+++ b/python/qemu/qmp/models.py
@@ -54,7 +54,7 @@ def __repr__(self) -> str:
 
 class Greeting(Model):
     """
-    Defined in qmp-spec.txt, section 2.2, "Server Greeting".
+    Defined in qmp-spec.rst, section "Server Greeting".
 
     :param raw: The raw Greeting object.
     :raise KeyError: If any required fields are absent.
@@ -82,7 +82,7 @@ def _asdict(self) -> Dict[str, object]:
 
 class QMPGreeting(Model):
     """
-    Defined in qmp-spec.txt, section 2.2, "Server Greeting".
+    Defined in qmp-spec.rst, section "Server Greeting".
 
     :param raw: The raw QMPGreeting object.
     :raise KeyError: If any required fields are absent.
@@ -104,7 +104,7 @@ def __init__(self, raw: Mapping[str, Any]):
 
 class ErrorResponse(Model):
     """
-    Defined in qmp-spec.txt, section 2.4.2, "error".
+    Defined in qmp-spec.rst, section "Error".
 
     :param raw: The raw ErrorResponse object.
     :raise KeyError: If any required fields are absent.
@@ -126,7 +126,7 @@ def __init__(self, raw: Mapping[str, Any]):
 
 class ErrorInfo(Model):
     """
-    Defined in qmp-spec.txt, section 2.4.2, "error".
+    Defined in qmp-spec.rst, section "Error".
 
     :param raw: The raw ErrorInfo object.
     :raise KeyError: If any required fields are absent.
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index 9d73ae6e7a..2a817f9db3 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -369,7 +369,7 @@ async def _on_message(self, msg: Message) -> None:
             # This is very likely a server parsing error.
             # It doesn't inherently belong to any pending execution.
             # Instead of performing clever recovery, just terminate.
-            # See "NOTE" in qmp-spec.txt, section 2.4.2
+            # See "NOTE" in qmp-spec.rst, section "Error".
             raise ServerParseError(
                 ("Server sent an error response without an ID, "
                  "but there are no ID-less executions pending. "
@@ -377,7 +377,7 @@ async def _on_message(self, msg: Message) -> None:
                 msg
             )
 
-        # qmp-spec.txt, section 2.4:
+        # qmp-spec.rst, section "Commands Responses":
         # 'Clients should drop all the responses
         # that have an unknown "id" field.'
         self.logger.log(
-- 
2.39.2


