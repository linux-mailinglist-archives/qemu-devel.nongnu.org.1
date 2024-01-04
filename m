Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FF82434C
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:09:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLONh-0004D1-8X; Thu, 04 Jan 2024 09:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLONZ-0004Co-SC
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:07:26 -0500
Received: from mail-40141.protonmail.ch ([185.70.40.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <inesvarhol@proton.me>)
 id 1rLONV-0005ep-O6
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1704377236; x=1704636436;
 bh=LohKmgRseDaSB+ERASxnrHO1oCJyhHlcxqdfm2iO8u0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NGvS733oTQ2W/tMfEhWdJOeDVU3ofLr01b03fZ40OpNoWw7jNX3fGSy7JatH9n7yd
 0Q54NoldC0XEAw3AEZRB76zaLysoFGrDf71ZgUK6nkrjC2zJXjxmfNU+F4nOf8kYIS
 pSt4wsfaBANStHBWjpDEb8oOhWSshhZXtJRpRnMlsdkuxlFUnReqVYImfBztjZSbNi
 pMHY9SjALrQCJZcnAuwy9Y840Sp4O5CpRxhZ+rZGLO7mtN4n1C0U5rITNJikrJRpmb
 hsRgZcUsLOfHNAWw8o1XUHRHybbAxeJyLj8grymTMCTJYEmjyZrElN16iI4OofcdJc
 7ScD1OgS0iIsQ==
Date: Thu, 04 Jan 2024 14:06:58 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: inesvarhol <inesvarhol@proton.me>
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?utf-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/3] hw/misc: Implement STM32L4x5 EXTI
Message-ID: <ZA25TvKEnDkQ1IUMEzqgQzAq_I9qTKGSDakpgWY-Ez9qggizPb9iHsH5iASQbUzKxznIqHArEz6zoLDRhTbz4449ErmrkYaDaZdCfMbICxs=@proton.me>
In-Reply-To: <b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org>
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
 <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
 <877ckpgrie.fsf@telecom-paris.fr>
 <b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org>
Feedback-ID: 78004345:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.141; envelope-from=inesvarhol@proton.me;
 helo=mail-40141.protonmail.ch
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





Le jeudi 4 janvier 2024 =C3=A0 14:40, Philippe Mathieu-Daud=C3=A9 <philmd@l=
inaro.org> a =C3=A9crit=C2=A0:

> If you don't have access to similar compiler, you can fork on GitLab
> and push a branch to trigger the CI; I expect it to fail.

Thanks for the tip !

Ines Varhol

