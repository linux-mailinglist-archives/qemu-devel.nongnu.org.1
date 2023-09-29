Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F737B2D58
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 09:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm8Nw-0003Fk-Dr; Fri, 29 Sep 2023 03:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qm8Nv-0003FX-2g
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:58:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qm8Ns-0001El-Sl
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QB2pg+mjhPrDb+npuFy7lf4XYzMLtZBzpbGvauE/Kb4=; b=K96pq7mCtXTDPkqN70XLyTsD39
 NSGNS5vlYWUsFtkFPXfKBHX1qY8nPurZloI7f+nxrA5/AT7QOetl/FtUMyeVp2H020EWVqAlia+Gt
 JcdVqdSeKSrUP/chGkGqm9vPzMGWhFkD6foUT/2XhDIvCU3B7E/8sm+1v9xY6d+Mj1usxra20jCbx
 iEBXdJbnaDbLR6Xq5F/3chrBoKZWLxUuodnVA61Ckljv7b2CzXuczJ2NzOLhFNxSSPnZSmqclUuCJ
 1PAgZLHN5huo1KltsVIg7Q1sbyr1CjXLpDB2o0luhL+d6gXax9pVz4mVxV/JnuUcohxD0yeC1ZHOx
 ADoE21nOq9W1x1bFeRt61rSOQhobR2GgxPpHY/CD6U/hIlLNEIyTX8ilhFgD9pWkS8jpdZXU+qV1T
 a0Dz+YayfGfCm2lseo6m8qjLLABJy1Qp/62hc5x8gqySRDBGetnwlvt+O+m9H8wq/42B1JyYpm4fQ
 rJacjgj70hEL1JnoS/CVNJzERbPYu0abcBRXQSJGS+gQgJko2sBPm8gdDanEn0jlB0k+PKH8xSXmT
 QPuHUW3VVmttKta7ch+RV+hP8LwYO8DNSjEL14HwbFiflqnOSQiD0821216K6Ncn94HFNrPDWb+B7
 fmCEhIJkKGlSAfKlwG9BfmnOsxBjy0rcW3Vr75Fas=;
Received: from [2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qm8Nd-000BJ7-3U; Fri, 29 Sep 2023 08:57:49 +0100
Message-ID: <d462d277-4f32-2b98-19c4-7af43167af8d@ilande.co.uk>
Date: Fri, 29 Sep 2023 08:57:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
 <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
 <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 26/09/2023 09:00, Marc-André Lureau wrote:

> Hi Laszlo
> 
> On Mon, Sep 25, 2023 at 7:36 PM Laszlo Ersek <lersek@redhat.com> wrote:
>> Has this been queued by someone? Both Gerd and Marc-André are "odd
>> fixers", so I'm not sure who should be sending a PR with these patches
>> (and I don't see a pending PULL at
>> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
>> with these patch subjects included).
> 
> I have the series in my "ui" branch. I was waiting for a few more
> patches to be accumulated. But if someone else takes this first, I'll
> drop them.

Does this series fix the "../ui/console.c:818: dpy_get_ui_info: Assertion 
`dpy_ui_info_supported(con)' failed." assert() on startup when using gtk? It would be 
good to get this fixed in git master soon, as it has been broken for a couple of 
weeks now, and -display sdl has issues tracking the mouse correctly on my laptop here :(


ATB,

Mark.


