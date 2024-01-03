Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A0822D6B
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:46:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0cL-0005LD-O0; Wed, 03 Jan 2024 07:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0cD-0005KH-QB
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:44:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0c6-0000Rp-B3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704285888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=h8EDm2yIiKBksYoK3AMOQBkTf/ZtxiQTz1oGX/NVS2Q=;
 b=a40tJ/9d6DQAycG/A3V/8HFTgZ1jdzS2kTyfzFXlBccXg1xhOLB8Zjyaxv/LUJNwCYejep
 XtUuh4kRkCi9t+xdjH3Wp1UL1BT18sy27OZSry0M/aEWPehbr7vmmrz0MzDKPwGU4XivA8
 jqh3IHpChQOb2j6++ik0z0Etgj+UrJ8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-0vq4ZfUaPIWEC7qSmVWDHA-1; Wed,
 03 Jan 2024 07:44:42 -0500
X-MC-Unique: 0vq4ZfUaPIWEC7qSmVWDHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29D8238143A6
 for <qemu-devel@nongnu.org>; Wed,  3 Jan 2024 12:44:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71AA32026D66;
 Wed,  3 Jan 2024 12:44:41 +0000 (UTC)
Date: Wed, 3 Jan 2024 12:44:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] pc-bios/optionrom: Fix pvh.img ld build failure on
 fedora rawhide
Message-ID: <ZZVWtxyGkVzBjf0O@redhat.com>
References: <20231128143647.847668-1-crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128143647.847668-1-crobinso@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 28, 2023 at 09:36:47AM -0500, Cole Robinson wrote:
> binutils 2.39 shows some warnings when building pvh.img
> 
> /usr/bin/ld: warning: pvh.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/bin/ld: warning: pvh.img has a LOAD segment with RWX permissions
> 
> The latter of which is fatal on Fedora rawhide for some reason.
> 
> Add linker options to suppress the errors

This makes it silent, but I guess someone needs to confirm that this
option ROM code genuinely does NOT need to have executable stack,
otherwise the future change that is being warned about could impact
it ?

> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  pc-bios/optionrom/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 30d07026c7..f54ed39b54 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -36,7 +36,7 @@ config-cc.mak: Makefile
>  	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
>  -include config-cc.mak
>  
> -override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
> +override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds -Wl,--no-warn-rwx-segments -Wl,--no-warn-execstack
>  
>  pvh.img: pvh.o pvh_main.o
>  
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


