Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CFF7A0185
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjQn-0005SR-IG; Thu, 14 Sep 2023 06:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1qgjQl-0005SI-RK
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1qgjQk-0001Ax-5T
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694686715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzYDwh344m09Ed1ijvsam1E3iddh6uJ13xpt+uERMp4=;
 b=Ad2u8KQfrfRs0rkyXmPIGN9mRCIGZXAkPedEoKNrpuE3G0FESZ8DgbQeCSx5VWzOFMqoj1
 mPYKLM1ClQMnGjlbmPor7CRRqjsQ7NZqHyojLIgt7luTrWIPJbFzrCRezf2NFNzBeH0lK/
 1lbLVNA+9PS9IZf1Q6ID6zdAOyWoDM8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-avhfkdMeM5-tRwggqyP2bQ-1; Thu, 14 Sep 2023 06:17:24 -0400
X-MC-Unique: avhfkdMeM5-tRwggqyP2bQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ABA4800B23;
 Thu, 14 Sep 2023 10:17:24 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 934E910F1BE7;
 Thu, 14 Sep 2023 10:17:22 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:17:19 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: =?utf-8?B?0JzQuNGA0L7QvdC+0LIg0KHQtdGA0LPQtdC5INCS0LvQsNC00LjQvNC40YA=?=
 =?utf-8?B?0L7QstC40Yc=?= <mironov@fintech.ru>
Cc: "libvirt-security@redhat.com" <libvirt-security@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
Subject: Re: [sdl-qemu] [PATCH 0/1] There are no checks,
 virDomainChrSourceDefNew can return 0
Message-ID: <ZQLdr02TannQD5gi@angien.pipo.sk>
References: <ace59b33a24b45dbb4075800c0922641@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ace59b33a24b45dbb4075800c0922641@fintech.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CC-ing qemu-devel with a patch solely for libvirt doesn't make sense.

Also 'libvirt-security' list is private and is is intended as a first
contact list for stuff to be embargoed. It makes little sense to include
it when posting to the public 'libvir-list'.

On Thu, Sep 14, 2023 at 09:44:13 +0000, Миронов Сергей Владимирович wrote:
> There are no checks, virDomainChrSourceDefNew can return 0.

s/0/NULL

While very technically true, realistically that can't happen any more.

'virObjectNew' always returns a valid pointer or abort()s, and
VIR_CLASS_NEW can return 0 on programming errors.

Thus this is not a security issue.

> Return value of a function 'virDomainChrSourceDefNew'
> 
> is dereferenced at qemu_hotplug.c without checking for NULL,
> 
> but it is usually checked for this function.

Remove the extra empty lines please.

> 
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> Fixes: 1f85f0967b ("ci: jobs.sh: Add back '--no-suite syntax-check --print-errorlogs'")

^^ This makes no sense. The commit you are referencing is changing a
shell script.

> 
> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> 
> ---
> src/qemu/qemu_hotplug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
> index 177ca87d11..09e16c2c7e 100644
> --- a/src/qemu/qemu_hotplug.c
> +++ b/src/qemu/qemu_hotplug.c
> @@ -3207,6 +3207,8 @@ qemuDomainAttachFSDevice(virQEMUDriver *driver,
>      qemuAssignDeviceFSAlias(vm->def, fs);
> 
>      chardev = virDomainChrSourceDefNew(priv->driver->xmlopt);
> +    if (chardev == NULL)
> +           goto cleanup;
>      chardev->type = VIR_DOMAIN_CHR_TYPE_UNIX;
>      chardev->data.nix.path = qemuDomainGetVHostUserFSSocketPath(priv, fs);
> --
> 2.31.1


