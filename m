Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D179E7B43F0
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 23:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmhW8-0006Ew-2G; Sat, 30 Sep 2023 17:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qmhW6-0006Eo-7G
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 17:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qmhW4-0007sY-FF
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 17:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696109326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4THjHDs9fuBRSjNdnxeerGNnCrE6BU5VkDv4vc5kjk=;
 b=OYnrt3bw3d/4ImPE/EKhoRQfXydlngV/rneZJBNZ9me/U3ICPhW2ykc3UbcciXVd54z19t
 IGfDu8b+/SUSlo1thf9GgbA9CyyrLaI0EiHez+nDahEEoFIdY23uGkfQ3HowXSJ9EBmLcP
 xVA1etWA8MBPchZj1rhx1VRB+Py3AfA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-JGkl8A9GM7aqgRkFk5frvg-1; Sat, 30 Sep 2023 17:28:42 -0400
X-MC-Unique: JGkl8A9GM7aqgRkFk5frvg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B6EB8007A4;
 Sat, 30 Sep 2023 21:28:42 +0000 (UTC)
Received: from [10.39.192.54] (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EB1492B16;
 Sat, 30 Sep 2023 21:28:40 +0000 (UTC)
Message-ID: <7dc6ed8b-adfd-2d00-b26e-3d7acb4fe9ee@redhat.com>
Date: Sat, 30 Sep 2023 23:28:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
 <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
 <CAJ+F1CKPaU5z8mnnFJWvw4CmFyEenFQ679A5Nf3CAqzJMqdqVA@mail.gmail.com>
 <d462d277-4f32-2b98-19c4-7af43167af8d@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <d462d277-4f32-2b98-19c4-7af43167af8d@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/29/23 09:57, Mark Cave-Ayland wrote:
> On 26/09/2023 09:00, Marc-André Lureau wrote:
> 
>> Hi Laszlo
>>
>> On Mon, Sep 25, 2023 at 7:36 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>> Has this been queued by someone? Both Gerd and Marc-André are "odd
>>> fixers", so I'm not sure who should be sending a PR with these patches
>>> (and I don't see a pending PULL at
>>> <https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
>>> with these patch subjects included).
>>
>> I have the series in my "ui" branch. I was waiting for a few more
>> patches to be accumulated. But if someone else takes this first, I'll
>> drop them.
> 
> Does this series fix the "../ui/console.c:818: dpy_get_ui_info:
> Assertion `dpy_ui_info_supported(con)' failed." assert() on startup when
> using gtk? It would be good to get this fixed in git master soon, as it
> has been broken for a couple of weeks now, and -display sdl has issues
> tracking the mouse correctly on my laptop here :(

... probably not; I've never seen that issue. Can you provide a reproducer?

Also, it should be bisectable (over Marc-André's 52-part series I guess).

Laszlo

> 
> 
> ATB,
> 
> Mark.
> 


