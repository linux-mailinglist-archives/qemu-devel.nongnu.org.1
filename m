Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A8A366EA
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Feb 2025 21:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2KE-00047A-Fn; Fri, 14 Feb 2025 15:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KB-00046R-Nd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2K9-0001ya-8q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gdyGCh2dz9H4adBNlVDJUKRfJK6pdw2YnRUuj8wqQE=;
 b=fpPhBmQ29PSgampX4Eqz4dRWmOzwycvjKuRJTLMzJxfHIi9QjTgan954a/1zgUuvKh5tOL
 uc+WP0lNEHIecOMaTHFjJV6JZ1tafDKt7D593qGhnFiforwnzl8w365YWAdYzJlfIsvGsO
 GpmzY4owZqZuszj3wS1VxIcV34D28A0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-w7VgUASBM-eqejd_IwSPoA-1; Fri,
 14 Feb 2025 15:30:06 -0500
X-MC-Unique: w7VgUASBM-eqejd_IwSPoA-1
X-Mimecast-MFC-AGG-ID: w7VgUASBM-eqejd_IwSPoA_1739565005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06152180087B
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:05 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D0D61800352; Fri, 14 Feb 2025 20:30:02 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 04/11] qapi: golang: Generate struct types
Date: Fri, 14 Feb 2025 21:29:37 +0100
Message-ID: <20250214202944.69897-5-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

This patch handles QAPI struct types and generates the equivalent
types in Go. The following patch adds extra logic when a member of the
struct has a Type that can take JSON Null value (e.g: StrOrNull in
QEMU)

The highlights of this implementation are:

1. Generating a Go struct that requires a @base type, the @base type
   fields are copied over to the Go struct. The advantage of this
   approach is to not have embed structs in any of the QAPI types.
   Note that embedding a @base type is recursive, that is, if the
   @base type has a @base, all of those fields will be copied over.

2. About the Go struct's fields:

   i) They can be either by Value or Reference.

  ii) Every field that is marked as optional in the QAPI specification
      are translated to Reference fields in its Go structure. This
      design decision is the most straightforward way to check if a
      given field was set or not. Exception only for types that can
      take JSON Null value.

 iii) Mandatory fields are always by Value with the exception of QAPI
      arrays, which are handled by Reference (to a block of memory) by
      Go.

  iv) All the fields are named with Uppercase due Golang's export
      convention.

Example:

qapi:
 | ##
 | # @BlockdevCreateOptionsFile:
 | #
 | # Driver specific image creation options for file.
 | #
 | # @filename: Filename for the new image file
 | #
 | # @size: Size of the virtual disk in bytes
 | #
 | # @preallocation: Preallocation mode for the new image (default: off;
 | #     allowed values: off, falloc (if CONFIG_POSIX_FALLOCATE), full
 | #     (if CONFIG_POSIX))
 | #
 | # @nocow: Turn off copy-on-write (valid only on btrfs; default: off)
 | #
 | # @extent-size-hint: Extent size hint to add to the image file; 0 for
 | #     not adding an extent size hint (default: 1 MB, since 5.1)
 | #
 | # Since: 2.12
 | ##
 | { 'struct': 'BlockdevCreateOptionsFile',
 |   'data': { 'filename':             'str',
 |             'size':                 'size',
 |             '*preallocation':       'PreallocMode',
 |             '*nocow':               'bool',
 |             '*extent-size-hint':    'size'} }

go:
 | // Driver specific image creation options for file.
 | //
 | // Since: 2.12
 | type BlockdevCreateOptionsFile struct {
 | 	// Filename for the new image file
 | 	Filename string `json:"filename"`
 | 	// Size of the virtual disk in bytes
 | 	Size uint64 `json:"size"`
 | 	// Preallocation mode for the new image (default: off; allowed
 | 	// values: off, falloc (if CONFIG_POSIX_FALLOCATE), full (if
 | 	// CONFIG_POSIX))
 | 	Preallocation *PreallocMode `json:"preallocation,omitempty"`
 | 	// Turn off copy-on-write (valid only on btrfs; default: off)
 | 	Nocow *bool `json:"nocow,omitempty"`
 | 	// Extent size hint to add to the image file; 0 for not adding an
 | 	// extent size hint (default: 1 MB, since 5.1)
 | 	ExtentSizeHint *uint64 `json:"extent-size-hint,omitempty"`
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 193 +++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index aa1a18a501..e8a47b4a1e 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -150,6 +150,14 @@ def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis.write(output_dir)
 
 
+def qapi_name_is_base(name: str) -> bool:
+    return qapi_name_is_object(name) and name.endswith("-base")
+
+
+def qapi_name_is_object(name: str) -> bool:
+    return name.startswith("q_obj_")
+
+
 def qapi_to_field_name(name: str) -> str:
     return name.title().replace("_", "").replace("-", "")
 
@@ -158,6 +166,27 @@ def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
+def qapi_to_go_type_name(name: str) -> str:
+    # We want to keep CamelCase for Golang types. We want to avoid removing
+    # already set CameCase names while fixing uppercase ones, eg:
+    # 1) q_obj_SocketAddress_base -> SocketAddressBase
+    # 2) q_obj_WATCHDOG-arg -> WatchdogArg
+
+    if qapi_name_is_object(name):
+        # Remove q_obj_ prefix
+        name = name[6:]
+
+    # Handle CamelCase
+    words = list(name.replace("_", "-").split("-"))
+    name = words[0]
+    if name.islower() or name.isupper():
+        name = name.title()
+
+    name += "".join(word.title() for word in words[1:])
+
+    return name
+
+
 def qapi_schema_type_to_go_type(qapitype: str) -> str:
     schema_types_to_go = {
         "str": "string",
@@ -325,6 +354,131 @@ def generate_struct_type(
     return f"""{type_doc}{with_type} struct{members}"""
 
 
+def get_struct_field(
+    self: QAPISchemaGenGolangVisitor,
+    qapi_name: str,
+    qapi_type_name: str,
+    field_doc: str,
+    is_optional: bool,
+    is_variant: bool,
+) -> dict[str:str]:
+    field = qapi_to_field_name(qapi_name)
+    member_type = qapi_schema_type_to_go_type(qapi_type_name)
+
+    optional = ""
+    if is_optional:
+        if member_type not in self.accept_null_types:
+            optional = ",omitempty"
+
+    # Use pointer to type when field is optional
+    isptr = "*" if is_optional and member_type[0] not in "*[" else ""
+
+    fieldtag = (
+        '`json:"-"`' if is_variant else f'`json:"{qapi_name}{optional}"`'
+    )
+    arg = {
+        "name": f"{field}",
+        "type": f"{isptr}{member_type}",
+        "tag": f"{fieldtag}",
+    }
+    if field_doc != "":
+        arg["doc"] = field_doc
+
+    return arg
+
+
+def recursive_base(
+    self: QAPISchemaGenGolangVisitor,
+    base: Optional[QAPISchemaObjectType],
+) -> List[dict[str:str]]:
+    fields: List[dict[str:str]] = []
+
+    if not base:
+        return fields
+
+    if base.base is not None:
+        embed_base = self.schema.lookup_entity(base.base.name)
+        fields = recursive_base(self, embed_base)
+
+    doc = self.docmap.get(base.name, None)
+    _, docfields = qapi_to_golang_struct_docs(doc)
+
+    for member in base.local_members:
+        field_doc = docfields.get(member.name, "")
+        field = get_struct_field(
+            self,
+            member.name,
+            member.type.name,
+            field_doc,
+            member.optional,
+            False,
+        )
+        fields.append(field)
+
+    return fields
+
+
+# Helper function that is used for most of QAPI types
+def qapi_to_golang_struct(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    info: Optional[QAPISourceInfo],
+    __: QAPISchemaIfCond,
+    ___: List[QAPISchemaFeature],
+    base: Optional[QAPISchemaObjectType],
+    members: List[QAPISchemaObjectTypeMember],
+    variants: Optional[QAPISchemaVariants],
+    indent: int = 0,
+    doc_enabled: bool = True,
+) -> str:
+    fields = recursive_base(self, base)
+
+    doc = self.docmap.get(name, None)
+    type_doc, docfields = qapi_to_golang_struct_docs(doc)
+    if not doc_enabled:
+        type_doc = ""
+
+    if members:
+        for member in members:
+            field_doc = docfields.get(member.name, "") if doc_enabled else ""
+            field = get_struct_field(
+                self,
+                member.name,
+                member.type.name,
+                field_doc,
+                member.optional,
+                False,
+            )
+            fields.append(field)
+
+    exists = {}
+    if variants:
+        fields.append({"comment": "Variants fields"})
+        for variant in variants.variants:
+            if variant.type.is_implicit():
+                continue
+
+            exists[variant.name] = True
+            field_doc = docfields.get(variant.name, "") if doc_enabled else ""
+            field = get_struct_field(
+                self,
+                variant.name,
+                variant.type.name,
+                field_doc,
+                True,
+                True,
+            )
+            fields.append(field)
+
+    type_name = qapi_to_go_type_name(name)
+    content = string_to_code(
+        generate_struct_type(
+            type_name, type_doc=type_doc, args=fields, indent=indent
+        )
+    )
+    return content
+
+
 def generate_template_alternate(
     self: QAPISchemaGenGolangVisitor,
     name: str,
@@ -434,6 +588,7 @@ def __init__(self, _: str):
         types = {
             "alternate": ["encoding/json", "errors", "fmt"],
             "enum": [],
+            "struct": ["encoding/json"],
         }
 
         self.schema: QAPISchema
@@ -441,6 +596,7 @@ def __init__(self, _: str):
         self.duplicate = list(gofiles)
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
+        self.structs: dict[str, str] = {}
         self.accept_null_types = []
         self.docmap = {}
 
@@ -477,6 +633,7 @@ def visit_end(self) -> None:
         del self.schema
         self.types["enum"] += generate_content_from_dict(self.enums)
         self.types["alternate"] += generate_content_from_dict(self.alternates)
+        self.types["struct"] += generate_content_from_dict(self.structs)
 
     def visit_object_type(
         self,
@@ -488,7 +645,41 @@ def visit_object_type(
         members: List[QAPISchemaObjectTypeMember],
         branches: Optional[QAPISchemaBranches],
     ) -> None:
-        pass
+        # Do not handle anything besides struct.
+        if (
+            name == self.schema.the_empty_object_type.name
+            or not isinstance(name, str)
+            or info.defn_meta not in ["struct"]
+        ):
+            return
+
+        # Base structs are embed
+        if qapi_name_is_base(name):
+            return
+
+        # visit all inner objects as well, they are not going to be
+        # called by python's generator.
+        if branches:
+            for branch in branches.variants:
+                assert isinstance(branch.type, QAPISchemaObjectType)
+                self.visit_object_type(
+                    self,
+                    branch.type.name,
+                    branch.type.info,
+                    branch.type.ifcond,
+                    branch.type.base,
+                    branch.type.local_members,
+                    branch.type.branches,
+                )
+
+        # Save generated Go code to be written later
+        if info.defn_meta == "struct":
+            assert name not in self.structs
+            self.structs[name] = string_to_code(
+                qapi_to_golang_struct(
+                    self, name, info, ifcond, features, base, members, branches
+                )
+            )
 
     def visit_alternate_type(
         self,
-- 
2.48.1


