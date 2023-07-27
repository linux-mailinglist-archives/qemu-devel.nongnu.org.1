Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6476602A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 01:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP9pY-0001ce-Ta; Thu, 27 Jul 2023 18:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qP9pT-0001c4-0f; Thu, 27 Jul 2023 18:51:31 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>)
 id 1qP9pQ-0000OM-7s; Thu, 27 Jul 2023 18:51:30 -0400
Date: Thu, 27 Jul 2023 22:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690498284; x=1690757484;
 bh=GwWlYL2UvwlOrUg5NFvCC/4Xk3RqRiNQvjX65p9oWzU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FNUlG1aoipHKGdQ224hIJ/ssoadO1F91Umh9ctxTDMVswdCHU2JXD6HDmwxo4HNmD
 hFaZvm/YMGT/U2th7rM8imA/l3T2kFX5IZdydd454bRMgraETP5QEZSDRWQfEQ9+CJ
 b2611Z03WK3X4w8dx1XUgPCMhUP+MYCswKn8H9K4EHDllQGR+yiELKx5CW3r/ot85q
 TCqATr4N9tHqTacPGThlbFyzIsN8oL0u5kPc+D2vCY5ZgipNFa/sqbzj6hro3Hzy6h
 SP0+6G7YlzKU5DKERe3jnFKEcTMnlikm4SQfGU5dCDz5b31/31cSqMlztoFEFlvkZF
 XQpI2jpwfj4tA==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/6] Add nRF51 DETECT signal with test
Message-ID: <yokIQT37oK_0HPVzoPJBD5moVrsM_9vvTfjLSATREN7NSvy794przKE2H0mtVB7Puff1nucD8N0Boa4tdRv8CcqFZHaM2FY6Wxty2-tkTjY=@laplante.io>
In-Reply-To: <CAFEAcA_HWapg170-7yu2cZ-ePTe4PaX-tWyL7FJzENgig=dq5g@mail.gmail.com>
References: <20230714232659.76434-1-chris@laplante.io>
 <CAFEAcA_gGia=ckyv4=XHNX4=VHJJ=rmVGXQbdnOAGv5h1rzLzw@mail.gmail.com>
 <uJ83qRpjm3C76JRjI4OOm2NAz3uF-RDUa2WL8sp3ftAzoH16KDfxZhwxsqxqxrHTfXHKkZZXy0JY6UUpq7nD0jfYEUtYM_K340O6E6BFwJY=@laplante.io>
 <CAFEAcA_HWapg170-7yu2cZ-ePTe4PaX-tWyL7FJzENgig=dq5g@mail.gmail.com>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=chris@laplante.io;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Hi Peter,

> > 2. I also have some implementations for pieces of CLOCK, namely the HFC=
LKSTART/HFCLKSTOP events and HFCLKSTARTED event. Should I include that in t=
his patch series, or would you prefer it in a separate series? It is unrela=
ted to DETECT and POWER.
>=20
>=20
> If you think they're ready to go in, and it doesn't
> make the series more than about 12-15 patches long,
> you can put them on the end of the series. If the
> patchset is starting to get a bit big then it might
> be easier to get the POWER/DETECT parts reviewed
> first.

Unrelated question regarding the CLOCK module. Should I model the startup t=
imes for the various crystal oscillators? Or should I just assume they star=
t instantly for simplicity? External xtal startup time is 750-800 us. Inter=
nal RC startup time is 4-5 us. I've already modeled the delay for the exter=
nal xtal, but just wondering if its worth the extra code.

Thanks,
Chris

