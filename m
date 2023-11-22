Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFCD7F4581
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5m58-0006IZ-VS; Wed, 22 Nov 2023 07:11:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5m56-0006BJ-7p
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:11:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r5m54-0005n6-Jl
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700655105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bbLjfYTSjryIl+booM3xjdnEY+dbZXPfA1LjMgzUFuQ=;
 b=FwybCNPwDzWx5V30/O01bFY3Xn+zJuRiFLCu4ERL/FNYM8oKcBJ3BsTiz0+5VVLcwrOurd
 hqJHLD4UsSvOguN0A312iYsQJuWvecSm3N+oB2swTq+kRjhXfxXI4tA8GCHaGIheJDNZO3
 BTqpMeCzo0YztMZnBxH0+kMOwpiFLVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-mk4UYr5AMiufNNdo_eaHrQ-1; Wed, 22 Nov 2023 07:11:41 -0500
X-MC-Unique: mk4UYr5AMiufNNdo_eaHrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B1B580C346;
 Wed, 22 Nov 2023 12:11:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB599492BFA;
 Wed, 22 Nov 2023 12:11:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0C3FF1800929; Wed, 22 Nov 2023 13:11:39 +0100 (CET)
Date: Wed, 22 Nov 2023 13:11:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 mimoja@mimoja.de
Subject: Re: [PATCH 00/16] hw/uefi: add uefi variable service
Message-ID: <blrhg7z7jbjsa5orsb2glu6yxjo3ymlj466zyg2xnsigbzqfju@a62su45vvyoc>
References: <20231115151242.184645-1-kraxel@redhat.com>
 <9db15906-9474-4a6e-82a9-5275c72cf2b4@amazon.com>
 <nxzed5dhgjpn3fafjttocvxe6ztxxf5xhghaqncpdxup6y7o7y@47i3eyoehio2>
 <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bfb52e6-3698-7c44-5927-31d47d031d57@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

  Hi,

> Even during the present patch review, while going through only the
> headers thus far, I've already said at least twice that we're going to
> have to be super careful about integer overflows and buffer overflows.
> Any such problem is no longer a guest<->guest privilege boundary breach
> but a guest<->host one.
> 
> Not sure if the suggested remedy ("write it in Rust") is practical.

It should prevent certain classes of bugs such as buffer overflows.  Not
sure how much compromises you have to make (i.e. 'unsafe' code sections)
for a C library interface, so you can link the lib into qemu.  And of
course it wouldn't automatically stop logic errors.

> > But I'm open to discuss other options.
> 
> A selfish aspect: given that I've been reviewing this set, should I
> consider it a proof of concept / prototype, or something we might want
> to build upon, i.e., should I assume we'd put these foundations into
> production at some point? I've been reviewing the series with the latter
> in mind, but if that's not correct, I should probably adjust my pedantry
> knob.

In case we continue the C route I certainly expect that this patch set
will turn into something production-ready, and I've tried to code things
up accordingly.  Copy buffers so the guest can't modify them while qemu
processes them, carefully check length fields, ...

> at least with virtiofsd, we had gone with a C impl first, and only then
> with a Rust impl...

And virtiofsd was easier because it is a completely separate process,
not something you want link into qemu ...

take care,
  Gerd


