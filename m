Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7E87AEE63
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 16:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8rz-00017u-Et; Tue, 26 Sep 2023 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8rx-00017f-5G
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:16:58 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8ru-00007j-Vg
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 10:16:56 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50307acd445so14209246e87.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695737813; x=1696342613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ETmpNE//lsEvgGiHT+faS5lA65nsY6L9lOKqWow4I10=;
 b=MZVhD6hbpsd9MCepD21onw3/zx77xlUuGiTwupKkx0SL2WkyjtrIdeDSb+6bN/imhW
 MadT0AaAozqSihcuP0I6vFZcMXwwK5sZpi4VRNPJBEwHVi/5q8HGHGqX+6ISr8iPVt1C
 4jK3pd4eIr1zo22IIYGIUh+idREi9VtE1zOczd3vu648YebfVOkfrLkp/4eUFoR5cqzr
 mUfcEWfjIiDMw9RkIJWceiNYA0Qq3e7YLychgSOR/8M3FE8FCpCD5ippbLe7zMwEE7v9
 Fc2kNQ+REblDHINHLH4AqolkYirM/3AQh3YObo91w0F6KdtEpfgPdYUZWdvtP02a0LWb
 Ldrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737813; x=1696342613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETmpNE//lsEvgGiHT+faS5lA65nsY6L9lOKqWow4I10=;
 b=g7+sog9VXmn3um6/Rfebq5GqaagFp1itb1fod7R5OfHzfK4uWKZeJ57XxnKU29+Afa
 S2A0Rc0FNi5NdODtvMqd6jUXTJ7eeFOX+8GOa/1BWsOpOIryfnUS+Reqmsun7GR56wso
 XoM8gyc7tFwnoZ/UoreJfvmUU8JcbUyUv8Xj8HBaAVjmVzJuF6FD1aM06/Ovlo1xoRkt
 SEb1yuK7iwzm0Cu931FJAG7N8BUf8RI099wsqf3NN5qdqpCNuIp3nqMhyXNGKWJ783Bu
 KMfSwwISl6D4DebwTU/N/QmturCrjp5oNEVJWO0WCXspzh9sNJY1Fdtckv7Ky0prMA7R
 guOQ==
X-Gm-Message-State: AOJu0YzJkx3FP5BtsOtPlPPX3FrZ81g0zQ0b6GqXXXcuDKBmBKWy6NHO
 h0zsQiv1m1Jd3kSnNqPGk/bbF360oD7CejRiRG6oSg==
X-Google-Smtp-Source: AGHT+IF87zPba88vU7hp+e9rGoY2uTYoRkpeUNxQFKlOkj+jvYCt+a8XI3NrsQ7RnT/GCcDseUAmAY434Gzwcf0DADw=
X-Received: by 2002:a05:6512:3a8f:b0:501:bee7:487b with SMTP id
 q15-20020a0565123a8f00b00501bee7487bmr9896308lfu.11.1695737812680; Tue, 26
 Sep 2023 07:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-3-vsementsov@yandex-team.ru>
 <CAFEAcA_jgL_CLQxT1R2Zu5xDd3RZZpySpjhd1EyBgFM8Ttps6w@mail.gmail.com>
 <02ed54d5-31ef-7acd-d5a0-68714147c00b@yandex-team.ru>
In-Reply-To: <02ed54d5-31ef-7acd-d5a0-68714147c00b@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 15:16:34 +0100
Message-ID: <CAFEAcA-wi4y9u4Ow7cTh0LW8wdKxG_7vKvENv6yS7KjYxWR3Sw@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 26 Sept 2023 at 15:12, Vladimir Sementsov-Ogievskiy
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
>
> But touching vtd_spte_rsvd with level>=5 is even worse than
> assertion, I think. That's overflows the array.

Correct. We shouldn't do that. But we also should not just
assert().

> I don't know what the real hardware should do in this case.

Then we should find out... Hopefully the specs will say.
If they don't then we can do whatever is a reasonable
behaviour (eg treat like some other valid value).

thanks
-- PMM

