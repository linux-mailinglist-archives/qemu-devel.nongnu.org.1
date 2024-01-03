Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A181D82372C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 22:35:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL8sa-00086E-4p; Wed, 03 Jan 2024 16:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1rL8sT-00085J-Hr; Wed, 03 Jan 2024 16:34:17 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1rL8sP-0005v9-ER; Wed, 03 Jan 2024 16:34:17 -0500
Received: from localhost (styx2022 [192.168.200.17])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 8E83228F4B;
 Wed,  3 Jan 2024 22:34:06 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
 with ESMTP id pZhiWc51jnsS; Wed,  3 Jan 2024 22:34:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1704317644;
 bh=hvXSgV1uqYS4CfjbDHEhbM1pDscEkwkkiA5jLy0Or6w=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=OnDzy7p62i8qeV1fggnSGaGD9B1pjThdszeok2kDpQ4OndNKuXItFQ7qG7KjsMowU
 6a0pHsSn5A3KCvrBrCmzvpi9QEteTXYNpVwdmlNp2a5igXSuiKjAKE5cgRojGAyauk
 l3o+3NuDqIAKmwkBCW0Pgd3LlifZBiY7m3FqalBGOAjgd3360ooO4eCxgC0G5aVKLv
 A0XsRD946mviAifxEzhOMlkFXpuJM0exg/xjyW2EHgdtEKzjfJwcw9eHi2afiA5UQ9
 pbo0ClG5M4tFTrG02Ync7uro3+NPPaJAB9ihMT3STlmJdQXswXPnHQce55Rk35puDp
 19J5s6DR7djXQ==
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 33E5B29030;
 Wed,  3 Jan 2024 22:34:04 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] docs: use "buses" rather than "busses"
Date: Wed, 3 Jan 2024 22:34:12 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240103172817.2197737-1-sam@rfc1149.net>
In-Reply-To: <20240103172817.2197737-1-sam@rfc1149.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202401032234.12134.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.771, SPF_HELO_NONE=0.001,
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

On Wednesday 03 of January 2024 18:28:17 Samuel Tardieu wrote:
> If "busses" might be encountered as a plural of "bus" (5 instances),
> the correct spelling is "buses" (26 instances). Fixing those 5
> instances makes the doc more consistent.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

PS: there is waiting my previous CAN FIX from December 14
and I have received any feedback if it will be taken
by somebody with commit rights

  https://gitlab.com/qemu-project/qemu/-/issues/2028
  https://patchew.org/QEMU/20231214104623.31147-1-pisa@fel.cvut.cz/

Should I resend it?

