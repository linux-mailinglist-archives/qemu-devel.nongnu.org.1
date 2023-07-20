Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC1075B4EA
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWmR-0003YJ-EJ; Thu, 20 Jul 2023 12:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWmO-0003Xk-60
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:45:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWmL-0001oW-ML
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:45:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso170106566b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689871524; x=1690476324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYiwNN2mTchLvDbaV5uU+SGhDyT4rTj5DSA5zxilECw=;
 b=uCKGtPBTvKtRpPX5YmUNZlblA5tpJl8PlgIEbFPiiSE2lHfTJR4oQNXz5WZ+UqtzH4
 9xn0230QrF9NcgFLT24QtWwxCUBy4Ako3g2mIxq6Bikrk3GSfaAsQPiCM+Q8RrXKbEQ1
 4FY7A4+cepPCixl1GT0LO4J5a5CzExegFz7CjbtSccfYcZXaEoLvcvYRi40bbNSGL5Ll
 d1OCFW5MNRSnWjk/7m/1WQCWijocp+YG4jSH13nNDlRRg/aS5jGJPjKnx4SDjRQAZuW1
 C4Ye8e0BpoAVgeXm0YU4trCfucsJt/hKn2R5MLJz0BmrtyY8FeVqYTl9/4N7DBOGHFdf
 B+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689871524; x=1690476324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nYiwNN2mTchLvDbaV5uU+SGhDyT4rTj5DSA5zxilECw=;
 b=Gn3raZ8zfl4mjV29dzsH8CsjnOFfhBo2ifM1WOZBrvHHRw/lAQAeRvhILYtfmhlFih
 wzO5dNRBA3VniuryrKqDQDuDUXy3W83ewwFGCMBNvAqyroRy3yqSoh+PzxdMSSJEEu8d
 ZlG7K9TRZ10Eqsu/Qp/dkRSbu1B0l13Kn0rqiqFwE2WoVDtasRM6pN7AR7OIjdMxsR2F
 RwJDOooQL95YWx0AXEvz8MRZirpa1CPmJ99MiZlqXnsYO8bdroUvxcVl5CfvZ7+jKlk5
 LKIKzeFkeHtTg5DQynsiAtR7/76TM910m5CfErrplnwnngUF49W3672+N/hThGdMdnix
 4SLA==
X-Gm-Message-State: ABy/qLYAqrUSs/nFTUu2rZgai1bFYCLw3ioqCr05VEXtAwDVUebSPVzL
 H8is3u6Niqmxe4yYvCSTZ1qRZWSkkf6YnOFmOnx5MA==
X-Google-Smtp-Source: APBJJlHlAgbBQ9sc282o8VspJZN5K4NCPz2kSrfNJ7BNlylTCo+ny9JZPbpFTOTqvRyWP8g7RWVplXNwyW651DZV708=
X-Received: by 2002:a17:907:6da7:b0:988:d6ca:ea72 with SMTP id
 sb39-20020a1709076da700b00988d6caea72mr6521903ejc.71.1689871523913; Thu, 20
 Jul 2023 09:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-4-peter.maydell@linaro.org>
 <e15250a2-3d21-d70b-980f-38d8165f0e30@kaod.org>
In-Reply-To: <e15250a2-3d21-d70b-980f-38d8165f0e30@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:45:13 +0100
Message-ID: <CAFEAcA9SmC+oN3wfoEfO-j6pms_0k-dmuuYCdLwVsHcQk_=hDA@mail.gmail.com>
Subject: Re: [PATCH for-8.2 3/4] hw/rtc/aspeed_rtc: Use 64-bit offset for
 holding time_t difference
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 20 Jul 2023 at 17:42, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/20/23 17:59, Peter Maydell wrote:
> > In the aspeed_rtc device we store a difference between two time_t
> > values in an 'int'. This is not really correct when time_t could
> > be 64 bits. Enlarge the field to 'int64_t'.
> >
> > This is a migration compatibility break for the aspeed boards.
> > While we are changing the vmstate, remove the accidental
> > duplicate of the offset field.
>
> Ah yes. Thanks.
>
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
>
> > ---
> > I took "bump the migration version" as the simplest approach
> > here, because I don't think we care about migration compat
> > in this case. If we do I can write the alternate version of
> > the patch...
>
>
> I don't think we care much about migration compat and fyi, migration
> of aspeed machines broke a while ago. It still migrates if done before
> Linux is loaded.

Is that the "migration of AArch32 Secure state doesn't work
properly" bug, or am I misremembering?

-- PMM

