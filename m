Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19077D4B65
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 11:00:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDGZ-0006CP-0D; Tue, 24 Oct 2023 04:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qvDGW-0006CD-Qm
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:59:56 -0400
Received: from shasxm03.verisilicon.com ([101.89.135.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <Lu.Gao@verisilicon.com>)
 id 1qvDGT-0007yP-1S
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:59:56 -0400
Content-Language: zh-CN
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
 c=simple/simple; t=1698137612; h=from:subject:to:date:message-id;
 bh=rbjd7B74/ZIrRP/shKBvzjd7+d6d+M8PQxa8M4JdvXU=;
 b=RGT+Xm3PUGtLTdEtGswdx4deEf2GFhqvOB7ujUkCRqpl7hHW8iheJftdfXxxQbcegyB/mnL3myW
 D3pFRWHKel/NdiVl9wnMnCGYkL5A2NzZzQBFMfWjQJA+5ukPvaEL4nl23ApIVaexq2ei1NkfTe/Az
 vdNl0STBe6+jV6HznVg=
Received: from SHASXM06.verisilicon.com ([fe80::59a8:ce34:dc14:ddda]) by
 SHASXM03.verisilicon.com ([fe80::938:4dda:a2f9:38aa%14]) with mapi id
 14.03.0408.000; Tue, 24 Oct 2023 16:53:31 +0800
To: Lu Gao <Lu.Gao@verisilicon.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jianxian Wen <Jianxian.Wen@verisilicon.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH] qom/object_interfaces: Handle `len-` property first
Thread-Topic: [PATCH] qom/object_interfaces: Handle `len-` property first
Thread-Index: AQHZ7JZF/spwj5oW9kOZXKLqLuyoRrBY1XxA
Date: Tue, 24 Oct 2023 08:53:31 +0000
Message-ID: <34781C803212B140A51E6B66D9092E5D02BEDA7B26@SHASXM06.verisilicon.com>
References: <20230921141634.26233-1-lu.gao@verisilicon.com>
In-Reply-To: <20230921141634.26233-1-lu.gao@verisilicon.com>
Accept-Language: en-US, zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.44.41]
MIME-Version: 1.0
Received-SPF: pass client-ip=101.89.135.44;
 envelope-from=Lu.Gao@verisilicon.com; helo=shasxm03.verisilicon.com
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
Reply-to:  Lu Gao <Lu.Gao@verisilicon.com>
From:  Lu Gao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

ping

https://patchew.org/QEMU/20230921141634.26233-1-lu.gao@verisilicon.com/

Could you please help review the patch?

Thanks.
B.R.

-----Original Message-----
From: Lu Gao=20
Sent: Thursday, September 21, 2023 10:17 PM
To: qemu-devel@nongnu.org
Cc: Lu Gao; Jianxian Wen; Paolo Bonzini; Daniel P. Berrang=E9; Eduardo Habk=
ost
Subject: [PATCH] qom/object_interfaces: Handle `len-` property first

From: "Gao, Lu" <lu.gao@verisilicon.com>

Array property needs corresponding `len-` property set first to add
actual array properties. Then we need to make sure `len-` property is
set first before array property.

But when the model is used with like
`-device driver[,prop[=3Dvalue][,...]]`
in QEMU command line options, this is not guaranteed in current
property set from qdict. Array property might be
handled before 'len-' property, then leads to an error.

Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
---
 qom/object_interfaces.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..87500401a4 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -18,6 +18,7 @@
 #include "qapi/opts-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/keyval.h"
+#include "hw/qdev-properties.h"
=20
 bool user_creatable_complete(UserCreatable *uc, Error **errp)
 {
@@ -52,8 +53,22 @@ static void object_set_properties_from_qdict(Object *obj=
, const QDict *qdict,
         return;
     }
     for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
-        if (!object_property_set(obj, e->key, v, errp)) {
-            goto out;
+        /* set "len-" first for the array props to be allocated first */
+        if (strncmp(e->key, PROP_ARRAY_LEN_PREFIX,
+                    strlen(PROP_ARRAY_LEN_PREFIX)) =3D=3D 0) {
+            if (!object_property_set(obj, e->key, v, errp)) {
+                goto out;
+            }
+        }
+    }
+
+    for (e =3D qdict_first(qdict); e; e =3D qdict_next(qdict, e)) {
+        /* "len-" has been set above */
+        if (strncmp(e->key, PROP_ARRAY_LEN_PREFIX,
+                    strlen(PROP_ARRAY_LEN_PREFIX)) !=3D 0) {
+            if (!object_property_set(obj, e->key, v, errp)) {
+                goto out;
+            }
         }
     }
     visit_check_struct(v, errp);
--=20
2.17.1


