Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E975B1CC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMV2s-0002IT-5v; Thu, 20 Jul 2023 10:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qMV2p-0002H9-G2
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:54:19 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qMV2p-0008EN-4x; Thu, 20 Jul 2023 10:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=i5jR7ROUPm3Xd+PpNgzj2AicXhaoGFjywepF/cXzjaE=; b=Gs2+bHTeB1qDrutkbHqG
 I5yqoVh0k0M2Fn+foyTrvcF1QK0y/4Xr78PDdlkfZtIDJedpN7+sNsKxSJVa1ieENkOGPr0CqRfIt
 gJZ5Nrapa1XLtcc9EfGJmowC2EFnAJnbIZ8Fte3p1e/oB3bjTxSwPijB64ZukJGgHXpgF17v9Msjv
 Jpj+KnFlptJwhsM0k6Tz2WIJZzpEINtNbU0nC1A1lLxUePbmWDeeMA10RJFV3ecz/DHZjY2BLfyT/
 WqYzkuDnZWB0IHOW6mJncsjWtTO1mLlLNYmwNpc8/ndo5EnYVcjdzmc+iEuFKxAjrNixKHXAkqtHD
 t6i2eWfY05YOzg==;
Received: from 2a02-8440-2108-7b74-de41-a9ff-fe47-ec49.rev.sfr.net
 ([2a02:8440:2108:7b74:de41:a9ff:fe47:ec49] helo=begin)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qMV2o-0007a7-UC; Thu, 20 Jul 2023 10:54:18 -0400
Received: from samy by begin with local (Exim 4.96)
 (envelope-from <samuel.thibault@gnu.org>) id 1qMV2l-007jkF-0E;
 Thu, 20 Jul 2023 16:54:15 +0200
Date: Thu, 20 Jul 2023 16:54:15 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Felix Wu <flwu@google.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: Tips for local testing guestfwd
Message-ID: <20230720145415.w7s3ystkrf5gc66y@begin>
References: <CAJt6XFoT2irgOwtMB2qpgr3Yj6Q-zij_fpD9BL24QvFG7w3zOg@mail.gmail.com>
 <20230626114916.45355529@mobian.usb.local>
 <20230626100819.vtkuuvzg376hktk2@begin>
 <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJt6XFpDwuim-FF7a5MMibQvJa1YJ=X165n43XEtQaF4356r9w@mail.gmail.com>
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

Felix Wu, le mar. 18 juil. 2023 18:12:16 -0700, a ecrit:
> 02 == SYN so it looks good. But both tcpdump and wireshark (looking into packet
> dump provided by QEMU invocation)

Which packet dump?

> I added multiple prints inside slirp and confirmed the ipv6 version of [1] was
> reached.
> in tcp_output function [2], I got following print:
> qemu-system-aarch64: info: Slirp: AF_INET6 out dst ip =
> fdb5:481:10ce:0:8c41:aaff:fea9:f674, port = 52190
> qemu-system-aarch64: info: Slirp: AF_INET6 out src ip = fec0::105, port = 54322
> It looks like there should be something being sent back to the guest,

That's what it is.

> unless my understanding of tcp_output is wrong.

It looks so.

> To understand the datapath of guestfwd better, I have the following questions:
> 1. What's the meaning of tcp_input and tcp_output? My guess is the following
> graph, but I would like to confirm.

No, tcp_input is for packets that come from the guest, and tcp_output is
for packets that are send to the guest. So it's like that:

>         tcp_input    write_cb          host send()
> QEMU --------> slirp -----------> QEMU --------------------> host
>     <--------        <---------         <-----------------
>          tcp_output  slirp_socket_recv    host recv()

> 2. I don't see port 6655 in the above process. How does slirp know 6655 is the
> port that needs to be visited on the host side?

Slirp itself *doesn't* know that port. The guestfwd piece just calls the
SlirpWriteCb when it has data coming from the guest. See the
documentation:

/* Set up port forwarding between a port in the guest network and a
 * callback that will receive the data coming from the port */
SLIRP_EXPORT
int slirp_add_guestfwd(Slirp *slirp, SlirpWriteCb write_cb, void *opaque,
                       struct in_addr *guest_addr, int guest_port);

and 

/* This is called by the application for a guestfwd, to provide the data to be
 * sent on the forwarded port */
SLIRP_EXPORT
void slirp_socket_recv(Slirp *slirp, struct in_addr guest_addr, int guest_port,
                       const uint8_t *buf, int size);

Samuel

