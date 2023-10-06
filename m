Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576357BBC02
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomyD-0006mB-9x; Fri, 06 Oct 2023 11:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxx-0006fy-Tp; Fri, 06 Oct 2023 11:42:14 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxs-0003cf-SP; Fri, 06 Oct 2023 11:42:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id AF7696122D;
 Fri,  6 Oct 2023 18:42:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-R5Kt6kcm; Fri, 06 Oct 2023 18:42:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606926;
 bh=0pBFPYojTSaRvYhmsttp5ojegBIHFgDNL/M2SYLgLRc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1CMZDH22x7qiz0f2wxpxaxT8LN1JELj95JBMB9GDW3IHoTJKtbqHClPFnBY1lmZM/
 vUwfDpofwOsZYX9pFEZlKnU4tTDf0aNEYVuy5TdKDrsdUguN/rGwEsg4BbMAi4REEs
 tNVpf6m+tuqrTcX8YgqkjmwHMDuODafqxbJE90Tw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Subject: [PATCH v7 14/15] scripts: add python_qmp_updater.py
Date: Fri,  6 Oct 2023 18:41:24 +0300
Message-Id: <20231006154125.1068348-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

A script, to update the pattern

    result = self.vm.qmp(...)
    self.assert_qmp(result, 'return', {})

(and some similar ones) into

    self.vm.cmd(...)

Used in the next commit
    "python: use vm.cmd() instead of vm.qmp() where appropriate"

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.34.1


