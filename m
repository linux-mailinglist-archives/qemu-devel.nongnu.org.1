Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D7811AD9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSwc-0007E4-Od; Wed, 13 Dec 2023 12:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDSwa-00077F-6e
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDSwX-0001AI-N7
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:22:47 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6421F75A4D7;
 Wed, 13 Dec 2023 18:22:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id O8zguMu_0NcT; Wed, 13 Dec 2023 18:22:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 31C8C75A4C2; Wed, 13 Dec 2023 18:22:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2FC1F75A4BC;
 Wed, 13 Dec 2023 18:22:39 +0100 (CET)
Date: Wed, 13 Dec 2023 18:22:39 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
cc: Rene Engel <ReneEngel80@emailn.de>, peter.maydell@linaro.org, 
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
In-Reply-To: <d27f1e22-7fe3-4c00-ad73-1926dabec30a@daynix.com>
Message-ID: <e3839467-6d4c-e8e6-9247-a71fafe5505e@eik.bme.hu>
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
 <5fcbed94a573a1b3bc9968ef9f72b496@mail.emailn.de>
 <d27f1e22-7fe3-4c00-ad73-1926dabec30a@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1181701199-1702488159=:24141"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1181701199-1702488159=:24141
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 13 Dec 2023, Akihiko Odaki wrote:
> On 2023/12/13 0:38, Rene Engel wrote:
>> 
>> --- Ursprüngliche Nachricht ---
>> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Datum: 11.12.2023 06:39:35
>> An: Peter Maydell <peter.maydell@linaro.org>,  Philippe Mathieu-Daudé 
>> <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Marc-André Lureau 
>> <marcandre.lureau@redhat.com>
>> Betreff: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
>> 
>> Tested-by:<ReneEngel80@emailn.de>
>
> Thanks for testing.
>
>> 
>> This patch works very well on MacOs Sonoma with the Qemu Cocoa output. 
>> Thanks
>> 
>> Since you are dealing with the Cocoa output under MacOs, I have a request 
>> for you. Is it possible to use the Cocoa output with zoom to fit in full 
>> screen mode like it is possible with the GTK output with "-display 
>> gtk,zoom-to-fit=on -full-screen"? >
>> I mainly start Qemu using a start script that immediately puts Qemu into 
>> full screen.
>
>
> It should be possible, at least with this patch. Recently, Carwyn Ellis added 
> the support for the command line option (commit 5ec0898b0579 ("ui/cocoa: add 
> zoom-to-fit display option")) so your script can utilize it.

Looks like commit 5ec0898b0579 missed to update documentation so this 
option does not show up in 
https://www.qemu.org/docs/master/system/invocation.html#hxtool-3
Should this be added to qemu-options.hx?

By the way is there a way to get those options from the command line? 
I've tried this but got an error:

$ qemu-system-ppc -display sdl,help
qemu-system-ppc: -display sdl,help: Help is not available for this option

Regards,
BALATON Zoltan
--3866299591-1181701199-1702488159=:24141--

