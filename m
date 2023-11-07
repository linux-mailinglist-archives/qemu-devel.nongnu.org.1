Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D67E46FB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 18:29:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ps5-00052y-8q; Tue, 07 Nov 2023 12:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r0Ps0-00051x-1U
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 12:28:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1r0Pru-0002Qo-EX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 12:28:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE2683127B;
 Tue,  7 Nov 2023 20:28:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 62BBE33BFE;
 Tue,  7 Nov 2023 20:27:58 +0300 (MSK)
Message-ID: <01860b45-b4b0-44c9-a0a8-fd379b15b04c@tls.msk.ru>
Date: Tue, 7 Nov 2023 20:27:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2 1/4] ati-vga: Fix aperture sizes
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 marcandre.lureau@redhat.com
References: <cover.1698871239.git.balaton@eik.bme.hu>
 <d077d4f90d19db731df78da6f05058db074cada1.1698871239.git.balaton@eik.bme.hu>
 <da9904df-1e3c-4e73-b614-b93665d73a05@tls.msk.ru>
 <ad496517-ecb6-975f-7829-0773f66cd71d@eik.bme.hu>
Content-Language: en-US
In-Reply-To: <ad496517-ecb6-975f-7829-0773f66cd71d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

07.11.2023 18:33, BALATON Zoltan:
..
>> Is it stable-worthy?
> 
> Not really beacause this is only needed by RV100 drivers but that GPU is not emulated enough yet to work so this won't help them. However the last 
> patch adding pixman fallbacks to ati_2d.c fixes graphics issues on Apple silicon Macs where pixman does not work that happens also with the default 
> rage128p emulation so that patch may be useful in stable. It should be independent of the other patches in the series so should apply without the 
> other patches.

Heh. Interesting.  Thank you for the clarification, I'm picking up 08730ee0cc01
"ati-vga: Implement fallback for pixman routines" instead of aperture sizes fix.


/mjt

