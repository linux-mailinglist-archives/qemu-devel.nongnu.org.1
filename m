Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D18427D7CC6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvteW-0004wi-90; Thu, 26 Oct 2023 02:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qvteM-0004oJ-C5; Thu, 26 Oct 2023 02:15:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qvteJ-0004Ax-6f; Thu, 26 Oct 2023 02:15:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6757E2D66B;
 Thu, 26 Oct 2023 09:15:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10DCB31416;
 Thu, 26 Oct 2023 09:15:07 +0300 (MSK)
Message-ID: <016501c2-e72e-4998-8fc8-a5d47dbf7453@tls.msk.ru>
Date: Thu, 26 Oct 2023 09:15:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/ahci: fix legacy software reset
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20231005100407.1136484-1-nks@flawful.org>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231005100407.1136484-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

05.10.2023 13:04, Niklas Cassel:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Legacy software contains a standard mechanism for generating a reset to a
> Serial ATA device - setting the SRST (software reset) bit in the Device
> Control register.
> 
> Serial ATA has a more robust mechanism called COMRESET, also referred to
> as port reset. A port reset is the preferred mechanism for error
> recovery and should be used in place of software reset.
> 
> Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> improved the handling of PxCI, such that PxCI gets cleared after handling
> a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> receiving an arbitrary FIS).
> 
> However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> enough, we also need to clear PxCI when receiving a SRST in the Device
> Control register.
> 
> This fixes an issue for FreeBSD where the device would fail to reset.
> The problem was not noticed in Linux, because Linux uses a COMRESET
> instead of a legacy software reset by default.
> 
> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Ping?  This bugfix hasn't landed in master still.. :(

/mjt

