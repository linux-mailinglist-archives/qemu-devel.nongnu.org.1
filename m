Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D953770429
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwVU-0000GT-Tm; Fri, 04 Aug 2023 11:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qRwVS-0000Fk-8T
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:14:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qRwVP-0007Pr-J6
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:14:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHTfx6tjbz67R01;
 Fri,  4 Aug 2023 23:10:33 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:14:15 +0100
Date: Fri, 4 Aug 2023 16:14:14 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 2/4] cxl/mailbox: interface to add CCI commands to an
 existing CCI
Message-ID: <20230804161414.00006eaa@huawei.com>
In-Reply-To: <20230721163505.1910-3-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
 <20230721163505.1910-3-gregory.price@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 21 Jul 2023 12:35:06 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> This enables wrapper devices to customize the base device's CCI
> (for example, with custom commands outside the specification)
> without the need to change the base device.
>=20
> The also enabled the base device to dispatch those commands without
> requiring additional driver support.
>=20
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 19 +++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  2 ++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ddee3f1718..cad0cd0adb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1383,6 +1383,25 @@ static void cxl_copy_cci_commands(CXLCCI *cci, con=
st struct cxl_cmd (*cxl_cmds)[
>      }
>  }
> =20
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_se=
t)[256], size_t payload_max)
> +{
> +    cci->payload_max =3D payload_max > cci->payload_max ? payload_max : =
cci->payload_max;
> +    for (int set =3D 0; set < 256; set++) {
> +        for (int cmd =3D 0; cmd < 256; cmd++) {
> +            if (cxl_cmd_set[set][cmd].handler) {
> +                const struct cxl_cmd *c =3D &cxl_cmd_set[set][cmd];
> +                cci->cxl_cmd_set[set][cmd] =3D *c;
Don't interleave definitions and code.

> +                struct cel_log *log =3D
> +                    &cci->cel_log[cci->cel_size];
> +
> +                log->opcode =3D (set << 8) | cmd;
> +                log->effect =3D c->effect;
> +                cci->cel_size++;

So my gut feeling on this is based on the large amount of overlapping code.=
  I might queue it
as it stands, but I'd like to see this refactored.

1) Single copy routine used in all places that copie in any new entries to =
cci->cxl_cmd_set[][]
2) A single cel_log builder function to be called in normal path and after =
an update. Just rebuild
the whole thing rather than trying to append to it I think.

Something like (so far untested but I'll poke it with Fan's code in a few m=
ins)

However this is all proving rather costly in space so maybe we need a better
representation for the sparse nature of cxl comamnds - a job for another da=
y.


=46rom 8ab48adfb2b481be0702b84a0d172a4f142b0df6 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry.memverge@gmail.com>
Date: Fri, 21 Jul 2023 12:35:06 -0400
Subject: [PATCH] cxl/mailbox: interface to add CCI commands to an existing =
CCI

This enables wrapper devices to customize the base device's CCI
(for example, with custom commands outside the specification)
without the need to change the base device.

The also enabled the base device to dispatch those commands without
requiring additional driver support.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Link: https://lore.kernel.org/r/20230721163505.1910-3-gregory.price@memverg=
e.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
Heavily edited by Jonathan Cameron to increase code reuse
---
 include/hw/cxl/cxl_device.h |  2 ++
 hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 0c9254dff9..2a3050fbad 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState=
 *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)=
[256],
+                          size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                             size_t len_in, uint8_t *pl_in,
                             size_t *len_out, uint8_t *pl_out,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 37703f254f..852e5a046b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1353,9 +1353,9 @@ static void bg_timercb(void *opaque)
     }
 }
=20
-void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+static void cxl_rebuild_cel(CXLCCI *cci)
 {
-    cci->payload_max =3D payload_max;
+    cci->cel_size =3D 0; /* Reset for a fresh build */
     for (int set =3D 0; set < 256; set++) {
         for (int cmd =3D 0; cmd < 256; cmd++) {
             if (cci->cxl_cmd_set[set][cmd].handler) {
@@ -1369,6 +1369,13 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
             }
         }
     }
+}
+
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
+{
+    cci->payload_max =3D payload_max;
+    cxl_rebuild_cel(cci);
+
     cci->bg.complete_pct =3D 0;
     cci->bg.starttime =3D 0;
     cci->bg.runtime =3D 0;
@@ -1387,10 +1394,19 @@ static void cxl_copy_cci_commands(CXLCCI *cci, cons=
t struct cxl_cmd (*cxl_cmds)[
     }
 }
=20
+void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)=
[256],
+                                 size_t payload_max)
+{
+    cci->payload_max =3D payload_max > cci->payload_max ? payload_max : cc=
i->payload_max;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
+    cxl_rebuild_cel(cci);
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max)
 {
     cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
+    cxl_rebuild_cel(cci);
     cci->d =3D d;
     cci->intf =3D intf;
     cxl_init_cci(cci, payload_max);
@@ -1399,6 +1415,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, Device=
State *intf,
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload=
_max)
 {
     cxl_copy_cci_commands(cci, cxl_cmd_set);
+    cxl_rebuild_cel(cci);
     cci->d =3D d;
=20
     /* No separation for PCI MB as protocol handled in PCI device */
--=20
2.39.2



> +            }
> +        }
> +    }
> +}
> +
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, Device=
State *d, size_t payload_max)
>  {
>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9a3c8b2dfa..abc8405cc5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -297,6 +297,8 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceSta=
te *d, size_t payload_max);
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max);
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> +void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_se=
t)[256],
> +                          size_t payload_max);
>  int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                              size_t len_in, uint8_t *pl_in,
>                              size_t *len_out, uint8_t *pl_out,


