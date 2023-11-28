Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34D7FB169
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 06:43:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7qrS-0004cy-2p; Tue, 28 Nov 2023 00:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7qrP-0004cc-18
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 00:42:15 -0500
Received: from dog.elm.relay.mailchannels.net ([23.83.212.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r7qrN-0005v0-Hn
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 00:42:14 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 4D4AD7A266B;
 Tue, 28 Nov 2023 05:42:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E2B1C7A1F82;
 Tue, 28 Nov 2023 05:42:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701150130; a=rsa-sha256;
 cv=none;
 b=p/EMAhh8tf/7smBDvVCf4u/zEoJETO6cYt33QokiPiZz4X5v7bX3xx54iK/jSbDUBhPX2A
 twEKx6DlV29sE8IDD5F6sgK29F7G+PDvtrI2+rf2KxwEPUexKrBp4/wzCp0zywYnZ1bi6M
 +NLu6ik/4xec+iEX4Z15kHZHc3HgL799ReOY+VIouXLIJE8cvroQTFcHQSMPop6v2LkHoZ
 S1UQdqtXJu3chCq1PzOUay/28ixTtvnPI6fQsH2H1vOwy8Y8cTLpjj7lJBKgxoTgWdv4St
 KAYAEHAMV+brLXgBGwkxGfvHtU//nzSl+N2LIaSR95hc2PlbEWvET2PoQe0JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1701150130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=tLMwFOxsZMfOGl9n4WNYh84SZ7I4TDnBPylPg1s/b3I=;
 b=s8kQ/6IhRCu0ciwOTluO6kICbMVzL+SD0uN1p6hvr3x5lzb5Vx+UEWVXj9K8AihJUX9HB4
 l04TEpcAZKISWob8GUa2TBCZdigcjmogvU0vsSVc0zIf6fZhjW1OIkC0mZ1an8xX+6/I3O
 CYgp2S2EG1HQ8vFLqZbHCk/nPSiLEWFxaqfHuvXEVMvwNS4zv0G816mKr0p08/TIEMRrk/
 1hNoszgHmC+TQE9Cfc1Y9ethyZIWFq3xggbz6ieZSkT0KNOfnuv+VBtsgYQb8c4woOBTpu
 vaHXq+KakGO11n+xWFv71YMFNwMeQ9XHIV5ARkstIrC9tiQxbKdpGY0Cr9S5FQ==
ARC-Authentication-Results: i=1; rspamd-d88d8bd54-k4wfs;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Ski: 59a169c536d6ba0c_1701150131081_3275851682
X-MC-Loop-Signature: 1701150131081:4134875065
X-MC-Ingress-Time: 1701150131081
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.248.75 (trex/6.9.2); Tue, 28 Nov 2023 05:42:11 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4SfWYZ2JvMzDh; 
 Mon, 27 Nov 2023 21:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1701150130;
 bh=tLMwFOxsZMfOGl9n4WNYh84SZ7I4TDnBPylPg1s/b3I=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=OYEynavAhhtPTxpQNXW306ULOHzgsC+VhkplsfR0V7aspj4qHleXNEMr6DuXzqPr4
 yjVGB75dgJgvzZsT2dOsSfKCTThR9fu0jYBQKA3tqGXAAk4unczYrkyIA2zK2lq2kK
 clUanRSQ9VpQUTbZ8EwEQpqlGj3rP2n1oHMP9Uey+a0EkpMj0PPL7KxUaJWOImkYat
 UrevhhL2gdRqoPKH+BtVQ1HtGZPKsW5zDmBSVD1vPbtI7nAY8/x/nEOeN49NbIB50H
 0lqDUAeSXK9fZ85XxiyuIzqiI1MNVbub4PprFkm8ssieNhctUPBmwSSR+U91KmaJqE
 p7oKfKkgqvwgA==
Date: Mon, 27 Nov 2023 21:42:07 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-cxl@lore.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20231128054207.7wegi3kwd7aw42op@offworld>
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-2-42.hyeyoo@gmail.com>
 <20231127202702.zkqomoapz2iprpra@offworld>
 <CAB=+i9Q4rwM9vqO262GS6BAcDHuRmeKVCVroj1-iR3X5wwL9ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAB=+i9Q4rwM9vqO262GS6BAcDHuRmeKVCVroj1-iR3X5wwL9ig@mail.gmail.com>
User-Agent: NeoMutt/20220429
Received-SPF: pass client-ip=23.83.212.48; envelope-from=dave@stgolabs.net;
 helo=dog.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 28 Nov 2023, Hyeonggon Yoo wrote:

>All of them make sense to me. I will adjust, thanks!
>
>But I'm not confident enough to write a single description for all the
>changes so will
>split it into a few patches. May I add your Suggested-by (or
>Signed-off-by) in v2
>as it will contain some part of your idea and code?

Sure, feel free to split as you see fit.

