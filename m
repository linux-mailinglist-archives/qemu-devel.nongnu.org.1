Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E282CBEF
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 11:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rObS2-0004yY-AN; Sat, 13 Jan 2024 05:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rObRx-0004xu-Vs; Sat, 13 Jan 2024 05:41:14 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rObRv-0000Mx-UO; Sat, 13 Jan 2024 05:41:13 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 85B6680024;
 Sat, 13 Jan 2024 11:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1705142466; bh=XsBfk377Hx91qrk58snQlKdvUyxgU/0p/5F+skRQh7A=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=so0k2mO88xfaEBgdwt4NI2lWvCS8iy7kqRCwTUNvQJIX1KLZPyt59clZZoVghWY8g
 3Jnh0NrX0qVPV1dninf6MUVZ5Z7eMCQFGDdzoeLFwCASoC5hWK0DCrcWBoQ/j57kNT
 ySH2mvkWpieLYi/hIcn2MUtJp+tMqEGgnTohu6pkJEqjegTu+0fp5kTjJzVrqvEVgA
 nZ89CtoFAmnN+cm4OgBHbxbryDcFUyTItGPo76Lg08qCLwZE6pstoL8y4oolXYQ+d+
 lC1ThQuPRhn+S1L0K957OD1ZWZxGp7eHsJ12FLaIR8rB1FQuwLEcsHxAbOu2LlJIS1
 OTizmpZ81DjzA==
References: <20240113102913.18278-1-arnaud.minier@telecom-paris.fr>
 <20240113102913.18278-8-arnaud.minier@telecom-paris.fr>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: Alistair Francis <alistair@alistair23.me>, =?utf-8?Q?In=C3=A8s?= Varhol
 <ines.varhol@telecom-paris.fr>, qemu-arm@nongnu.org, Philipe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 7/7] Add tests for the STM32L4x5_RCC
Date: Sat, 13 Jan 2024 11:40:24 +0100
In-reply-to: <20240113102913.18278-8-arnaud.minier@telecom-paris.fr>
Message-ID: <878r4th5x9.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
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


Arnaud Minier <arnaud.minier@telecom-paris.fr> writes:

> +     * The procedure is taken from a program by Samuel Tardieu.

You may drop this line as I used the same procedure which is used 
in other tests, this does not deserve a mention here.

  Sam
-- 
Samuel Tardieu

