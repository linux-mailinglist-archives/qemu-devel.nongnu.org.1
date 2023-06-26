Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17073DC05
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj9D-0005Vr-US; Mon, 26 Jun 2023 06:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qDj90-0005UX-G4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:08:27 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qDj90-0001Iz-2B; Mon, 26 Jun 2023 06:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=AWxdhxN2K0UWVyJTi4vPfWKZPw8ZcyxEvaTv1hRa7u8=; b=WBZ+sUJrRaxIO4V2+JI1
 5EmWc8eWV30C3YtejDCGWsQzasHkas0ZzpA1mxaTdDqctqwjGbq1R/gfz+ljxTFhy+LGiFZmqBqsz
 ntW9ql+qKLLwuHGJ+UY04l/Y8vX61quYmgNhmctxhtCIa+0cm2Kv3fw7HpLp0aojvkn0zKll9s9Iu
 fNb6lYCE9Z59Gbjvk3vd9zdJpdfS6RLw4SVJL/YHzMXm8Z0Cug1ovVQXjDpaZ8SkYAutOJfccU3W7
 vOSL6jFPVw40In/lNQFswYy7UL3S4WTaM56T8RC1laot1PYEFBDP3qL/xYyFtjyorhNjUi211SuXo
 C7Uhulo7VYhvGA==;
Received: from [91.151.117.182] (helo=begin)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qDj8w-0004su-Fd; Mon, 26 Jun 2023 06:08:25 -0400
Received: from samy by begin with local (Exim 4.96)
 (envelope-from <samuel.thibault@gnu.org>) id 1qDj8t-009Yt0-3A;
 Mon, 26 Jun 2023 12:08:19 +0200
Date: Mon, 26 Jun 2023 12:08:19 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Lukas Straub <lukasstraub2@web.de>
Cc: Felix Wu <flwu@google.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: Tips for local testing guestfwd
Message-ID: <20230626100819.vtkuuvzg376hktk2@begin>
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626114916.45355529@mobian.usb.local>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Hello,

Felix Wu <flwu@google.com> wrote:
> 2. I want to understand what ip I should use. Currently I have following
> formats for the QEMU invocation in ipv6:
> ```
> guestfwd=tcp:[::1]:1234-tcp:[my:host:ip:from:ifconfig]:22
> ```
> I know the general form is `guestfwd=tcp:server:port-dev`, where
> server:port is for guest,

Yes, the address to be used within the guest network. So it needs to be
within the guest network.

> Is the aforementioned invocation correct?

No, because ::1 isn't in the guest network.

> Or in this case [::1] is the local host address and I should put qemu
> address for it instead?

You can use whatever IP you want, as long as it's in the guest network.
e.g. [fec0::1234] if you're with the default fec0::/64 network.

> 3. Is there a default ipv6 address for QEMU instance? I think I need it in
> the invocation.

By default it's address 2 within the prefix, i.e. fec0::2 with the
default fec0::/64 network.

Samuel

