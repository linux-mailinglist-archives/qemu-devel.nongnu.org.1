Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140476C529
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 08:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR53y-0005Jt-BM; Wed, 02 Aug 2023 02:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR53v-0005Jl-VS
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:10:24 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qR53u-0006EN-CD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 02:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690956617; x=1691561417; i=deller@gmx.de;
 bh=LYLzkpPmRUkuwQvqNtF1r4bP8TSxjzpZrPGMFSJYNk4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AxppvWT+cdg+V+li9Jqqk5bEl2kL1IEU9DIc1BbdyzDuCJSTqVWW3Hr6fmOt5Aw6k1+HOfP
 0j3ga8loitUvHetvj5T1fM9elIWbIVzUBn5etb9ss5dJqtvU9bOebbDk9daDeouiYmueS3Jpc
 1JbKlrVATtDvTaYxHc/ZxawYRCQXAdQlY+REqjNfhSrD0/spxZI4Hx7J4P29QiG1Wh+hLDGhD
 6agz4RJoBbH0c1QqwgsxxTccvUFjBCgm0yLlOwsovdJ9TD17Mvx2ue1tT9niHfrrbS8X9dDEV
 KEbvE+v1G29wjerv3ie0BMwVI1+VWV4l44LGIhcpGZIaUh7XHS0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.146.69]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1qSjUN2roc-001eg7; Wed, 02
 Aug 2023 08:10:17 +0200
Date: Wed, 2 Aug 2023 08:10:16 +0200
From: Helge Deller <deller@gmx.de>
To: Joel Stanley <joel@jms.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v6 0/8] linux-user: brk fixes
Message-ID: <ZMnzSBlYnO/VeywC@p100>
References: <20230801232745.4125-1-deller@gmx.de>
 <CACPK8XfGNcDEPEsJkcfPjfhCx76ioYr4uOmXK6ziwb9iRwBaaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfGNcDEPEsJkcfPjfhCx76ioYr4uOmXK6ziwb9iRwBaaA@mail.gmail.com>
X-Provags-ID: V03:K1:NW+uZHdyHqSma9p7UGxB3wmcsU/SfVIj82Lthy6xdt+/F2U0O01
 KM9I80HbbWDq0yCfvoa/Vh6muxW8ix0yXFLXSCdQszM13yRXtd/I6adsubY29HB7Kj9C/kT
 D1Uf9a8eWBWZHXAoZw00LMIC6/txgLKOoZ/5M8y0vo1h/AlEe7YwBNx/P7RS1GKYuuWhI+g
 tYuDk5pkJBFTMG/W2DGrg==
UI-OutboundReport: notjunk:1;M01:P0:Edhx0L+s0Fw=;g2jD29MzJjkUWb3dOrNW0JSdJjw
 Pl918GqS4bDfAXzebkGuugvdizMZMZezYWOrNEx6tU871VTTHuEQ1NrrsYu6CjniPS8VhHPsE
 t6mFr7QdNAX5L+b0+xTMkrwuWoBkmlrEQowMux6SNHSb8NStbpU1H+3FuhUwCtlhJy7nPO1Cl
 S5iXNWMGsGVAbyswe0swXG7wh6yuaeihGx9o1OEAFdztvyxqHoZerTvs8380N3OmgCR+Y7yk/
 4HWv6Dc5TT90jOFJyR3IwoeF+irL32boHBQKUcU3JSozlm/+eY0mSmye1slU8ZAmNJT2lpdNV
 1fHgJMQhh236tHYoTFiRvIp30kNQHcFFkvyjTtN4rZCv3mrmjWvFN2JopQQY9qcJieDLoegdS
 c/ACxJxTnCdvRONFpVLc4SRf9G11b7gCOHgxnfeKmhKEsBQXd/WcrRv0U2q3xMo3aYFbdIp/q
 066dd70SW2HullKJo7jTgTpVgN2PN7bndVNfs3VrRVQbA8IuYjtmqW5VKjOs4EERuh8IWJtbw
 o2RqIhM07YLeIzOsOHGd04+qnKTxxcse457wccuQpVyWz2lP4F7SjBWJWBeP5KGCRN707tE3E
 FS0Hn5eEuILKJl69dFmWOIp9n3lyyNTA274mO8tMg4niqKMIKnmnA3y4pe48Pl+Rv1pKBEsep
 Vnq3SEYgM+OKjq85U+YV+AxgTyAFU1olO7yKG5qhdlZY3qsSL119SaodJQwRw2jQRNYztnUck
 eaHyPzaQ7GQdxp6dqchjFZbSuvxplrPcsXFisADWhFR0oDKvr1QOOsY+3d0j9XVRFVUIXGSP3
 4okmYfEL/KeZOl0bs/94iqM9EzgVMB3Jcav7HVFXtVhLIKkkIHMTT4fXjWRq/oCluqgqOrA+K
 ww9gSuCkWM0LTWrtIxIdV21fSnnUmnI3ADAGCPmcY1V0MZ12Z4gj0ohULw6tWlR8VT5Ibyi5G
 eioKcA==
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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
> On Tue, 1 Aug 2023 at 23:28, Helge Deller <deller@gmx.de> wrote:
> >
> > This patch series is a fix-up for some current problems
> > regarding heap memory / brk handling in qemu which happens
> > on some 32-bit platforms, e.g. problems loading static
> > binaries.
> >
> > This series includes the 5 patches from Akihiko Odaki
> > with some additional fixes and cleanups by me.
>
> This has the same segfault as the branch that I previously tested,
> when running on a ppc64le host..
>
> As a reminder, the ppc64le machine (normally, and does in this case)
> uses a 64K page size. I think this is a detail that is missing from
> your chroot testing.

Could you try with this hunk on top of the patch series ?

Helge

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8f5a79b537..a61e3d1080 100644
=2D-- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3178,7 +3178,7 @@ static void load_elf_image(const char *image_name, i=
nt image_fd,
     info->start_data =3D -1;
     info->end_data =3D 0;
     /* possible start for brk is behind all sections of this ELF file. */
-    info->brk =3D TARGET_PAGE_ALIGN(load_offset + hiaddr);
+    info->brk =3D HOST_PAGE_ALIGN(load_offset + hiaddr);
     info->elf_flags =3D ehdr->e_flags;

     prot_exec =3D PROT_EXEC;

