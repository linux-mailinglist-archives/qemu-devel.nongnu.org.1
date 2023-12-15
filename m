Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04F813E98
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 01:13:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDvoV-0006jb-KL; Thu, 14 Dec 2023 19:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rDvoS-0006jK-5W
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 19:12:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rDvoP-0008GV-Hu
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 19:12:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso1539395e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 16:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702599134; x=1703203934;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/qj6Ba4B2O/JAFZcpP3dbeW2XELwLVa7fWg1Jn45Cg=;
 b=UJqEXpbU1LJuIqHldDAqDyfz08dwc4f6saRPqFB1q45TK5HbXD0ht3gC+3zQpK9461
 ogTY3noCBCStwKFAejpUqu4IX/ExK88xrCezkOtmmGINbjb1FUJ4nepC8dPFET6gMdMB
 Wg1aFBj3Vdx6ZnygBuyqcQeDaQkbXs/+D/2YJR1uUGRF9jwS611bG/sZYVX/wWl9WvbJ
 fBLvCXuLpGUj04I8mg1VT79VEDaYd6cOzPH+9WQT03tDdLLsDHNqiuKktSCzPhswADNM
 OQV+c5ygd/Na7jY4rNH18DWyelC3ltunrcHWFtxNGJC3Uzj8kmLnew7LSDJGa5Uoy0jN
 VCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702599134; x=1703203934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/qj6Ba4B2O/JAFZcpP3dbeW2XELwLVa7fWg1Jn45Cg=;
 b=fFNaKCvvduqdYlXeV/COGAs/4VQi8PHUv4yMoNji6cxfg0tQ6jWwrADYvDljh7Gzts
 fdFbPSjymppbhsocEvD1n0S6uycFs2xKKBdZDPzbMxbH1pZim1/7hfLjtO1LnhUMFIg2
 8oXE+DShautg5KQycZkX46qX7rsnrrp7jWfRTd3hOzzY8oCkyd+OA6GAxjMq8KEwBbhE
 mlcRjypYldyjx3H7coA/qN5wEQG4tl7AFO+lOlqZYvvjMKncALfjpPmj/m9S8vOym2BJ
 UH08KozXUhAM+U84zGzLvAiyGSPgXSjEKFJQs83gdz33+JOjhZX7ZPY4bdZEtGdgHgcU
 AnyQ==
X-Gm-Message-State: AOJu0Yxy/nAiLA/+78aupK0hPwO4dNBG2aCA/b9BMHjfGQwyb12rwkp7
 tR0s4Ey/T2tea0l/Klj4/RoAcCOEvE3yjRpmyDMD3Q==
X-Google-Smtp-Source: AGHT+IHiNAZkcL7k2/vC1SJZz89KoHAIQtnpKOqNTCJmetUqgWc0U0nOPpi1EwyUPO+0dEWU55lkleI1mheofNPM30k=
X-Received: by 2002:a05:600c:1d95:b0:40b:2979:b787 with SMTP id
 p21-20020a05600c1d9500b0040b2979b787mr5560087wms.10.1702599134539; Thu, 14
 Dec 2023 16:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
 <0d11ec9c-ca9f-4135-b723-8155d7d7279c@redhat.com>
In-Reply-To: <0d11ec9c-ca9f-4135-b723-8155d7d7279c@redhat.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Fri, 15 Dec 2023 09:11:58 +0900
Message-ID: <CAFS=EcnVWVUQts=Ej2KVKxuykAxXem28Q8KEHO7EFr+8GALf-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] system/memory.c: support unaligned access
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Dec 11, 2023 at 10:31=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
> FWIW, there has been a previous proposal for unaligned accesses support [=
1].
>
> Thanks,
>
> C.
>
> [1] https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.i=
d.au/
>

Thanks for your information.
This patch is an RFC, and unfortunately it doesn't seem to have been merged=
.
This feature is useful for devices that allow unaligned access.

Regards,

Tomoyuki HIROSE

On Mon, Dec 11, 2023 at 10:31=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
>
> Hello,
>
> On 12/11/23 08:12, Tomoyuki HIROSE wrote:
> > The previous code ignored 'impl.unaligned' and handled unaligned access=
es
> > as is. But this implementation cannot emulate specific registers of som=
e
> > devices that allow unaligned access such as xHCI Host Controller Capabi=
lity
> > Registers.
> > This commit checks 'impl.unaligned' and if it is false, QEMU emulates
> > unaligned access with multiple aligned access.
> >
> > Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
>
> FWIW, there has been a previous proposal for unaligned accesses support [=
1].
>
> Thanks,
>
> C.
>
> [1] https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.i=
d.au/
>
>
> > ---
> >   system/memory.c | 22 ++++++++++++++++------
> >   1 file changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/system/memory.c b/system/memory.c
> > index 798b6c0a17..b0caa90fef 100644
> > --- a/system/memory.c
> > +++ b/system/memory.c
> > @@ -539,6 +539,9 @@ static MemTxResult access_with_adjusted_size(hwaddr=
 addr,
> >       unsigned i;
> >       MemTxResult r =3D MEMTX_OK;
> >       bool reentrancy_guard_applied =3D false;
> > +    hwaddr aligned_addr;
> > +    unsigned corrected_size =3D size;
> > +    signed align_diff =3D 0;
> >
> >       if (!access_size_min) {
> >           access_size_min =3D 1;
> > @@ -560,18 +563,25 @@ static MemTxResult access_with_adjusted_size(hwad=
dr addr,
> >           reentrancy_guard_applied =3D true;
> >       }
> >
> > -    /* FIXME: support unaligned access? */
> >       access_size =3D MAX(MIN(size, access_size_max), access_size_min);
> >       access_mask =3D MAKE_64BIT_MASK(0, access_size * 8);
> > +    if (!mr->ops->impl.unaligned) {
> > +        aligned_addr =3D addr & ~(access_size - 1);
> > +        align_diff =3D addr - aligned_addr;
> > +        corrected_size =3D size < access_size ? access_size :
> > +                            size + (align_diff > 0 ? access_size : 0);
> > +        addr =3D aligned_addr;
> > +    }
> >       if (memory_region_big_endian(mr)) {
> > -        for (i =3D 0; i < size; i +=3D access_size) {
> > +        for (i =3D 0; i < corrected_size; i +=3D access_size) {
> >               r |=3D access_fn(mr, addr + i, value, access_size,
> > -                        (size - access_size - i) * 8, access_mask, att=
rs);
> > +                        (size - access_size - i + align_diff) * 8,
> > +                        access_mask, attrs);
> >           }
> >       } else {
> > -        for (i =3D 0; i < size; i +=3D access_size) {
> > -            r |=3D access_fn(mr, addr + i, value, access_size, i * 8,
> > -                        access_mask, attrs);
> > +        for (i =3D 0; i < corrected_size; i +=3D access_size) {
> > +            r |=3D access_fn(mr, addr + i, value, access_size,
> > +                        ((signed)i - align_diff) * 8, access_mask, att=
rs);
> >           }
> >       }
> >       if (mr->dev && reentrancy_guard_applied) {
>

