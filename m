Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4875A988
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPGJ-0001HB-8S; Thu, 20 Jul 2023 04:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMPGH-0001GU-1k
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:43:49 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMPGD-0001Ce-Df
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:43:48 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb41682472so793507e87.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689842623; x=1690447423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0m/IIxr/kPBKVdvT3CEpnVDaeHwbBxtsB+eHKcXAwHk=;
 b=ejaWtfn+W6oa6PcFeatemJW6kvxT9tyjADx+Lws7VYd+7TX03B+4Ddg7HQbDhAL9x2
 fOzg/h1p751U7v5RZeQiMs7Y3eiHRLqGxGr16vEt3s54QEvP+8MZKeoll7Wg0sGgu6eN
 gnCZsKivBPxixatxSZCsCg/0rjOu5Rz7XFaokvM4IYGCU8yMyVR53gG4wcH18XA2P9TC
 nfN2cRd9t0GuxbZi1mpDNv53XlXQ6xR9jU6IpPz+M+f0pzAyLLyPxWh3xQM2w7+rof42
 f54lAjf1+TdTSEZUQrlc0zuPFBV4csj26TM6Z5AIJ7Z+oFFSW1hI06N7Yf6hm3VXQFIt
 r5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689842623; x=1690447423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0m/IIxr/kPBKVdvT3CEpnVDaeHwbBxtsB+eHKcXAwHk=;
 b=Gut977PFEtZgLhXSzh6G9KqPqhNpz48bNWOV768w5A+uhsYYt480myqtJwF+JIYBYH
 MUaTsCoHkKDsVasor36iA5aemiK6BvdqkV/LrPAkOc1qxtwfVV/d9PFrGjbx9MvzBBJ6
 O0TjTX3y4oddxANtyCzJkPrylBUIJIeC0y2MhM17sQXbNDBKFisNjmNHBCnQMrsQ9gDe
 E7UQIxEmybseBKXC/aJb25bfjiGh7h8xJKuk2QlDScy50KEyOtuqUeS6kPV6pc/hG8c/
 y0ZFVQ7g49R1C7/LJaCR2tfwj7gZDeYRVQQvaD4p+mrZMndC7I71KN24L5UhltX67dAv
 fuag==
X-Gm-Message-State: ABy/qLZTqaEKbbXA1ttDMd7hGDTTSKUWSYkJkopGjQYvHzdenZpzgnDC
 NKesL+sUYLGliJoDAojMB6lAhd8Im/MJuV0sDMGgag==
X-Google-Smtp-Source: APBJJlFCYrmo3ZTWia8XiP1TTeA88wRI4FZtxYNpn9nXPlYcbghfAgYWnQ/sFVVGTeaIjkokGlmeDTbZSJrwAd7hG9I=
X-Received: by 2002:a19:6544:0:b0:4fb:85b2:cf78 with SMTP id
 c4-20020a196544000000b004fb85b2cf78mr1767718lfj.37.1689842622743; Thu, 20 Jul
 2023 01:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230719073605.98222-3-its@irrelevant.dk>
 <20230719073605.98222-4-its@irrelevant.dk>
 <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
In-Reply-To: <437f0e05-f052-cb78-418f-054378c6ae68@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 09:43:31 +0100
Message-ID: <CAFEAcA-BwdoxeiFjA8Xce-fX9j8Qf2FcrJBKBhgKbONVfrJ7ew@mail.gmail.com>
Subject: Re: [PULL 1/1] hw/nvme: fix endianness issue for shadow doorbells
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 Fam Zheng <fam@euphon.net>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 19 Jul 2023 at 21:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 19.07.2023 10:36, Klaus Jensen wrote:
> pu(req->cmd.dptr.prp2);
> > +    uint32_t v;
>
> >           if (sq) {
> > +            v = cpu_to_le32(sq->tail);
>
> > -            pci_dma_write(pci, sq->db_addr, &sq->tail, sizeof(sq->tail));
> > +            pci_dma_write(pci, sq->db_addr, &v, sizeof(sq->tail));
>
> This and similar cases hurts my eyes.
>
> Why we pass address of v here, but use sizeof(sq->tail) ?
>
> Yes, I know both in theory should be of the same size, but heck,
> this is puzzling at best, and confusing in a regular case.
>
> Dunno how it slipped in the review, it instantly catched my eye
> in a row of applied patches..
>
> Also, why v is computed a few lines before it is used, with
> some expressions between the assignment and usage?
>
> How about the following patch:

If you're going to change this, better to take the approach
Philippe suggested in review of using stl_le_pci_dma().

https://lore.kernel.org/qemu-devel/376e5e45-a3e7-0029-603a-b7ad9673fac4@linaro.org/

thanks
-- PMM

