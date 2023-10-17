Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE37CC3E9
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjXj-0005ft-Bg; Tue, 17 Oct 2023 08:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <surajshirvankar@gmail.com>)
 id 1qseTo-0005Hj-9t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:27:04 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <surajshirvankar@gmail.com>)
 id 1qseTm-0001gz-2a
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:27:04 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507bd644a96so449867e87.3; 
 Tue, 17 Oct 2023 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697527618; x=1698132418; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YgQkW1x0KrKLWcdr7NFMAmVCcwQxaRgnchdMWxobaLY=;
 b=hK54q9hjf+UD2Exw1BQnSl0+sZwBQcgImzB1n0jZN4TNrFaF5sOKkZkAAgxXak7P7h
 Bq72Cr0Q4d/255rExN/WxTWXLUYzu6LaGun/4sD9yDt9y755RFoq+IsldDy2/6Y1/P9X
 pnUygHo6pdNWfkYRzHEC1EPjuQ5Dj9HnuzKfgeJtErVrFkquKviyKjt7xTcKsKxEKdaO
 oDmBgmBQNVMFqGgr15HW71JvMqOmvzODXo43CEpJgWQPwzvRxAlEh1ZAKVA+Xr9M3M8+
 j+ZG6qg4GhYXUR3myuS7ZJln59WRZu1npPSDplA9toYs7+KYjLrsbSTADZvf2QZkFUrv
 6XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697527618; x=1698132418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YgQkW1x0KrKLWcdr7NFMAmVCcwQxaRgnchdMWxobaLY=;
 b=lDZnotcKa9xZC6VKyn4evRJjEK2c3goIQvu9iN5FC+qMhSLTSAJrrzbKxE0kKV5t9L
 HUwV+xOIt7MZfK5ZdTjMwvJh6JVYtB473A7ODf7pFzX9Fb3ncXlny3rQXbEU9mFtc45I
 R4iM2o0UogI4zGG2zje89fLPcHhh/7ff1zeWNT/BPb3miFwZ/y5BFFrxHJF6mDIxltY3
 tFdDQrkLdpuwpstDS62rkPaPU8+6wTgPn55SwMu1y32o6Ym8EKgXnvH/OcpInIBu2qt8
 q4+nZsks5+/qTbIROF+cpAomvQofc/LufxyE/bXxnoi/a93v7SI+QKDX1v/ehrxiJXfd
 v/Lw==
X-Gm-Message-State: AOJu0Yzo3SrcKtJKlHIzS916kAYCtPFr7EIHqaL8ckMusOpD+1KOC3f/
 VIzeGRk1ufyLggMH7B6/nL4wupZ4z1eDLbwDLJo=
X-Google-Smtp-Source: AGHT+IFvK7eyNnPQR4aX8D7JE4ZSfMkgQY2Xqs7j+qPpnFfET88wQxQ+8htHPBrNsttpgFf8wohJUOXuoMZwaCMqChg=
X-Received: by 2002:ac2:5456:0:b0:503:fee:5849 with SMTP id
 d22-20020ac25456000000b005030fee5849mr1187179lfn.53.1697527617695; Tue, 17
 Oct 2023 00:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <169635378817.28428.8916197505999208589-0@git.sr.ht>
 <169635378817.28428.8916197505999208589-1@git.sr.ht>
 <CAFEAcA9ziEdL3JFYS6b1zY8cNaS=1imYWS6byOhHraA2kfVJ7A@mail.gmail.com>
In-Reply-To: <CAFEAcA9ziEdL3JFYS6b1zY8cNaS=1imYWS6byOhHraA2kfVJ7A@mail.gmail.com>
From: Suraj Shirvankar <surajshirvankar@gmail.com>
Date: Tue, 17 Oct 2023 09:26:46 +0200
Message-ID: <CAB=F9tV-x-M5eR=2_A=y17ajfcbcWZ2VBZNdd=Fns3xaMECdOg@mail.gmail.com>
Subject: Re: [PATCH qemu 1/1] Switch memory management calls to new coding
 conventions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, trivial@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a6349a0607e4721a"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=surajshirvankar@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Oct 2023 08:51:25 -0400
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

--000000000000a6349a0607e4721a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for review.My bad I forgot to change the remaining frees.Going to
send another patch

On Mon, Oct 16, 2023 at 6:49=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 3 Oct 2023 at 18:23, ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht>
> wrote:
> >
> > From: Suraj Shirvankar <surajshirvankar@gmail.com>
> >
> > Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
>
> Hi; thanks for this patch. Mostly it looks good, but I
> have a couple of review comments; details below.
>
> > ---
> >  contrib/elf2dmp/addrspace.c | 4 ++--
> >  contrib/elf2dmp/main.c      | 4 ++--
> >  contrib/elf2dmp/pdb.c       | 4 ++--
> >  contrib/elf2dmp/qemu_elf.c  | 4 ++--
> >  4 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
> > index 64b5d680ad..3bfbb5093c 100644
> > --- a/contrib/elf2dmp/addrspace.c
> > +++ b/contrib/elf2dmp/addrspace.c
> > @@ -72,7 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf
> *qemu_elf)
> >          }
> >      }
> >
> > -    ps->block =3D malloc(sizeof(*ps->block) * ps->block_nr);
> > +    ps->block =3D g_new(struct pa_block, ps->block_nr);
> >      if (!ps->block) {
> >          return 1;
> >      }
>
> Unlike malloc(), g_new() can never fail. So the error check
> for NULL becomes redundant, and we can remove it. Similarly
> in the other cases below (including the g_malloc() call).
>
> > @@ -97,7 +97,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf
> *qemu_elf)
> >  void pa_space_destroy(struct pa_space *ps)
> >  {
> >      ps->block_nr =3D 0;
> > -    free(ps->block);
> > +    g_free(ps->block);
> >  }
> >
> >  void va_space_set_dtb(struct va_space *vs, uint64_t dtb)
> > diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> > index 5db163bdbe..97baf0c0c1 100644
> > --- a/contrib/elf2dmp/main.c
> > +++ b/contrib/elf2dmp/main.c
> > @@ -120,14 +120,14 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t
> KernBase, struct pdb_reader *pdb,
> >          }
> >      }
> >
> > -    kdbg =3D malloc(kdbg_hdr.Size);
> > +    kdbg =3D g_malloc(kdbg_hdr.Size);
> >      if (!kdbg) {
> >          return NULL;
> >      }
> >
> >      if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) =
{
> >          eprintf("Failed to extract entire KDBG\n");
> > -        free(kdbg);
> > +        g_free(kdbg);
> >          return NULL;
> >      }
>
> This isn't the only place where we free the memory we
> allocate here. The other place is the "free(kdbg)" at the
> bottom of the main() function. So for consistency we should
> change that also to g_free().
>
> > diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> > index 6ca5086f02..625001d1cf 100644
> > --- a/contrib/elf2dmp/pdb.c
> > +++ b/contrib/elf2dmp/pdb.c
> > @@ -116,7 +116,7 @@ static void *pdb_ds_read(const PDB_DS_HEADER *heade=
r,
> >
> >      nBlocks =3D (size + header->block_size - 1) / header->block_size;
> >
> > -    buffer =3D malloc(nBlocks * header->block_size);
> > +    buffer =3D g_malloc(nBlocks * header->block_size);
> >      if (!buffer) {
> >          return NULL;
> >      }
>
> Similarly here the buffer we allocated is usually returned
> from this function, assigned to some struct field, and then
> free()d much later on. So we should also switch all the other
> free() calls in this file to g_free().
>
> We should end up with no calls to free() left at all in
> the contrib/elf2dmp/ source files, I think.
>
> > @@ -201,7 +201,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
> >      return 0;
> >
> >  out_symbols:
> > -    free(symbols);
> > +    g_free(symbols);
> >
> >      return err;
> >  }
> > diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> > index de6ad744c6..9aa8715108 100644
> > --- a/contrib/elf2dmp/qemu_elf.c
> > +++ b/contrib/elf2dmp/qemu_elf.c
> > @@ -94,7 +94,7 @@ static int init_states(QEMU_Elf *qe)
> >
> >      printf("%zu CPU states has been found\n", cpu_nr);
> >
> > -    qe->state =3D malloc(sizeof(*qe->state) * cpu_nr);
> > +    qe->state =3D g_new(QEMUCPUState*, cpu_nr);
> >      if (!qe->state) {
> >          return 1;
> >      }
> > @@ -115,7 +115,7 @@ static int init_states(QEMU_Elf *qe)
> >
> >  static void exit_states(QEMU_Elf *qe)
> >  {
> > -    free(qe->state);
> > +    g_free(qe->state);
> >  }
> >
> >  static bool check_ehdr(QEMU_Elf *qe)
> > --
> > 2.38.5
>
> thanks
> -- PMM
>

--000000000000a6349a0607e4721a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for review.My bad I forgot to change the remaining =
frees.Going to send another patch <br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 16, 2023 at 6:49=E2=80=AF=
PM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Tue, 3 Oct 2023 at 18:23, ~h0lyalg0rithm &lt;<a href=3D"ma=
ilto:h0lyalg0rithm@git.sr.ht" target=3D"_blank">h0lyalg0rithm@git.sr.ht</a>=
&gt; wrote:<br>
&gt;<br>
&gt; From: Suraj Shirvankar &lt;<a href=3D"mailto:surajshirvankar@gmail.com=
" target=3D"_blank">surajshirvankar@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Suraj Shirvankar &lt;<a href=3D"mailto:surajshirvankar@=
gmail.com" target=3D"_blank">surajshirvankar@gmail.com</a>&gt;<br>
<br>
Hi; thanks for this patch. Mostly it looks good, but I<br>
have a couple of review comments; details below.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 contrib/elf2dmp/addrspace.c | 4 ++--<br>
&gt;=C2=A0 contrib/elf2dmp/main.c=C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
&gt;=C2=A0 contrib/elf2dmp/pdb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
&gt;=C2=A0 contrib/elf2dmp/qemu_elf.c=C2=A0 | 4 ++--<br>
&gt;=C2=A0 4 files changed, 8 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c=
<br>
&gt; index 64b5d680ad..3bfbb5093c 100644<br>
&gt; --- a/contrib/elf2dmp/addrspace.c<br>
&gt; +++ b/contrib/elf2dmp/addrspace.c<br>
&gt; @@ -72,7 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *q=
emu_elf)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ps-&gt;block =3D malloc(sizeof(*ps-&gt;block) * ps-&gt;=
block_nr);<br>
&gt; +=C2=A0 =C2=A0 ps-&gt;block =3D g_new(struct pa_block, ps-&gt;block_nr=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!ps-&gt;block) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Unlike malloc(), g_new() can never fail. So the error check<br>
for NULL becomes redundant, and we can remove it. Similarly<br>
in the other cases below (including the g_malloc() call).<br>
<br>
&gt; @@ -97,7 +97,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *q=
emu_elf)<br>
&gt;=C2=A0 void pa_space_destroy(struct pa_space *ps)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ps-&gt;block_nr =3D 0;<br>
&gt; -=C2=A0 =C2=A0 free(ps-&gt;block);<br>
&gt; +=C2=A0 =C2=A0 g_free(ps-&gt;block);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 void va_space_set_dtb(struct va_space *vs, uint64_t dtb)<br>
&gt; diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c<br>
&gt; index 5db163bdbe..97baf0c0c1 100644<br>
&gt; --- a/contrib/elf2dmp/main.c<br>
&gt; +++ b/contrib/elf2dmp/main.c<br>
&gt; @@ -120,14 +120,14 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t Kern=
Base, struct pdb_reader *pdb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 kdbg =3D malloc(kdbg_hdr.Size);<br>
&gt; +=C2=A0 =C2=A0 kdbg =3D g_malloc(kdbg_hdr.Size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!kdbg) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdb=
g_hdr.Size, 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eprintf(&quot;Failed to extract enti=
re KDBG\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(kdbg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(kdbg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
This isn&#39;t the only place where we free the memory we<br>
allocate here. The other place is the &quot;free(kdbg)&quot; at the<br>
bottom of the main() function. So for consistency we should<br>
change that also to g_free().<br>
<br>
&gt; diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c<br>
&gt; index 6ca5086f02..625001d1cf 100644<br>
&gt; --- a/contrib/elf2dmp/pdb.c<br>
&gt; +++ b/contrib/elf2dmp/pdb.c<br>
&gt; @@ -116,7 +116,7 @@ static void *pdb_ds_read(const PDB_DS_HEADER *head=
er,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 nBlocks =3D (size + header-&gt;block_size - 1) / h=
eader-&gt;block_size;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 buffer =3D malloc(nBlocks * header-&gt;block_size);<br>
&gt; +=C2=A0 =C2=A0 buffer =3D g_malloc(nBlocks * header-&gt;block_size);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!buffer) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Similarly here the buffer we allocated is usually returned<br>
from this function, assigned to some struct field, and then<br>
free()d much later on. So we should also switch all the other<br>
free() calls in this file to g_free().<br>
<br>
We should end up with no calls to free() left at all in<br>
the contrib/elf2dmp/ source files, I think.<br>
<br>
&gt; @@ -201,7 +201,7 @@ static int pdb_init_symbols(struct pdb_reader *r)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;<br>
&gt;=C2=A0 out_symbols:<br>
&gt; -=C2=A0 =C2=A0 free(symbols);<br>
&gt; +=C2=A0 =C2=A0 g_free(symbols);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return err;<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c<b=
r>
&gt; index de6ad744c6..9aa8715108 100644<br>
&gt; --- a/contrib/elf2dmp/qemu_elf.c<br>
&gt; +++ b/contrib/elf2dmp/qemu_elf.c<br>
&gt; @@ -94,7 +94,7 @@ static int init_states(QEMU_Elf *qe)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 printf(&quot;%zu CPU states has been found\n&quot;=
, cpu_nr);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 qe-&gt;state =3D malloc(sizeof(*qe-&gt;state) * cpu_nr)=
;<br>
&gt; +=C2=A0 =C2=A0 qe-&gt;state =3D g_new(QEMUCPUState*, cpu_nr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!qe-&gt;state) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -115,7 +115,7 @@ static int init_states(QEMU_Elf *qe)<br>
&gt;<br>
&gt;=C2=A0 static void exit_states(QEMU_Elf *qe)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 free(qe-&gt;state);<br>
&gt; +=C2=A0 =C2=A0 g_free(qe-&gt;state);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static bool check_ehdr(QEMU_Elf *qe)<br>
&gt; --<br>
&gt; 2.38.5<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000a6349a0607e4721a--

