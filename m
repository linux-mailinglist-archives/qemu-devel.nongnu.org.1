Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B37B02DE
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSgH-0002Sr-Nm; Wed, 27 Sep 2023 07:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSgB-0002Qs-A5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qlSg6-0001gE-7o
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 07:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695813961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GwKpX3stjEyNOpO5fFkOHehLuyvDb76vCGkP1116b0=;
 b=WZbgb6c4TQwsHLjA0aXkTkLWkZUtoo8zR9VkW1HXbHwa7r3EOi1KvjmQEmzGoCIYCDc3oD
 npQZhuvGCc4vsl4dskbUlU9mKpUK0zl6TKxG7keQImu2RLSIRASZ1OHKHy6MXiFYm/+ccR
 NQV1cdWnpk5RwrLYD/C4t5BBgsgoEUI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-BS2kd1h7PM2YbmN2j8tSLQ-1; Wed, 27 Sep 2023 07:25:59 -0400
X-MC-Unique: BS2kd1h7PM2YbmN2j8tSLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A30A9811E7B
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 11:25:59 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.224.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 919841054FC2;
 Wed, 27 Sep 2023 11:25:58 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v1 9/9] docs: add notes on Golang code generator
Date: Wed, 27 Sep 2023 13:25:44 +0200
Message-ID: <20230927112544.85011-10-victortoso@redhat.com>
In-Reply-To: <20230927112544.85011-1-victortoso@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

The goal of this patch is converge discussions into a documentation,
to make it easy and explicit design decisions, known issues and what
else might help a person interested in how the Go module is generated.

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 docs/devel/qapi-golang-code-gen.rst | 341 ++++++++++++++++++++++++++++
 1 file changed, 341 insertions(+)
 create mode 100644 docs/devel/qapi-golang-code-gen.rst

diff --git a/docs/devel/qapi-golang-code-gen.rst b/docs/devel/qapi-golang-code-gen.rst
new file mode 100644
index 0000000000..2a91f8fc60
--- /dev/null
+++ b/docs/devel/qapi-golang-code-gen.rst
@@ -0,0 +1,341 @@
+==========================
+QAPI Golang code generator
+==========================
+
+..
+   Copyright (C) 2023 Red Hat, Inc.
+
+   This work is licensed under the terms of the GNU GPL, version 2 or
+   later.  See the COPYING file in the top-level directory.
+
+
+Introduction
+============
+
+This document provides information of how the generated Go code maps
+with the QAPI specification, clarifying design decisions when needed.
+
+
+Scope of the generated Go code
+==============================
+
+The scope is limited to data structures that can interpret and be used
+to generate valid QMP messages. These data structures are generated
+from a QAPI schema and should be able to handle QMP messages from the
+same schema.
+
+The generated Go code is a Go module with data structs that uses Go
+standard library `encoding/json`, implementing its field tags and
+Marshal interface whenever needed.
+
+
+QAPI types to Go structs
+========================
+
+Enum
+----
+
+Enums are mapped as strings in Go, using a specified string type per
+Enum to help with type safety in the Go application.
+
+.. code-block:: JSON
+    { 'enum': 'HostMemPolicy',
+      'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
+
+.. code-block:: go
+    type HostMemPolicy string
+
+    const (
+        HostMemPolicyDefault    HostMemPolicy = "default"
+        HostMemPolicyPreferred  HostMemPolicy = "preferred"
+        HostMemPolicyBind       HostMemPolicy = "bind"
+        HostMemPolicyInterleave HostMemPolicy = "interleave"
+    )
+
+
+Struct
+------
+
+The mapping between a QAPI struct in Go struct is very straightforward.
+ - Each member of the QAPI struct has its own field in a Go struct.
+ - Optional members are pointers type with 'omitempty' field tag set
+
+One important design decision was to _not_ embed base struct, copying
+the base members to the original struct. This reduces the complexity
+for the Go application.
+
+.. code-block:: JSON
+    { 'struct': 'BlockExportOptionsNbdBase',
+      'data': { '*name': 'str', '*description': 'str' } }
+
+    { 'struct': 'BlockExportOptionsNbd',
+      'base': 'BlockExportOptionsNbdBase',
+      'data': { '*bitmaps': ['BlockDirtyBitmapOrStr'],
+                '*allocation-depth': 'bool' } }
+
+.. code-block:: go
+    type BlockExportOptionsNbd struct {
+        Name        *string `json:"name,omitempty"`
+        Description *string `json:"description,omitempty"`
+
+        Bitmaps         []BlockDirtyBitmapOrStr `json:"bitmaps,omitempty"`
+        AllocationDepth *bool                   `json:"allocation-depth,omitempty"`
+    }
+
+
+Union
+-----
+
+Unions in QAPI are binded to a Enum type which provides all possible
+branches of the union. The most important caveat here is that the Union
+does not need to implement all possible branches for the Enum.
+Receiving a enum value of a unimplemented branch is valid. For this
+reason, we keep a discriminator field in each Union Go struct and also
+implement the Marshal interface.
+
+As each Union Go struct type has both the discriminator field and
+optional fields, it is important to note that when converting Go struct
+to JSON, we only consider the discriminator field if no optional field
+member was set. In practice, the user should use the optional fields if
+the QAPI Union type has defined them, otherwise the user can set the
+discriminator field for the unbranched enum value.
+
+.. code-block:: JSON
+    { 'union': 'ImageInfoSpecificQCow2Encryption',
+      'base': 'ImageInfoSpecificQCow2EncryptionBase',
+      'discriminator': 'format',
+      'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
+
+.. code-block:: go
+    type ImageInfoSpecificQCow2Encryption struct {
+        Format BlockdevQcow2EncryptionFormat `json:"format"`
+
+        // Variants fields
+        Luks *QCryptoBlockInfoLUKS `json:"-"`
+    }
+
+    func (s ImageInfoSpecificQCow2Encryption) MarshalJSON() ([]byte, error) {
+        // Normal logic goes here
+        // ...
+
+        // Check for valid values without field members
+        if len(bytes) == 0 && err == nil &&
+            (s.Format == BlockdevQcow2EncryptionFormatAes) {
+            type Alias ImageInfoSpecificQCow2Encryption
+            bytes, err = json.Marshal(Alias(s))
+        }
+        // ...
+    }
+
+
+    func (s *ImageInfoSpecificQCow2Encryption) UnmarshalJSON(data []byte) error {
+        // Normal logic goes here
+        // ...
+
+        switch tmp.Format {
+        case BlockdevQcow2EncryptionFormatLuks:
+            // ...
+        default:
+            // Check for valid values without field members
+            if tmp.Format != BlockdevQcow2EncryptionFormatAes {
+                return fmt.Errorf(...)
+            }
+        }
+        return nil
+    }
+
+
+Alternate
+---------
+
+Like Unions, alternates can have a few branches. Unlike Unions, they
+don't have a discriminator field and each branch should be a different
+class of Type entirely (e.g: You can't have two branches of type int in
+one Alternate).
+
+While the marshalling is similar to Unions, the unmarshalling uses a
+try-and-error approach, trying to fit the data payload in one of the
+Alternate fields.
+
+The biggest caveat is handling Alternates that can take JSON Null as
+value. The issue lies on `encoding/json` library limitation where
+unmarshalling JSON Null data to a Go struct which has the 'omitempty'
+field that, it bypass the Marshal interface. The same happens when
+marshalling, if the field tag 'omitempty' is used, a nil pointer would
+never be translated to null JSON value.
+
+The problem being, we use pointer to type plus `omitempty` field to
+express a QAPI optional member.
+
+In order to handle JSON Null, the generator needs to do the following:
+  - Read the QAPI schema prior to generate any code and cache
+    all alternate types that can take JSON Null
+  - For all Go structs that should be considered optional and they type
+    are one of those alternates, do not set `omitempty` and implement
+    Marshal interface for this Go struct, to properly handle JSON Null
+  - In the Alternate, uses a boolean 'IsNull' to express a JSON Null
+    and implement the AbsentAlternate interface, to help sturcts know
+    if a given Alternate type should be considered Absent (not set) or
+    any other possible Value, including JSON Null.
+
+.. code-block:: JSON
+    { 'alternate': 'BlockdevRefOrNull',
+      'data': { 'definition': 'BlockdevOptions',
+                'reference': 'str',
+                'null': 'null' } }
+
+.. code-block:: go
+    type BlockdevRefOrNull struct {
+        Definition *BlockdevOptions
+        Reference  *string
+        IsNull     bool
+    }
+
+    func (s *BlockdevRefOrNull) ToAnyOrAbsent() (any, bool) {
+        if s != nil {
+            if s.IsNull {
+                return nil, false
+            } else if s.Definition != nil {
+                return *s.Definition, false
+            } else if s.Reference != nil {
+                return *s.Reference, false
+            }
+        }
+
+        return nil, true
+    }
+
+    func (s BlockdevRefOrNull) MarshalJSON() ([]byte, error) {
+        if s.IsNull {
+            return []byte("null"), nil
+        } else if s.Definition != nil {
+            return json.Marshal(s.Definition)
+        } else if s.Reference != nil {
+            return json.Marshal(s.Reference)
+        }
+        return []byte("{}"), nil
+    }
+
+    func (s *BlockdevRefOrNull) UnmarshalJSON(data []byte) error {
+        // Check for json-null first
+        if string(data) == "null" {
+            s.IsNull = true
+            return nil
+        }
+        // Check for BlockdevOptions
+        {
+            s.Definition = new(BlockdevOptions)
+            if err := StrictDecode(s.Definition, data); err == nil {
+                return nil
+            }
+            s.Definition = nil
+        }
+        // Check for string
+        {
+            s.Reference = new(string)
+            if err := StrictDecode(s.Reference, data); err == nil {
+                return nil
+            }
+            s.Reference = nil
+        }
+
+        return fmt.Errorf("Can't convert to BlockdevRefOrNull: %s", string(data))
+    }
+
+
+Event
+-----
+
+All events are mapped to its own struct with the additional
+MessageTimestamp field, for the over-the-wire 'timestamp' value.
+
+Marshaling and Unmarshaling happens over the Event interface, so users
+should use the MarshalEvent() and UnmarshalEvent() methods.
+
+.. code-block:: JSON
+    { 'event': 'SHUTDOWN',
+      'data': { 'guest': 'bool',
+                'reason': 'ShutdownCause' } }
+
+.. code-block:: go
+    type Event interface {
+        GetName() string
+        GetTimestamp() Timestamp
+    }
+
+    type ShutdownEvent struct {
+        MessageTimestamp Timestamp     `json:"-"`
+        Guest            bool          `json:"guest"`
+        Reason           ShutdownCause `json:"reason"`
+    }
+
+    func (s *ShutdownEvent) GetName() string {
+        return "SHUTDOWN"
+    }
+
+    func (s *ShutdownEvent) GetTimestamp() Timestamp {
+        return s.MessageTimestamp
+    }
+
+
+Command
+-------
+
+All commands are mapped to its own struct with the additional MessageId
+field for the optional 'id'. If the command has a boxed data struct,
+the option struct will be embed in the command struct.
+
+As commands do require a return value, every command has its own return
+type. The Command interface has a GetReturnType() method that returns a
+CommandReturn interface, to help Go application handling the data.
+
+Marshaling and Unmarshaling happens over the Command interface, so
+users should use the MarshalCommand() and UnmarshalCommand() methods.
+
+.. code-block:: JSON
+   { 'command': 'set_password',
+     'boxed': true,
+     'data': 'SetPasswordOptions' }
+
+.. code-block:: go
+    type Command interface {
+        GetId() string
+        GetName() string
+        GetReturnType() CommandReturn
+    }
+
+    // SetPasswordOptions is embed
+    type SetPasswordCommand struct {
+        SetPasswordOptions
+        MessageId string `json:"-"`
+    }
+
+    // This is an union
+    type SetPasswordOptions struct {
+        Protocol  DisplayProtocol    `json:"protocol"`
+        Password  string             `json:"password"`
+        Connected *SetPasswordAction `json:"connected,omitempty"`
+
+        // Variants fields
+        Vnc *SetPasswordOptionsVnc `json:"-"`
+    }
+
+Now an example of a command without boxed type.
+
+.. code-block:: JSON
+    { 'command': 'set_link',
+      'data': {'name': 'str', 'up': 'bool'} }
+
+.. code-block:: go
+    type SetLinkCommand struct {
+        MessageId string `json:"-"`
+        Name      string `json:"name"`
+        Up        bool   `json:"up"`
+    }
+
+Known issues
+============
+
+- Type names might not follow proper Go convention. Andrea suggested an
+  annotation to the QAPI schema that could solve it.
+  https://lists.gnu.org/archive/html/qemu-devel/2022-05/msg00127.html
-- 
2.41.0


