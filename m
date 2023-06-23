Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F259F73B544
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:29:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCe2T-0001Zs-Cy; Fri, 23 Jun 2023 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCe2H-0001Sc-Uz
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCe2E-0001a1-Nw
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687516136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xt7LiQO11sRTZYzSqpOjBYPcjvfH80TD1dsmeEOdBIc=;
 b=NM++b2bt43eVI6ucOMSbg1oowWZmzyTv392Dy3byEPTo5JCoW6iZjwSMEXgEHWtZ6a71Ze
 U6WZ05MAtR/o2jIBBsAHoSqO+WTuGRuBhT6KTxSKt8fmcicnQkWaltmjHjfZIZbJ0Wgd9s
 m5uh3jTfO5mbjWNFt4Nte4tHqE4P7+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-kYSpfgQMPAqJoNI5_WBNoA-1; Fri, 23 Jun 2023 06:28:54 -0400
X-MC-Unique: kYSpfgQMPAqJoNI5_WBNoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A40A580027F;
 Fri, 23 Jun 2023 10:28:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2407200C0CD;
 Fri, 23 Jun 2023 10:28:52 +0000 (UTC)
Date: Fri, 23 Jun 2023 11:28:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Message-ID: <ZJVz4rTEeiA+reWN@redhat.com>
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620162024.1132013-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 20, 2023 at 05:20:24PM +0100, Peter Maydell wrote:
> The xkb official name for the Arabic keyboard layout is 'ara'.
> However xkb has for at least the past 15 years also permitted it to
> be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
> synoynm was removed, which breaks compilation of QEMU:
> 
> FAILED: pc-bios/keymaps/ar
> /home/fred/qemu-git/src/qemu/build-full/qemu-keymap -f pc-bios/keymaps/ar -l ar
> xkbcommon: ERROR: Couldn't find file "symbols/ar" in include paths
> xkbcommon: ERROR: 1 include paths searched:
> xkbcommon: ERROR: 	/usr/share/X11/xkb
> xkbcommon: ERROR: 3 include paths could not be added:
> xkbcommon: ERROR: 	/home/fred/.config/xkb
> xkbcommon: ERROR: 	/home/fred/.xkb
> xkbcommon: ERROR: 	/etc/xkb
> xkbcommon: ERROR: Abandoning symbols file "(unnamed)"
> xkbcommon: ERROR: Failed to compile xkb_symbols
> xkbcommon: ERROR: Failed to compile keymap
> 
> The upstream xkeyboard-config change removing the compat
> mapping is:
> https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6
> 
> Make QEMU always ask for the 'ara' xkb layout, which should work on
> both older and newer xkeyboard-config.  We leave the QEMU name for
> this keyboard layout as 'ar'; it is not the only one where our name
> for it deviates from the xkb standard name.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1709
> ---
>  pc-bios/keymaps/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


