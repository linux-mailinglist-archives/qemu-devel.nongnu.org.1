Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C176C0DE
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:29:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymU-0001K7-LD; Tue, 01 Aug 2023 19:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymS-0001JE-Ga
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymO-00077x-Td
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932468; x=1691537268; i=deller@gmx.de;
 bh=u2YNxFmEdrBbo7ggn7oE7m69UMkwd/D2Njq/BE8FFh8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oLcqeXmuYGx8dosoZg5i1bXs9+BEOsGCCu/O36t+7LMdP22kivIiisA4q/IqldddCHyxXHO
 mRkB755dowGBdaBmZJaFOhA1g0kq5jBowZmvlXDg2gFptKBx3VF4bd06cB0lCFXJ63qh58jPw
 KzNIr3XnhfVhAgw+oQV1qfCeJ+hGPbAnO4CcRR1yozqZ7YYU2OiXv748dwEmHKFpcDlX7kROu
 1AfYNu1PUnN9NEWk3ApF9U/XKAV/99xoMOhiwvpGFlbhVK+1XOublM4ROQBhjWxZTfvuUftAD
 i7LAKN1krOoC7ULhspNs7bF7fGzYWQabqVrpIZF3OQZczAPur2Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbivG-1pr6GQ0F9a-00dJPI; Wed, 02
 Aug 2023 01:27:48 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 5/8] linux-user: Do not align brk with host page size
Date: Wed,  2 Aug 2023 01:27:42 +0200
Message-ID: <20230801232745.4125-6-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5C5yuTtJdLQAlkoS3iX42TV9t3riQMIWnqLao4B1qfUoMBgVihv
 Ab/hMXS62poXaX4L/Feq0zGkdNzrN02R/rgmQ//VPT+7JLLxHXr6YbVRypRUvbV8eqBfFGO
 YBtUiTXTV1Grz31LZG9cyhH3Dj1uaspMb8ETiWGfbLqLFCNIf/O5EeJNtvtSUEDZ5/QSm2G
 yKfbHtvaAvEukhfEsW0Gw==
UI-OutboundReport: notjunk:1;M01:P0:GOqbO38/KBg=;XBZnqVcj47JsbdPMzBzkDzKWvok
 azzWz3loQLJGYREeQhegl8oSxkdwGyd0oeSCDmOHzmrFMtpDbGQOH/Slh3rp2LIlcTUX0iIYk
 EiNDutECDxq46ErZIQDGG/gziWh0JeqneR20n8fjEwMaqYC89CqzaBYQY4zER5wHEMlzcaGhA
 groOVjhkEVi1CrlVuZtxf5ar/u8Tr6OedVRgd6Hl5TqdBbo0xqHWzdfPV+Ivc7ib9Z+Ug93Oe
 jYUla2qDUKr1YiVuqGMCfrsKySbnvS89naY/SpC+76dT8fsbedHAG4K7i01xWFiyyCtkdesBu
 xcOaHFDlopODQWIPhukViHLgoOAFkERDJggWYowH4wkyMyRCAckf7ZVRTRA+Sh9wSdfLrRD9Q
 i/paP4pBcWGYavTm1DPZuUtsw6c8N5iPFF8OeJJAvvvKg6cea1wqvf5kgEThVHtFg/V9QwXJ2
 NjrqZKY9+tYn7SuIuhnSyO9q1lGCZQXcBN17ea4bPPbvTfogQqygvSfhffwD28tdnrx/QDonf
 gKQQteNpLeWRQ+rGDoRu6J1i/UFwjSD+9OuMpOYLMW2KTaT7/hnx2h8f6q3AFV54u5Pi/92JQ
 JJsaCt0oB0h9YRT5COdCafs57PX3pVImJ+Eks3A32bK/3bwhPkINNt3u8u3uRPsJZ+PUDtABu
 nT24GSIz/1wcjIj8YT/h1pob20DHXxfDAlfZvJ/WrCafBRDQOeMWk4jSMvMS97puuaQyUQVCi
 4f6Wj+LhdHqPHli6KCG7zUrZeOwRVkHIldCYT3SFtkmMwRQXBUHyFSYAEMix5D/im+oIAjCBX
 cxOv9FXMd7GuZPuAyaifOKY9mqS4o9zWnpBBBk3zKpD4eqqkwsKlYCYmZ0vmXokGvMJAFK52W
 B/OoD9isYiYKSE08AHOdoNVetC9qLoXsEdsEEVNQNIAkvhpEVQmvaTyg9LgRehk9sm5dpdeA0
 YRCR/qmTqElPBdv8NNpbb6xHDh4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

do_brk() minimizes calls into target_mmap() by aligning the address
with host page size, which is potentially larger than the target page
size. However, the current implementation of this optimization has two
bugs:

- The start of brk is rounded up with the host page size while brk
  advertises an address aligned with the target page size as the
  beginning of brk. This makes the beginning of brk unmapped.
- Content clearing after mapping is flawed. The size to clear is
  specified as HOST_PAGE_ALIGN(brk_page) - brk_page, but brk_page is
  aligned with the host page size so it is always zero.

This optimization actually has no practical benefit. It makes difference
when brk() is called multiple times with values in a range of the host
page size. However, sophisticated memory allocators try to avoid to
make such frequent brk() calls. For example, glibc 2.37 calls brk() to
shrink the heap only when there is a room more than 128 KiB. It is
rare to have a page size larger than 128 KiB if it happens.

Let's remove the optimization to fix the bugs and make the code simpler.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1616
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/elfload.c |  4 ++--
 linux-user/syscall.c | 54 ++++++++++----------------------------------
 2 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..2aee2298ec 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3678,8 +3678,8 @@ int load_elf_binary(struct linux_binprm *bprm, struc=
t image_info *info)
      * to mmap pages in this space.
      */
     if (info->reserve_brk) {
-        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve_b=
rk);
+        abi_ulong start_brk =3D TARGET_PAGE_ALIGN(info->brk);
+        abi_ulong end_brk =3D TARGET_PAGE_ALIGN(info->brk + info->reserve=
_brk);
         target_munmap(start_brk, end_brk - start_brk);
     }

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ebdc8c144c..475260b7ce 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -802,81 +802,51 @@ static inline int host_to_target_sock_type(int host_=
type)
 }

 static abi_ulong target_brk, initial_target_brk;
-static abi_ulong brk_page;

 void target_set_brk(abi_ulong new_brk)
 {
     target_brk =3D TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk =3D target_brk;
-    brk_page =3D HOST_PAGE_ALIGN(target_brk);
 }

 /* do_brk() must return target values and target errnos. */
 abi_long do_brk(abi_ulong brk_val)
 {
     abi_long mapped_addr;
-    abi_ulong new_alloc_size;
-    abi_ulong new_brk, new_host_brk_page;
+    abi_ulong new_brk;
+    abi_ulong old_brk;

     /* brk pointers are always untagged */

-    /* return old brk value if brk_val unchanged */
-    if (brk_val =3D=3D target_brk) {
-        return target_brk;
-    }
-
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
         return target_brk;
     }

     new_brk =3D TARGET_PAGE_ALIGN(brk_val);
-    new_host_brk_page =3D HOST_PAGE_ALIGN(brk_val);
+    old_brk =3D TARGET_PAGE_ALIGN(target_brk);

-    /* brk_val and old target_brk might be on the same page */
-    if (new_brk =3D=3D TARGET_PAGE_ALIGN(target_brk)) {
-        /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
+    /* new and old target_brk might be on the same page */
+    if (new_brk =3D=3D old_brk) {
         target_brk =3D brk_val;
         return target_brk;
     }

     /* Release heap if necesary */
-    if (new_brk < target_brk) {
-        /* empty remaining bytes in (possibly larger) host page */
-        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
-
-        /* free unused host pages and set new brk_page */
-        target_munmap(new_host_brk_page, brk_page - new_host_brk_page);
-        brk_page =3D new_host_brk_page;
+    if (new_brk < old_brk) {
+        target_munmap(new_brk, old_brk - new_brk);

         target_brk =3D brk_val;
         return target_brk;
     }

-    if (new_host_brk_page > brk_page) {
-        new_alloc_size =3D new_host_brk_page - brk_page;
-        mapped_addr =3D target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ | PROT_WRITE,
-                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PR=
IVATE,
-                                  0, 0);
-    } else {
-        new_alloc_size =3D 0;
-        mapped_addr =3D brk_page;
-    }
-
-    if (mapped_addr =3D=3D brk_page) {
-        /* Heap contents are initialized to zero, as for anonymous
-         * mapped pages.  Technically the new pages are already
-         * initialized to zero since they *are* anonymous mapped
-         * pages, however we have to take care with the contents that
-         * come from the remaining part of the previous page: it may
-         * contains garbage data due to a previous heap usage (grown
-         * then shrunken).  */
-        memset(g2h_untagged(brk_page), 0, HOST_PAGE_ALIGN(brk_page) - brk=
_page);
+    mapped_addr =3D target_mmap(old_brk, new_brk - old_brk,
+                              PROT_READ | PROT_WRITE,
+                              MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVAT=
E,
+                              0, 0);

+    if (mapped_addr =3D=3D old_brk) {
         target_brk =3D brk_val;
-        brk_page =3D new_host_brk_page;
         return target_brk;
     }

=2D-
2.41.0


