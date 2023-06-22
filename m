Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A5739F5B
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIOd-00059Z-55; Thu, 22 Jun 2023 07:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIOb-00059R-Os
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:22:37 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIOZ-0006HZ-Vs
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687432951; x=1688037751; i=lukasstraub2@web.de;
 bh=Q0A14vffn08CMXaiQ9zgKTot5/J14WGLPsJvNOe5Z8U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=RNk5U2kKltqq0+WO1o0LYk8GFlHxlcZmuQaxfPy+K0+sJbCySPReQAXX8oJ1ObXz2/VpT2q
 zvudxaDLYGvueW7UoNdqEsb9kt6JcSFUo/dh6FdfrPXnX/ePg+N/xI2IVm+EGKxCnB07lhzDD
 QY2fFcIWquqmae5bw/6cSdjS/l/YKJqx5Y9+fWTp2Bt5BosRyPa2bHM0u1Yw5eZFwmSLMKdqE
 wPHhMPxhK9ItaUPdm2DdDVFDIpzdB2ky7k4QPlUDLSH2RiYe+QORfAkmJpIj+pzrMsgJOvRkP
 fzrQpP2EumqKfCTgZT5bZcDjLNRi+Gw+tP6OwgPddrA8M/D4b17g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mmyqx-1plifQ03N9-00k9qK; Thu, 22
 Jun 2023 13:22:31 +0200
Date: Thu, 22 Jun 2023 13:22:26 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, "=?UTF-8?B?Q8OpZHJpYw==?= Le Goater"
 <clg@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 1/2] vfio: Don't be a iterable and legacy device at the same
 time
Message-ID: <3c45b84bf970d20bfc72865c4de5c33563c2b62d.1687430098.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xF2ZyHc=++LELis2iYi0di/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:FdIbjF0R4/nrtSksfO5LR5yej+j1raKdwKcrYzhW4DakZmNkJMf
 0+viTSAklvrcbpdNnVASRWShPL0wyQJxJd9lebHrqKutougg0ZrYyipixu5MSwilr2qPBRW
 SJ6NuJWNgk438PD14GDF9HxqK12so6XNPmP4Gp/ySlzT3AGK6r6SBrFnXh2Wvvuh1T2e92b
 kqr7D7F7lrn5v23+2Ch4Q==
UI-OutboundReport: notjunk:1;M01:P0:uCSYVKHLFTg=;6bYJjumgmOqR7+65WclBuZr+iLj
 F75hsrVkxkRG/TE82VzUsF0CIXuY5YB4k/+yfHbVCOsBIqUgnLDHyYSwdEH2rpiuB8Xbie8e1
 SitN+VThoJEoTzpXd8KlYCbYxQ/+Owvx6uXoo4taDCGIWDLH1OLl1aFuhA2DUJ++sbuK3AHw3
 U/G75gsw4bNociHT2xyRmQIVEub1XqE5vba4yqYXvPb+MZ3utoGxaJidlurVhJEWnmtuXa+Gf
 Wsoh9nOANBdBDWbVQnSL6rxRrFwtf44RFfaqtxg5k1oAgyudJhcGd5w6zWpMxVsV6ZFYtYx95
 laJp2+NxYOja+8+bL3uNJq6ZZCVz3frHQLAzUdrG4/d3USWmFqzKTi5AySzByOKZ44GLYE3C+
 IcG0lUvw7h14OopUIBfn9RFMQW+IDlkw+7Vq80iWRVdcvgO6roOwuFr1LJNZBrn8qNV4SAKGb
 ZfW8aEaFIODFYns5Dm7ybrTh/W1wD95y83bfMJwoMcBYQ8Ke+t2p/mBCPJoLfxiXPjMgyIKxW
 Uzpw6QM9TPfIdE5J3jReGYsUx7JwYUZPpp4/+Qf35kXWSfIUlPggdqqlsZgzINSBaxPZPMYuU
 oDACexSEqtpDFHUi6m7+TzUVJl+p+iSfCojDD2DpErO477DpFwyCWGKKm0jQwVC702xrx43bX
 ETnSe5xi8H4eVQ5jxUN+/+4dLks/PnWya+Fdc/4y+Olwr95KIQcb9GrN7U02OwZFlZbFtL7cx
 YVZmCQ7CGlF8U7lIzxvjAG/l/uIanlAKwNnv32mHih92dKG/hRKOkWiLHK2CWfEocV5hXzEQm
 xTWEImH2APkmKYulxE7BjBuKITsXRHALzHIG9s9sTI80YUDWJ5lcDc2mw6sdjVo4NrLFQZSwV
 /sjVMm1kZ6xVgoG8syPXWMhTzXzsTk3hF5c9xhBZrC5ktCNkVBhjCg62mJf+VC+AxgMLokJ4Z
 Kkb4Qw==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--Sig_/xF2ZyHc=++LELis2iYi0di/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Legacy savevm devices only implement save_state() and load_state().
Iterable devices shouldn't implement save_state() or else they are
handled both as an iterable and legacy device in the savevm code.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---

Note: this patch is completely untested.

 hw/vfio/migration.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b58dddb88..8d7f22dbd3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -166,23 +166,6 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *v=
basedev,
     return ret;
 }
=20
-static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
-{
-    VFIODevice *vbasedev =3D opaque;
-
-    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
-
-    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
-        vbasedev->ops->vfio_save_config(vbasedev, f);
-    }
-
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
-
-    trace_vfio_save_device_config_state(vbasedev->name);
-
-    return qemu_file_get_error(f);
-}
-
 static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev =3D opaque;
@@ -351,7 +334,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void=
 *opaque)
         }
     } while (!ret);
=20
-    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
     ret =3D qemu_file_get_error(f);
     if (ret) {
         return ret;
@@ -365,20 +347,23 @@ static int vfio_save_complete_precopy(QEMUFile *f, vo=
id *opaque)
                                    VFIO_DEVICE_STATE_ERROR);
     trace_vfio_save_complete_precopy(vbasedev->name, ret);
=20
-    return ret;
-}
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_STATE);
=20
-static void vfio_save_state(QEMUFile *f, void *opaque)
-{
-    VFIODevice *vbasedev =3D opaque;
-    int ret;
+    if (vbasedev->ops && vbasedev->ops->vfio_save_config) {
+        vbasedev->ops->vfio_save_config(vbasedev, f);
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    trace_vfio_save_device_config_state(vbasedev->name);
=20
-    ret =3D vfio_save_device_config_state(f, opaque);
+    ret =3D qemu_file_get_error(f);
     if (ret) {
         error_report("%s: Failed to save device config space",
                      vbasedev->name);
-        qemu_file_set_error(f, ret);
     }
+
+    return ret;
 }
=20
 static int vfio_load_setup(QEMUFile *f, void *opaque)
@@ -458,7 +443,6 @@ static const SaveVMHandlers savevm_vfio_handlers =3D {
     .save_cleanup =3D vfio_save_cleanup,
     .state_pending_exact =3D vfio_state_pending_exact,
     .save_live_complete_precopy =3D vfio_save_complete_precopy,
-    .save_state =3D vfio_save_state,
     .load_setup =3D vfio_load_setup,
     .load_cleanup =3D vfio_load_cleanup,
     .load_state =3D vfio_load_state,
--=20
2.39.2


--Sig_/xF2ZyHc=++LELis2iYi0di/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSULvIACgkQNasLKJxd
slji1A//X1Rb1XNtHcdpClMwoy1ZuSNLegZ4Rh5C5fGTfYSYI8OEjCXksP4J9rbv
Ef4Hrl7WhXuGz4oISBTYLycNf0Ge38WmsohHXBpBHpYLU6tDDy7d1sgsnPRqFTU2
yuGxoD/+cifqoKhzX3FKYwMoXNcCadtVD31wTNv5nNuWegRosPHBHZgoeLqM41gz
vACeg9EeJEOC/0GuNa4iGkSlFwQTWod8xwXyEbF0KGlTNj167KuzgVGZ9xT7opoo
Zn7Zo9+BfPdL4K4lRq9yifRG0DrwJ8TEHjua1d3KFaobowFuj1q+Nd2IwSZUbA+N
q8tFGsktfFkr3/OQJuT5bQxSZz5N+Phyq1GeCFWrZD4e2LoWOcH19vwGP+igG+Cp
7KToKEOUjARkqlLsVF+MufY2na2QVtbzzj4ejAM2ifPrm34w++RF/z2NFRbd8k8f
wG6GlTdsktvgdAVZwID/o9BpPr2lRhpiYjMmCmY+nVwuDER1+wzndl+z5lzLkn0u
nfsju4boOTvDjT+nqC1RR6RZ+HuYlkY+rxMr/Qe3wM4QWBxeqwKpwMixPTsIrYoV
b/wGgoZR8/0KWNp/bepjD5a1vkzjA/eiL/QrMobA7dMUAjqNnY6TXJ/0BXUh8xtX
zZsyyyLHbLHX8eNjKY/gCHHDcEHOg0VbyYWAE9XnNZOpa895pIo=
=VQMo
-----END PGP SIGNATURE-----

--Sig_/xF2ZyHc=++LELis2iYi0di/--

