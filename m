Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F73C8287FD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rND23-0005ma-J9; Tue, 09 Jan 2024 09:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rND1v-0005Uy-6o
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rND1p-0008LA-Lv
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704810267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=s1pfYPdowOYwfhJ76cMX39pyh95o+l68DPOd009Rn4w=;
 b=jJmNl1sYhEzV7M5UVqa9WELBjNJPdl6Knk7Rt0pwPuJzySgqh4t80h8s8ruegBE6A9K03F
 3TlMqwozGJ9ltMGRmwcLbzzjRSxEG15Dh1upicBtenFOo1xn34F9LlTYMvxn2EXpqAfX91
 9LYxZDz+Me6dvLJcPk83upL/uBWnvMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-_Qgq8ZtZPxWisvwIbTe-nQ-1; Tue, 09 Jan 2024 09:24:24 -0500
X-MC-Unique: _Qgq8ZtZPxWisvwIbTe-nQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCDA1185A78E;
 Tue,  9 Jan 2024 14:24:23 +0000 (UTC)
Received: from localhost (unknown [10.39.195.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96E343C39;
 Tue,  9 Jan 2024 14:24:22 +0000 (UTC)
Date: Tue, 9 Jan 2024 09:24:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>
Subject: Static qemu-user-x86_64 "Unable to find a guest_base to satisfy all
 guest address mapping requirements"
Message-ID: <20240109142420.GA425733@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZBCSiAdsRnXPAJKc"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--ZBCSiAdsRnXPAJKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,
Christophe Fergeau found that Fedora's
qemu-user-static-x86-8.1.3-1.fc39.aarch64 fails when running a
statically linked hello world binary:

  qemu-x86_64-static: /root/podman_hello_world.alpine: Unable to find a gue=
st_base to satisfy all guest address mapping requirements
  0000000000000000-0000000000000fff
  0000000000400000-00000000004047ef

That error message was introduced in QEMU 8.1 commit dd55885516f4
("linux-user: Rewrite non-fixed probe_guest_base").

Fedora's qemu-x86_64-static /proc/self/maps looks like this on aarch64:

00400000-00401000 r--p 00000000 00:22 78921                              /u=
sr/bin/qemu-x86_64-static
^^^^^^^^^^^^^^^^^
00410000-0066b000 r-xp 00010000 00:22 78921                              /u=
sr/bin/qemu-x86_64-static
00670000-0078e000 r--p 00270000 00:22 78921                              /u=
sr/bin/qemu-x86_64-static
00793000-007b0000 r--p 00393000 00:22 78921                              /u=
sr/bin/qemu-x86_64-static
007b0000-007dd000 rw-p 003b0000 00:22 78921                              /u=
sr/bin/qemu-x86_64-static
007dd000-007ef000 rw-p 00000000 00:00 0                                  [h=
eap]
007ef000-008b7000 rw-p 00000000 00:00 0                                  [h=
eap]
ffffe8000000-ffffeffff000 rwxp 00000000 00:00 0=20
ffffeffff000-fffff0000000 ---p 00000000 00:00 0=20
fffff0000000-fffff0021000 rw-p 00000000 00:00 0=20
fffff0021000-fffff4000000 ---p 00000000 00:00 0=20
fffff776c000-fffff77ed000 rw-p 00000000 00:00 0=20
fffff77ed000-fffff77fd000 ---p 00000000 00:00 0=20
fffff77fd000-fffff7ffd000 rw-p 00000000 00:00 0=20
fffff7ffd000-fffff7fff000 r--p 00000000 00:00 0                          [v=
var]
fffff7fff000-fffff8000000 r-xp 00000000 00:00 0                          [v=
dso]
fffffffdf000-1000000000000 rw-p 00000000 00:00 0                         [s=
tack]

Address 0x400000 is used by both the statically linked QEMU and the
statically linked hello world binary:

$ readelf -a podman_hello_world.alpine
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x401047
  Start of program headers:          64 (bytes into file)
  Start of section headers:          75000 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         9
  Size of section headers:           64 (bytes)
  Number of section headers:         27
  Section header string table index: 26

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .note.gnu.pr[...] NOTE             0000000000400238  00000238
       0000000000000030  0000000000000000   A       0     0     8
  [ 2] .note.gnu.bu[...] NOTE             0000000000400268  00000268
       0000000000000024  0000000000000000   A       0     0     4
  [ 3] .init             PROGBITS         0000000000401000  00001000
       0000000000000003  0000000000000000  AX       0     0     1
  [ 4] .text             PROGBITS         0000000000401010  00001010
       0000000000000e90  0000000000000000  AX       0     0     16
  [ 5] .fini             PROGBITS         0000000000401ea0  00001ea0
       0000000000000003  0000000000000000  AX       0     0     1
  [ 6] .rodata           PROGBITS         0000000000402000  00002000
       00000000000001ad  0000000000000001 AMS       0     0     8
  [ 7] .eh_frame         PROGBITS         00000000004021b0  000021b0
       0000000000000034  0000000000000000   A       0     0     8
  [ 8] .init_array       INIT_ARRAY       0000000000403fb8  00002fb8
       0000000000000008  0000000000000008  WA       0     0     8
  [ 9] .fini_array       FINI_ARRAY       0000000000403fc0  00002fc0
       0000000000000008  0000000000000008  WA       0     0     8
  [10] .data.rel.ro      PROGBITS         0000000000403fc8  00002fc8
       0000000000000010  0000000000000000  WA       0     0     8
  [11] .got              PROGBITS         0000000000403fd8  00002fd8
       0000000000000028  0000000000000008  WA       0     0     8
  [12] .data             PROGBITS         0000000000404000  00003000
       0000000000000110  0000000000000000  WA       0     0     32
  [13] .bss              NOBITS           0000000000404120  00003110
       00000000000006d0  0000000000000000  WA       0     0     32
  [14] .comment          PROGBITS         0000000000000000  00003110
       0000000000000031  0000000000000001  MS       0     0     1
  [15] .debug_aranges    PROGBITS         0000000000000000  00003150
       00000000000006a0  0000000000000000           0     0     16
  [16] .debug_info       PROGBITS         0000000000000000  000037f0
       0000000000006157  0000000000000000           0     0     1
  [17] .debug_abbrev     PROGBITS         0000000000000000  00009947
       000000000000247d  0000000000000000           0     0     1
  [18] .debug_line       PROGBITS         0000000000000000  0000bdc4
       0000000000001d6c  0000000000000000           0     0     1
  [19] .debug_frame      PROGBITS         0000000000000000  0000db30
       0000000000000858  0000000000000000           0     0     8
  [20] .debug_str        PROGBITS         0000000000000000  0000e388
       0000000000000ea5  0000000000000001  MS       0     0     1
  [21] .debug_line_str   PROGBITS         0000000000000000  0000f22d
       000000000000044d  0000000000000001  MS       0     0     1
  [22] .debug_loclists   PROGBITS         0000000000000000  0000f67a
       00000000000016bc  0000000000000000           0     0     1
  [23] .debug_rnglists   PROGBITS         0000000000000000  00010d36
       0000000000000431  0000000000000000           0     0     1
  [24] .symtab           SYMTAB           0000000000000000  00011168
       0000000000000c90  0000000000000018          25    62     8
  [25] .strtab           STRTAB           0000000000000000  00011df8
       00000000000005e0  0000000000000000           0     0     1
  [26] .shstrtab         STRTAB           0000000000000000  000123d8
       0000000000000120  0000000000000000           0     0     1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), l (large), p (processor specific)

There are no section groups in this file.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                 0x000000000000028c 0x000000000000028c  R      0x1000
  LOAD           0x0000000000001000 0x0000000000401000 0x0000000000401000
                 0x0000000000000ea3 0x0000000000000ea3  R E    0x1000
  LOAD           0x0000000000002000 0x0000000000402000 0x0000000000402000
                 0x00000000000001e4 0x00000000000001e4  R      0x1000
  LOAD           0x0000000000002fb8 0x0000000000403fb8 0x0000000000403fb8
                 0x0000000000000158 0x0000000000000838  RW     0x1000
  NOTE           0x0000000000000238 0x0000000000400238 0x0000000000400238
                 0x0000000000000030 0x0000000000000030  R      0x8
  NOTE           0x0000000000000268 0x0000000000400268 0x0000000000400268
                 0x0000000000000024 0x0000000000000024  R      0x4
  GNU_PROPERTY   0x0000000000000238 0x0000000000400238 0x0000000000400238
                 0x0000000000000030 0x0000000000000030  R      0x8
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x0000000000002fb8 0x0000000000403fb8 0x0000000000403fb8
                 0x0000000000000048 0x0000000000000048  R      0x1

Oddly, when I compile static QEMU from source on this machine, then the
resulting binary does not use 0x400000 and it can successfully run the
hello world binary. Maybe the address is related to the compiler flags
or something else in Fedora's RPM build environment.

There is a bugzilla tracking this here:
https://bugzilla.redhat.com/show_bug.cgi?id=3D2256916

Any ideas what can be done to solve this problem?

Thanks,
Stefan

--ZBCSiAdsRnXPAJKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWdVxQACgkQnKSrs4Gr
c8iwTQgAnyrA69CFY3YmtOmDpeXDeF5W/CKxuwxuUKQm6S1NNB4d84QQ0Vf0gIdw
k0mGgTP54MMeem6NwNsbRbzexfwwTE7eLoVdlTddG/Gr0P6jZfXwICoa9Wx6kJcd
MaBQlnsAStBHhS6pCewErpirj1ZwpxHwzW9igVi6I61nlwL85hVXzCQNcMCN94IN
+oAw0OYsgHXFNaiAQk+qzfnSceYC/bSrXeKllYss/XQ1oKjrqGv/axnWZkn3XC25
ove/2JzXxsuzh2uPsvF7hNDMnDvFtjqJBXCX+u10NxrDB7Xi4qdt0UbTz5o+Fm3W
lSFMcev30qtvNzZR+A3d6J05XZ/T6A==
=OeAg
-----END PGP SIGNATURE-----

--ZBCSiAdsRnXPAJKc--


