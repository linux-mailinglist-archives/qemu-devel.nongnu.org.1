Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 473ED964602
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Aug 2024 15:13:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjey1-0005K9-0N; Thu, 29 Aug 2024 09:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjexy-0005E9-Pq
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:13:34 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1sjexw-0005nD-FB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 09:13:34 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 0E2083A301;
 Thu, 29 Aug 2024 15:13:31 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id ZZ7P37I27Mg6; Thu, 29 Aug 2024 15:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1724937208;
 bh=apV8L9XfX6jHjwXhMbl6Hhc6+uDO7AxqPmEXPHbd1G4=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=aWy74r7ELqnB9G8LxcVMxAEah2aGfrT8VLM9FDLujA7sgXxXe94G04E2F6DQc43E5
 VLgT0bSeFBIfj2+ofs40hlT2Txha72oTdylLhMgJGG2LzJEbEDMYQPqeG319zojTST
 bZ1afkY4f7MZC+esHUSbLYMa0hAK/KatPyAX9hTusmv36QPzTv6Fh3nrPbv+spFIEn
 hDii52CDai4qSs26dPUHlJYeBiXTYVmcarI6Wpp9roNGaUNs7LCirs1f95HQh6iC50
 SzxUH9U9C0HD4jEYUlVbjpGh93KdW2lp1OK4dtMk9f8dlNeCl7vMmNHAzGi1o7cnEJ
 xv9y8m+M/deqw==
Received: from [147.32.86.193] (unknown [147.32.86.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id BDDBA3A300;
 Thu, 29 Aug 2024 15:13:28 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 4/7] hw/net/can/xlnx-versal-canfd: Handle flags
 correctly
Date: Thu, 29 Aug 2024 15:13:34 +0200
User-Agent: KMail/1.9.10
Cc: Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240827034927.66659-1-doug@schmorgal.com>
 <20240827034927.66659-5-doug@schmorgal.com>
In-Reply-To: <20240827034927.66659-5-doug@schmorgal.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202408291513.34117.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-1.084,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tuesday 27 of August 2024 05:49:24 Doug Brown wrote:
> Add support for QEMU_CAN_FRMF_ESI and QEMU_CAN_FRMF_BRS flags, and
> ensure frame->flags is always initialized to 0.
>
> Note that the Xilinx IP core doesn't allow manually setting the ESI bit
> during transmits, so it's only implemented for the receive case.
>
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

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

