Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9987AF38F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDII-0002H9-Kt; Tue, 26 Sep 2023 15:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlDHx-0001oF-1b
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:11 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlDHu-0003GU-Vv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:00:04 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso11519903a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695754801; x=1696359601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pzLt0rycwnycrPtAJ9yjj9V7GhaxPYrnAukE9PePMsg=;
 b=Lqc0/Wg82SbH0IwM0a1YkCVAA+QsjoQHU0ovTmy1iW5qBjhEcEY1O97nZTs20frV7I
 OhygM6tou9noUL5VSK3Y4/eOyY5t9oJvZRvkyEHl9rZl2rOx3PKWugErPlqhQXszt5PI
 LpL5mDpbS36CabBHGBoMKpJHeEFblq8dOEw//qmgNahomXCAp3UAR9sV5yGuAD2Pa9/n
 MimsN+W8BWsQPhm1ZLbc6CEDWO01bWldOnCQA/+6j27aS7BMI9JNuTlSHB7bJD3IInej
 Ij+2SobDJBBcGkJG/laYGND9JPrXDcSmczRZhhaa4Yzgc5OnImZeU5t1cO14lv8zadgu
 mJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695754801; x=1696359601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzLt0rycwnycrPtAJ9yjj9V7GhaxPYrnAukE9PePMsg=;
 b=AqPHFfplgp9J9iLV8B1hVNYy2H6KHbPj3WRu98JOptiuZ8v488rFiAHTC4CTbEDTnT
 hl9PmlJeSm0uQv6RPKkdXMbqac5I9fg/dXNWx/tqJy8c5+r2Ex5E/HaqkPP/mo2WnCAS
 iEJPuCDvhkrg6YtwN1SQegiszGOopJZxlm5ovfaKpwtmNHlHBudcFBw/1vqRBOFXJgVU
 gsnQBSSbwC4cIzYLukOY7YFlC7p8E8vjQEHDGPXAZgUGduB92aue1Nqxa4F2ZFx0Olm/
 XJ6CwcjPdG0Tl4lvHFiljkKYsByeIyPmlviYyvzw2hQqmP8IWkX/JF0wU38LfjD7GlUH
 C1xQ==
X-Gm-Message-State: AOJu0YyiX5VB0YRHu4Ol182duuDquisGUAEWN1E19t7pic/W2l/yYlmS
 G4ni4xq5c+v84u+MRwDC6tmf30mZxCWuAfgBc9tBDg==
X-Google-Smtp-Source: AGHT+IHcU1g/6sTOukWTq3EjVl9weDHQ20yRJ5sQUf9tdvBKmm+VpsTw65tzCOZnHIzGL/Tr97h76VIrMG6t69xx5dM=
X-Received: by 2002:a05:6402:1659:b0:533:f22:17b9 with SMTP id
 s25-20020a056402165900b005330f2217b9mr9514687edx.19.1695754801020; Tue, 26
 Sep 2023 12:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-3-vsementsov@yandex-team.ru>
 <CAFEAcA_jgL_CLQxT1R2Zu5xDd3RZZpySpjhd1EyBgFM8Ttps6w@mail.gmail.com>
 <a39b4d16-3055-8718-0f84-ebbdd1078758@yandex-team.ru>
In-Reply-To: <a39b4d16-3055-8718-0f84-ebbdd1078758@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 19:59:42 +0100
Message-ID: <CAFEAcA_5cBU_LNeqnXhztiZrgGm-8=0x7pz-12ny5=J_sgBWxA@mail.gmail.com>
Subject: Re: [PATCH 02/12] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd():
 reduce magic numbers
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 26 Sept 2023 at 19:36, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 26.09.23 13:37, Peter Maydell wrote:
> > On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Add a constant and clear assertion. The assertion also tells Coverity
> >> that we are not going to overflow the array.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >> ---
> >>   hw/i386/intel_iommu.c | 11 ++++++++---
> >>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >> index c0ce896668..2233dbe13a 100644
> >> --- a/hw/i386/intel_iommu.c
> >> +++ b/hw/i386/intel_iommu.c
> >> @@ -1028,12 +1028,17 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
> >>    *     vtd_spte_rsvd 4k pages
> >>    *     vtd_spte_rsvd_large large pages
> >>    */
> >> -static uint64_t vtd_spte_rsvd[5];
> >> -static uint64_t vtd_spte_rsvd_large[5];
> >> +#define VTD_SPTE_RSVD_LEN 5
> >> +static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
> >> +static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
> >>
> >>   static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
> >>   {
> >> -    uint64_t rsvd_mask = vtd_spte_rsvd[level];
> >> +    uint64_t rsvd_mask;
> >> +
> >> +    assert(level < VTD_SPTE_RSVD_LEN);
> >> +
> >> +    rsvd_mask = vtd_spte_rsvd[level];
> >
> >
> > Looking at the code it is not clear to me why this assertion is
> > valid. It looks like we are picking up fields from guest-set
> > configuration (probably in-memory data structures). So we can't
> > assert() here -- we need to do whatever the real hardware does
> > if these fields are set to an incorrect value, or at least something
> > sensible that doesn't crash QEMU.
> >
>
> Finally, seems that assertion is valid. We do check the guest-set configuration:
>
> 1. in vtd_decide_config(), we check that s->aw_bits is exactly one of VTD_HOST_AW_39BIT or VTD_HOST_AW_48BIT.
>
> 2. in vtd_init(), in s->cap we set VTD_CAP_SAGAW_39bit (bit 1) and may be VTD_CAP_SAGAW_48bit (bit 2),  but never bit 3 (which would allow 5-level page-table) or any other bit (i.e. bits 0 and 4 which are reserved).
>
> 3. then, as I could follow, both context entry and pasid entry should go through vtd_is_level_supported(), which checks that level is allowed in s->cap.
>
> So in the code we should work only with levels 3 and 4.

Thanks for working through that. I'm not completely sure if we always
do the level validity check (eg in vtd_dev_to_context_entry() we skip
it if s->root_scalable is true), but clearly the intention of the code
is to validate the level early. So asserting in this function is fine,
and if the assert ever fires we know we got the validity check wrong
earlier.

A comment something like

  /*
   * We should have caught a guest-mis-programmed level earlier,
   * via vtd_is_level_supported
   */

might help somebody in future if the assert ever does fire.

Could you also add "CID: 1487158, 1487186" to the commit message?
I've just noticed this issue is in our online coverity scan db too
as unresolved.

With those changes,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

