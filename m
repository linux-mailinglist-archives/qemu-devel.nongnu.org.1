Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596C8259A2
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:05:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoXu-0004be-JU; Fri, 05 Jan 2024 13:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rLoXr-0004ae-PX; Fri, 05 Jan 2024 13:03:47 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rLoXp-0000HO-Q1; Fri, 05 Jan 2024 13:03:47 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 9DB0F80024;
 Fri,  5 Jan 2024 19:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1704477822; bh=iLoRepbx4vfuo3JSlCYs0nvNO2gl1nCFC2LADd1/OyM=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=BGCDTHKPXAkFTJidrWh9BPj5g/5C/2AazBmCp6rDK7lZ0gtvyI3liT+tX4JGKD/WB
 g4ytX2Kdxaiwo+LpqI+pZfxZriFTNdJrIY10Itt8xQelzEgVRiob3mFOebgUwqFNbS
 EnxiqcRKSsttxucKuyAB6f4Tp85cysU/hDLrEafbMEd2Gi0BM0oymwVvmGTe+9EV9Q
 bGmIj4jK/VCaMmiv+wp9XVoS9GtE0zQgKKgiuRe/sVZBilplfYmijGsWfSsfvRWWqA
 6EJRc0hPyOUslnpIEwQu5rwIJ+Vftou7VUruR3AwcuF2z4Wkqzc2fjQq0vOXYNNA3k
 ukN+AjBrbjOmQ==
References: <20240103155337.2026946-1-sam@rfc1149.net>
 <20240103155337.2026946-3-sam@rfc1149.net>
 <CAFEAcA8k22X+8Ypw_gvpsFHVAm=pHnB2-_iVNwyMrHhhyP=JRA@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 qemu-arm@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>, Alistair
 Francis <alistair@alistair23.me>, =?utf-8?Q?In=C3=A8s?= Varhol
 <ines.varhol@telecom-paris.fr>, Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 2/3] hw/arm/armv7m: alias the NVIC "num-prio-bits"
 property
Date: Fri, 05 Jan 2024 19:01:21 +0100
In-reply-to: <CAFEAcA8k22X+8Ypw_gvpsFHVAm=pHnB2-_iVNwyMrHhhyP=JRA@mail.gmail.com>
Message-ID: <87ttnrbqtd.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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


Peter Maydell <peter.maydell@linaro.org> writes:

> There's a comment in include/hw/arm/armv7m.h which documents
> all the GPIO inputs, QOM properties, etc, that this device
> has -- that also needs a line adding to it for this property.

Thanks Peter for your review. I'll send a v3 containing the=20
requested change after In=C3=A8s has submitted an updated version of=20
her "Add minimal support for the B-L475E-IOT01A board" serie on=20
which this one is based.

Best.

  Sam
--=20
Samuel Tardieu

