Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60197737C3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTDmE-0008Jb-EM; Mon, 07 Aug 2023 23:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qTDm8-0008Hv-QJ; Mon, 07 Aug 2023 23:52:52 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qTDm2-0000Vm-Vy; Mon, 07 Aug 2023 23:52:50 -0400
Received: from [192.168.8.53] (unknown [94.25.229.164])
 by mail.ispras.ru (Postfix) with ESMTPSA id 07E0140F1DCC;
 Tue,  8 Aug 2023 03:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 07E0140F1DCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691466759;
 bh=wWPPKMdNbVNwUyvVVt6rB7iBhAjrOgSbEePKgC8XfPs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RZHXzVWWG5RmAcOiggAMkhF/fTr1MOxEjHCZrHzyVxF7hSpsr3/32xeah/KSmuRzL
 4phj1xpLp3CPEOG1G09ft47BFJz3zVSg4okeEhP4CM5hbm0ALosZc6rI575uP7BspF
 hCzWgqg0pEbW45V/tu1XyHiKeRDFHMWDPWgnZX8I=
Message-ID: <7903fa1d-1bcd-fd72-5dff-0ac665eb1ddd@ispras.ru>
Date: Tue, 8 Aug 2023 06:52:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] spapr: Fix record-replay machine reset consuming too
 many events
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-5-npiggin@gmail.com>
 <3be75aa3-780d-2d4d-a68c-1f8d1d000ee8@ispras.ru>
 <CULFQXOOUWDB.3GMPJXRWAWSDW@wheely> <CUMU01SZ63FP.3B3F5NBPCVQT0@wheely>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <CUMU01SZ63FP.3B3F5NBPCVQT0@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 08.08.2023 06:09, Nicholas Piggin wrote:
> On Sun Aug 6, 2023 at 9:46 PM AEST, Nicholas Piggin wrote:
>> On Fri Aug 4, 2023 at 6:50 PM AEST, Pavel Dovgalyuk wrote:
>>> BTW, there is a function qemu_register_reset_nosnapshotload that can be
>>> used in similar cases.
>>> Can you just use it without changing the code of the reset handler?
>>
>> I didn't know that, thanks for pointing it out. I'll take a closer look
>> at it before reposting.
> 
> Seems a bit tricky because the device tree has to be rebuilt at reset
> time (including snapshot load), but it uses the random number. So

It seems strange to me, that loading the existing configuration has to 
randomize the device tree.

> having a second nosnapshotload reset function might not be called in
> the correct order, I think?  For now I will keep it as is.

Ok, let's wait for other reviewers.


Pavel Dovgalyuk


