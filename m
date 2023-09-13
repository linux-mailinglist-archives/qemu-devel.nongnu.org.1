Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC379EA0D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQF6-0002Nw-Gr; Wed, 13 Sep 2023 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qgQF5-0002Nj-Fu
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:49:19 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qgQF0-0006XY-TK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 09:49:19 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41215efeb1aso46177681cf.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694612953; x=1695217753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf89dov2mof29WnidCDd+eLRxZDVTjwn4le0xz6RB4g=;
 b=FExtGqD3vES7o3KpUe3ZgFWm/iDiTf7IbsxBKVpEN+iRnkvkvP+vIzXbSS0UZYCNY9
 +4NBySQA17DLlw10+r7K8OjRQaVtH71pgqVhy24wyQnl/JJzKkdvNSzdFBtg+Z3NfscX
 Ql006CkI3fabfv6kLdaWXGZ8iNzlyOk+nzyMtmlmuDB00Ey2DdeiSS+JIMh9rxFpVhqr
 q7C9VvQJZvaYhXwnrRYXaqCmRWddcS0kByCmVoJCWyxEUq4OG6d4eQWcCMFk82TV0IQt
 t6H71IbiErUuV9n06lVr1Fkyo4V3Xpv023MyeZFOvGiBvJ3GVY4kbIUBRWWqR6gLRXuC
 8Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694612953; x=1695217753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf89dov2mof29WnidCDd+eLRxZDVTjwn4le0xz6RB4g=;
 b=au0J7W684pF2FkNwtWiNTn4PHMXQQjbTT/UoYmX0Pju8gzSfQMS0lPJHpwzjGXdskS
 JvAC2KXGSLXBU1rQKiIxcT2BkxKOyByyuVgYHe1kNx1D8Cyr3zaYMuQAR8GxOb3uEWZa
 6iFd3Asa11bBDfe2CCtsQ2X9xqNHeaW+3irejpYUTl/nF5nVtRIFxfzbzPctzb4Y3orI
 ZBgMiwOHFKCtuV8f2rb2BmXZk4BgmtUemsHrOhV77g5pGwRWlGU/2jVpH71NsAMlC3bu
 +fHoOmI0lqcGXNHmkmJxCI86ejMmK5/ZnD3zx2eVs2Sw3nxCII9Kk5xqW+cecS40eM0o
 JTOw==
X-Gm-Message-State: AOJu0Yyjx3ZcLrX0Qo1BfTJhCelxXZF811VGBtjhrc6xHVdsDyBp15Cc
 l8XT8orAmzse4lN2uHu5USZwrIRzpjLFD6BJyNI=
X-Google-Smtp-Source: AGHT+IGMv7/P8VM6KWJ5wScILpkj83LajinQXU6NVq6ECADcxBtQ7yswKrLGuXYZ9gxz3Qr7o6HTHBqvUotUeqxSvW0=
X-Received: by 2002:a05:622a:1a93:b0:400:9126:3f16 with SMTP id
 s19-20020a05622a1a9300b0040091263f16mr2806035qtc.1.1694612953450; Wed, 13 Sep
 2023 06:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230829003629.410-1-gurchetansingh@chromium.org>
 <ZO/6JXmYm/lW9dSZ@amd.com>
 <CAAfnVBmxaAbEX-0wVVwE94cKrGtoCRWKv58X73P+_hKM8-_hkQ@mail.gmail.com>
 <CAJ+F1CJwATzG8by1tZucq15KbDHfE9OJEGq1jZ71UHivoTRsXQ@mail.gmail.com>
 <CAAfnVBn4yjOCi+OzqjYJ2wos1wsjrCAj+9j1kZ4v63a4LVX7mQ@mail.gmail.com>
In-Reply-To: <CAAfnVBn4yjOCi+OzqjYJ2wos1wsjrCAj+9j1kZ4v63a4LVX7mQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Sep 2023 17:49:01 +0400
Message-ID: <CAJ+F1CLfJ_0yYh4ZaNwLt5JRB-QfijRZ3DPEEipbUbqV2Sv+=Q@mail.gmail.com>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Huang Rui <ray.huang@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, 
 "ernunes@redhat.com" <ernunes@redhat.com>, 
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Sep 13, 2023 at 5:08=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
> On Tue, Sep 12, 2023 at 6:59=E2=80=AFAM Marc-Andr=C3=A9 Lureau <marcandre=
.lureau@gmail.com> wrote:
>> Packaging aemu and gfxstream is a bit problematic. I have some WIP
>> Fedora packages.
>>
>> AEMU:
>> - installs files under /usr/include/host-common and
>> /usr/include/snapshot. Can this be moved under /usr/include/aemu
>> instead?
>> - builds only static versions of libaemu-host-common.a and
>> liblogging-base.a (distros don't like static libs much)
>> - could liblogging-base(.a,.so,..) also have "aemu" name in it?
>> - libaemu-base.so is not versioned
>> - I can't find a release tarball, nor the (v0.1.2) release tag
>> - could have a README file
>>
>> I am not very familiar with cmake, so it's not obvious how to make the
>> required changes. Would you like me to open an issue (where?) or try
>> to make some patches?
>
>
> I filed an internal bug with all the issues you listed: Android side shou=
ld fix this internally.
>
> I see a few options for packaging:
>
> 1) Punt on gfxstream/AEMU packaging, just do rutabaga
>
> gfxstream is mostly useful for Android guests, and I didn't expect anyone=
 to actually package it at this point since most here are interested in Lin=
ux guests (where gfxstream VK is headless only right now).  Plus ioctl-fowa=
rding > API forwarding for security and performance, so I'm not sure if it'=
ll have any sticking power even if everything is supported (outside of a fe=
w niche use cases).
>
> Though, I sense interest in Wayland passthrough for dual Linux use cases.=
  I put up:
>
> crrev.com/c/4860836
>
> that'll allow packaging on rutabaga_gfx and even CI testing without gfxst=
ream, since it is designed to function without it.  We could issue another =
rutabaga-release tag, or you can simply add a patch (a common packaging pra=
ctice) on the Fedora package with the "UPSTEAM label".
>
> 2) Actually package gfxstream only
>
> Probably an intermediate solution that doesn't introduce versioning/stati=
c library issues would be just to have a copy of AEMU in the gfxstream repo=
, and link it statically.  Will need another release tag/commit of gfxstrea=
m.
>
> 3) Don't package at all
>
> For my particular use case since we have to build QEMU for sources, this =
is fine.  If upstream breaks virtio-gpu-rutabaga.c, we'll send a patch and =
fix it.  Being in-tree is most important.
>
> Let me know what you prefer!
>

I would rather have standard packaging of the various projects, so we
can test and develop easily.

For rutabaga, I ended up having to patch a little bit the shared
library, to fix SONAME:

diff --git a/ffi/Makefile b/ffi/Makefile
index d2f0d38..7efc8f3 100644
--- a/ffi/Makefile
+++ b/ffi/Makefile
@@ -47,13 +47,13 @@ build:

 install: build
 ifeq ($(UNAME), Linux)
-    install -D -m 755 -t $(DESTDIR)$(libdir) $(OUT)/$(LIB_NAME)
+    install -D -m 755 $(OUT)/$(LIB_NAME)
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
 endif
 ifeq ($(UNAME), Darwin)
-        install_name_tool -id $(DESTDIR)$(libdir)/$(LIB_NAME)
$(DESTDIR)$(libdir)/$(LIB_NAME)
+        install_name_tool -id
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
$(DESTDIR)$(libdir)/$(LIB_NAME)
 endif
-    ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION)
-    ln -sf $(DESTDIR)$(libdir)/$(LIB_NAME)
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)
+    ln -s $(LIB_NAME).$(RUTABAGA_VERSION)
$(DESTDIR)$(libdir)/$(LIB_NAME).$(RUTABAGA_VERSION_MAJOR)
+    ln -s $(LIB_NAME).$(RUTABAGA_VERSION) $(DESTDIR)$(libdir)/$(LIB_NAME)
 ifeq ($(UNAME), Linux)
     install -D -m 0644 $(SRC)/share/rutabaga_gfx_ffi.pc
$(DESTDIR)$(libdir)/pkgconfig/rutabaga_gfx_ffi.pc
     install -D -m 0644 $(SRC)/include/rutabaga_gfx_ffi.h
$(DESTDIR)$(includedir)/rutabaga_gfx_ffi.h
diff --git a/ffi/build.rs b/ffi/build.rs
new file mode 100644
index 0000000..efa18d3
--- /dev/null
+++ b/ffi/build.rs
@@ -0,0 +1,3 @@
+fn main() {
+       println!("cargo:rustc-cdylib-link-arg=3D-Wl,-soname,librutabaga_gfx=
_ffi.so.0");
+}


The package is a bit unconventional, since it's a rust project
providing a C shared library. I am not sure I did Fedora packaging
right, let see:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D2238751


--=20
Marc-Andr=C3=A9 Lureau

