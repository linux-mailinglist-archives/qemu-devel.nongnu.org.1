Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848976068D
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 05:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qO8ff-0000oC-Gn; Mon, 24 Jul 2023 23:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qO8fd-0000nw-P9
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 23:25:10 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qO8fb-0001ap-IB
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 23:25:09 -0400
Date: Tue, 25 Jul 2023 03:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1690255501; x=1690514701;
 bh=wObaOjtz0t4P7hmP4mV+hxoFOlQUOJU987JChTQuDd8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=kcbc2JwCfpWSGPXDCSodjel5T3lhYhjYUIqKOiCgOcbMoTB1f4Pkj6oSILu2xN9Cn
 PTFafuF0g7XytVnkBypPt9M1Wq1Zdps62kPCBtNEfLrsoe2QnXkEfUymP0OCdR72WG
 9z8W8Vxgs5IjYoFtUynPqHQ1Ek5nlQc1d1sVzpxCBjOMq+iiskHbO7OmLttRrGrZpU
 LhzFW3al9HolY8gYhnpvTPk1d0TFd/J1wU+uvBQNVuX1OakbP5TKvbSUDYuJeWQLz/
 NdlyGwAgyD+5JGkTeW1lbDN6xd+rM49KbBTMzZlSX17bOKeXWSabRBcu5b8viTwd9m
 7OPlx0yZVJN0g==
To: Peter Maydell <peter.maydell@linaro.org>
From: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/6] Add nRF51 DETECT signal with test
Message-ID: <uJ83qRpjm3C76JRjI4OOm2NAz3uF-RDUa2WL8sp3ftAzoH16KDfxZhwxsqxqxrHTfXHKkZZXy0JY6UUpq7nD0jfYEUtYM_K340O6E6BFwJY=@laplante.io>
In-Reply-To: <CAFEAcA_gGia=ckyv4=XHNX4=VHJJ=rmVGXQbdnOAGv5h1rzLzw@mail.gmail.com>
References: <20230714232659.76434-1-chris@laplante.io>
 <CAFEAcA_gGia=ckyv4=XHNX4=VHJJ=rmVGXQbdnOAGv5h1rzLzw@mail.gmail.com>
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

Hi Peter,

> Thanks for this patchset and especially for the work
> improving the qtest infrastructure. I've given my
> comments on the different patches, and in some cases
> reviewed-by tags. (Where I've given one of those, you should
> add it to your commit message for the relevant patch under
> your Signed-off-by: line, so that when you send the version
> 2 of the patchset we know that those parts are already
> reviewed and don't need re-examining. If I said "make
> some change; otherwise Reviewed-by" that means "make
> that minor change, and then you can add the tag, etc".)

Thanks very much for the feedback and help!

> Do you have the parts of this feature that use the DETECT
> signal in the POWER device, or have you not written those
> yet ? If you have them, you could send those too in v2.

That part is halfway done, so I will work on finishing it before submitting=
 v2. Two questions regarding that (to potentially save us a v3):=20

1. The nRF51 POWER device overlaps with the memory maps of the CLOCK and MP=
U devices. So I have created a CPM (CLOCK, POWER, MPU) device in hw/misc. D=
oes that sound reasonable naming-wise?
2. I also have some implementations for pieces of CLOCK, namely the HFCLKST=
ART/HFCLKSTOP events and HFCLKSTARTED event. Should I include that in this =
patch series, or would you prefer it in a separate series? It is unrelated =
to DETECT and POWER.

Thanks,
Chris 

