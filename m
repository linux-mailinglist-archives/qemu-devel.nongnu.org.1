Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4C881C71D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:05:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbSq-000080-5r; Fri, 22 Dec 2023 04:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGbSn-000071-Ep
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGbSl-000434-AT
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703235897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wplu7Sj6MbELWRbQaUKXk9DqyMTsuCbkR8MZesPb3w=;
 b=aT9tLF2U1/7uVMTxcGczAJxRADcgTp2ZACQVt8M3r1titfP9blNnT5yZUjwBDspG3A7Srf
 mm6wVEw2hsxxt97njjVhfIc9mhd7b0SXQ+4PZHdMQfgkNrBuzxU27HWKLJ1sUF6zwMocAe
 9rX30qTE0oldS+41Bs8sLlyznCSG+6o=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-z7aZFepLNfGjcfkD8DViRA-1; Fri, 22 Dec 2023 04:04:55 -0500
X-MC-Unique: z7aZFepLNfGjcfkD8DViRA-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7cade8197e7so403170241.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235895; x=1703840695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wplu7Sj6MbELWRbQaUKXk9DqyMTsuCbkR8MZesPb3w=;
 b=m059fBTnISPze8M2pxvkFzCWTVWHKO44posG4rjxm7CPAVFQWmHsVovlBuJN/5mjdB
 7vJ/arAhFVGWyFn9tGZvvAjKatSqtlMRmdcw3Me9RM07+BBntoBOoHv/jRB6JzywNADl
 lzYwt30ob16l0WeFPU41Ek697oB7pa7oD2SbriwTwh4o6tkVsnwDgTAQfgjFHoBYOdoO
 N/AB+2IDqvPi6OQDYUTyLCEZ4QkMbiZ9vElfxrp4rE10FRe04GfsiIsMzce/i0VRlXi/
 4oVnvUwR+b4P1F5qHxn3tlQ0e31sgZLQO4xhTYLqU+QYMFoYo4wL9WGOHx5vrFXSkZNb
 RiSA==
X-Gm-Message-State: AOJu0YwnXhrWdpgHPWaIxbni+c2zBF2oh5WCdtJisdd9cPtNKiPt2UCk
 KlOl+1GtHojhB6N2rKdySAYXUVfxPsq5barzLNDkLTEypMsKdEEu/z0wTGG+tho2D3jvFtZFkh4
 /eMJLpnqIPuiigph7VQR9iVdZ+jGF8viPEq5vwYU=
X-Received: by 2002:a05:6122:3105:b0:4b6:de44:dfd7 with SMTP id
 cg5-20020a056122310500b004b6de44dfd7mr487874vkb.20.1703235895098; 
 Fri, 22 Dec 2023 01:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcGPiDnh1SE9Eh2vwTxJgSMMuo4veCPBsnF+g/iC/N9RaR3I24JXEdDs3G6xNueQhEckFhETw3SVQar9sdFT8=
X-Received: by 2002:a05:6122:3105:b0:4b6:de44:dfd7 with SMTP id
 cg5-20020a056122310500b004b6de44dfd7mr487871vkb.20.1703235894765; Fri, 22 Dec
 2023 01:04:54 -0800 (PST)
MIME-Version: 1.0
References: <25995a01-720e-485a-b7c2-36ec612a888b@ipxe.org>
 <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
 <1082dfde-644b-4887-bd0f-35b8cea6be26@linaro.org>
In-Reply-To: <1082dfde-644b-4887-bd0f-35b8cea6be26@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Dec 2023 10:04:42 +0100
Message-ID: <CABgObfY=Rd5fih1=2y17ACoeqsPOKUynwOnpL+ygvk5Xis5pNw@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Fix physical address truncation
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Brown <mcb30@ipxe.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

On Thu, Dec 21, 2023 at 10:33=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/22/23 02:49, Michael Brown wrote:
> > The address translation logic in get_physical_address() will currently
> > truncate physical addresses to 32 bits unless long mode is enabled.
> > This is incorrect when using physical address extensions (PAE) outside
> > of long mode, with the result that a 32-bit operating system using PAE
> > to access memory above 4G will experience undefined behaviour.
> >
> > The truncation code was originally introduced in commit 33dfdb5 ("x86:
> > only allow real mode to access 32bit without LMA"), where it applied
> > only to translations performed while paging is disabled (and so cannot
> > affect guests using PAE).
> >
> > Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
> > rearranged the code such that the truncation also applied to the use
> > of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
> > atomic operations for pte updates") brought this truncation into scope
> > for page table entry accesses, and is the first commit for which a
> > Windows 10 32-bit guest will reliably fail to boot if memory above 4G
> > is present.
> >
> > The original truncation code (now ten years old) appears to be wholly
> > redundant in the current codebase.  With paging disabled, the CPU
> > cannot be in long mode and so the maximum address size for any
> > executed instruction is 32 bits.  This will already cause the linear
> > address to be truncated to 32 bits, and there is therefore no way for
> > get_physical_address() to be asked to translate an address outside of
> > the 32-bit range.
> >
> > Fix by removing the address truncation in get_physical_address().
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
> > Signed-off-by: Michael Brown <mcb30@ipxe.org>
> > ---
> >   target/i386/tcg/sysemu/excp_helper.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sys=
emu/excp_helper.c
> > index 5b86f439ad..707f7326d4 100644
> > --- a/target/i386/tcg/sysemu/excp_helper.c
> > +++ b/target/i386/tcg/sysemu/excp_helper.c
> > @@ -582,12 +582,6 @@ static bool get_physical_address(CPUX86State *env,=
 vaddr addr,
> >
> >       /* Translation disabled. */
> >       out->paddr =3D addr & x86_get_a20_mask(env);
> > -#ifdef TARGET_X86_64
> > -    if (!(env->hflags & HF_LMA_MASK)) {
> > -        /* Without long mode we can only address 32bits in real mode *=
/
> > -        out->paddr =3D (uint32_t)out->paddr;
> > -    }
> > -#endif
>
> If the extension is not needed, then the a20 mask isn't either.

I think it is. The extension is not needed because the masking is
applied by either TCG (e.g. in gen_lea_v_seg_dest or gen_add_A0_im) or
mmu_translate(); but the a20 mask is never applied elsewhere for
either non-paging mode or page table walks.

> But I think there are some missing masks within mmu_translate that need f=
ixing at the same
> time:

Right.

> >             /*
> >              * Page table level 3
> >              */
> >             pte_addr =3D ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & =
a20_mask;
>
> Bits 32-63 of cr3 must be ignored when !LMA.
>
> >         /*
> >          * Page table level 2
> >          */
> >         pte_addr =3D ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a2=
0_mask;
> >         if (!ptw_translate(&pte_trans, pte_addr)) {
> >             return false;
> >         }
> >     restart_2_nopae:
>
> Likewise.
>
> Looking again, it appears that all of the actual pte_addr calculations ha=
ve both
> PG_ADDRESS_MASK and a20_mask applied, and have verified that bits beyond =
MAXPHYSADDR are
> zero via rsvd_mask.

In fact, applying a20_mask is incorrect when there will be an NPT
walk.  I'll include Michael's patch in a more complete series and send
it out after testing.

Paolo


