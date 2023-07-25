Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E96A27606FD
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 06:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO9H4-0005G9-6o; Tue, 25 Jul 2023 00:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qO9H2-0005Fr-P5
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 00:03:48 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qO9H0-0008Kt-6W
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 00:03:48 -0400
Date: Tue, 25 Jul 2023 04:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690257822; x=1690517022;
 bh=FzHkezrXUwtNFiOep8NQSkIG/L/SpnpJvatf25VRcOQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CNtnRQOHfOhOG/FvG7lVTImOnAdEvEQbqV6emLMlsyH2RBCRG/HHdlSXQzH4lqO5M
 eNCP1MS/DUH44NNBwTaBCLpm9Wn7CutA2v8Px5dI7TdYx/5A5Cz0jFVJ9SIWWVpvNt
 f/BSACUkvJYi8m2om9ZQ2xI8B4KsmKUig10rib3CrO+Edz1AJh1NVdyOvCq/vVBOSG
 uwmJNttUTgFJaEolYMGHNXtzAzua23SxLhVJcPnjt4rcYgqSIoBCJ9t7rBC5Io1ubd
 DPCbs0Ato0k72wjXuB3AGelXbfQ7Kba53b0xztMzDnLdgsDG484iUZ64S3QoTyUIIo
 j88t1TX+YXpog==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: Re: [PATCH 5/6] qtest: irq_intercept_[out/in]: return FAIL if no
 intercepts are installed
Message-ID: <xu8BRMMwZ-YDUONRpB3ezRZBQSdPJ8KybNIsTf-ciNUp8r2WpuuOcuz9BorqrvG-DBFMmLTAX5rKaAYLtTOHP4YgCU-GQUffQOzpMkE-byI=@laplante.io>
In-Reply-To: <CAFEAcA_kfDP_RpQB=_u46tH6C0pSeB=crv2cBgfrCjLCbWmGBA@mail.gmail.com>
References: <20230714232659.76434-1-chris@laplante.io>
 <20230714232659.76434-6-chris@laplante.io>
 <CAFEAcA_kfDP_RpQB=_u46tH6C0pSeB=crv2cBgfrCjLCbWmGBA@mail.gmail.com>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=chris@laplante.io;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
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


> Makes sense. Did you do a 'make check' on an
> all-targets-enabled build just to confirm we haven't
> accidentally let any bogus uses of the command in while
> it was returning OK for these cases?
>=20
> Reviewed-by: Peter Maydell peter.maydell@linaro.org

Yes, I just did a 'make check' and got:

Ok:                 737=20
Expected Fail:      0  =20
Fail:               0  =20
Unexpected Pass:    0  =20
Skipped:            71 =20
Timeout:            0  =20

Thanks,
Chris

