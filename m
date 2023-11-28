Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A40377FB5CA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:29:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uOJ-0002Jt-U7; Tue, 28 Nov 2023 04:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r7uOG-0002Jh-Hn
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r7uOD-0000Y8-7n
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701163699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhA57uoNu/D81LuL1E+1rTPhLfABwx+lKeXdNxcYY1c=;
 b=GW1dlKLRO+4TPjBBU3cKSp2rWt7DhKVrarNSnytBL4kUQ+ksKJFqDCs6vKugYhopMpn3r8
 ISAbAL0sMi89jXaZ0MF51Ivu36rRLB6DYJS66DKvn9GinjBZFyDu1vL7i4xmOvLDXlE4jS
 yT36O2MpPMbrO/m10Q3P/0wMi8Yd1LE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-Rzgpk2ghPX-9u4fqULTweQ-1; Tue, 28 Nov 2023 04:28:16 -0500
X-MC-Unique: Rzgpk2ghPX-9u4fqULTweQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 887FC101AA42;
 Tue, 28 Nov 2023 09:28:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D785C1596F;
 Tue, 28 Nov 2023 09:28:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 02A9D180092D; Tue, 28 Nov 2023 10:28:13 +0100 (CET)
Date: Tue, 28 Nov 2023 10:28:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/2] Firmware/seabios 20231128 patches
Message-ID: <y2h7krxkjelhex243rmmladmizkwzkh73lpmysng2kb2spswdr@fgkk23cutsp7>
References: <20231128081743.2214005-1-kraxel@redhat.com>
 <0e4fb831-94fd-47fd-9b9d-3cfb8423bf0a@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e4fb831-94fd-47fd-9b9d-3cfb8423bf0a@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Nov 28, 2023 at 11:54:34AM +0300, Michael Tokarev wrote:
> 28.11.2023 11:17, Gerd Hoffmann :
> 
> > seabios: update to 1.16.3 release
> 
> Gerd, please also push this tag to seabios master git branch.

Can't push to master branch right now (the tag is in the repo though),
trying to sort this out with the coreboot admins ATM

take care,
  Gerd


