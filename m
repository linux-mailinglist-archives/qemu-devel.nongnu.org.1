Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7133E765E52
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 23:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP8bS-0007iK-3G; Thu, 27 Jul 2023 17:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qP8bP-0007hl-HM
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:32:55 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qP8bM-0007yU-Pu
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 17:32:55 -0400
Date: Thu, 27 Jul 2023 21:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690493568; x=1690752768;
 bh=6UEgGJx7IRv12KdoBKXYB3rS8Hd3GF4d8b4Zu9vybik=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QvasVDc/Vgv3LwOiI1reBCFa6e+wYS5PSSEJmsINF+qIPm3IsDY6CgScIlCgHGjA6
 eJCX+2WUKN4sF2GpDVodEXTi7t+1st6Djv+zX9fUYql6/hxTU3eYI4N/ec6n6JtuSz
 npPuVGSOt4VqQ75j6MMtlvnHPiYFwQuFlrAT5t4HXn5C9sJM7zTqnFT6ztCpGgjYfM
 0vMuYMeYgsTIw3+gIrxQiOQqGkDzFr7l5s1/mKfVAb+vDgOvCTIpxHS7gStHTPCISO
 cektS37cOoQV94lkJTduD8BQdo+ZlLmSz9Bf9AE0ZNwqKgjT1d8YdLY53nrcdlaULc
 9oUlN4V4ucC+Q==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 3/6] qtest: implement named interception of out-GPIO
Message-ID: <EEsgXkv-Wn8WPzAg07I02DqCvpurTMkc4Vvb1kwHcAPi7jCW9gCRK7C0psplsefPiOL4ltRhb27ipChaC-nrnwOqNjXOjbtJCH_wwLh2_iA=@laplante.io>
In-Reply-To: <CAFEAcA_K+Rzt8=0apiyO5tB3EwTRJMo8afKu3wkb2=jAsyLvmg@mail.gmail.com>
References: <20230726030450.757462-1-chris@laplante.io>
 <20230726030450.757462-4-chris@laplante.io>
 <CAFEAcA_K+Rzt8=0apiyO5tB3EwTRJMo8afKu3wkb2=jAsyLvmg@mail.gmail.com>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
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


> (g_strcmp0() can handle the NULL case without having
> to special case it -- this is how qdev_get_named_gpio_list()
> finds entries in the ngl list.)
>=20
> Apologies for not noticing that on the first round of review.

No worries - it makes the code much simpler anyway. Should we bother factor=
ing out qtest_install_gpio_out_intercept still? It is only used in one plac=
e now, as before.

Thanks,
Chris

