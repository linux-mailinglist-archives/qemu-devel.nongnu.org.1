Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98BD73FC68
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M0-0008WJ-1h; Tue, 27 Jun 2023 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lk-0008Uz-Di
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lg-00074a-A6
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFDkDp9rimF6iwnlZ/BVgfg224qyFjRqkgTrI28JCoQ=;
 b=Azf9QKs9LiUlBcPeRWaAS36b/FIJ0m9KEer8Pw7cATfSVT18Rl5VskF0QYLkCUbmT/GTRq
 vhksSnWb+i7cxadKqMC4+xPHQLPu2xq3m+/0vNZuXUNqS0rqXXML+gR0Olj5FwNGe8KU30
 ZW6omXKevxQJaucQb7Q6Xswz94wEnWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-_nNBuCAPMaCa-lPhfme8yA-1; Tue, 27 Jun 2023 09:03:09 -0400
X-MC-Unique: _nNBuCAPMaCa-lPhfme8yA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7C4B10504CF;
 Tue, 27 Jun 2023 13:03:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA3A614682FA;
 Tue, 27 Jun 2023 13:03:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 16/33] scripts: add a XML preprocessor script
Date: Tue, 27 Jun 2023 15:02:13 +0200
Message-ID: <20230627130231.1614896-17-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

gdbus-codegen doesn't support conditions or pre-processing.

Rather than duplicating D-Bus interfaces for win32 adaptation, let's
have a preprocess step, so we can have platform-specific interfaces.

The python script is based on
https://github.com/peitaosu/XML-Preprocessor, with bug fixes, some
testing and replacing lxml dependency with the built-in xml module.

This preprocessing syntax style is not very common, but is similar to
the one provided by WiX (https://wixtoolset.org/docs/v3/overview/preprocessor/)
or wixl, that we adopted in QEMU for packaging the guest agent.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-5-marcandre.lureau@redhat.com>
---
 MAINTAINERS                    |   1 +
 scripts/meson.build            |   2 +
 scripts/xml-preprocess-test.py | 136 +++++++++++++++
 scripts/xml-preprocess.py      | 293 +++++++++++++++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 scripts/xml-preprocess-test.py
 create mode 100755 scripts/xml-preprocess.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e07746ac7d..21a587ce4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3202,6 +3202,7 @@ F: docs/interop/dbus*
 F: docs/sphinx/dbus*
 F: docs/sphinx/fakedbusdoc.py
 F: tests/qtest/dbus*
+F: scripts/xml-preprocess*
 
 Seccomp
 M: Daniel P. Berrange <berrange@redhat.com>
diff --git a/scripts/meson.build b/scripts/meson.build
index 1c89e10a76..532277f5a2 100644
--- a/scripts/meson.build
+++ b/scripts/meson.build
@@ -1,3 +1,5 @@
 if stap.found()
   install_data('qemu-trace-stap', install_dir: get_option('bindir'))
 endif
+
+test('xml-preprocess', files('xml-preprocess-test.py'), suite: ['unit'])
diff --git a/scripts/xml-preprocess-test.py b/scripts/xml-preprocess-test.py
new file mode 100644
index 0000000000..dd92579969
--- /dev/null
+++ b/scripts/xml-preprocess-test.py
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2023 Red Hat, Inc.
+#
+# SPDX-License-Identifier: MIT
+"""Unit tests for xml-preprocess"""
+
+import contextlib
+import importlib
+import os
+import platform
+import subprocess
+import tempfile
+import unittest
+from io import StringIO
+
+xmlpp = importlib.import_module("xml-preprocess")
+
+
+class TestXmlPreprocess(unittest.TestCase):
+    """Tests for xml-preprocess.Preprocessor"""
+
+    def test_preprocess_xml(self):
+        with tempfile.NamedTemporaryFile(mode="w", delete=False) as temp_file:
+            temp_file.write("<root></root>")
+            temp_file_name = temp_file.name
+        result = xmlpp.preprocess_xml(temp_file_name)
+        self.assertEqual(result, "<root></root>")
+        os.remove(temp_file_name)
+
+    def test_save_xml(self):
+        with tempfile.NamedTemporaryFile(mode="w", delete=False) as temp_file:
+            temp_file_name = temp_file.name
+            xmlpp.save_xml("<root></root>", temp_file_name)
+        self.assertTrue(os.path.isfile(temp_file_name))
+        os.remove(temp_file_name)
+
+    def test_include(self):
+        with tempfile.NamedTemporaryFile(mode="w", delete=False) as inc_file:
+            inc_file.write("<included>Content from included file</included>")
+            inc_file_name = inc_file.name
+        xml_str = f"<?include {inc_file_name} ?>"
+        expected = "<included>Content from included file</included>"
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+        os.remove(inc_file_name)
+        self.assertRaises(FileNotFoundError, xpp.preprocess, xml_str)
+
+    def test_envvar(self):
+        os.environ["TEST_ENV_VAR"] = "TestValue"
+        xml_str = "<root>$(env.TEST_ENV_VAR)</root>"
+        expected = "<root>TestValue</root>"
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+        self.assertRaises(KeyError, xpp.preprocess, "$(env.UNKNOWN)")
+
+    def test_sys_var(self):
+        xml_str = "<root>$(sys.ARCH)</root>"
+        expected = f"<root>{platform.architecture()[0]}</root>"
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+        self.assertRaises(KeyError, xpp.preprocess, "$(sys.UNKNOWN)")
+
+    def test_cus_var(self):
+        xml_str = "<root>$(var.USER)</root>"
+        expected = "<root></root>"
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+        xml_str = "<?define USER=FOO?><root>$(var.USER)</root>"
+        expected = "<root>FOO</root>"
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+
+    def test_error_warning(self):
+        xml_str = "<root><?warning \"test warn\"?></root>"
+        expected = "<root></root>"
+        xpp = xmlpp.Preprocessor()
+        out = StringIO()
+        with contextlib.redirect_stdout(out):
+            result = xpp.preprocess(xml_str)
+        self.assertEqual(result, expected)
+        self.assertEqual(out.getvalue(), "[Warning]: test warn\n")
+        self.assertRaises(RuntimeError, xpp.preprocess, "<?error \"test\"?>")
+
+    def test_cmd(self):
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess('<root><?cmd "echo hello world"?></root>')
+        self.assertEqual(result, "<root>hello world</root>")
+        self.assertRaises(
+            subprocess.CalledProcessError,
+            xpp.preprocess, '<?cmd "test-unknown-cmd"?>'
+        )
+
+    def test_foreach(self):
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess(
+            '<root><?foreach x in a;b;c?>$(var.x)<?endforeach?></root>'
+        )
+        self.assertEqual(result, "<root>abc</root>")
+
+    def test_if_elseif(self):
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess('<root><?if True?>ok<?endif?></root>')
+        self.assertEqual(result, "<root>ok</root>")
+        result = xpp.preprocess('<root><?if False?>ok<?endif?></root>')
+        self.assertEqual(result, "<root></root>")
+        result = xpp.preprocess('<root><?if True?>ok<?else?>ko<?endif?></root>')
+        self.assertEqual(result, "<root>ok</root>")
+        result = xpp.preprocess('<root><?if False?>ok<?else?>ko<?endif?></root>')
+        self.assertEqual(result, "<root>ko</root>")
+        result = xpp.preprocess(
+            '<root><?if False?>ok<?elseif True?>ok2<?else?>ko<?endif?></root>'
+        )
+        self.assertEqual(result, "<root>ok2</root>")
+        result = xpp.preprocess(
+            '<root><?if False?>ok<?elseif False?>ok<?else?>ko<?endif?></root>'
+        )
+        self.assertEqual(result, "<root>ko</root>")
+
+    def test_ifdef(self):
+        xpp = xmlpp.Preprocessor()
+        result = xpp.preprocess('<root><?ifdef USER?>ok<?else?>ko<?endif?></root>')
+        self.assertEqual(result, "<root>ko</root>")
+        result = xpp.preprocess(
+            '<?define USER=FOO?><root><?ifdef USER?>ok<?else?>ko<?endif?></root>'
+        )
+        self.assertEqual(result, "<root>ok</root>")
+
+
+if __name__ == "__main__":
+    unittest.main()
diff --git a/scripts/xml-preprocess.py b/scripts/xml-preprocess.py
new file mode 100755
index 0000000000..57f1d28912
--- /dev/null
+++ b/scripts/xml-preprocess.py
@@ -0,0 +1,293 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2017-2019 Tony Su
+# Copyright (c) 2023 Red Hat, Inc.
+#
+# SPDX-License-Identifier: MIT
+#
+# Adapted from https://github.com/peitaosu/XML-Preprocessor
+#
+"""This is a XML Preprocessor which can be used to process your XML file before
+you use it, to process conditional statements, variables, iteration
+statements, error/warning, execute command, etc.
+
+## XML Schema
+
+### Include Files
+```
+<?include path/to/file ?>
+```
+
+### Variables
+```
+$(env.EnvironmentVariable)
+
+$(sys.SystemVariable)
+
+$(var.CustomVariable)
+```
+
+### Conditional Statements
+```
+<?if ?>
+
+<?ifdef ?>
+
+<?ifndef ?>
+
+<?else?>
+
+<?elseif ?>
+
+<?endif?>
+```
+
+### Iteration Statements
+```
+<?foreach VARNAME in 1;2;3?>
+    $(var.VARNAME)
+<?endforeach?>
+```
+
+### Errors and Warnings
+```
+<?error "This is error message!" ?>
+
+<?warning "This is warning message!" ?>
+```
+
+### Commands
+```
+<? cmd "echo hello world" ?>
+```
+"""
+
+import os
+import platform
+import re
+import subprocess
+import sys
+from typing import Optional
+from xml.dom import minidom
+
+
+class Preprocessor():
+    """This class holds the XML preprocessing state"""
+
+    def __init__(self):
+        self.sys_vars = {
+            "ARCH": platform.architecture()[0],
+            "SOURCE": os.path.abspath(__file__),
+            "CURRENT": os.getcwd(),
+        }
+        self.cus_vars = {}
+
+    def _pp_include(self, xml_str: str) -> str:
+        include_regex = r"(<\?include([\w\s\\/.:_-]+)\s*\?>)"
+        matches = re.findall(include_regex, xml_str)
+        for group_inc, group_xml in matches:
+            inc_file_path = group_xml.strip()
+            with open(inc_file_path, "r", encoding="utf-8") as inc_file:
+                inc_file_content = inc_file.read()
+                xml_str = xml_str.replace(group_inc, inc_file_content)
+        return xml_str
+
+    def _pp_env_var(self, xml_str: str) -> str:
+        envvar_regex = r"(\$\(env\.(\w+)\))"
+        matches = re.findall(envvar_regex, xml_str)
+        for group_env, group_var in matches:
+            xml_str = xml_str.replace(group_env, os.environ[group_var])
+        return xml_str
+
+    def _pp_sys_var(self, xml_str: str) -> str:
+        sysvar_regex = r"(\$\(sys\.(\w+)\))"
+        matches = re.findall(sysvar_regex, xml_str)
+        for group_sys, group_var in matches:
+            xml_str = xml_str.replace(group_sys, self.sys_vars[group_var])
+        return xml_str
+
+    def _pp_cus_var(self, xml_str: str) -> str:
+        define_regex = r"(<\?define\s*(\w+)\s*=\s*([\w\s\"]+)\s*\?>)"
+        matches = re.findall(define_regex, xml_str)
+        for group_def, group_name, group_var in matches:
+            group_name = group_name.strip()
+            group_var = group_var.strip().strip("\"")
+            self.cus_vars[group_name] = group_var
+            xml_str = xml_str.replace(group_def, "")
+        cusvar_regex = r"(\$\(var\.(\w+)\))"
+        matches = re.findall(cusvar_regex, xml_str)
+        for group_cus, group_var in matches:
+            xml_str = xml_str.replace(
+                group_cus,
+                self.cus_vars.get(group_var, "")
+            )
+        return xml_str
+
+    def _pp_foreach(self, xml_str: str) -> str:
+        foreach_regex = r"(<\?foreach\s+(\w+)\s+in\s+([\w;]+)\s*\?>(.*)<\?endforeach\?>)"
+        matches = re.findall(foreach_regex, xml_str)
+        for group_for, group_name, group_vars, group_text in matches:
+            group_texts = ""
+            for var in group_vars.split(";"):
+                self.cus_vars[group_name] = var
+                group_texts += self._pp_cus_var(group_text)
+            xml_str = xml_str.replace(group_for, group_texts)
+        return xml_str
+
+    def _pp_error_warning(self, xml_str: str) -> str:
+        error_regex = r"<\?error\s*\"([^\"]+)\"\s*\?>"
+        matches = re.findall(error_regex, xml_str)
+        for group_var in matches:
+            raise RuntimeError("[Error]: " + group_var)
+        warning_regex = r"(<\?warning\s*\"([^\"]+)\"\s*\?>)"
+        matches = re.findall(warning_regex, xml_str)
+        for group_wrn, group_var in matches:
+            print("[Warning]: " + group_var)
+            xml_str = xml_str.replace(group_wrn, "")
+        return xml_str
+
+    def _pp_if_eval(self, xml_str: str) -> str:
+        ifelif_regex = (
+            r"(<\?(if|elseif)\s*([^\"\s=<>!]+)\s*([!=<>]+)\s*\"*([^\"=<>!]+)\"*\s*\?>)"
+        )
+        matches = re.findall(ifelif_regex, xml_str)
+        for ifelif, tag, left, operator, right in matches:
+            if "<" in operator or ">" in operator:
+                result = eval(f"{left} {operator} {right}")
+            else:
+                result = eval(f'"{left}" {operator} "{right}"')
+            xml_str = xml_str.replace(ifelif, f"<?{tag} {result}?>")
+        return xml_str
+
+    def _pp_ifdef_ifndef(self, xml_str: str) -> str:
+        ifndef_regex = r"(<\?(ifdef|ifndef)\s*([\w]+)\s*\?>)"
+        matches = re.findall(ifndef_regex, xml_str)
+        for group_ifndef, group_tag, group_var in matches:
+            if group_tag == "ifdef":
+                result = group_var in self.cus_vars
+            else:
+                result = group_var not in self.cus_vars
+            xml_str = xml_str.replace(group_ifndef, f"<?if {result}?>")
+        return xml_str
+
+    def _pp_if_elseif(self, xml_str: str) -> str:
+        if_elif_else_regex = (
+            r"(<\?if\s(True|False)\?>"
+            r"(.*?)"
+            r"<\?elseif\s(True|False)\?>"
+            r"(.*?)"
+            r"<\?else\?>"
+            r"(.*?)"
+            r"<\?endif\?>)"
+        )
+        if_else_regex = (
+            r"(<\?if\s(True|False)\?>"
+            r"(.*?)"
+            r"<\?else\?>"
+            r"(.*?)"
+            r"<\?endif\?>)"
+        )
+        if_regex = r"(<\?if\s(True|False)\?>(.*?)<\?endif\?>)"
+        matches = re.findall(if_elif_else_regex, xml_str, re.DOTALL)
+        for (group_full, group_if, group_if_elif, group_elif,
+             group_elif_else, group_else) in matches:
+            result = ""
+            if group_if == "True":
+                result = group_if_elif
+            elif group_elif == "True":
+                result = group_elif_else
+            else:
+                result = group_else
+            xml_str = xml_str.replace(group_full, result)
+        matches = re.findall(if_else_regex, xml_str, re.DOTALL)
+        for group_full, group_if, group_if_else, group_else in matches:
+            result = ""
+            if group_if == "True":
+                result = group_if_else
+            else:
+                result = group_else
+            xml_str = xml_str.replace(group_full, result)
+        matches = re.findall(if_regex, xml_str, re.DOTALL)
+        for group_full, group_if, group_text in matches:
+            result = ""
+            if group_if == "True":
+                result = group_text
+            xml_str = xml_str.replace(group_full, result)
+        return xml_str
+
+    def _pp_command(self, xml_str: str) -> str:
+        cmd_regex = r"(<\?cmd\s*\"([^\"]+)\"\s*\?>)"
+        matches = re.findall(cmd_regex, xml_str)
+        for group_cmd, group_exec in matches:
+            output = subprocess.check_output(
+                group_exec, shell=True,
+                text=True, stderr=subprocess.STDOUT
+            )
+            xml_str = xml_str.replace(group_cmd, output)
+        return xml_str
+
+    def _pp_blanks(self, xml_str: str) -> str:
+        right_blank_regex = r">[\n\s\t\r]*"
+        left_blank_regex = r"[\n\s\t\r]*<"
+        xml_str = re.sub(right_blank_regex, ">", xml_str)
+        xml_str = re.sub(left_blank_regex, "<", xml_str)
+        return xml_str
+
+    def preprocess(self, xml_str: str) -> str:
+        fns = [
+            self._pp_blanks,
+            self._pp_include,
+            self._pp_foreach,
+            self._pp_env_var,
+            self._pp_sys_var,
+            self._pp_cus_var,
+            self._pp_if_eval,
+            self._pp_ifdef_ifndef,
+            self._pp_if_elseif,
+            self._pp_command,
+            self._pp_error_warning,
+        ]
+
+        while True:
+            changed = False
+            for func in fns:
+                out_xml = func(xml_str)
+                if not changed and out_xml != xml_str:
+                    changed = True
+                xml_str = out_xml
+            if not changed:
+                break
+
+        return xml_str
+
+
+def preprocess_xml(path: str) -> str:
+    with open(path, "r", encoding="utf-8") as original_file:
+        input_xml = original_file.read()
+
+        proc = Preprocessor()
+        return proc.preprocess(input_xml)
+
+
+def save_xml(xml_str: str, path: Optional[str]):
+    xml = minidom.parseString(xml_str)
+    with open(path, "w", encoding="utf-8") if path else sys.stdout as output_file:
+        output_file.write(xml.toprettyxml())
+
+
+def main():
+    if len(sys.argv) < 2:
+        print("Usage: xml-preprocessor input.xml [output.xml]")
+        sys.exit(1)
+
+    output_file = None
+    if len(sys.argv) == 3:
+        output_file = sys.argv[2]
+
+    input_file = sys.argv[1]
+    output_xml = preprocess_xml(input_file)
+    save_xml(output_xml, output_file)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.41.0


