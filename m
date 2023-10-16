Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884C7CA750
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMF9-0006i8-Ry; Mon, 16 Oct 2023 07:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qsMF6-0006hN-7r; Mon, 16 Oct 2023 07:58:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qsMF3-0005pc-MG; Mon, 16 Oct 2023 07:58:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 614342AA47;
 Mon, 16 Oct 2023 14:58:42 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B6782F610;
 Mon, 16 Oct 2023 14:58:27 +0300 (MSK)
Message-ID: <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
Date: Mon, 16 Oct 2023 14:58:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -drive if=none: can't we make this the default?
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
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

Almost everyone mentions -blockdev as a replacement for -drive.

But I have to remind several issues with it:

1. While documentation has improved a lot, -blockdev is still mostly unknown
    to the masses.

2. -blockdev is just too verbose, one have to specify a lot of parameters just to
    do a simple thing which is solved with an extra parameter with -drive.
    Including various backing stores/chains for qcow2 files - this is terrible for
    using things manually from command line

3. -blockdev does not work with -snapshot

4. Something else I forgot while typing all the above :)

In my view, -blockdev is not a substitute for -drive, not at all, and it is
very user-unfriendly.  This is why -drive seems to be a good trade-off between
things like -hda (which is just too simplistic) and -blockdev which which is
way too verbose and lacks some automatic sugar like -snapshot.

/mjt

