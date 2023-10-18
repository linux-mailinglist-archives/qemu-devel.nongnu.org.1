Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998B7CDA46
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4hD-0002EG-5d; Wed, 18 Oct 2023 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qt4hB-0002Cz-24
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qt4h9-0005KF-F1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697628394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYzu4MCInTxt01XTIzX6puDebEJgbY36W46EhAB7o8k=;
 b=WxQrSPos25JRPnJoBMJvRP/erjOtIVcau1phRua03AMm/q0Wi8UalLPpBGvNzJY/BL8ySF
 Y59ZgvL1TpvpVwmitkXnevo1+QRcNVs7bT+2FLq77TEh5jJHq/M2/AUMb73t3ZNoaMjrG0
 2tpxhJ5U4MRjz6SLrOayCS6fyXAEXl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-_IN9rlhKOzqamKhHo9hQ9Q-1; Wed, 18 Oct 2023 07:26:33 -0400
X-MC-Unique: _IN9rlhKOzqamKhHo9hQ9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C32FE10201F2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:26:32 +0000 (UTC)
Received: from [10.39.192.202] (unknown [10.39.192.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0257C15BB8;
 Wed, 18 Oct 2023 11:26:31 +0000 (UTC)
Message-ID: <72e1adac-fe95-5650-536b-b70faab7b6d6@redhat.com>
Date: Wed, 18 Oct 2023 13:26:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231002203221.17241-1-lersek@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20231002203221.17241-1-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Hi Michael,

still waiting for you to pick this up, please.

In
<http://mid.mail-archive.com/20231004122927-mutt-send-email-mst@kernel.org>,
you wrote:

> OK. I'll need to do another PR soonish since a bunch of patchsets
> which I wanted in this PR had issues and I had to drop them.
> v3 will be there.

(Alt. link:
<https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01164.html>.)

That was on 04 Oct 2023 -- exactly two weeks ago :(

Stefan, can you perhaps apply this v3 series directly from the list?

Thanks,
Laszlo

On 10/2/23 22:32, Laszlo Ersek wrote:
> v2:
> 
> - http://mid.mail-archive.com/20230830134055.106812-1-lersek@redhat.com
> - https://patchwork.ozlabs.org/project/qemu-devel/cover/20230830134055.106812-1-lersek@redhat.com/
> 
> v3 picks up tags from Phil, Eugenio and Albert, and updates the commit
> message on patch#7 according to Eugenio's comments.
> 
> Retested.
> 
> Laszlo Ersek (7):
>   vhost-user: strip superfluous whitespace
>   vhost-user: tighten "reply_supported" scope in "set_vring_addr"
>   vhost-user: factor out "vhost_user_write_sync"
>   vhost-user: flatten "enforce_reply" into "vhost_user_write_sync"
>   vhost-user: hoist "write_sync", "get_features", "get_u64"
>   vhost-user: allow "vhost_set_vring" to wait for a reply
>   vhost-user: call VHOST_USER_SET_VRING_ENABLE synchronously
> 
>  hw/virtio/vhost-user.c | 216 ++++++++++----------
>  1 file changed, 108 insertions(+), 108 deletions(-)
> 
> 
> base-commit: 36e9aab3c569d4c9ad780473596e18479838d1aa


