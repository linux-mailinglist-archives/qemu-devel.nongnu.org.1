Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F076AD7CD4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 23:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPp20-0002Tq-Ut; Thu, 12 Jun 2025 17:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPp1y-0002Rb-8g
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPp1n-0000qH-Uv
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 17:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749762002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=emNV1/voq8vLNxrXGL0MQiHgqI8v5/GVX6i/w8ik8zI=;
 b=XJ8RVA8Dapj42b42A2xq9wplaYFN6Xs4NU1bVFC6IVc+ldgJqH6viprr4ed3rT4GUD+Ok/
 U98hN28SxWznkF6KuExQiVPj7FqwNSw8w0gDQ+JBEK6v2zo6xyRTt9hunBYbB3M/HV+i1m
 P6JY4hFZjfhK8oBTd0X34Q0P/tSze/s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-FMI1iKeyOf-ip1YEUJLvsQ-1; Thu,
 12 Jun 2025 17:00:00 -0400
X-MC-Unique: FMI1iKeyOf-ip1YEUJLvsQ-1
X-Mimecast-MFC-AGG-ID: FMI1iKeyOf-ip1YEUJLvsQ_1749761996
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E471956095; Thu, 12 Jun 2025 20:59:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A265C1955F4A; Thu, 12 Jun 2025 20:59:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Fabiano Rosas <farosas@suse.de>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ed Maste <emaste@freebsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Blake <eblake@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Troy Lee <leetroy@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Roth <michael.roth@amd.com>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-s390x@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paul Durrant <paul@xen.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alessandro Di Federico <ale@rev.ng>,
 Thomas Huth <thuth@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-rust@nongnu.org,
 Bandan Das <bsd@redhat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Fam Zheng <fam@euphon.net>,
 Jia Liu <proljc@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Alexandre Iooss <erdnaxe@crans.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 08/12] python: further 3.9+ syntax upgrades
Date: Thu, 12 Jun 2025 16:54:46 -0400
Message-ID: <20250612205451.1177751-9-jsnow@redhat.com>
In-Reply-To: <20250612205451.1177751-1-jsnow@redhat.com>
References: <20250612205451.1177751-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

pyupgrade does not catch absolutely everything - there are still a few
deprecated type aliases we need to shift away from using.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py                 | 8 ++------
 docs/sphinx/qapi_domain.py            | 6 +++---
 python/qemu/machine/console_socket.py | 4 ++--
 python/qemu/qmp/events.py             | 9 +++++++--
 python/qemu/qmp/protocol.py           | 3 +--
 python/qemu/utils/qemu_ga_client.py   | 4 ++--
 tests/qemu-iotests/fat16.py           | 3 ++-
 tests/qemu-iotests/iotests.py         | 8 ++++++--
 8 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 2a93687cb3e..1eb1a49d976 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -2,13 +2,9 @@
 Sphinx cross-version compatibility goop
 """
 
+from collections.abc import Callable
 import re
-from typing import (
-    TYPE_CHECKING,
-    Any,
-    Callable,
-    Optional,
-)
+from typing import TYPE_CHECKING, Any, Optional
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index cb6104922b5..7673eaed6d5 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -39,8 +39,8 @@
 
 
 if TYPE_CHECKING:
-    from collections.abc import Iterable
-    from typing import AbstractSet, Any
+    from collections.abc import Iterable, Set
+    from typing import Any
 
     from docutils.nodes import Element, Node
     from sphinx.addnodes import desc_signature, pending_xref
@@ -825,7 +825,7 @@ def clear_doc(self, docname: str) -> None:
                 del self.objects[fullname]
 
     def merge_domaindata(
-        self, docnames: AbstractSet[str], otherdata: dict[str, Any]
+        self, docnames: Set[str], otherdata: dict[str, Any]
     ) -> None:
         for fullname, obj in otherdata["objects"].items():
             if obj.docname in docnames:
diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machine/console_socket.py
index 0754f340310..bcd27017fc9 100644
--- a/python/qemu/machine/console_socket.py
+++ b/python/qemu/machine/console_socket.py
@@ -17,7 +17,7 @@
 import socket
 import threading
 import time
-from typing import Deque, Optional
+from typing import Optional
 
 
 class ConsoleSocket(socket.socket):
@@ -43,7 +43,7 @@ def __init__(self,
 
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
-        self._buffer: Deque[int] = deque()
+        self._buffer: deque[int] = deque()
         if address is not None:
             socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
             self.connect(address)
diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index e444d9334ec..33a9317e4d4 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -448,10 +448,15 @@ def accept(self, event) -> bool:
 """
 
 import asyncio
-from collections.abc import AsyncIterator, Iterable, Iterator
+from collections.abc import (
+    AsyncIterator,
+    Callable,
+    Iterable,
+    Iterator,
+)
 from contextlib import contextmanager
 import logging
-from typing import Callable, Optional, Union
+from typing import Optional, Union
 
 from .error import QMPError
 from .message import Message
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 4ec9564c4b3..683df61f55e 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -15,7 +15,7 @@
 
 import asyncio
 from asyncio import StreamReader, StreamWriter
-from collections.abc import AsyncGenerator, Awaitable
+from collections.abc import AsyncGenerator, Awaitable, Callable
 from contextlib import asynccontextmanager
 from enum import Enum
 from functools import wraps
@@ -25,7 +25,6 @@
 from ssl import SSLContext
 from typing import (
     Any,
-    Callable,
     Generic,
     Optional,
     TypeVar,
diff --git a/python/qemu/utils/qemu_ga_client.py b/python/qemu/utils/qemu_ga_client.py
index a653c234c4b..d15848667b1 100644
--- a/python/qemu/utils/qemu_ga_client.py
+++ b/python/qemu/utils/qemu_ga_client.py
@@ -39,11 +39,11 @@
 import argparse
 import asyncio
 import base64
-from collections.abc import Sequence
+from collections.abc import Callable, Sequence
 import os
 import random
 import sys
-from typing import Any, Callable, Optional
+from typing import Any, Optional
 
 from qemu.qmp import ConnectError, SocketAddrT
 from qemu.qmp.legacy import QEMUMonitorProtocol
diff --git a/tests/qemu-iotests/fat16.py b/tests/qemu-iotests/fat16.py
index 88c3d56c662..ec4bc980725 100644
--- a/tests/qemu-iotests/fat16.py
+++ b/tests/qemu-iotests/fat16.py
@@ -15,8 +15,9 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+from collections.abc import Callable
 import string
-from typing import Callable, Optional, Protocol
+from typing import Optional, Protocol
 
 
 SECTOR_SIZE = 512
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 104a61058fa..b69895cd117 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -20,7 +20,12 @@
 import atexit
 import bz2
 from collections import OrderedDict
-from collections.abc import Iterable, Iterator, Sequence
+from collections.abc import (
+    Callable,
+    Iterable,
+    Iterator,
+    Sequence,
+)
 from contextlib import contextmanager
 import faulthandler
 import json
@@ -35,7 +40,6 @@
 import time
 from typing import (
     Any,
-    Callable,
     Optional,
     TextIO,
     TypeVar,
-- 
2.48.1


