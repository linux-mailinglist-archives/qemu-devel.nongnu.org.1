Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F17CBA58
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscuo-000111-57; Tue, 17 Oct 2023 01:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qscul-00010e-CQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qscuj-00069J-9U
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697521603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUSMWN5wzpWjp87Hswug2p1wT9W7iuOz11i3m35A7cc=;
 b=UiYbb5JiObiVJ4LSJmeNLxZushsrYHO/0JzB1KUELrexDgPtZwqdOBVIAoLi71yflNh76Q
 rNJeLZ/ohbc2xOn/poxmwJvDvP0kZZaLD8ezCaSbjg8jfMg6n5BEPoYfw/iOiBF7QldEDR
 gdulhN8lADImXAIOhslo+alAn1MaVuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-Ibtc4We9Oo2t2lh1yYdokQ-1; Tue, 17 Oct 2023 01:46:29 -0400
X-MC-Unique: Ibtc4We9Oo2t2lh1yYdokQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63F73858F1C;
 Tue, 17 Oct 2023 05:46:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431801C060AE;
 Tue, 17 Oct 2023 05:46:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4271B21E6A1F; Tue, 17 Oct 2023 07:46:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 03/17] meson, cutils: allow non-relocatable installs
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-4-pbonzini@redhat.com>
 <87edhuixx5.fsf@pond.sub.org>
 <CABgObfZqosmqTG=OY4u6RY3u8jShid3ML_7qhWEW+wnwuPVLMQ@mail.gmail.com>
Date: Tue, 17 Oct 2023 07:46:28 +0200
In-Reply-To: <CABgObfZqosmqTG=OY4u6RY3u8jShid3ML_7qhWEW+wnwuPVLMQ@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 16 Oct 2023 23:29:56 +0200")
Message-ID: <87edhter7v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Mon, Oct 16, 2023 at 1:55=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>> Out of curiosity: what's a non-relocatable install, and why should I
>> care?
>
> In a relocatable install if you move qemu-system-x86_64 from /usr/bin
> to /home/armbru/bin, it will start looking for firmware in
> /home/armbru/share/qemu.
>
> In a non-relocatable install, it will keep looking for firmware in
> /usr/share/qemu.
>
> Whether that's something desirable or not... it depends.
>
> On POSIX systems you almost never notice. Non-relocatability can help
> if you want to do experiments with old firmware and new QEMU or vice
> versa (because you can just upgrade/downgrade the firmware package,
> and use rpm2cpio to extract the QEMU binaries outside /usr).
>
> On the other hand Windows almost always wants relocatable installs,
> which is why the whole idea was introduced in QEMU in fact. Newfangled
> distribution mechanisms such as AppImage
> (https://docs.appimage.org/reference/best-practices.html) and I think
> NixOS (which installs each package in its own prefix, so you can
> install multiple versions and switch at will the one that is symlinked
> to /usr) also dislike using at runtime the absolute paths that were
> established at build time.
>
> Finally, the same code that handles relocation also lets you run QEMU
> from the build tree and pick e.g. firmware files from the source tree
> transparently. Even with this patch, that part of the code remains
> active even if you configure with --disable-relocatable.
>
> IOW: you probably have relied on the code, but if you have never
> noticed in the past 3 years, it means that you probably need not care.

I think this would make a fine commit message body :)

Thanks!


