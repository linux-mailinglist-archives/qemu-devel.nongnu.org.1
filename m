Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 622E9815DE8
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 08:39:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEliM-0001RJ-L8; Sun, 17 Dec 2023 02:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rEliJ-0001Qx-NR; Sun, 17 Dec 2023 02:37:27 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rEliG-0002a0-4t; Sun, 17 Dec 2023 02:37:27 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 995DE80025;
 Sun, 17 Dec 2023 08:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1702798638; bh=WJtvAqRs6pqgFMDIUz7FqRnqdA6ge5oy8hsHAq+8alE=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=c1ZmcisYoBZZrAFU83G8C/0FieLZt3yQYXmRKUvS/FrxY13D/ZnldKgLzO8+uCR97
 /YdaLFBNTeeqHCZ58gcg+qxC6pjF8tAA86YQbumdoFFsiwibu04aqm88BFadVMYzqX
 i2dtkXNZ8R2I3xctIvnMa+K9P2s4PEINaz0+dviaN6aoNH05HEX+rAy3LrwT9ZzfEg
 9nHPoRpOO/R6HWSR70LG0RYaiZEGPUgCQ4eZ+KUxww9RD9JR7g2nqP7ydP1IqdWEoz
 BbVNxsVjaG251N/RcmX0rhvVHFPLji75d9FNSFO1kU4BzQLvmmGogpb+yQWr78kWfb
 E+42aJHJrNiPg==
References: <20231216182740.3305724-1-sam@rfc1149.net>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Anton Kochkov <anton.kochkov@proton.me>, qemu-arm@nongnu.org, Alexandre
 Iooss <erdnaxe@crans.org>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] Add "num-prio-bits" property for Cortex-M devices
Date: Sun, 17 Dec 2023 08:35:31 +0100
In-reply-to: <20231216182740.3305724-1-sam@rfc1149.net>
Message-ID: <878r5tqnyu.fsf@rfc1149.net>
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


> Samuel Tardieu (3):
>   hw/intc/armv7m_nvic: add "num-prio-bits" property
>   hw/arm/armv7m: alias the NVIC "num-prio-bits" property
>   hw/arm/socs: configure priority bits for existing SOCs

Any idea to why patchew fails to apply thoses patches? The mbox at 
<https://patchew.org/QEMU/20231216182740.3305724-1-sam@rfc1149.net/> 
applies cleanly on master AFAICS.

  Sam
-- 
Samuel Tardieu

