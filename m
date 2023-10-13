Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A417C8DAD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYk-0007Xo-Gl; Fri, 13 Oct 2023 15:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYS-0007G0-1X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYB-0001xQ-PV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3ZfV/fIoupB5gtPZYjLu0l1bdDmtHuAyzmyVWMACA0=;
 b=GRTWXk+Mpp9Bo9lVWdv4PsZ+UINx7iKrO8cbJOu/gwM1i+vC0zhFUOKrV7Q4TRsTSRM510
 JOwlGLLDPnh2h3bdEZc30+sPW0j4Df6di/S5u0KMb7BFnGdEmOzGH8bKU/byNY53OtfoXH
 ud0BnyAmGKdahRvbSUZ0b9vqoI+MD44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-EgbJ9dRYO66VQWyj2jZQ9w-1; Fri, 13 Oct 2023 15:10:15 -0400
X-MC-Unique: EgbJ9dRYO66VQWyj2jZQ9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9064E281294C;
 Fri, 13 Oct 2023 19:10:14 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4437140C6CA0;
 Fri, 13 Oct 2023 19:10:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 24/25] scripts: add python_qmp_updater.py
Date: Fri, 13 Oct 2023 15:09:39 -0400
Message-ID: <20231013190941.3699288-25-jsnow@redhat.com>
In-Reply-To: <20231013190941.3699288-1-jsnow@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

A script, to update the pattern

    result = self.vm.qmp(...)
    self.assert_qmp(result, 'return', {})

(and some similar ones) into

    self.vm.cmd(...)

Used in the next commit
    "python: use vm.cmd() instead of vm.qmp() where appropriate"

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-15-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/python_qmp_updater.py | 136 ++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 scripts/python_qmp_updater.py

diff --git a/scripts/python_qmp_updater.py b/scripts/python_qmp_updater.py
new file mode 100755
index 0000000000..494a169812
--- /dev/null
+++ b/scripts/python_qmp_updater.py
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+#
+# Intended usage:
+#
+# git grep -l '\.qmp(' | xargs ./scripts/python_qmp_updater.py
+#
+
+import re
+import sys
+from typing import Optional
+
+start_reg = re.compile(r'^(?P<padding> *)(?P<res>\w+) = (?P<vm>.*).qmp\(',
+                       flags=re.MULTILINE)
+
+success_reg_templ = re.sub('\n *', '', r"""
+    (\n*{padding}(?P<comment>\#.*$))?
+    \n*{padding}
+    (
+        self.assert_qmp\({res},\ 'return',\ {{}}\)
+    |
+        assert\ {res}\['return'\]\ ==\ {{}}
+    |
+        assert\ {res}\ ==\ {{'return':\ {{}}}}
+    |
+        self.assertEqual\({res}\['return'\],\ {{}}\)
+    )""")
+
+some_check_templ = re.sub('\n *', '', r"""
+    (\n*{padding}(?P<comment>\#.*$))?
+    \s*self.assert_qmp\({res},""")
+
+
+def tmatch(template: str, text: str,
+           padding: str, res: str) -> Optional[re.Match[str]]:
+    return re.match(template.format(padding=padding, res=res), text,
+                    flags=re.MULTILINE)
+
+
+def find_closing_brace(text: str, start: int) -> int:
+    """
+    Having '(' at text[start] search for pairing ')' and return its index.
+    """
+    assert text[start] == '('
+
+    height = 1
+
+    for i in range(start + 1, len(text)):
+        if text[i] == '(':
+            height += 1
+        elif text[i] == ')':
+            height -= 1
+        if height == 0:
+            return i
+
+    raise ValueError
+
+
+def update(text: str) -> str:
+    result = ''
+
+    while True:
+        m = start_reg.search(text)
+        if m is None:
+            result += text
+            break
+
+        result += text[:m.start()]
+
+        args_ind = m.end()
+        args_end = find_closing_brace(text, args_ind - 1)
+
+        all_args = text[args_ind:args_end].split(',', 1)
+
+        name = all_args[0]
+        args = None if len(all_args) == 1 else all_args[1]
+
+        unchanged_call = text[m.start():args_end+1]
+        text = text[args_end+1:]
+
+        padding, res, vm = m.group('padding', 'res', 'vm')
+
+        m = tmatch(success_reg_templ, text, padding, res)
+
+        if m is None:
+            result += unchanged_call
+
+            if ('query-' not in name and
+                    'x-debug-block-dirty-bitmap-sha256' not in name and
+                    not tmatch(some_check_templ, text, padding, res)):
+                print(unchanged_call + text[:200] + '...\n\n')
+
+            continue
+
+        if m.group('comment'):
+            result += f'{padding}{m.group("comment")}\n'
+
+        result += f'{padding}{vm}.cmd({name}'
+
+        if args:
+            result += ','
+
+            if '\n' in args:
+                m_args = re.search('(?P<pad> *).*$', args)
+                assert m_args is not None
+
+                cur_padding = len(m_args.group('pad'))
+                expected = len(f'{padding}{res} = {vm}.qmp(')
+                drop = len(f'{res} = ')
+                if cur_padding == expected - 1:
+                    # tolerate this bad style
+                    drop -= 1
+                elif cur_padding < expected - 1:
+                    # assume nothing to do
+                    drop = 0
+
+                if drop:
+                    args = re.sub('\n' + ' ' * drop, '\n', args)
+
+            result += args
+
+        result += ')'
+
+        text = text[m.end():]
+
+    return result
+
+
+for fname in sys.argv[1:]:
+    print(fname)
+    with open(fname) as f:
+        t = f.read()
+
+    t = update(t)
+
+    with open(fname, 'w') as f:
+        f.write(t)
-- 
2.41.0


