Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D07AEA8C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5SX-0005Ck-F7; Tue, 26 Sep 2023 06:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5SF-00052b-PO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:38:16 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5SE-0001qb-12
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:38:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-530bc7c5bc3so10139874a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 03:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695724688; x=1696329488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pz+SGO64Zoxuud/sDvqsIAXzsgFRYm2EX81l7BwwyTw=;
 b=X7YgUshcYs+dOIcSrN+Y404RXBHAo4OxKYVUVeEFXMdfC4LDHZdXt3CKQQ/56HwBnO
 l77xfIengoCYiEgfF76IZ8T6WtJ3k32FBHhauiEcAsOhhslWM+IgQvds0MF8hJ9UEKDP
 Nt/k7sk1vhJHQirqI/NWBxL6hqhdKm6y/uQAVJ5jAfys+FXRC9+PxcioSfzQG4rnG5vJ
 h1On//FgqwsxzZDWqpZketk2YunqYLqa4cnAJUnNHGjQYdmE9l/vOLQAFVXpYPNaDxl6
 fkfQRwrA86VBOgOdCY4GPj3n4yuuZGsQmy2efjXL7XBxCUBgl99x2MTPGBRrDEjIub+l
 1NUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695724688; x=1696329488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pz+SGO64Zoxuud/sDvqsIAXzsgFRYm2EX81l7BwwyTw=;
 b=Ll717MU3IyE2B3qmlMsHbHlZfiEcU7LB5RIsfoSZ2svY6yAOsUZXF+eINqGXe6SME+
 pVkqRAeMRKPbf7+BPS4M80CB9tk6wHDgwv3Pm1TJ7KW3deKc+jDwr3kYcJFqRg3wKXfj
 L8FOlHQc8UDsTEt6g8QkZNHawsi9DjTa26CIuZq7OM6lhwA0qR1Qu75QXS+SsztcVYrN
 y+rxExE8KIFQXaPNyc2L+O+1CY3SdJZblntGdeElqQ8S48IUEey+qefAPrPJ2anmCoCH
 tZlK9RXMbplwMmF8c7O5idB6RWQAm8+D3wiWzwrE0I4McBIu7GmreqhTpFfg6yYxnMRm
 HQsw==
X-Gm-Message-State: AOJu0Yzu2hpA3Krk92pYWCf3iLTa5UAqDucau1+u+JL4zBNq4YxswTEp
 jRj4vUdGiuptALCAwtevMi/icIjxmq43AiqB3rjIEw==
X-Google-Smtp-Source: AGHT+IFd9ANzZUdR7naAFK0mbFcfcZluTHmoObX1SbCsNpcOBFh3XeJcdL5GvbnKkKFUISrt9nKXE5u/S0AZSMzPrzU=
X-Received: by 2002:a05:6402:204f:b0:523:4acb:7f41 with SMTP id
 bc15-20020a056402204f00b005234acb7f41mr8079929edb.14.1695724687912; Tue, 26
 Sep 2023 03:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-3-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-3-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 11:37:49 +0100
Message-ID: <CAFEAcA_jgL_CLQxT1R2Zu5xDd3RZZpySpjhd1EyBgFM8Ttps6w@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 25 Sept 2023 at 20:41, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Add a constant and clear assertion. The assertion also tells Coverity
> that we are not going to overflow the array.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/i386/intel_iommu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c0ce896668..2233dbe13a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1028,12 +1028,17 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>   *     vtd_spte_rsvd 4k pages
>   *     vtd_spte_rsvd_large large pages
>   */
> -static uint64_t vtd_spte_rsvd[5];
> -static uint64_t vtd_spte_rsvd_large[5];
> +#define VTD_SPTE_RSVD_LEN 5
> +static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
> +static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
>
>  static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>  {
> -    uint64_t rsvd_mask = vtd_spte_rsvd[level];
> +    uint64_t rsvd_mask;
> +
> +    assert(level < VTD_SPTE_RSVD_LEN);
> +
> +    rsvd_mask = vtd_spte_rsvd[level];


Looking at the code it is not clear to me why this assertion is
valid. It looks like we are picking up fields from guest-set
configuration (probably in-memory data structures). So we can't
assert() here -- we need to do whatever the real hardware does
if these fields are set to an incorrect value, or at least something
sensible that doesn't crash QEMU.

thanks
-- PMM

