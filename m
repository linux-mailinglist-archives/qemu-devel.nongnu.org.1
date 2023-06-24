Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D773C728
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 08:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCwwX-0004xH-Rc; Sat, 24 Jun 2023 02:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qCwwU-0004wp-Ir
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 02:40:18 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qCwwN-0000Jy-7W
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 02:40:18 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso181669166b.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1687588807; x=1690180807;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4B+21lKxKTxXjdKxGSG9Kq9GEu7ynJBkhDjDeipxVqg=;
 b=oIuawj9IvCA1nYRzevGfiYYmqpUcR8ku0sEgxciw3ntSoMcTI5MfGMhMBwHPSV4Vys
 /x63kzPZq5GMQywYTUVeZWHo1MOdzixI1pY5ZQaMgmylM0S8uEJ2VqkUobp0J8pIQ5KM
 KR0EATvC+yV8ZBkCUPrBq9c79+/36xK/6zeixEIFNmJUd+nF3NHbPUTwDefaYxSvWBrr
 rNEmKcO3i0HyMwZPjk2X+En3NSDHtNwmcug9vyCdm1wr24s9le+d2+7MgsrGB495qhJw
 AY0Hm8YKyP0LkA/dpiCn8SDM7sNJFbWDVyq+e7c5J/MdTnKJybzkxJNN4K3ANSdNy1XE
 u70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687588807; x=1690180807;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4B+21lKxKTxXjdKxGSG9Kq9GEu7ynJBkhDjDeipxVqg=;
 b=EWw4VX/Nqx55VFIbugBIkO9mUSq/AZDmVfZQ/Tj0pOIOsot7jLd8AWUB39ylELdmYK
 Lfch/slEWCQ3e7V6+e5CRSXn+Z0Wqys+eXvzjQUn6O4b/gkaSuIkVVi0yQIHrsMlFeg5
 WJqadPI39N5jQay+Rai8Xk6a99NntW1m3tmp3w35ZaitD1Ji16lTbr3zCMbNfGksBv54
 YPHEXklwApYeipQmsvjsj13hJbvF9d5KYge9heunr5kOern7BXVXqVtOvP3drzmhebcE
 2sDXSvW+Tts042OgNb1ZnVWfLwdUZMKsu1x9uz8KdQgTC1ejb7n4VJJupuPyGPqdlncQ
 29Zw==
X-Gm-Message-State: AC+VfDzrirKkRrgp+iobi50fWvZbqXs7+wrJ56ib5iAKtcN6h87EXc9N
 wbxXOyPQdrREvmX2w5AtHIVLxm6MuvpMOWM2f4QyZZdaNvASRmx030c=
X-Google-Smtp-Source: ACHHUZ45TS9j7Sev4U8zft1IDVH4MczaXJUxkqDUBArrIKJpQfZxs2g3Kmm8J59KlEpDUYLC1wPdWZFNc47izYuEmw4=
X-Received: by 2002:a17:907:2d2c:b0:98d:bc7c:c962 with SMTP id
 gs44-20020a1709072d2c00b0098dbc7cc962mr1686943ejc.45.1687588806666; Fri, 23
 Jun 2023 23:40:06 -0700 (PDT)
MIME-Version: 1.0
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 24 Jun 2023 00:40:33 -0600
Message-ID: <CANCZdfrHEQ=dMfpKGvYBHbXMfbQb9fDQh+bkdZW0Z6zQWVVUCA@mail.gmail.com>
Subject: RFC: bsd-user broken a while ago, is this the right fix?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000059435d05feda6384"
Received-SPF: none client-ip=2a00:1450:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--00000000000059435d05feda6384
Content-Type: text/plain; charset="UTF-8"

This change:

commit f00506aeca2f6d92318967693f8da8c713c163f3
Merge: d37158bb242 87e303de70f
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Wed Mar 29 11:19:19 2023 +0100

    Merge tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu into
staging

    Use a local version of GTree [#285]
    Fix page_set_flags vs the last page of the address space [#1528]
    Re-enable gdbstub breakpoints under KVM

    # -----BEGIN PGP SIGNATURE-----
    #
    # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN846K9+IV8FAmQjcLIdHHJpY2hhcmQu
    # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN846K9+IV8rkgf/ZazodovRKxfaO622
    # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOLSx42T70QstWvBMukjovLMz1+Ttbo1
    # VOvpGH2B5W76l3i+muAlKxFRbBH2kMLTaL+BXtkmkL4FJ9bS8WiPApsL3lEX/q2E
    # 3kqaT3N3C09sWO5oVAPGTUHL0EutKhOar2VZL0+PVPFzL3BNPhnQH9QcbNvDBV3n
    # cx3GSXZyL7Plyi+qwsKf/3Jo+F2wr2NVf3Dqscu9T1N1kI5hSjRpwqUEJzJZ5rei
    # ly/gBXC/J7+WN+x+w2JlN0kWXWqC0QbDfZnj96Pd3owWZ7j4sT9zR5fcNenecxlR
    # 38Bo0w==
    # =ysF7
    # -----END PGP SIGNATURE-----
    # gpg: Signature made Tue 28 Mar 2023 23:56:50 BST
    # gpg:                using RSA key
7A481E78868B4DB6A85A05C064DF38E8AF7E215F
    # gpg:                issuer "richard.henderson@linaro.org"
    # gpg: Good signature from "Richard Henderson <
richard.henderson@linaro.org>" [full]
    # Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF 38E8
AF7E 215F

    * tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu:
      softmmu: Restore use of CPU watchpoint for all accelerators
      softmmu/watchpoint: Add missing 'qemu/error-report.h' include
      softmmu: Restrict cpu_check_watchpoint / address_matches to TCG accel
      linux-user/arm: Take more care allocating commpage
      include/exec: Change reserved_va semantics to last byte
      linux-user: Pass last not end to probe_guest_base
      accel/tcg: Pass last not end to tb_invalidate_phys_range
      accel/tcg: Pass last not end to tb_invalidate_phys_page_range__locked
      accel/tcg: Pass last not end to page_collection_lock
      accel/tcg: Pass last not end to PAGE_FOR_EACH_TB
      accel/tcg: Pass last not end to page_reset_target_data
      accel/tcg: Pass last not end to page_set_flags
      linux-user: Diagnose misaligned -R size
      tcg: use QTree instead of GTree
      util: import GTree as QTree

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

breaks bsd-user. when I merge it to the bsd-user upstream blitz branch I
get memory allocation errors on startup. At least for armv7.

specifically, if I back out the bsd-user part of both
commit 95059f9c313a7fbd7f22e4cdc1977c0393addc7b
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Mar 6 01:26:29 2023 +0300

    include/exec: Change reserved_va semantics to last byte

    Change the semantics to be the last byte of the guest va, rather
    than the following byte.  This avoids some overflow conditions.

    Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

and

commit 49840a4a098149067789255bca6894645f411036
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Mar 6 01:51:09 2023 +0300

    accel/tcg: Pass last not end to page_set_flags

    Pass the address of the last byte to be changed, rather than
    the first address past the last byte.  This avoids overflow
    when the last page of the address space is involved.

    Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1528
    Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

things work again. If I backout parts, it fails still. If I back out only
one of
the two, but not both, then it fails.

What's happening is that we're picking a reserved_va that's overflowing when
we add 1 to it. this overflow goes away if I make the overflows not
possible:
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index a88251f8705..bd86c0a8689 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -237,8 +237,8 @@ unsigned long last_brk;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong addr;
-    abi_ulong end_addr;
+    uint64_t addr;
+    uint64_t end_addr;
     int prot;
     int looped = 0;

My question is, is this the right fix? The old code avoided the overflow in
two ways. 1 it set reserve_va to a page short (which if I fix that, it
works better, but not quite right). and it never computes an address that
may overflow (which the new code does without the above patch).

It seems to work, but it looks super weird.

Comments?

Warrner

--00000000000059435d05feda6384
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This change:</div><div><br></div><div>commit f00506ae=
ca2f6d92318967693f8da8c713c163f3<br>Merge: d37158bb242 87e303de70f<br>Autho=
r: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt;<br>Date: =C2=A0 Wed Mar 29 11:19:19 2023 +0100<br><b=
r>=C2=A0 =C2=A0 Merge tag &#39;pull-tcg-20230328&#39; of <a href=3D"https:/=
/gitlab.com/rth7680/qemu">https://gitlab.com/rth7680/qemu</a> into staging<=
br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Use a local version of GTree [#285]<br>=
=C2=A0 =C2=A0 Fix page_set_flags vs the last page of the address space [#15=
28]<br>=C2=A0 =C2=A0 Re-enable gdbstub breakpoints under KVM<br>=C2=A0 =C2=
=A0 <br>=C2=A0 =C2=A0 # -----BEGIN PGP SIGNATURE-----<br>=C2=A0 =C2=A0 #<br=
>=C2=A0 =C2=A0 # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN846K9+IV8FAmQjcLIdHHJpY2=
hhcmQu<br>=C2=A0 =C2=A0 # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN846K9+IV8rkgf/Z=
azodovRKxfaO622<br>=C2=A0 =C2=A0 # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOLSx42T=
70QstWvBMukjovLMz1+Ttbo1<br>=C2=A0 =C2=A0 # VOvpGH2B5W76l3i+muAlKxFRbBH2kML=
TaL+BXtkmkL4FJ9bS8WiPApsL3lEX/q2E<br>=C2=A0 =C2=A0 # 3kqaT3N3C09sWO5oVAPGTU=
HL0EutKhOar2VZL0+PVPFzL3BNPhnQH9QcbNvDBV3n<br>=C2=A0 =C2=A0 # cx3GSXZyL7Ply=
i+qwsKf/3Jo+F2wr2NVf3Dqscu9T1N1kI5hSjRpwqUEJzJZ5rei<br>=C2=A0 =C2=A0 # ly/g=
BXC/J7+WN+x+w2JlN0kWXWqC0QbDfZnj96Pd3owWZ7j4sT9zR5fcNenecxlR<br>=C2=A0 =C2=
=A0 # 38Bo0w=3D=3D<br>=C2=A0 =C2=A0 # =3DysF7<br>=C2=A0 =C2=A0 # -----END P=
GP SIGNATURE-----<br>=C2=A0 =C2=A0 # gpg: Signature made Tue 28 Mar 2023 23=
:56:50 BST<br>=C2=A0 =C2=A0 # gpg: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0using RSA key 7A481E78868B4DB6A85A05C064DF38E8AF7E215F<br>=
=C2=A0 =C2=A0 # gpg: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0issuer &quot;<a href=3D"mailto:richard.henderson@linaro.org">richard.hen=
derson@linaro.org</a>&quot;<br>=C2=A0 =C2=A0 # gpg: Good signature from &qu=
ot;Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt;&quot; [full]<br>=C2=A0 =C2=A0 # Primary =
key fingerprint: 7A48 1E78 868B 4DB6 A85A =C2=A005C0 64DF 38E8 AF7E 215F<br=
>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 * tag &#39;pull-tcg-20230328&#39; of <a hr=
ef=3D"https://gitlab.com/rth7680/qemu">https://gitlab.com/rth7680/qemu</a>:=
<br>=C2=A0 =C2=A0 =C2=A0 softmmu: Restore use of CPU watchpoint for all acc=
elerators<br>=C2=A0 =C2=A0 =C2=A0 softmmu/watchpoint: Add missing &#39;qemu=
/error-report.h&#39; include<br>=C2=A0 =C2=A0 =C2=A0 softmmu: Restrict cpu_=
check_watchpoint / address_matches to TCG accel<br>=C2=A0 =C2=A0 =C2=A0 lin=
ux-user/arm: Take more care allocating commpage<br>=C2=A0 =C2=A0 =C2=A0 inc=
lude/exec: Change reserved_va semantics to last byte<br>=C2=A0 =C2=A0 =C2=
=A0 linux-user: Pass last not end to probe_guest_base<br>=C2=A0 =C2=A0 =C2=
=A0 accel/tcg: Pass last not end to tb_invalidate_phys_range<br>=C2=A0 =C2=
=A0 =C2=A0 accel/tcg: Pass last not end to tb_invalidate_phys_page_range__l=
ocked<br>=C2=A0 =C2=A0 =C2=A0 accel/tcg: Pass last not end to page_collecti=
on_lock<br>=C2=A0 =C2=A0 =C2=A0 accel/tcg: Pass last not end to PAGE_FOR_EA=
CH_TB<br>=C2=A0 =C2=A0 =C2=A0 accel/tcg: Pass last not end to page_reset_ta=
rget_data<br>=C2=A0 =C2=A0 =C2=A0 accel/tcg: Pass last not end to page_set_=
flags<br>=C2=A0 =C2=A0 =C2=A0 linux-user: Diagnose misaligned -R size<br>=
=C2=A0 =C2=A0 =C2=A0 tcg: use QTree instead of GTree<br>=C2=A0 =C2=A0 =C2=
=A0 util: import GTree as QTree<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Signed-o=
ff-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.=
maydell@linaro.org</a>&gt;<br><br></div><div>breaks bsd-user. when I merge =
it to the bsd-user upstream blitz branch I get memory allocation errors on =
startup. At least for armv7.<br></div><div><br></div><div>specifically, if =
I back out the bsd-user part of both</div><div>commit 95059f9c313a7fbd7f22e=
4cdc1977c0393addc7b<br>Author: Richard Henderson &lt;<a href=3D"mailto:rich=
ard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>Date: =C2=
=A0 Mon Mar 6 01:26:29 2023 +0300<br><br>=C2=A0 =C2=A0 include/exec: Change=
 reserved_va semantics to last byte<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Chan=
ge the semantics to be the last byte of the guest va, rather<br>=C2=A0 =C2=
=A0 than the following byte.=C2=A0 This avoids some overflow conditions.<br=
>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud&lt;C3&g=
t;&lt;A9&gt; &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>=
&gt;<br>=C2=A0 =C2=A0 Signed-off-by: Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&gt;<br><br=
></div><div>and</div><div><br></div><div>commit 49840a4a098149067789255bca6=
894645f411036<br>Author: Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt;<br>Date: =C2=A0 Mo=
n Mar 6 01:51:09 2023 +0300<br><br>=C2=A0 =C2=A0 accel/tcg: Pass last not e=
nd to page_set_flags<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Pass the address of=
 the last byte to be changed, rather than<br>=C2=A0 =C2=A0 the first addres=
s past the last byte.=C2=A0 This avoids overflow<br>=C2=A0 =C2=A0 when the =
last page of the address space is involved.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=
=A0 Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1528=
">https://gitlab.com/qemu-project/qemu/-/issues/1528</a><br>=C2=A0 =C2=A0 R=
eviewed-by: Philippe Mathieu-Daud&lt;C3&gt;&lt;A9&gt; &lt;<a href=3D"mailto=
:philmd@linaro.org">philmd@linaro.org</a>&gt;<br>=C2=A0 =C2=A0 Signed-off-b=
y: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt;<br><br></div><div>things work again. If =
I backout parts, it fails still. If I back out only one of</div><div>the tw=
o, but not both, then it fails.</div><div><br></div><div>What&#39;s happeni=
ng is that we&#39;re picking a reserved_va that&#39;s overflowing when</div=
><div>we add 1 to it. this overflow goes away if I make the overflows not p=
ossible:</div><div>diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>index =
a88251f8705..bd86c0a8689 100644<br>--- a/bsd-user/mmap.c<br>+++ b/bsd-user/=
mmap.c<br>@@ -237,8 +237,8 @@ unsigned long last_brk;<br>=C2=A0static abi_u=
long mmap_find_vma_reserved(abi_ulong start, abi_ulong size,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong ali=
gnment)<br>=C2=A0{<br>- =C2=A0 =C2=A0abi_ulong addr;<br>- =C2=A0 =C2=A0abi_=
ulong end_addr;<br>+ =C2=A0 =C2=A0uint64_t addr;<br>+ =C2=A0 =C2=A0uint64_t=
 end_addr;<br>=C2=A0 =C2=A0 =C2=A0int prot;<br>=C2=A0 =C2=A0 =C2=A0int loop=
ed =3D 0;<br>=C2=A0</div><div>My question is, is this the right fix? The ol=
d code avoided the overflow in two ways. 1 it set reserve_va to a page shor=
t (which if I fix that, it works better, but not quite right). and it never=
 computes an address that may overflow (which the new code does without the=
 above patch).</div><div><br></div><div>It seems to work, but it looks supe=
r weird.</div><div><br></div><div>Comments?</div><div><br></div><div>Warrne=
r<br></div></div>

--00000000000059435d05feda6384--

