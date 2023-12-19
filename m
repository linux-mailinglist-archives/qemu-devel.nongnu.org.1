Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0C819097
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:20:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfZM-00087R-QN; Tue, 19 Dec 2023 14:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rFfZI-00081C-E5; Tue, 19 Dec 2023 14:15:52 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rFfZG-0002RP-1z; Tue, 19 Dec 2023 14:15:52 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 7AD9880024;
 Tue, 19 Dec 2023 20:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1703013343; bh=0dClO786ziR8HNe1s46NWlhaDGUzRlloPD7GXUzTnJA=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=o9LVi3mVPDajKlQCn+2UdzAmbWsadIpaPrMsAVQkf9I3ve8PrXT6Y3xVb+GtKaHqo
 u++oiRkQN8Fiqlhb4stTKYwrIJB6RvxocGgTXVmXG/MGiSzYhGjnk0g0S8mRvV4s8p
 MeCySE+t4qb6uu4qqyjIv0pSHKnTvLhcYQdZTXioX9djSfWAd7L7kAmCk9sJaLvvjj
 cRVxcYOsLinrHNRfuBwjyZkBVYY9c7WcfUbO0c4relgCnkHUk984OAhrys3ly/7T7y
 GRX348cRZestfzRvh4EaIyhutIsF1ffQIVUr5at0unvrG28JTLjrivbAdh/RuenZlU
 zCHMClCstzmMw==
References: <20231216182740.3305724-1-sam@rfc1149.net>
 <878r5tqnyu.fsf@rfc1149.net>
 <CAFEAcA8sTLZSQdqZmNGSv4yp3TZvq86kwbhU8gFmK2=j8vVZhQ@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, Alistair Francis
 <alistair@alistair23.me>
Subject: Re: [PATCH 0/3] Add "num-prio-bits" property for Cortex-M devices
Date: Tue, 19 Dec 2023 20:13:52 +0100
In-reply-to: <CAFEAcA8sTLZSQdqZmNGSv4yp3TZvq86kwbhU8gFmK2=j8vVZhQ@mail.gmail.com>
Message-ID: <87wmtaxaub.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_CSS=0.1 autolearn=ham autolearn_force=no
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

>> Any idea to why patchew fails to apply thoses patches? The mbox 
>> at
>> <https://patchew.org/QEMU/20231216182740.3305724-1-sam@rfc1149.net/>
>> applies cleanly on master AFAICS.
>
> This is because you put a Based-on: tag in the cover letter.
> Based-on: means "please apply this other patch first before this
> series, because there is a dependency" (we use it for things
> like "this patchset has to sit on top of some other cleanup
> patchset I sent last week and which hasn't got into git yet").
> So patchew applied Anton's original patch from 2022, and then 
> tried
> to apply your three patches on top of that, which caused a 
> conflict.

Thanks for the explanation. I thought "Based-on:" was just a 
polite way of attributing credit to past discussions. I'll keep 
that in mind. Do you want me to resubmit it as a v2 without the 
"Based-on:" tag so that patchew gets it right?

> Anyway, I just wanted to say that this patchset is on my
> todo list to review but I'm not going to be able to get to
> it before I break for Christmas, so I'll get back to it
> in January. Thanks for the contribution!

Noted!

Best.

  Sam
-- 
Samuel Tardieu

