Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBB7CB54C
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVAN-0003Ee-O4; Mon, 16 Oct 2023 17:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsVAL-0003E3-0E
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 17:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsVAI-0002m8-WB
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 17:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697491816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8spe+gfMUm0LxTT7xkyr02/+h3t27Ghv8MUKw4Sk2jA=;
 b=Njke7WVyHJ2cI+9KZbMrc94ztwPC1XLa7fJGct6Vi+ABl9K3Y/lR4XN+9coiNxBB8zade1
 lDqf4fuhb/F5gu4b5W73EFra+hN9aMBjdO4DDVcFgTN1/f07E5mHaeKdqkR5Bc7KhW9sBu
 7BOYsZlxlNARKks49mEUm+16ooeCUhE=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-g2WUd5YOPhalfwKNowj_3w-1; Mon, 16 Oct 2023 17:30:10 -0400
X-MC-Unique: g2WUd5YOPhalfwKNowj_3w-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-457ba010ae1so3766228137.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 14:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491809; x=1698096609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8spe+gfMUm0LxTT7xkyr02/+h3t27Ghv8MUKw4Sk2jA=;
 b=QDAZgMcYmBfhla4o2E9GiNy9GBDVbIQqhK4S6rw/65e8DyHykC4q7L299gvHYd8ULK
 uqTdMGFGRbi7T81wkHooFJc9uUv/BCBkjhxyBMj771fohHY5BVSutDRHJRwjqvePdHtB
 ypa2MYH5cl+nb62uGafPrz34Jjm41T0YFmxk0K31merFAyK3G5CP1xZk8lcZGKkcPOGa
 7eJIcolu7WD0pk4gKbenPEpBQniGmI8nkQMDMi2beVheHFpBpmPV2kMp7aREbGZyYX7k
 WD9hZYU1Z2dv20ENr0+2DoGH9FmbqMRqbh4MYXrJwFf0/t/6Ptm3j5Isp4eoo+wYjjmu
 8CJg==
X-Gm-Message-State: AOJu0YxENJ5RmXXki37NT+DQUgdiYDBE6cR0ha9TWljApquX1K1ZSQ8O
 BJmd3IByu3tUYzZMlUsZERp97KdqI1z9UeDY8s+Yh9OQVaR1V0nJuAoK2VNbWgV9wVqp0sh1I7P
 kAEj196+dQZSMOfG6rAIkN0jJTVuQWbn4dWmlys9aew==
X-Received: by 2002:a05:6102:3d1c:b0:457:c953:bc39 with SMTP id
 i28-20020a0561023d1c00b00457c953bc39mr12358vsv.1.1697491808870; 
 Mon, 16 Oct 2023 14:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUqahnYE36nb/tj/65dnsmYj+uNtpqQT0S7Mv1taZh8XDnKTq71tTOfcfAqh295yAEz9o7CvOHorsB55z63ng=
X-Received: by 2002:a05:6102:3d1c:b0:457:c953:bc39 with SMTP id
 i28-20020a0561023d1c00b00457c953bc39mr12348vsv.1.1697491808611; Mon, 16 Oct
 2023 14:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-4-pbonzini@redhat.com>
 <87edhuixx5.fsf@pond.sub.org>
In-Reply-To: <87edhuixx5.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Oct 2023 23:29:56 +0200
Message-ID: <CABgObfZqosmqTG=OY4u6RY3u8jShid3ML_7qhWEW+wnwuPVLMQ@mail.gmail.com>
Subject: Re: [PATCH 03/17] meson, cutils: allow non-relocatable installs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On Mon, Oct 16, 2023 at 1:55=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
> Out of curiosity: what's a non-relocatable install, and why should I
> care?

In a relocatable install if you move qemu-system-x86_64 from /usr/bin
to /home/armbru/bin, it will start looking for firmware in
/home/armbru/share/qemu.

In a non-relocatable install, it will keep looking for firmware in
/usr/share/qemu.

Whether that's something desirable or not... it depends.

On POSIX systems you almost never notice. Non-relocatability can help
if you want to do experiments with old firmware and new QEMU or vice
versa (because you can just upgrade/downgrade the firmware package,
and use rpm2cpio to extract the QEMU binaries outside /usr).

On the other hand Windows almost always wants relocatable installs,
which is why the whole idea was introduced in QEMU in fact. Newfangled
distribution mechanisms such as AppImage
(https://docs.appimage.org/reference/best-practices.html) and I think
NixOS (which installs each package in its own prefix, so you can
install multiple versions and switch at will the one that is symlinked
to /usr) also dislike using at runtime the absolute paths that were
established at build time.

Finally, the same code that handles relocation also lets you run QEMU
from the build tree and pick e.g. firmware files from the source tree
transparently. Even with this patch, that part of the code remains
active even if you configure with --disable-relocatable.

IOW: you probably have relied on the code, but if you have never
noticed in the past 3 years, it means that you probably need not care.

Paolo


