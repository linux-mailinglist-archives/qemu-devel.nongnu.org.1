Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B34448296B6
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:57:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNVJX-0004tp-IU; Wed, 10 Jan 2024 04:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp@tutamail.com>) id 1rNVJT-0004ry-EK
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:55:55 -0500
Received: from w1.tutanota.de ([81.3.6.162])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp@tutamail.com>) id 1rNVJQ-0004cH-Hp
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:55:55 -0500
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
 by w1.tutanota.de (Postfix) with ESMTP id 2FDC9FBFC17;
 Wed, 10 Jan 2024 09:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1704880546; 
 s=s1; d=tutamail.com;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=S9na4O9D2aRwt3IsJ7OUYJhIkLIh3e8OV1LJr9sfPmg=;
 b=E7dXuHMM49POjwJbzDQErJ5OQ+IRddKQNaKvqwBSSQezlE1jkk6kwxHf0hV4Dl1b
 QwWOZzdzAXNlta7TpL+HDFV6r6jKafSTSKzV76PIMD9bo193aRDUfBFnJ/C9QlfbDjK
 TPqkWlc9h+OrbEp15lguKHYxuOP7j1s6w6ZDeZIv+HzeQB4IqutmL8sVlFqNg2iUrx3
 gMKbHKFJOCAv9Fa0823m1dG/clAl0nfjFRkGD8phjIF3OfgC3nwrVtqWCKnak/aecxb
 cs4nwuQ7Km9H8Nc5WNI/Jn0r4bD8yCAqUTK1/sgpN4KizfmwKfWyBZqd1SIz3tlsn7S
 ZijNOHHaqA==
Date: Wed, 10 Jan 2024 10:55:46 +0100 (CET)
To: Qemu Devel <qemu-devel@nongnu.org>
Cc: Kwolf <kwolf@redhat.com>, Hreitz <hreitz@redhat.com>
Message-ID: <Nnmn8eL--7-9@tutamail.com>
Subject: [PATCH] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_5606_866180345.1704880546187"
Received-SPF: pass client-ip=81.3.6.162; envelope-from=atp@tutamail.com;
 helo=w1.tutanota.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  atp@tutamail.com
From: atp--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

------=_Part_5606_866180345.1704880546187
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Abhiram Tilak <atp@tutamail.com>

When running the command `qemu-img snapshot -l SNAPSHOT` the output of
VM_CLOCK (measures the offset between host and VM clock) cannot to
accommodate values in the order of thousands (4-digit).

This line [1] hints on the problem. Additionally, the column width for
the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
in line [2], resulting in a shortage of space.

[1]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
[2]: https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763

This patch restores the column width to 15 spaces and makes adjustments 
to the affected iotests accordingly. Furthermore, addresses a potential source 
of confusion by removing whitespace in column headers. Example, VM CLOCK 
is modified to VM_CLOCK. Additionally a '--' symbol is introduced when 
ICOUNT returns no output for clarity.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
Fixes: b39847a50553 (migration: introduce icount field for snapshots )
Signed-off-by: Abhiram Tilak <atp@tutamail.com> <mailto:atp.exp@gmail.com>
---
block/qapi.c | 10 ++++----
tests/qemu-iotests/267.out | 48 +++++++++++++++++++-------------------
2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 9e806fa230..ee066ee53c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
char *sizing = NULL;

if (!sn) {
- qemu_printf("%-10s%-17s%8s%20s%13s%11s",
- "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
+ qemu_printf("%-10s%-17s%8s%20s%15s%11s",
+ "ID", "TAG", "VM_SIZE", "DATE", "VM_CLOCK", "ICOUNT");
} else {
g_autoptr(GDateTime) date = g_date_time_new_from_unix_local(sn->date_sec);
g_autofree char *date_buf = g_date_time_format(date, "%Y-%m-%d %H:%M:%S");

secs = sn->vm_clock_nsec / 1000000000;
snprintf(clock_buf, sizeof(clock_buf),
- "%02d:%02d:%02d.%03d",
+ "%04d:%02d:%02d.%03d",
(int)(secs / 3600),
(int)((secs / 60) % 60),
(int)(secs % 60),
@@ -759,8 +759,10 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
if (sn->icount != -1ULL) {
snprintf(icount_buf, sizeof(icount_buf),
"%"PRId64, sn->icount);
+ } else {
+ snprintf(icount_buf, sizeof(icount_buf), "--");
}
- qemu_printf("%-9s %-16s %8s%20s%13s%11s",
+ qemu_printf("%-9s %-16s %8s%20s%15s%11s",
sn->id_str, sn->name,
sizing,
date_buf,
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 7176e376e1..21339e67ad 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

Internal snapshots on overlay:
Snapshot list:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
-1 snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+1 snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
Internal snapshots on backing file:

=== -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
(qemu) savevm snap0
(qemu) info snapshots
List of snapshots present on all disks:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
(qemu) loadvm snap0
(qemu) quit

Internal snapshots on overlay:
Snapshot list:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
-1 snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+1 snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
Internal snapshots on backing file:
Snapshot list:
-ID TAG VM SIZE DATE VM CLOCK ICOUNT
-1 snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT
+1 snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --
*** done
--
2.40.1

------=_Part_5606_866180345.1704880546187
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
<div>From: Abhiram Tilak &lt;<a href=3D"mailto:atp@tutamail.com" rel=3D"noo=
pener noreferrer" target=3D"_blank">atp@tutamail.com</a>&gt;<br></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">When running the command `qemu-img=
 snapshot -l SNAPSHOT` the output of<br></div><div dir=3D"auto">VM_CLOCK (m=
easures the offset between host and VM clock) cannot to<br></div><div dir=
=3D"auto">accommodate values in the order of thousands (4-digit).<br></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">This line [1] hints on the pr=
oblem. Additionally, the column width for<br></div><div dir=3D"auto">the VM=
_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5<br></div><=
div dir=3D"auto">in line [2], resulting in a shortage of space.<br></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">[1]: <a href=3D"https://gitlab.=
com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=3Dheads#L753" rel=
=3D"noopener noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/=
qemu/-/blob/master/block/qapi.c?ref_type=3Dheads#L753</a><br></div><div dir=
=3D"auto">[2]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/maste=
r/block/qapi.c?ref_type=3Dheads#L763" rel=3D"noopener noreferrer" target=3D=
"_blank">https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?re=
f_type=3Dheads#L763</a><br></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">This patch restores the column width to 15 spaces and makes adjustments=
 <br></div><div dir=3D"auto">to the affected iotests accordingly. Furthermo=
re, addresses a potential source <br></div><div dir=3D"auto">of confusion b=
y removing whitespace in column headers. Example, VM CLOCK <br></div><div d=
ir=3D"auto">is modified to VM_CLOCK. Additionally a '--' symbol is introduc=
ed when <br></div><div dir=3D"auto">ICOUNT returns no output for clarity.<b=
r></div><div dir=3D"auto"><br></div><div dir=3D"auto">Resolves: <a href=3D"=
https://gitlab.com/qemu-project/qemu/-/issues/2062" rel=3D"noopener norefer=
rer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2062</=
a><br></div><div dir=3D"auto">Fixes: b39847a50553 (migration: introduce ico=
unt field for snapshots )<br></div><div dir=3D"auto">Signed-off-by: Abhiram=
 Tilak &lt;<a href=3D"mailto:atp.exp@gmail.com" rel=3D"noopener noreferrer"=
 target=3D"_blank">atp@tutamail.com&gt;</a><br></div><div dir=3D"auto">---<=
br></div><div dir=3D"auto">block/qapi.c | 10 ++++----<br></div><div dir=3D"=
auto">tests/qemu-iotests/267.out | 48 +++++++++++++++++++------------------=
-<br></div><div dir=3D"auto">2 files changed, 30 insertions(+), 28 deletion=
s(-)<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">diff --git a/bl=
ock/qapi.c b/block/qapi.c<br></div><div dir=3D"auto">index 9e806fa230..ee06=
6ee53c 100644<br></div><div dir=3D"auto">--- a/block/qapi.c<br></div><div d=
ir=3D"auto">+++ b/block/qapi.c<br></div><div dir=3D"auto">@@ -742,15 +742,1=
5 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)<br></div><div dir=3D"aut=
o">char *sizing =3D NULL;<br></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">if (!sn) {<br></div><div dir=3D"auto">- qemu_printf("%-10s%-17s%8s%20=
s%13s%11s",<br></div><div dir=3D"auto">- "ID", "TAG", "VM SIZE", "DATE", "V=
M CLOCK", "ICOUNT");<br></div><div dir=3D"auto">+ qemu_printf("%-10s%-17s%8=
s%20s%15s%11s",<br></div><div dir=3D"auto">+ "ID", "TAG", "VM_SIZE", "DATE"=
, "VM_CLOCK", "ICOUNT");<br></div><div dir=3D"auto">} else {<br></div><div =
dir=3D"auto">g_autoptr(GDateTime) date =3D g_date_time_new_from_unix_local(=
sn-&gt;date_sec);<br></div><div dir=3D"auto">g_autofree char *date_buf =3D =
g_date_time_format(date, "%Y-%m-%d %H:%M:%S");<br></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">secs =3D sn-&gt;vm_clock_nsec / 1000000000;<br><=
/div><div dir=3D"auto">snprintf(clock_buf, sizeof(clock_buf),<br></div><div=
 dir=3D"auto">- "%02d:%02d:%02d.%03d",<br></div><div dir=3D"auto">+ "%04d:%=
02d:%02d.%03d",<br></div><div dir=3D"auto">(int)(secs / 3600),<br></div><di=
v dir=3D"auto">(int)((secs / 60) % 60),<br></div><div dir=3D"auto">(int)(se=
cs % 60),<br></div><div dir=3D"auto">@@ -759,8 +759,10 @@ void bdrv_snapsho=
t_dump(QEMUSnapshotInfo *sn)<br></div><div dir=3D"auto">if (sn-&gt;icount !=
=3D -1ULL) {<br></div><div dir=3D"auto">snprintf(icount_buf, sizeof(icount_=
buf),<br></div><div dir=3D"auto">"%"PRId64, sn-&gt;icount);<br></div><div d=
ir=3D"auto">+ } else {<br></div><div dir=3D"auto">+ snprintf(icount_buf, si=
zeof(icount_buf), "--");<br></div><div dir=3D"auto">}<br></div><div dir=3D"=
auto">- qemu_printf("%-9s %-16s %8s%20s%13s%11s",<br></div><div dir=3D"auto=
">+ qemu_printf("%-9s %-16s %8s%20s%15s%11s",<br></div><div dir=3D"auto">sn=
-&gt;id_str, sn-&gt;name,<br></div><div dir=3D"auto">sizing,<br></div><div =
dir=3D"auto">date_buf,<br></div><div dir=3D"auto">diff --git a/tests/qemu-i=
otests/267.out b/tests/qemu-iotests/267.out<br></div><div dir=3D"auto">inde=
x 7176e376e1..21339e67ad 100644<br></div><div dir=3D"auto">--- a/tests/qemu=
-iotests/267.out<br></div><div dir=3D"auto">+++ b/tests/qemu-iotests/267.ou=
t<br></div><div dir=3D"auto">@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'h=
elp' for more information<br></div><div dir=3D"auto">(qemu) savevm snap0<br=
></div><div dir=3D"auto">(qemu) info snapshots<br></div><div dir=3D"auto">L=
ist of snapshots present on all disks:<br></div><div dir=3D"auto">-ID TAG V=
M SIZE DATE VM CLOCK ICOUNT<br></div><div dir=3D"auto">--- snap0 SIZE yyyy-=
mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE=
 VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:mm=
:ss 0000:00:00.000 --<br></div><div dir=3D"auto">(qemu) loadvm snap0<br></d=
iv><div dir=3D"auto">(qemu) quit<br></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more in=
formation<br></div><div dir=3D"auto">(qemu) savevm snap0<br></div><div dir=
=3D"auto">(qemu) info snapshots<br></div><div dir=3D"auto">List of snapshot=
s present on all disks:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE VM =
CLOCK ICOUNT<br></div><div dir=3D"auto">--- snap0 SIZE yyyy-mm-dd hh:mm:ss =
00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK ICOUN=
T<br></div><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.=
000 --<br></div><div dir=3D"auto">(qemu) loadvm snap0<br></div><div dir=3D"=
auto">(qemu) quit<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">@@=
 -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information<br></=
div><div dir=3D"auto">(qemu) savevm snap0<br></div><div dir=3D"auto">(qemu)=
 info snapshots<br></div><div dir=3D"auto">List of snapshots present on all=
 disks:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE VM CLOCK ICOUNT<br>=
</div><div dir=3D"auto">--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000<br>=
</div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></div><div =
dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<br></div>=
<div dir=3D"auto">(qemu) loadvm snap0<br></div><div dir=3D"auto">(qemu) qui=
t<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">@@ -94,8 +94,8 @@ =
QEMU X.Y.Z monitor - type 'help' for more information<br></div><div dir=3D"=
auto">(qemu) savevm snap0<br></div><div dir=3D"auto">(qemu) info snapshots<=
br></div><div dir=3D"auto">List of snapshots present on all disks:<br></div=
><div dir=3D"auto">-ID TAG VM SIZE DATE VM CLOCK ICOUNT<br></div><div dir=
=3D"auto">--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=
=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+=
-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<br></div><div dir=3D"au=
to">(qemu) loadvm snap0<br></div><div dir=3D"auto">(qemu) quit<br></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">@@ -105,8 +105,8 @@ QEMU X.Y.Z m=
onitor - type 'help' for more information<br></div><div dir=3D"auto">(qemu)=
 savevm snap0<br></div><div dir=3D"auto">(qemu) info snapshots<br></div><di=
v dir=3D"auto">List of snapshots present on all disks:<br></div><div dir=3D=
"auto">-ID TAG VM SIZE DATE VM CLOCK ICOUNT<br></div><div dir=3D"auto">--- =
snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=3D"auto">+ID =
TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+-- snap0 SIZE =
yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<br></div><div dir=3D"auto">(qemu) loa=
dvm snap0<br></div><div dir=3D"auto">(qemu) quit<br></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type =
'help' for more information<br></div><div dir=3D"auto">(qemu) savevm snap0<=
br></div><div dir=3D"auto">(qemu) info snapshots<br></div><div dir=3D"auto"=
>List of snapshots present on all disks:<br></div><div dir=3D"auto">-ID TAG=
 VM SIZE DATE VM CLOCK ICOUNT<br></div><div dir=3D"auto">--- snap0 SIZE yyy=
y-mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DA=
TE VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:=
mm:ss 0000:00:00.000 --<br></div><div dir=3D"auto">(qemu) loadvm snap0<br><=
/div><div dir=3D"auto">(qemu) quit<br></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for mor=
e information<br></div><div dir=3D"auto">(qemu) savevm snap0<br></div><div =
dir=3D"auto">(qemu) info snapshots<br></div><div dir=3D"auto">List of snaps=
hots present on all disks:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE =
VM CLOCK ICOUNT<br></div><div dir=3D"auto">--- snap0 SIZE yyyy-mm-dd hh:mm:=
ss 00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK IC=
OUNT<br></div><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:=
00.000 --<br></div><div dir=3D"auto">(qemu) loadvm snap0<br></div><div dir=
=3D"auto">(qemu) quit<br></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on<br></div><div dir=3D"auto">(qemu) savevm snap0<br></div><div dir=3D"auto=
">(qemu) info snapshots<br></div><div dir=3D"auto">List of snapshots presen=
t on all disks:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE VM CLOCK IC=
OUNT<br></div><div dir=3D"auto">--- snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00=
.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></d=
iv><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<b=
r></div><div dir=3D"auto">(qemu) loadvm snap0<br></div><div dir=3D"auto">(q=
emu) quit<br></div><div dir=3D"auto"><br></div><div dir=3D"auto">Internal s=
napshots on overlay:<br></div><div dir=3D"auto">Snapshot list:<br></div><di=
v dir=3D"auto">-ID TAG VM SIZE DATE VM CLOCK ICOUNT<br></div><div dir=3D"au=
to">-1 snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=3D"aut=
o">+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+1 snap0=
 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<br></div><div dir=3D"auto">Inte=
rnal snapshots on backing file:<br></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=
=3D<br></div><div dir=3D"auto">@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - t=
ype 'help' for more information<br></div><div dir=3D"auto">(qemu) savevm sn=
ap0<br></div><div dir=3D"auto">(qemu) info snapshots<br></div><div dir=3D"a=
uto">List of snapshots present on all disks:<br></div><div dir=3D"auto">-ID=
 TAG VM SIZE DATE VM CLOCK ICOUNT<br></div><div dir=3D"auto">--- snap0 SIZE=
 yyyy-mm-dd hh:mm:ss 00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZ=
E DATE VM_CLOCK ICOUNT<br></div><div dir=3D"auto">+-- snap0 SIZE yyyy-mm-dd=
 hh:mm:ss 0000:00:00.000 --<br></div><div dir=3D"auto">(qemu) loadvm snap0<=
br></div><div dir=3D"auto">(qemu) quit<br></div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Internal snapshots on overlay:<br></div><div dir=3D"auto=
">Snapshot list:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE VM CLOCK I=
COUNT<br></div><div dir=3D"auto">-1 snap0 SIZE yyyy-mm-dd hh:mm:ss 00:00:00=
.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK ICOUNT<br></d=
iv><div dir=3D"auto">+1 snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:00.000 --<br=
></div><div dir=3D"auto">Internal snapshots on backing file:<br></div><div =
dir=3D"auto">Snapshot list:<br></div><div dir=3D"auto">-ID TAG VM SIZE DATE=
 VM CLOCK ICOUNT<br></div><div dir=3D"auto">-1 snap0 SIZE yyyy-mm-dd hh:mm:=
ss 00:00:00.000<br></div><div dir=3D"auto">+ID TAG VM_SIZE DATE VM_CLOCK IC=
OUNT<br></div><div dir=3D"auto">+1 snap0 SIZE yyyy-mm-dd hh:mm:ss 0000:00:0=
0.000 --<br></div><div dir=3D"auto">*** done<br></div><div dir=3D"auto">--<=
br></div><div dir=3D"auto">2.40.1<br></div>  </body>
</html>

------=_Part_5606_866180345.1704880546187--

