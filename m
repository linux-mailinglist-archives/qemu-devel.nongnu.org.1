Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B576ED79
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZpy-0007tn-Qf; Thu, 03 Aug 2023 11:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRZpc-0007sD-O2
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:01:41 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRZpa-0007im-9w
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691074894; x=1691679694; i=deller@gmx.de;
 bh=PBUojLBTAPqa8wqm9v3UbyRdTCUihnweprPUVRYppAk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=twcmdb3RAMvep+LF5QqBibjV5gXJ/DzkrfaaA1co42e3cLSW5rraZEi4/Hw6agntbspmUSb
 eFK68CW1JRPb5s6dL0nNbYRHnoa9vYpG20iZXD4Ow/GqG5wFxTGhdMXHIyHz5NNduoL5JUYel
 cZPaqiku6ASq85W1ShKUxUFNhDxE7GFC0pBTXb232ljmPvqvji3OsmiAN3dZLIzLKoBzhDogT
 OMa3POLM0hoLuyzhQlqzaPon2Fhh2SEbTj4lxJitMFrccV42w7IYYnhLenXzfCFDUsGiob2cN
 wkIJljmvf/qMHAYJWftOUcFHJrveVubBgSTpN3sgGndUpVsqgfgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.147.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1psF4w1AI4-00ZP1H; Thu, 03
 Aug 2023 17:01:34 +0200
Date: Thu, 3 Aug 2023 17:01:32 +0200
From: Helge Deller <deller@gmx.de>
To: Joel Stanley <joel@jms.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, akihiko.odaki@daynix.com
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Message-ID: <ZMvBTMpi9jDVWDiP@p100>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
 <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
X-Provags-ID: V03:K1:P89SRBzScudyZNWuSPqbR/PaNhc/sQAFeVYztf2AY/MkfNk/HTf
 s9s6jwE8WIO1IYct2PQYqUW+0a8l9cKVd95rUvvzsxfN2j6xF9P6IAsINk4iQsdE4Fb6sZZ
 JQczzfxiEgwJRboquJ5nri9KEpKee3prrz0ThImeBYxpSp5JhqSUVqDsHF7erpDiu6qEY6c
 2i9k7I778aPJ8dii4Aszg==
UI-OutboundReport: notjunk:1;M01:P0:GAny/nA/Zgo=;rvFRs3e755Ynw7/9XvYvwec0Ckg
 jHtkfBrKp7Uqd2BZHGT5wLgrPZMUHKrglRvQ+QtD0OIXd7XiiyncY0EWS5k+OUY8UVUuebhc7
 euPEhPL+DMkS6SIxLNMspzx3gll34pmuRQBqbXxFLs4ZlQzUiDFLLjb4d5cBMIhbqb0agZZJV
 mVgfMwPPWuScTCeGiBATk9ji4iMBk4XQAJkGvj74BJUR7fJ5SMWN/xOUeIj2F+0yaU7cPhC/F
 EtmUGG7okSOlwbEnpIn2FoiolIcGQdIBFP6OwGSEjJ3GvLuKKcW8Y2S0OAK75Il7o6tfe1aoD
 mRpLkgR/ICTj5CdL+tmFYWWDQRE/dx8RaRcq5eOddoESYe+hsRetr+W15067ITtTOP55KdmA1
 2Y8cxd2/b6HC3rHCNkP4dqXuuX4zaLlKZVwLFm2OICbDGJCUefziyA5gPg4y86T5fA/BeyWWD
 6Hz+cHg0iT5uN/I/8Cp26Jbt8ZWwHRUVRgE6Ke7PJt4Qk+P6wRvz9YPsfX2ZwSS1rsqT387NG
 mSTFDquVeaKifV3JQ6uGbmRi1jHoD5YtbWjRdekH0J9DYZeWlBj2t0+3gMg6wZxNesy8YwkNW
 ej3rNq5kgW1nvU8FJmIY+GA5FEpPjmjzlgTHDSwiUbcHwDlZjEwxhHa0Dhjp7b2RG4TY9nG0V
 Gb2Da/ODfwqkDwJ64NV3917cBDRpnWxJgoHypN5qGJ/Erm1j1O+9DNcnOjDwoGgQ3gE6GMCa8
 r/jyyfEsqvki72DrQjH8WmDvbg9xclBWtnzn4JqAt6v29YFK78gn9VycJ6offmz3AWNp9FXol
 kEmJdWxCtP/GeR/ZxLrAJLGm2PrDdGhPN7dNcAty9dkfGSGIkuwn0tXVxnZ5rpby2mIUMbBfH
 Z/FxL4TMXaaWwl4JE4wre3B/7318eZxvhQOvdaMd1RjiA+OGQqbLudNSsCqKkll4d9+SKjPhP
 OcOKig==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

* Joel Stanley <joel@jms.id.au>:
> On Thu, 3 Aug 2023 at 13:55, Helge Deller <deller@gmx.de> wrote:
> > > 143551 brk(NULL) =3D 0x0009b000
> > > 143551 brk(0x0009b8fc) =3D 0x0009b000
> >
> > I think the problem is the brk with 9b000 here.
> > It's not 64k aligned (=3Dpages size of your ppc64le).
> >
> > Please try with this patch on top of Richard's series:
> >
> > > @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_n=
ame, int image_fd,
> > >       info->end_code =3D 0;
> > >       info->start_data =3D -1;
> > >       info->end_data =3D 0;
> > > -    info->brk =3D .....
> > change that to become:
> >      info->brk =3D HOST_PAGE_ALIGN(hiaddr);
>
> That stopped the crashing, and the binaries seem to run fine. I tested
> on two hosts: ppc64le (64K) and arm64 (16K).

Great!

That made re-read Akihiko's patch:
=2D---
Author: Akihiko Odaki <akihiko.odaki@daynix.com>
    linux-user: Do not align brk with host page size

    do_brk() minimizes calls into target_mmap() by aligning the address
    with host page size, which is potentially larger than the target page
    size. However, the current implementation of this optimization has two
    bugs:

    - The start of brk is rounded up with the host page size while brk
      advertises an address aligned with the target page size as the
      beginning of brk. This makes the beginning of brk unmapped.
=2D---
this patch has wrong assumptions.

The start of brk always needs to be host page aligned.
It's not an optimization, but a requirement, since brk needs to be
located on a host-aligned page which may get different permissions
than the page before it (where code from the binary may be located).

I wonder if we need that patch at all.


Joel, could you give the patch below on top of git head (no other
patches applied) a spin?
(I just tested it here locally on a full range of linux-user chroots)

I think this is ALL what's needed for git head to fix the static binary
issues, has a nice preparation for Richard's ELF_ET_DYN_BASE patches.

If it does, it replaces patches 1,2 & 4-6 from Richard's v7 patch
series.

Helge



diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 861ec07abc..88d9e4056e 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3021,8 +3021,10 @@ static void load_elf_image(const char *image_name, =
int image_fd,
     struct elfhdr *ehdr =3D (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
+    unsigned long load_offset =3D 0;
     int i, retval, prot_exec;
     Error *err =3D NULL;
+    bool is_main_executable;

     /* First of all, some simple consistency checks */
     if (!elf_check_ident(ehdr)) {
@@ -3106,28 +3108,8 @@ static void load_elf_image(const char *image_name, =
int image_fd,
         }
     }

-    if (pinterp_name !=3D NULL) {
-        /*
-         * This is the main executable.
-         *
-         * Reserve extra space for brk.
-         * We hold on to this space while placing the interpreter
-         * and the stack, lest they be placed immediately after
-         * the data segment and block allocation from the brk.
-         *
-         * 16MB is chosen as "large enough" without being so large as
-         * to allow the result to not fit with a 32-bit guest on a
-         * 32-bit host. However some 64 bit guests (e.g. s390x)
-         * attempt to place their heap further ahead and currently
-         * nothing stops them smashing into QEMUs address space.
-         */
-#if TARGET_LONG_BITS =3D=3D 64
-        info->reserve_brk =3D 32 * MiB;
-#else
-        info->reserve_brk =3D 16 * MiB;
-#endif
-        hiaddr +=3D info->reserve_brk;
-
+    is_main_executable =3D (pinterp_name !=3D NULL);
+    if (is_main_executable) {
         if (ehdr->e_type =3D=3D ET_EXEC) {
             /*
              * Make sure that the low address does not conflict with
@@ -3136,10 +3118,11 @@ static void load_elf_image(const char *image_name,=
 int image_fd,
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
             /*
-             * The binary is dynamic, but we still need to
+             * The binary is dynamic (pie-executabe), but we still need t=
o
              * select guest_base.  In this case we pass a size.
              */
             probe_guest_base(image_name, 0, hiaddr - loaddr);
+            load_offset =3D 0 /* TODO: should be ELF_ET_DYN_BASE */;
         }
     }

@@ -3157,9 +3140,9 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr =3D target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_N=
ONE,
+    load_addr =3D target_mmap(loaddr + load_offset, (size_t)hiaddr - load=
dr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
-                            (ehdr->e_type =3D=3D ET_EXEC ? MAP_FIXED : 0)=
,
+                            (is_main_executable ? MAP_FIXED : 0),
                             -1, 0);
     if (load_addr =3D=3D -1) {
         goto exit_mmap;
@@ -3194,7 +3177,8 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     info->end_code =3D 0;
     info->start_data =3D -1;
     info->end_data =3D 0;
-    info->brk =3D 0;
+    /* possible start for brk is behind all sections of this ELF file. */
+    info->brk =3D HOST_PAGE_ALIGN(load_offset + hiaddr);
     info->elf_flags =3D ehdr->e_flags;

     prot_exec =3D PROT_EXEC;
@@ -3288,9 +3272,6 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
                     info->end_data =3D vaddr_ef;
                 }
             }
-            if (vaddr_em > info->brk) {
-                info->brk =3D vaddr_em;
-            }
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type =3D=3D PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -3618,6 +3599,15 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)

     if (elf_interpreter) {
         load_elf_interp(elf_interpreter, &interp_info, bprm->buf);
+        /*
+	 * Use brk address of interpreter if it was loaded above the
+	 * executable and leaves less than 16 MB for heap.
+	 * This happens e.g. with static binaries on armhf.
+         */
+        if (interp_info.brk > info->brk &&
+            interp_info.load_bias - info->brk < 16 * MiB)  {
+            info->brk =3D interp_info.brk;
+        }

         /* If the program interpreter is one of these two, then assume
            an iBCS2 image.  Otherwise assume a native linux image.  */
@@ -3672,17 +3662,6 @@ int load_elf_binary(struct linux_binprm *bprm, stru=
ct image_info *info)
     bprm->core_dump =3D &elf_core_dump;
 #endif

-    /*
-     * If we reserved extra space for brk, release it now.
-     * The implementation of do_brk in syscalls.c expects to be able
-     * to mmap pages in this space.
-     */
-    if (info->reserve_brk) {
-        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
-        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve_b=
rk);
-        target_munmap(start_brk, end_brk - start_brk);
-    }
-
     return 0;
 }



