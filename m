Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F3A5BF87
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 12:45:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxst-0000IZ-CM; Tue, 11 Mar 2025 07:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxr3-0003SP-Jv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqE-0006YL-60
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eCWReU6bUM5pOJMVwkYiN6cPZRJruZljXLIq66RMAc=;
 b=IgAyWubopLFul8qt0bAh0bT4WSfTKfofZbc9xBC/4W3eEIkSniJg4oNmtNXtn6Rkd+M7uq
 +mJkqqszGZXf/5tEFUCfIhXe+qbaPt43pk+L4DQW/QwnUMUpo50TLtr0HExcsTvo7V3w6r
 q/q+W2jMk5EQNH8gzkzvvwPo578Vjtg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-ugtc8FH-Nqq8n5zF_jP2RA-1; Tue,
 11 Mar 2025 07:32:03 -0400
X-MC-Unique: ugtc8FH-Nqq8n5zF_jP2RA-1
X-Mimecast-MFC-AGG-ID: ugtc8FH-Nqq8n5zF_jP2RA_1741692722
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4E6A19560B0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 228C21955BCB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:32:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0A6021E60E5; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 59/61] docs: add qapi-domain syntax documentation
Date: Tue, 11 Mar 2025 12:31:35 +0100
Message-ID: <20250311113137.1277125-60-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Who documents the documentation?

Me, I guess.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-63-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/index-build.rst |   1 +
 docs/devel/qapi-domain.rst | 670 +++++++++++++++++++++++++++++++++++++
 2 files changed, 671 insertions(+)
 create mode 100644 docs/devel/qapi-domain.rst

diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 0745c81a26..3f3cb21b9b 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -12,4 +12,5 @@ some of the basics if you are adding new files and targets to the build.
    kconfig
    docs
    qapi-code-gen
+   qapi-domain
    control-flow-integrity
diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
new file mode 100644
index 0000000000..1475870ca6
--- /dev/null
+++ b/docs/devel/qapi-domain.rst
@@ -0,0 +1,670 @@
+======================
+The Sphinx QAPI Domain
+======================
+
+An extension to the `rST syntax
+<https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_
+in Sphinx is provided by the QAPI Domain, located in
+``docs/sphinx/qapi_domain.py``. This extension is analogous to the
+`Python Domain
+<https://www.sphinx-doc.org/en/master/usage/domains/python.html>`_
+included with Sphinx, but provides special directives and roles
+speciically for annotating and documenting QAPI definitions
+specifically.
+
+A `Domain
+<https://www.sphinx-doc.org/en/master/usage/domains/index.html>`_
+provides a set of special rST directives and cross-referencing roles to
+Sphinx for understanding rST markup written to document a specific
+language. By itself, this QAPI extension is only sufficient to parse rST
+markup written by hand; the `autodoc
+<https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html>`_
+functionality is provided elsewhere, in ``docs/sphinx/qapidoc.py``, by
+the "Transmogrifier".
+
+It is not expected that any developer nor documentation writer would
+never need to write *nor* read these special rST forms. However, in the
+event that something needs to be debugged, knowing the syntax of the
+domain is quite handy. This reference may also be useful as a guide for
+understanding the QAPI Domain extension code itself. Although most of
+these forms will not be needed for documentation writing purposes,
+understanding the cross-referencing syntax *will* be helpful when
+writing rST documentation elsewhere, or for enriching the body of
+QAPIDoc blocks themselves.
+
+
+Concepts
+========
+
+The QAPI Domain itself provides no mechanisms for reading the QAPI
+Schema or generating documentation from code that exists. It is merely
+the rST syntax used to describe things. For instance, the Sphinx Python
+domain adds syntax like ``:py:func:`` for describing Python functions in
+documentation, but it's the autodoc module that is responsible for
+reading python code and generating such syntax. QAPI is analagous here:
+qapidoc.py is responsible for reading the QAPI Schema and generating rST
+syntax, and qapi_domain.py is responsible for translating that special
+syntax and providing APIs for Sphinx internals.
+
+In other words:
+
+qapi_domain.py adds syntax like ``.. qapi:command::`` to Sphinx, and
+qapidoc.py transforms the documentation in ``qapi/*.json`` into rST
+using directives defined by the domain.
+
+Or even shorter:
+
+``:py:`` is to ``:qapi:`` as *autodoc* is to *qapidoc*.
+
+
+Info Field Lists
+================
+
+`Field lists
+<https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#field-lists>`_
+are a standard syntax in reStructuredText. Sphinx `extends that syntax
+<https://www.sphinx-doc.org/en/master/usage/domains/python.html#info-field-lists>`_
+to give certain field list entries special meaning and parsing to, for
+example, add cross-references. The QAPI Domain takes advantage of this
+field list extension to document things like Arguments, Members, Values,
+and so on.
+
+The special parsing and handling of info field lists in Sphinx is provided by
+three main classes; Field, GroupedField, and TypedField. The behavior
+and formatting for each configured field list entry in the domain
+changes depending on which class is used.
+
+Field:
+  * Creates an ungrouped field: i.e., each entry will create its own
+    section and they will not be combined.
+  * May *optionally* support an argument.
+  * May apply cross-reference roles to *either* the argument *or* the
+    content body, both, or neither.
+
+This is used primarily for entries which are not expected to be
+repeated, i.e., items that may only show up at most once. The QAPI
+domain uses this class for "Errors" section.
+
+GroupedField:
+  * Creates a grouped field: i.e. multiple adjacent entries will be
+    merged into one section, and the content will form a bulleted list.
+  * *Must* take an argument.
+  * May optionally apply a cross-reference role to the argument, but not
+    the body.
+  * Can be configured to remove the bulleted list if there is only a
+    single entry.
+  * All items will be generated with the form: "argument -- body"
+
+This is used for entries which are expected to be repeated, but aren't
+expected to have two arguments, i.e. types without names, or names
+without types. The QAPI domain uses this class for features, returns,
+and enum values.
+
+TypedField:
+  * Creates a grouped, typed field. Multiple adjacent entres will be
+    merged into one section, and the content will form a bulleted list.
+  * *Must* take at least one argument, but supports up to two -
+    nominally, a name and a type.
+  * May optionally apply a cross-reference role to the type or the name
+    argument, but not the body.
+  * Can be configured to remove the bulleted list if there is only a
+    single entry.
+  * All items will be generated with the form "name (type) -- body"
+
+This is used for entries that are expected to be repeated and will have
+a name, a type, and a description. The QAPI domain uses this class for
+arguments, alternatives, and members. Wherever type names are referenced
+below, They must be a valid, documented type that will be
+cross-referenced in the HTML output; or one of the built-in JSON types
+(string, number, int, boolean, null, value, q_empty).
+
+
+``:feat:``
+----------
+
+Document a feature attached to a QAPI definition.
+
+:availability: This field list is available in the body of Command,
+               Event, Enum, Object and Alternate directives.
+:syntax: ``:feat name: Lorem ipsum, dolor sit amet...``
+:type: `sphinx.util.docfields.GroupedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.GroupedField.html?private=1>`_
+
+Example::
+
+   .. qapi:object:: BlockdevOptionsVirtioBlkVhostVdpa
+      :since: 7.2
+      :ifcond: CONFIG_BLKIO
+
+      Driver specific block device options for the virtio-blk-vhost-vdpa
+      backend.
+
+   :memb string path: path to the vhost-vdpa character device.
+   :feat fdset: Member ``path`` supports the special "/dev/fdset/N" path
+       (since 8.1)
+
+
+``:arg:``
+---------
+
+Document an argument to a QAPI command.
+
+:availability: This field list is only available in the body of the
+               Command directive.
+:syntax: ``:arg type name: description``
+:type: `sphinx.util.docfields.TypedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.TypedField.html?private=1>`_
+
+
+Example::
+
+   .. qapi:command:: job-pause
+      :since: 3.0
+
+      Pause an active job.
+
+      This command returns immediately after marking the active job for
+      pausing.  Pausing an already paused job is an error.
+
+      The job will pause as soon as possible, which means transitioning
+      into the PAUSED state if it was RUNNING, or into STANDBY if it was
+      READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
+
+      Cancelling a paused job automatically resumes it.
+
+      :arg string id: The job identifier.
+
+
+``:error:``
+-----------
+
+Document the error condition(s) of a QAPI command.
+
+:availability: This field list is only available in the body of the
+               Command directive.
+:syntax: ``:error: Lorem ipsum dolor sit amet ...``
+:type: `sphinx.util.docfields.Field
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.Field.html?private=1>`_
+
+The format of the :errors: field list description is free-form rST. The
+alternative spelling ":errors:" is also permitted, but strictly
+analogous.
+
+Example::
+
+   .. qapi:command:: block-job-set-speed
+      :since: 1.1
+
+      Set maximum speed for a background block operation.
+
+      This command can only be issued when there is an active block job.
+
+      Throttling can be disabled by setting the speed to 0.
+
+      :arg string device: The job identifier.  This used to be a device
+          name (hence the name of the parameter), but since QEMU 2.7 it
+          can have other values.
+      :arg int speed: the maximum speed, in bytes per second, or 0 for
+          unlimited.  Defaults to 0.
+      :error:
+          - If no background operation is active on this device,
+            DeviceNotActive
+
+
+``:return:``
+-------------
+
+Document the return type(s) and value(s) of a QAPI command.
+
+:availability: This field list is only available in the body of the
+               Command directive.
+:syntax: ``:return type: Lorem ipsum dolor sit amet ...``
+:type: `sphinx.util.docfields.GroupedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.GroupedField.html?private=1>`_
+
+
+Example::
+
+   .. qapi:command:: query-replay
+      :since: 5.2
+
+      Retrieve the record/replay information.  It includes current
+      instruction count which may be used for ``replay-break`` and
+      ``replay-seek`` commands.
+
+      :return ReplayInfo: record/replay information.
+
+      .. qmp-example::
+
+          -> { "execute": "query-replay" }
+          <- { "return": {
+                 "mode": "play", "filename": "log.rr", "icount": 220414 }
+             }
+
+
+``:value:``
+-----------
+
+Document a possible value for a QAPI enum.
+
+:availability: This field list is only available in the body of the Enum
+               directive.
+:syntax: ``:value name: Lorem ipsum, dolor sit amet ...``
+:type: `sphinx.util.docfields.GroupedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.GroupedField.html?private=1>`_
+
+Example::
+
+   .. qapi:enum:: QapiErrorClass
+      :since: 1.2
+
+      QEMU error classes
+
+      :value GenericError: this is used for errors that don't require a specific
+          error class.  This should be the default case for most errors
+      :value CommandNotFound: the requested command has not been found
+      :value DeviceNotActive: a device has failed to be become active
+      :value DeviceNotFound: the requested device has not been found
+      :value KVMMissingCap: the requested operation can't be fulfilled because a
+          required KVM capability is missing
+
+
+``:alt:``
+------------
+
+Document a possible branch for a QAPI alternate.
+
+:availability: This field list is only available in the body of the
+               Alternate directive.
+:syntax: ``:alt type name: Lorem ipsum, dolor sit amet ...``
+:type: `sphinx.util.docfields.TypedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.TypedField.html?private=1>`_
+
+As a limitation of Sphinx, we must document the "name" of the branch in
+addition to the type, even though this information is not visible on the
+wire in the QMP protocol format. This limitation *may* be lifted at a
+future date.
+
+Example::
+
+   .. qapi:alternate:: StrOrNull
+      :since: 2.10
+
+      This is a string value or the explicit lack of a string (null
+      pointer in C).  Intended for cases when 'optional absent' already
+      has a different meaning.
+
+       :alt string s: the string value
+       :alt null n: no string value
+
+
+``:memb:``
+----------
+
+Document a member of an Event or Object.
+
+:availability: This field list is available in the body of Event or
+               Object directives.
+:syntax: ``:memb type name: Lorem ipsum, dolor sit amet ...``
+:type: `sphinx.util.docfields.TypedField
+       <https://pydoc.dev/sphinx/latest/sphinx.util.docfields.TypedField.html?private=1>`_
+
+This is fundamentally the same as ``:arg:`` and ``:alt:``, but uses the
+"Members" phrasing for Events and Objects (Structs and Unions).
+
+Example::
+
+   .. qapi:event:: JOB_STATUS_CHANGE
+      :since: 3.0
+
+      Emitted when a job transitions to a different status.
+
+      :memb string id: The job identifier
+      :memb JobStatus status: The new job status
+
+
+Arbitrary field lists
+---------------------
+
+Other field list names, while valid rST syntax, are prohibited inside of
+QAPI directives to help prevent accidental misspellings of info field
+list names. If you want to add a new arbitrary "non-value-added" field
+list to QAPI documentation, you must add the field name to the allow
+list in ``docs/conf.py``
+
+For example::
+
+   qapi_allowed_fields = {
+       "see also",
+   }
+
+Will allow you to add arbitrary field lists in QAPI directives::
+
+   .. qapi:command:: x-fake-command
+
+      :see also: Lorem ipsum, dolor sit amet ...
+
+
+Cross-references
+================
+
+Cross-reference `roles
+<https://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html>`_
+in the QAPI domain are modeled closely after the `Python
+cross-referencing syntax
+<https://www.sphinx-doc.org/en/master/usage/domains/python.html#cross-referencing-python-objects>`_.
+
+QAPI definitions can be referenced using the standard `any
+<https://www.sphinx-doc.org/en/master/usage/referencing.html#role-any>`_
+role cross-reference syntax, such as with ```query-blockstats```.  In
+the event that disambiguation is needed, cross-references can also be
+written using a number of explicit cross-reference roles:
+
+* ``:qapi:mod:`block-core``` -- Reference a QAPI module. The link will
+  take you to the beginning of that section in the documentation.
+* ``:qapi:cmd:`query-block``` -- Reference a QAPI command.
+* ``:qapi:event:`JOB_STATUS_CHANGE``` -- Reference a QAPI event.
+* ``:qapi:enum:`QapiErrorClass``` -- Reference a QAPI enum.
+* ``:qapi:obj:`BlockdevOptionsVirtioBlkVhostVdpa`` -- Reference a QAPI
+  object (struct or union)
+* ``:qapi:alt:`StrOrNull``` -- Reference a QAPI alternate.
+* ``:qapi:type:`BlockDirtyInfo``` -- Reference *any* QAPI type; this
+  excludes modules, commands, and events.
+* ``:qapi:any:`block-job-set-speed``` -- Reference absolutely any QAPI entity.
+
+Type arguments in info field lists are converted into references as if
+you had used the ``:qapi:type:`` role. All of the special syntax below
+applies to both info field lists and standalone explicit
+cross-references.
+
+
+Type decorations
+----------------
+
+Type names in references can be surrounded by brackets, like
+``[typename]``, to indicate an array of that type.  The cross-reference
+will apply only to the type name between the brackets. For example;
+``:qapi:type:`[Qcow2BitmapInfoFlags]``` renders to:
+:qapi:type:`[Qcow2BitmapInfoFlags]`
+
+To indicate an optional argument/member in a field list, the type name
+can be suffixed with ``?``. The cross-reference will be transformed to
+"type, Optional" with the link applying only to the type name. For
+example; ``:qapi:type:`BitmapSyncMode?``` renders to:
+:qapi:type:`BitmapSyncMode?`
+
+
+Namespaces
+----------
+
+Mimicking the `Python domain target specification syntax
+<https://www.sphinx-doc.org/en/master/usage/domains/python.html#target-specification>`_,
+QAPI allows you to specify the fully qualified path for a data
+type. QAPI enforces globally unique names, so it's unlikely you'll need
+this specific feature, but it may be extended in the near future to
+allow referencing identically named commands and data types from
+different utilities; i.e. QEMU Storage Daemon vs QMP.
+
+* A module can be explicitly provided;
+  ``:qapi:type:`block-core.BitmapSyncMode``` will render to:
+  :qapi:type:`block-core.BitmapSyncMode`
+* If you don't want to display the "fully qualified" name, it can be
+  prefixed with a tilde; ``:qapi:type:`~block-core.BitmapSyncMode```
+  will render to: :qapi:type:`~block-core.BitmapSyncMode`
+
+
+Custom link text
+----------------
+
+The name of a cross-reference link can be explicitly overridden like
+`most stock Sphinx references
+<https://www.sphinx-doc.org/en/master/usage/referencing.html#syntax>`_
+using the ``custom text <target>`` syntax.
+
+For example, ``:qapi:cmd:`Merge dirty bitmaps
+<block-dirty-bitmap-merge>``` will render as: :qapi:cmd:`Merge dirty
+bitmaps <block-dirty-bitmap-merge>`
+
+
+Directives
+==========
+
+The QAPI domain adds a number of custom directives for documenting
+various QAPI/QMP entities. The syntax is plain rST, and follows this
+general format::
+
+  .. qapi:directive:: argument
+     :option:
+     :another-option: with an argument
+
+     Content body, arbitrary rST is allowed here.
+
+
+Sphinx standard options
+-----------------------
+
+All QAPI directives inherit a number of `standard options
+<https://www.sphinx-doc.org/en/master/usage/domains/index.html#basic-markup>`_
+from Sphinx's ObjectDescription class.
+
+The dashed spellings of the below options were added in Sphinx 7.2, the
+undashed spellings are currently retained as aliases, but will be
+removed in a future version.
+
+* ``:no-index:`` and ``:noindex:`` -- Do not add this item into the
+  Index, and do not make it available for cross-referencing.
+* ``no-index-entry:`` and ``:noindexentry:`` -- Do not add this item
+  into the Index, but allow it to be cross-referenced.
+* ``no-contents-entry`` and ``:nocontentsentry:`` -- Exclude this item
+  from the Table of Contents.
+* ``no-typesetting`` -- Create TOC, Index and cross-referencing
+  entities, but don't actually display the content.
+
+
+QAPI standard options
+---------------------
+
+All QAPI directives -- *except* for module -- support these common options.
+
+* ``:module: modname`` -- Borrowed from the Python domain, this option allows
+  you to override the module association of a given definition.
+* ``:since: x.y`` -- Allows the documenting of "Since" information, which is
+  displayed in the signature bar.
+* ``:ifcond: CONDITION`` -- Allows the documenting of conditional availability
+  information, which is displayed in an eyecatch just below the
+  signature bar.
+* ``:deprecated:`` -- Adds an eyecatch just below the signature bar that
+  advertises that this definition is deprecated and should be avoided.
+* ``:unstable:`` -- Adds an eyecatch just below the signature bar that
+  advertises that this definition is unstable and should not be used in
+  production code.
+
+
+qapi:module
+-----------
+
+The ``qapi:module`` directive marks the start of a QAPI module. It may have
+a content body, but it can be omitted. All subsequent QAPI directives
+are associated with the most recent module; this effects their "fully
+qualified" name, but has no other effect.
+
+Example::
+
+   .. qapi:module:: block-core
+
+      Welcome to the block-core module!
+
+Will be rendered as:
+
+.. qapi:module:: block-core
+   :noindex:
+
+   Welcome to the block-core module!
+
+
+qapi:command
+------------
+
+This directive documents a QMP command. It may use any of the standard
+Sphinx or QAPI options, and the documentation body may contain
+``:arg:``, ``:feat:``, ``:error:``, or ``:return:`` info field list
+entries.
+
+Example::
+
+  .. qapi:command:: x-fake-command
+     :since: 42.0
+     :unstable:
+
+     This command is fake, so it can't hurt you!
+
+     :arg int foo: Your favorite number.
+     :arg string? bar: Your favorite season.
+     :return [string]: A lovely computer-written poem for you.
+
+
+Will be rendered as:
+
+  .. qapi:command:: x-fake-command
+     :noindex:
+     :since: 42.0
+     :unstable:
+
+     This command is fake, so it can't hurt you!
+
+     :arg int foo: Your favorite number.
+     :arg string? bar: Your favorite season.
+     :return [string]: A lovely computer-written poem for you.
+
+
+qapi:event
+----------
+
+This directive documents a QMP event. It may use any of the standard
+Sphinx or QAPI options, and the documentation body may contain
+``:memb:`` or ``:feat:`` info field list entries.
+
+Example::
+
+  .. qapi:event:: COMPUTER_IS_RUINED
+     :since: 0.1
+     :deprecated:
+
+     This event is emitted when your computer is *extremely* ruined.
+
+     :memb string reason: Diagnostics as to what caused your computer to
+        be ruined.
+     :feat sadness: When present, the diagnostic message will also
+        explain how sad the computer is as a result of your wrongdoings.
+
+Will be rendered as:
+
+.. qapi:event:: COMPUTER_IS_RUINED
+   :noindex:
+   :since: 0.1
+   :deprecated:
+
+   This event is emitted when your computer is *extremely* ruined.
+
+   :memb string reason: Diagnostics as to what caused your computer to
+      be ruined.
+   :feat sadness: When present, the diagnostic message will also explain
+      how sad the computer is as a result of your wrongdoings.
+
+
+qapi:enum
+---------
+
+This directive documents a QAPI enum. It may use any of the standard
+Sphinx or QAPI options, and the documentation body may contain
+``:value:`` or ``:feat:`` info field list entries.
+
+Example::
+
+  .. qapi:enum:: Mood
+     :ifcond: LIB_PERSONALITY
+
+     This enum represents your virtual machine's current mood!
+
+     :value Happy: Your VM is content and well-fed.
+     :value Hungry: Your VM needs food.
+     :value Melancholic: Your VM is experiencing existential angst.
+     :value Petulant: Your VM is throwing a temper tantrum.
+
+Will be rendered as:
+
+.. qapi:enum:: Mood
+   :noindex:
+   :ifcond: LIB_PERSONALITY
+
+   This enum represents your virtual machine's current mood!
+
+   :value Happy: Your VM is content and well-fed.
+   :value Hungry: Your VM needs food.
+   :value Melancholic: Your VM is experiencing existential angst.
+   :value Petulant: Your VM is throwing a temper tantrum.
+
+
+qapi:object
+-----------
+
+This directive documents a QAPI structure or union and represents a QMP
+object. It may use any of the standard Sphinx or QAPI options, and the
+documentation body may contain ``:memb:`` or ``:feat:`` info field list
+entries.
+
+Example::
+
+  .. qapi:object:: BigBlobOfStuff
+
+     This object has a bunch of disparate and unrelated things in it.
+
+     :memb int Birthday: Your birthday, represented in seconds since the
+                         UNIX epoch.
+     :memb [string] Fav-Foods: A list of your favorite foods.
+     :memb boolean? Bizarre-Docs: True if the documentation reference
+        should be strange.
+
+Will be rendered as:
+
+.. qapi:object:: BigBlobOfStuff
+   :noindex:
+
+   This object has a bunch of disparate and unrelated things in it.
+
+   :memb int Birthday: Your birthday, represented in seconds since the
+                       UNIX epoch.
+   :memb [string] Fav-Foods: A list of your favorite foods.
+   :memb boolean? Bizarre-Docs: True if the documentation reference
+      should be strange.
+
+
+qapi:alternate
+--------------
+
+This directive documents a QAPI alternate. It may use any of the
+standard Sphinx or QAPI options, and the documentation body may contain
+``:alt:`` or ``:feat:`` info field list entries.
+
+Example::
+
+  .. qapi:alternate:: ErrorCode
+
+     This alternate represents an Error Code from the VM.
+
+     :alt int ec: An error code, like the type you're used to.
+     :alt string em: An expletive-laced error message, if your
+        computer is feeling particularly cranky and tired of your
+        antics.
+
+Will be rendered as:
+
+.. qapi:alternate:: ErrorCode
+   :noindex:
+
+   This alternate represents an Error Code from the VM.
+
+   :alt int ec: An error code, like the type you're used to.
+   :alt string em: An expletive-laced error message, if your
+      computer is feeling particularly cranky and tired of your
+      antics.
-- 
2.48.1


