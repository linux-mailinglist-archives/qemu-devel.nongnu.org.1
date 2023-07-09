Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA874C912
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 01:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIdbQ-00030x-NW; Sun, 09 Jul 2023 19:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qIdbO-00030V-3p
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 19:14:02 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qIdbK-0005Dn-Qw
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 19:14:01 -0400
Date: Sun, 09 Jul 2023 23:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1688944431; x=1689203631;
 bh=hFfuHKCQ8eiUPQZ9hvbTt++GNMK7hEWwLyzELI8TZRI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fQHJW1AJGC6Vc7fLYw/xaS6hmFqCmg1OU3L+A1nuhdWSEirBZeVyv6xfaw8/sUqGV
 doTdjsQH6/pChl102irAs8xylelTai3ac7ZZgy/MqFFOKyNlQOSaF1/01SWC/hB1Sy
 KQho5APcFiPznHCbMIyQPzjrHNTAAOP/b27KQMBl8RUhdwkuFYzdLk67eD3Qsxz3FX
 XhI6+OigECB6IO7qvx0abMLl+UT0U6mUEjlTskzq50pJG8ekWP/fgYZhoIXr/mZdFS
 QeFQwffRLYDNeOyZ6eKZIi+fiCVm4fdcDab/gduxzuhOxG6DuAeki/zdth7WPXVOin
 HBAlqfoJOj/VQ==
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Addition of qtest_irq_intercept_out_named,
 or modify qtest_irq_interrupt_out?
Message-ID: <11pkPgXrI-HabhwFY1WN1jlFjiiqGCIa7KNEJnavNR7g-I9iJnW7poVaIt_MgzFNmEa1gYoZ6Ivin_DD3Lzn0l3u8b0GCt-N5CPLIFXkQZ8=@laplante.io>
In-Reply-To: <fb1ebb07-6452-9ba1-f394-9b43a44a4d80@linaro.org>
References: <v4-CFRWoJDePdhYGwXmcoZ4pJoJVk37oEGjiSx0aN-3K4aBwDF3_5SVTlspGOZnwk9QA7ewsCyGgitkgaxtSLRiqe2euhsY1klbjIdCkHf8=@laplante.io>
 <fb1ebb07-6452-9ba1-f394-9b43a44a4d80@linaro.org>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=51.77.79.158; envelope-from=chris@laplante.io;
 helo=mail-0201.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[sorry, resending because I forgot to reply-all]

> qtest_irq_intercept_out() takes a QOM path argument. Whether it is
> a named IRQ or not should be irrelevant at this layer.

I'm a little confused about the QOM path. Currently the code in qtest_proce=
ss_command() is calling object_resolve_path, but (as I understand it) a nam=
ed IRQ is not an object, it's a property. So I either need to find a flavor=
 of object_resolve_path that can also handle properties, or I need to add a=
 parameter to qtest_irq_intercept_out for specifying the name. Does that so=
und right?

Thanks,
Chris

