Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B38744235
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIq7-0001XF-Dj; Fri, 30 Jun 2023 14:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qFIq4-0001X4-1q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:27:24 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qFIq1-0002WO-9P
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:27:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so3482092e87.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1688149639; x=1690741639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l1aO9RpzRrol6X6DhycWh+LBYqZaMdJEYX6msg4Tdv0=;
 b=M5BCNRwZlgQsR+3AqdYq20O4RXYK17g4ao7vxER9xhLKvc8PvMVweMTqpJ3FEwmT/n
 ld2+vay2LAES4M7H8Hae11QsHM2qk6ZaqyJtHkMXBpPiAfOS3IzdQ0vVrhjjW+90/Mpv
 jNJ9E9WNe2+E1qw8p69oRhZ/6yqQLdzu7jrb6+aX0QVS3NpkLbrEQo2VOIeyYtZzf1Jq
 UtO7JtzgbZAV6fweyxqjkrSvWUkUnjgQjFl5BwMTW9eoiwczhfN1CAXOSp1OKk8VFaTv
 eI1GIzBH2wub7hGY2OQptXWgP2NriCsNBaZmeY/sVzVMUThmRCrYWO3qNl9Knf4d8ZGc
 2yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688149639; x=1690741639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1aO9RpzRrol6X6DhycWh+LBYqZaMdJEYX6msg4Tdv0=;
 b=F2Ab8dFP9FSJPLDzgMYg14oIoRwT8vRdsmqQDuwt+ttw6Ov4lj846JAyYDC/LBVbm4
 TzBYyFs4XhC0+uqWbPrcGoSWf6LfcKIcBb8i8co2z9Ct5UYCQkRy8CNqioiGl3/Ow8/T
 DR2hncnCzT6HRu2h7ukeLTu3uPpb0RocJI52Vk8WqUPl6venjyt7oyEl7kPiJ0jONnjR
 44uHb3D1Jy4U3AZAT/osXL8N9NsWKxEaOprADS5eXQEb/f5J8lhFboqS0/D2ScVfkTB7
 LFaXk07kcuPHNPZnrBrzycFMmTdrcwg5jopI6INN3VgnUZNcgOtOKoXH9TsSkh0YSN6T
 claA==
X-Gm-Message-State: ABy/qLaO6pPGX6JSFbv1EsPox9TBsmre1wSnoAookn9otds3AubbT4yJ
 THbRS71w+zf09++A78pa+GxO2NW9952Pjmn10xHSUQ==
X-Google-Smtp-Source: APBJJlF+EHks67MB4IGdkAEAM7mNyZhDtPmNBabq/3RY9E5qpLjEc9LjH6B3n+Ltsc7BjbnV6P83PhaSgxhP5Mz/iHo=
X-Received: by 2002:a05:6512:3f7:b0:4f9:56b8:45de with SMTP id
 n23-20020a05651203f700b004f956b845demr2362375lfq.38.1688149638515; Fri, 30
 Jun 2023 11:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfrHEQ=dMfpKGvYBHbXMfbQb9fDQh+bkdZW0Z6zQWVVUCA@mail.gmail.com>
 <ZJlMQQP7Y8r6Wrd7@redhat.com>
 <539281fe-4a75-34aa-e9f1-e88056a6947a@linaro.org>
 <c106351d-624f-a77c-2e51-f1193590f03a@linaro.org>
In-Reply-To: <c106351d-624f-a77c-2e51-f1193590f03a@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 30 Jun 2023 12:27:07 -0600
Message-ID: <CANCZdfrjOm=tHbgHtzs4bgyp_Hj-DtGJnnPif-9xF57n1zHjAw@mail.gmail.com>
Subject: Re: RFC: bsd-user broken a while ago, is this the right fix?
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008827db05ff5cf71f"
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x136.google.com
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

--0000000000008827db05ff5cf71f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 12:24=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/26/23 11:52, Richard Henderson wrote:
> > On 6/26/23 10:28, Daniel P. Berrang=C3=A9 wrote:
> >> Just CC'ing Richard to make sure it catches his attention.
> >>
> >> On Sat, Jun 24, 2023 at 12:40:33AM -0600, Warner Losh wrote:
> >>> This change:
> >>>
> >>> commit f00506aeca2f6d92318967693f8da8c713c163f3
> >>> Merge: d37158bb242 87e303de70f
> >>> Author: Peter Maydell <peter.maydell@linaro.org>
> >>> Date:   Wed Mar 29 11:19:19 2023 +0100
> >>>
> >>>      Merge tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu
> into
> >>> staging
> >>>
> >>>      Use a local version of GTree [#285]
> >>>      Fix page_set_flags vs the last page of the address space [#1528]
> >>>      Re-enable gdbstub breakpoints under KVM
> >>>
> >>>      # -----BEGIN PGP SIGNATURE-----
> >>>      #
> >>>      # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN846K9+IV8FAmQjcLIdHHJpY2hhcm=
Qu
> >>>      # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN846K9+IV8rkgf/ZazodovRKxfaO6=
22
> >>>      # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOLSx42T70QstWvBMukjovLMz1+Ttb=
o1
> >>>      # VOvpGH2B5W76l3i+muAlKxFRbBH2kMLTaL+BXtkmkL4FJ9bS8WiPApsL3lEX/q=
2E
> >>>      # 3kqaT3N3C09sWO5oVAPGTUHL0EutKhOar2VZL0+PVPFzL3BNPhnQH9QcbNvDBV=
3n
> >>>      # cx3GSXZyL7Plyi+qwsKf/3Jo+F2wr2NVf3Dqscu9T1N1kI5hSjRpwqUEJzJZ5r=
ei
> >>>      # ly/gBXC/J7+WN+x+w2JlN0kWXWqC0QbDfZnj96Pd3owWZ7j4sT9zR5fcNenecx=
lR
> >>>      # 38Bo0w=3D=3D
> >>>      # =3DysF7
> >>>      # -----END PGP SIGNATURE-----
> >>>      # gpg: Signature made Tue 28 Mar 2023 23:56:50 BST
> >>>      # gpg:                using RSA key
> >>> 7A481E78868B4DB6A85A05C064DF38E8AF7E215F
> >>>      # gpg:                issuer "richard.henderson@linaro.org"
> >>>      # gpg: Good signature from "Richard Henderson <
> >>> richard.henderson@linaro.org>" [full]
> >>>      # Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF
> 38E8
> >>> AF7E 215F
> >>>
> >>>      * tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu:
> >>>        softmmu: Restore use of CPU watchpoint for all accelerators
> >>>        softmmu/watchpoint: Add missing 'qemu/error-report.h' include
> >>>        softmmu: Restrict cpu_check_watchpoint / address_matches to TC=
G
> accel
> >>>        linux-user/arm: Take more care allocating commpage
> >>>        include/exec: Change reserved_va semantics to last byte
> >>>        linux-user: Pass last not end to probe_guest_base
> >>>        accel/tcg: Pass last not end to tb_invalidate_phys_range
> >>>        accel/tcg: Pass last not end to
> tb_invalidate_phys_page_range__locked
> >>>        accel/tcg: Pass last not end to page_collection_lock
> >>>        accel/tcg: Pass last not end to PAGE_FOR_EACH_TB
> >>>        accel/tcg: Pass last not end to page_reset_target_data
> >>>        accel/tcg: Pass last not end to page_set_flags
> >>>        linux-user: Diagnose misaligned -R size
> >>>        tcg: use QTree instead of GTree
> >>>        util: import GTree as QTree
> >>>
> >>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>>
> >>> breaks bsd-user. when I merge it to the bsd-user upstream blitz branc=
h
> I
> >>> get memory allocation errors on startup. At least for armv7.
> >>>
> >>> specifically, if I back out the bsd-user part of both
> >>> commit 95059f9c313a7fbd7f22e4cdc1977c0393addc7b
> >>> Author: Richard Henderson <richard.henderson@linaro.org>
> >>> Date:   Mon Mar 6 01:26:29 2023 +0300
> >>>
> >>>      include/exec: Change reserved_va semantics to last byte
> >>>
> >>>      Change the semantics to be the last byte of the guest va, rather
> >>>      than the following byte.  This avoids some overflow conditions.
> >>>
> >>>      Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
> >>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>>
> >>> and
> >>>
> >>> commit 49840a4a098149067789255bca6894645f411036
> >>> Author: Richard Henderson <richard.henderson@linaro.org>
> >>> Date:   Mon Mar 6 01:51:09 2023 +0300
> >>>
> >>>      accel/tcg: Pass last not end to page_set_flags
> >>>
> >>>      Pass the address of the last byte to be changed, rather than
> >>>      the first address past the last byte.  This avoids overflow
> >>>      when the last page of the address space is involved.
> >>>
> >>>      Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1528
> >>>      Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
> >>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >>>
> >>> things work again. If I backout parts, it fails still. If I back out
> only
> >>> one of
> >>> the two, but not both, then it fails.
> >>>
> >>> What's happening is that we're picking a reserved_va that's
> overflowing when
> >>> we add 1 to it. this overflow goes away if I make the overflows not
> >>> possible:
> >>> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> >>> index a88251f8705..bd86c0a8689 100644
> >>> --- a/bsd-user/mmap.c
> >>> +++ b/bsd-user/mmap.c
> >>> @@ -237,8 +237,8 @@ unsigned long last_brk;
> >>>   static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong
> size,
> >>>                                           abi_ulong alignment)
> >>>   {
> >>> -    abi_ulong addr;
> >>> -    abi_ulong end_addr;
> >>> +    uint64_t addr;
> >>> +    uint64_t end_addr;
> >>>       int prot;
> >>>       int looped =3D 0;
> >>>
> >>> My question is, is this the right fix? The old code avoided the
> overflow in
> >>> two ways. 1 it set reserve_va to a page short (which if I fix that, i=
t
> >>> works better, but not quite right). and it never computes an address
> that
> >>> may overflow (which the new code does without the above patch).
> >
> > Not really correct, though it will work for the 32-bit guests.
> >
> > You want to change end_addr to last_addr, which would be end_addr - 1,
> and do that
> > basically everywhere. That's the only way to avoid overflow properly,
> and is what I'm
> > settling on with page_set_flags et al.
>
> ... and fyi there's now a follow-up that replaces this function entirely.
> It is in fact much easier to do with the interval tree in hand.
>

thanks richard. I'll try to test the patches you posted later today...
.... but most of my plans for the day have been upended by a clogged
sewer drain.

Warner

--0000000000008827db05ff5cf71f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 30, 2023 at 12:24=E2=80=AFPM =
Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richa=
rd.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 6/26/23 11:52, Richard Henderson wrote:<br>
&gt; On 6/26/23 10:28, Daniel P. Berrang=C3=A9 wrote:<br>
&gt;&gt; Just CC&#39;ing Richard to make sure it catches his attention.<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Jun 24, 2023 at 12:40:33AM -0600, Warner Losh wrote:<br>
&gt;&gt;&gt; This change:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; commit f00506aeca2f6d92318967693f8da8c713c163f3<br>
&gt;&gt;&gt; Merge: d37158bb242 87e303de70f<br>
&gt;&gt;&gt; Author: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt;&gt;&gt; Date:=C2=A0=C2=A0 Wed Mar 29 11:19:19 2023 +0100<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Merge tag &#39;pull-tcg-20230328&#39;=
 of <a href=3D"https://gitlab.com/rth7680/qemu" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/rth7680/qemu</a> into<br>
&gt;&gt;&gt; staging<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Use a local version of GTree [#285]<b=
r>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Fix page_set_flags vs the last page o=
f the address space [#1528]<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Re-enable gdbstub breakpoints under K=
VM<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # -----BEGIN PGP SIGNATURE-----<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 #<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN8=
46K9+IV8FAmQjcLIdHHJpY2hhcmQu<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN8=
46K9+IV8rkgf/ZazodovRKxfaO622<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOL=
Sx42T70QstWvBMukjovLMz1+Ttbo1<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # VOvpGH2B5W76l3i+muAlKxFRbBH2kMLTaL+=
BXtkmkL4FJ9bS8WiPApsL3lEX/q2E<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # 3kqaT3N3C09sWO5oVAPGTUHL0EutKhOar2V=
ZL0+PVPFzL3BNPhnQH9QcbNvDBV3n<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # cx3GSXZyL7Plyi+qwsKf/3Jo+F2wr2NVf3D=
qscu9T1N1kI5hSjRpwqUEJzJZ5rei<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # ly/gBXC/J7+WN+x+w2JlN0kWXWqC0QbDfZn=
j96Pd3owWZ7j4sT9zR5fcNenecxlR<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # 38Bo0w=3D=3D<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # =3DysF7<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # -----END PGP SIGNATURE-----<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # gpg: Signature made Tue 28 Mar 2023=
 23:56:50 BST<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # gpg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 using RSA key<=
br>
&gt;&gt;&gt; 7A481E78868B4DB6A85A05C064DF38E8AF7E215F<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # gpg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 issuer &quot;<=
a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.he=
nderson@linaro.org</a>&quot;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # gpg: Good signature from &quot;Rich=
ard Henderson &lt;<br>
&gt;&gt;&gt; <a href=3D"mailto:richard.henderson@linaro.org" target=3D"_bla=
nk">richard.henderson@linaro.org</a>&gt;&quot; [full]<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 # Primary key fingerprint: 7A48 1E78 =
868B 4DB6 A85A=C2=A0 05C0 64DF 38E8<br>
&gt;&gt;&gt; AF7E 215F<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 * tag &#39;pull-tcg-20230328&#39; of =
<a href=3D"https://gitlab.com/rth7680/qemu" rel=3D"noreferrer" target=3D"_b=
lank">https://gitlab.com/rth7680/qemu</a>:<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 softmmu: Restore use of C=
PU watchpoint for all accelerators<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 softmmu/watchpoint: Add m=
issing &#39;qemu/error-report.h&#39; include<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 softmmu: Restrict cpu_che=
ck_watchpoint / address_matches to TCG accel<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user/arm: Take more=
 care allocating commpage<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include/exec: Change rese=
rved_va semantics to last byte<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Pass last not=
 end to probe_guest_base<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to tb_invalidate_phys_range<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to tb_invalidate_phys_page_range__locked<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to page_collection_lock<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to PAGE_FOR_EACH_TB<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to page_reset_target_data<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not =
end to page_set_flags<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-user: Diagnose misa=
ligned -R size<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg: use QTree instead of=
 GTree<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 util: import GTree as QTr=
ee<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Peter Maydell &lt;<a h=
ref=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@lin=
aro.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; breaks bsd-user. when I merge it to the bsd-user upstream blit=
z branch I<br>
&gt;&gt;&gt; get memory allocation errors on startup. At least for armv7.<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; specifically, if I back out the bsd-user part of both<br>
&gt;&gt;&gt; commit 95059f9c313a7fbd7f22e4cdc1977c0393addc7b<br>
&gt;&gt;&gt; Author: Richard Henderson &lt;<a href=3D"mailto:richard.hender=
son@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt;&gt;&gt; Date:=C2=A0=C2=A0 Mon Mar 6 01:26:29 2023 +0300<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 include/exec: Change reserved_va sema=
ntics to last byte<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Change the semantics to be the last b=
yte of the guest va, rather<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 than the following byte.=C2=A0 This a=
voids some overflow conditions.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by: Philippe Mathieu-Daud&lt=
;C3&gt;&lt;A9&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Richard Henderson &lt;=
<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.h=
enderson@linaro.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; and<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; commit 49840a4a098149067789255bca6894645f411036<br>
&gt;&gt;&gt; Author: Richard Henderson &lt;<a href=3D"mailto:richard.hender=
son@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt;&gt;&gt; Date:=C2=A0=C2=A0 Mon Mar 6 01:51:09 2023 +0300<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 accel/tcg: Pass last not end to page_=
set_flags<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Pass the address of the last byte to =
be changed, rather than<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 the first address past the last byte.=
=C2=A0 This avoids overflow<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 when the last page of the address spa=
ce is involved.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Resolves: <a href=3D"https://gitlab.c=
om/qemu-project/qemu/-/issues/1528" rel=3D"noreferrer" target=3D"_blank">ht=
tps://gitlab.com/qemu-project/qemu/-/issues/1528</a><br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by: Philippe Mathieu-Daud&lt=
;C3&gt;&lt;A9&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Richard Henderson &lt;=
<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">richard.h=
enderson@linaro.org</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; things work again. If I backout parts, it fails still. If I ba=
ck out only<br>
&gt;&gt;&gt; one of<br>
&gt;&gt;&gt; the two, but not both, then it fails.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; What&#39;s happening is that we&#39;re picking a reserved_va t=
hat&#39;s overflowing when<br>
&gt;&gt;&gt; we add 1 to it. this overflow goes away if I make the overflow=
s not<br>
&gt;&gt;&gt; possible:<br>
&gt;&gt;&gt; diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
&gt;&gt;&gt; index a88251f8705..bd86c0a8689 100644<br>
&gt;&gt;&gt; --- a/bsd-user/mmap.c<br>
&gt;&gt;&gt; +++ b/bsd-user/mmap.c<br>
&gt;&gt;&gt; @@ -237,8 +237,8 @@ unsigned long last_brk;<br>
&gt;&gt;&gt; =C2=A0 static abi_ulong mmap_find_vma_reserved(abi_ulong start=
, abi_ulong size,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong alignment)<br>
&gt;&gt;&gt; =C2=A0 {<br>
&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0 abi_ulong addr;<br>
&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0 abi_ulong end_addr;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t addr;<br>
&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint64_t end_addr;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int prot;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int looped =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; My question is, is this the right fix? The old code avoided th=
e overflow in<br>
&gt;&gt;&gt; two ways. 1 it set reserve_va to a page short (which if I fix =
that, it<br>
&gt;&gt;&gt; works better, but not quite right). and it never computes an a=
ddress that<br>
&gt;&gt;&gt; may overflow (which the new code does without the above patch)=
.<br>
&gt; <br>
&gt; Not really correct, though it will work for the 32-bit guests.<br>
&gt; <br>
&gt; You want to change end_addr to last_addr, which would be end_addr - 1,=
 and do that <br>
&gt; basically everywhere. That&#39;s the only way to avoid overflow proper=
ly, and is what I&#39;m <br>
&gt; settling on with page_set_flags et al.<br>
<br>
... and fyi there&#39;s now a follow-up that replaces this function entirel=
y.<br>
It is in fact much easier to do with the interval tree in hand.<br></blockq=
uote><div><br></div><div>thanks richard. I&#39;ll try to test the patches y=
ou posted later today...</div><div>.... but most of my plans for the day ha=
ve been upended by a clogged</div><div>sewer drain.</div><div><br></div><di=
v>Warner=C2=A0<br></div></div></div>

--0000000000008827db05ff5cf71f--

