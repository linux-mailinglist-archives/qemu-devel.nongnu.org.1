Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E8E722B1D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:32:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CBQ-0004aH-NI; Mon, 05 Jun 2023 11:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CBI-0004Y2-4N
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:31:44 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CB4-00078S-C9
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:31:39 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2b1badb8f9bso30823031fa.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685979084; x=1688571084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FtGN9lzh++Kjs7WlpOkGj/xHKtWX1JywaOWgqN88Lic=;
 b=uQ7Bt2fhS3wA/sfGoxQ4mIB1gbCAQSDvpLd1EPKViz0XvR/UPhm9tFvqlcTvJ8i8cZ
 oq6jHjeWlTJmJmJilKu6bdC1Fe6AgZI8XolR/vSHpiM4B+yaAd4Jkkosr/fBlBVANiYD
 oBh4hB7HjVbcC63lksuZyHGxsqPi+WhoM7i6mAvuL0bXkssElYc38wp+Yd3kMTosInIE
 3xQin22XkgPyt5cJqQVd6iJZPz66xB0N60BUIBXoY+NfCWxFF6JYptpVWkZUy7hsCkk8
 orDmK3PKiA4l4EnKGBlt90AbhOKzqtaEJV1oKauLKIyZh0rRIheYQrv82E6haG26Qlel
 Uh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685979084; x=1688571084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FtGN9lzh++Kjs7WlpOkGj/xHKtWX1JywaOWgqN88Lic=;
 b=RQtBJQ4AJKZjLOPNlptEkadrAU+9dtFN0dRFwhEJxIVw/4ih+LBHf55v0F/JPl/beb
 /EAGD1j/Vk9QxNdzg7TJ/wtCBPKb8eVUKrT423uIoGb0jj4TwmBo34oBnORrLXAuqtWI
 sBMspAqoFkv+nSWVE10Zk2fvsuBfAbP6OtxIYqle4AsT5LHSuvmzgFURFad1TwfRMHUk
 GutXNftjw8ETYHwBOpUjHyA5FzEFL8o/SXPKWfSzCimr8lx82NO/J+iTBmM65bV18c6y
 7HHTG0lQmbfJ7cD1K7tlb47BcLRobQzbovjGV0T4A1boIUphtSLqmjDa7dJD4O/DAW/2
 kzoQ==
X-Gm-Message-State: AC+VfDy765zUsFwqyRlk9U5dMuHX0FT5IsTdd83IomMWicJAt51l/L5I
 niKTNbpw1GUzFzH5OqEcn7GQjwaE+VMJlCfww95t8A==
X-Google-Smtp-Source: ACHHUZ5BJxH5biaQHjPMRlZqEn7kG4UiNxCwWql4lCFFbP0Ef4AIyJlyA0oBm4w200nYtwbVTP2BdTaXXXM5Lp3Kse8=
X-Received: by 2002:a2e:9c5a:0:b0:2ad:94cd:3cb7 with SMTP id
 t26-20020a2e9c5a000000b002ad94cd3cb7mr4275539ljj.51.1685979083985; Mon, 05
 Jun 2023 08:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
 <CAPan3Wr1phuot=613sXh-hT0An1-A5vuhcxMZ9SCGTze9w_PdQ@mail.gmail.com>
In-Reply-To: <CAPan3Wr1phuot=613sXh-hT0An1-A5vuhcxMZ9SCGTze9w_PdQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 16:30:50 +0100
Message-ID: <CAFEAcA_6hcAVef1HCcQHMF4qsxGrMGuFeATviJdnCzVXSkvZng@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] *** Add allwinner-r40 support ***
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qianfanguijin@163.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 1 Jun 2023 at 19:48, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> Hi Qianfan,
>
> Thanks for sending the v5. From my side, I have no further comments on the content.
> So please feel free to add the following to each of the patches 01-11 in the series:
>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> As a reminder and explained here on this page, you'll need to make sure these lines gets added to each of the commit messages:
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review
>
> Doing so would require you to send another updated v6, and baselined on the latest master.

The rebase was simple, so I've applied this v5 to target-arm.next.
(The patch application tools can pick up Reviewed-by tags that are
on-list without requiring a respin just for that.)

Qianfan: thanks for working on this feature and for your efforts
in working through our patch review process.

Niek: thanks very much for taking the lead on the patch review of
this series, it's been a tremendous help.

-- PMM

