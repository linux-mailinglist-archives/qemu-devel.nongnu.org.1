Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61700AD7CD8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Jun 2025 23:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPp1Q-0001l8-71; Thu, 12 Jun 2025 16:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPp1N-0001jJ-Ed
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 16:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPp1J-0000mC-SN
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 16:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749761973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCIejFSQfcGoCjcsgn+YLuJOKRTgKy2BSecLZSTojbc=;
 b=cGmjYkd+Njhawz1s8vXrhnVju8VWBSJGTjznGV4xKn0YCBH0+6zC15zV9lTb3FiIBm4WaX
 1jOdW9+5lHrr9Zk/+nHefAqtFa2QBxWrZmZne/4t6ZdpCrnlg/1Cq+8+zPLVvvJCB94WMe
 zTDbMA+yYPhL56CuvevvIqXsoBQtkWU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76--dlK-Bb-Pq2wXo9ih3MOiQ-1; Thu,
 12 Jun 2025 16:59:31 -0400
X-MC-Unique: -dlK-Bb-Pq2wXo9ih3MOiQ-1
X-Mimecast-MFC-AGG-ID: -dlK-Bb-Pq2wXo9ih3MOiQ_1749761966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12AD919560B2; Thu, 12 Jun 2025 20:59:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9E4B1956050; Thu, 12 Jun 2025 20:58:57 +0000 (UTC)
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
Subject: [PATCH v2 07/12] fixup
Date: Thu, 12 Jun 2025 16:54:45 -0400
Message-ID: <20250612205451.1177751-8-jsnow@redhat.com>
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

These are manual fixes that ought be merged into the prior patch, but
are here separated for clarity to separate the automated portions of
this patch from the non-automated portions.

These fixes are only the necessary portions to allow python static
checks (and checkpatch.pl) to pass again, and don't perform any
"optional" cleanups. (i.e. this patch strictly prevents regressions.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/utils/qom_fuse.py |  1 +
 scripts/qapi/common.py        | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index c1f596e3273..e2ed70f9ded 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -41,6 +41,7 @@
 
 import fuse
 from fuse import FUSE, FuseOSError, Operations
+
 from qemu.qmp import ExecuteError
 
 from .qom_common import QOMCommand
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d1fa5003c29..ecdac1dff85 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -91,29 +91,29 @@ def c_name(name: str, protect: bool = True) -> str:
     """
     # ANSI X3J11/88-090, 3.1.1
     c89_words = {'auto', 'break', 'case', 'char', 'const', 'continue',
-                     'default', 'do', 'double', 'else', 'enum', 'extern',
-                     'float', 'for', 'goto', 'if', 'int', 'long', 'register',
-                     'return', 'short', 'signed', 'sizeof', 'static',
-                     'struct', 'switch', 'typedef', 'union', 'unsigned',
-                     'void', 'volatile', 'while'}
+                 'default', 'do', 'double', 'else', 'enum', 'extern',
+                 'float', 'for', 'goto', 'if', 'int', 'long', 'register',
+                 'return', 'short', 'signed', 'sizeof', 'static',
+                 'struct', 'switch', 'typedef', 'union', 'unsigned',
+                 'void', 'volatile', 'while'}
     # ISO/IEC 9899:1999, 6.4.1
     c99_words = {'inline', 'restrict', '_Bool', '_Complex', '_Imaginary'}
     # ISO/IEC 9899:2011, 6.4.1
     c11_words = {'_Alignas', '_Alignof', '_Atomic', '_Generic',
-                     '_Noreturn', '_Static_assert', '_Thread_local'}
+                 '_Noreturn', '_Static_assert', '_Thread_local'}
     # GCC http://gcc.gnu.org/onlinedocs/gcc-4.7.1/gcc/C-Extensions.html
     # excluding _.*
     gcc_words = {'asm', 'typeof'}
     # C++ ISO/IEC 14882:2003 2.11
     cpp_words = {'bool', 'catch', 'class', 'const_cast', 'delete',
-                     'dynamic_cast', 'explicit', 'false', 'friend', 'mutable',
-                     'namespace', 'new', 'operator', 'private', 'protected',
-                     'public', 'reinterpret_cast', 'static_cast', 'template',
-                     'this', 'throw', 'true', 'try', 'typeid', 'typename',
-                     'using', 'virtual', 'wchar_t',
-                     # alternative representations
-                     'and', 'and_eq', 'bitand', 'bitor', 'compl', 'not',
-                     'not_eq', 'or', 'or_eq', 'xor', 'xor_eq'}
+                 'dynamic_cast', 'explicit', 'false', 'friend', 'mutable',
+                 'namespace', 'new', 'operator', 'private', 'protected',
+                 'public', 'reinterpret_cast', 'static_cast', 'template',
+                 'this', 'throw', 'true', 'try', 'typeid', 'typename',
+                 'using', 'virtual', 'wchar_t',
+                 # alternative representations
+                 'and', 'and_eq', 'bitand', 'bitor', 'compl', 'not',
+                 'not_eq', 'or', 'or_eq', 'xor', 'xor_eq'}
     # namespace pollution:
     polluted_words = {'unix', 'errno', 'mips', 'sparc', 'i386', 'linux'}
     name = re.sub(r'[^A-Za-z0-9_]', '_', name)
-- 
2.48.1


