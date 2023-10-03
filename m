Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4237B6F52
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qniwA-0007r6-KR; Tue, 03 Oct 2023 13:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnivy-0007iK-Ry; Tue, 03 Oct 2023 13:11:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnivv-0003C6-O9; Tue, 03 Oct 2023 13:11:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3F2227289;
 Tue,  3 Oct 2023 20:12:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 997062C948;
 Tue,  3 Oct 2023 20:11:39 +0300 (MSK)
Message-ID: <a6cc110d-132e-b3f3-0b64-368bcb5c31a9@tls.msk.ru>
Date: Tue, 3 Oct 2023 20:11:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: FreeBSD 13.2 installer does not see AHCI devices on
 aarch64/sbsa-ref and x86-64/q35
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Damien Le Moal <dlemoal@kernel.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
 <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -79
X-Spam_score: -8.0
X-Spam_bar: --------
X-Spam_report: (-8.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

26.09.2023 15:05, Niklas Cassel:
> Hello Marcin,
> 
> I will have a look at this.

Hi Marcin, Hi Niklas!

Niklas, I remember asking you if the whole thing is okay for the -stable,
and you was a bit unsure about it :)  Regardless, I picked the changes
up for -stable. I don't think it was anyone's fault though, - after all,
I guess, without the change being in -stable, we'd know about this issue
in some distant future instead of now :)

I'm planning to release 8.1.2 soon, with freeze being at Oct-14.  It'd
be really great if we can include a fix for this both in master and in
8.1.2 (8.1.2 should have a long-awaited fix for a quite serious long-
standing issue in 8.1).

Were you able to take a look at what's going on here?  I wish I were
able to help here but I know right to nothing about ahci emulation..

Thanks,

/mjt

