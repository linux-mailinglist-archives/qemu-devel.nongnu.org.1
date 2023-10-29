Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9C7DB18B
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 00:46:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxFSb-00086B-Qn; Sun, 29 Oct 2023 19:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1qxFSW-00085p-Os; Sun, 29 Oct 2023 19:44:45 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1qxFSU-0007En-Ev; Sun, 29 Oct 2023 19:44:44 -0400
Received: from localhost (styx2022 [192.168.200.17])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id DF9951D3FB;
 Mon, 30 Oct 2023 00:43:37 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
 with ESMTP id jF2ncdxRdMz8; Mon, 30 Oct 2023 00:43:36 +0100 (CET)
Received: from baree.pikron.com (ip-78-102-109-231.bb.vodafone.cz
 [78.102.109.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id AC2461D7A2;
 Mon, 30 Oct 2023 00:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1698623016;
 bh=2MybkgFprZ5xt5OSjJ1gn407cF4sR/3fl1/kcWreZxY=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=gOwSKppYZzGiou4UG6+MyXAOe+RzahUa9phinrCmFT1yYFqi+NV5S/SHLNbyLs+D0
 N/ObrLZi1vFGg9PvtjSKUGd2+dZ0vMmHMgWbN1yVj49fqg47YAiuq+P4ca76KtSXmT
 81TJq7l84g8PO632KVHwUaiy4xkmfr703NqKurmaEwbfFQ77DU1YoZy4KL+Rbxtk27
 iuMYDA2agIElwhisijjq96JJN+C9auz16nCoIRoDDTkuYscMx9ltcEpUSY7WoKUZAy
 H0+4k0xOEcL114Mg1lyKG1NMnvgjadJkgZjWSI0wfG5KuZuicJm3mutM4iLvksqonm
 +1dBpvnyKgmFA==
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add the can documenation file to the CAN
 section
Date: Mon, 30 Oct 2023 00:43:40 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Vikram Garhwal <fnu.vikram@xilinx.com>,
 qemu-trivial@nongnu.org
References: <20231027060931.242491-1-thuth@redhat.com>
In-Reply-To: <20231027060931.242491-1-thuth@redhat.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310300043.40642.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.972, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Thomas and others,

On Friday 27 of October 2023 08:09:31 Thomas Huth wrote:
> Add can.rst to the corresponding section in MAINTAINERS, so that
> the maintainers get CC:-ed on corresponding patches.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cce6feff35..48d45b958f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2606,6 +2606,7 @@ W: https://canbus.pages.fel.cvut.cz/
>  F: net/can/*
>  F: hw/net/can/*
>  F: include/net/can_*.h
> +F: docs/system/devices/can.rst

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

I do not have commit right to the Qemu Git.
Please, Paolo or somebody else commit the patch
into mainline.

Best wishes,

                Pavel

-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

