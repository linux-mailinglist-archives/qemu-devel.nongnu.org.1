Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B36715FD9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yVt-00060Z-Bc; Tue, 30 May 2023 08:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yVI-0005cb-Dq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q3yVG-0001Vw-DD
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G+5FJEEgg5KIpZ4Eis/Vx368t9hUWcxs9oj0bCTcTII=;
 b=NtToNdRDDNcBKgTp1gZFurLmRWa3b4TwJ/2WpGamQQGLTsuklRZ24XdgGRsWXbJYtY09FO
 mRKFxyryUACqwznvyFntnbND7rm3IM4aA233QI9A54Zc0jrwh01N4nzQ/DjKahUmaiZj+V
 M0hZYa7Mr7ybGw1Zlhr+Vc1oTVUPUv0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-vWob8Lf9NuGwDVzSk0tRXw-1; Tue, 30 May 2023 08:31:03 -0400
X-MC-Unique: vWob8Lf9NuGwDVzSk0tRXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5390D3C13941;
 Tue, 30 May 2023 12:31:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7E220296C8;
 Tue, 30 May 2023 12:31:02 +0000 (UTC)
Date: Tue, 30 May 2023 13:30:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com
Subject: Re: [PATCH 0/5] meson: replace submodules with wrap files
Message-ID: <ZHXsgqo5gvN8lbv/@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, May 27, 2023 at 11:28:46AM +0200, Paolo Bonzini wrote:
> The remaining submodules consist of tests/lcitool/libvirt-ci and the
> firmware in roms/.  The former is only used in very specific cases,
> while the latter is mostly used only as a pointer used to create the QEMU
> tarball.  Unfortunately, git-submodule.sh is still needed for roms/SLOF,
> parts of which are used in the QEMU build process for pc-bios/s390-ccw;
> more on this later in this cover letter.
> 
> I'm not sure what's the best way to proceed for roms/SLOF.  Some
> possibilities, in no particular order, include:
> 
> * doing nothing
> 
> * merging --with-git-submodules with --enable-download, and
>   moving the git-submodule.sh rules from the main Makefile to
>   pc-bios/s390-ccw/ (my favorite option)
> 
> * copying the relevant SLOF files into pc-bios/
> 
> Also, getting into more overengineered territory:
> 
> * same as the second option, but also replace the roms/ submodules
>   with text files, in a format similar to .wrap files; meson uses the
>   standard configparser to read them, so it would not be a lot of
>   code.  The files would be parsed by scripts/make-release and
>   pc-bios/s390-ccw/Makefile.
> 
> * adding support for firmware with a meson build system to
>   configure; turn SLOF into a wrap and roms/SLOF into a symlink
>   for ../pc-bios/s390-ccw/subprojects/SLOF.  I'm mentioning this for
>   completeness but this is not something I would like.  On the other
>   hand it could reuse some (or most?) of the code currently used to
>   generate config-meson.cross, so maybe it isn't that bad...


Is there a reason why SLOF/s390-ccw is handled differently from
the other ROMs ?  ie, why haven't we checked in the pre-built
firmware binaries, such that we don't build SLOF by default ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


