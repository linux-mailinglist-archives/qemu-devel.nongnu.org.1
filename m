Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07827CA6EB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsM0e-0007hS-TH; Mon, 16 Oct 2023 07:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsM0b-0007fg-Tg
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:43:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsM0a-0002oX-Ab
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:43:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40776b1ff73so21788415e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697456618; x=1698061418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/1aGyquBYQeVGhqTSWHSHjwgGjmRrHlNcj7N6c3wZE=;
 b=LC1uhSxpJ+HER3+83j22DWcdluwCRoifLfxXCm9GRkXO7EtcD8w0BSHYCaLXLE0rZW
 acIhIIx21XjU6drYXfn+WSZ0pMERU2b7gSr3Ge2T/joWfTEy1pYWxKCDmGCc4QBpwWsG
 H+KoafoFCsJP957YFTzfsNeVNSnId80p+yBZB5XplE7kjA84OtjrzyiQDNIYHYN7ZPn1
 Zo0Ul0nOQUzSn3XXoWyDJ5CWPTPXgD/hnmaZFRFwLUzi5Ev9SZlUIfo5iI5N1YrAnE8c
 GDAMBRS+Y6/NQeFM6POsXFaEL2eJxt///obqZkRfjxS9C3vuWQKS9GztOQecLRD5k6DO
 xXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697456618; x=1698061418;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A/1aGyquBYQeVGhqTSWHSHjwgGjmRrHlNcj7N6c3wZE=;
 b=NhvxFMNiNZ+nhw0xY4dMf8MIjP7aDq2Q5NHrlqfNaXJ1WFyMN2OaMrch3gCpOnudiN
 ATmgMt6eIMWU2m8v8UJtz9vvIE/hxKGuwtGbNsE6H/ucdXav+nQhlkjxaqs65FOvAiqC
 FqZ9q9TYU5INuV3gouWZeMkDvDyGZT3ut3YOkA8Zq68Qscvr/UBwl5A5UQ8UxnW+ubZr
 LyEE54JpWAjfJr/MvFBdS7IbS7nlU5etT1U14YQftMCJsASk/PuujytoS5zwi7C8Tuyw
 0xmePs6Ec9ip+hG3flX/ae+qPWX9xiQiFW+o8iOCop3SepFvAL2IvSi96D/g+bDCarWA
 lRiQ==
X-Gm-Message-State: AOJu0YyDd8kjhW8rAjd+Pwjq2Uy5HseVFh0TZxitLlAs1gdQ1rGe9z7T
 90g6UYgMBun6Q0Ndc6bRjFZDMA==
X-Google-Smtp-Source: AGHT+IF+xQUMwquNqtNJ93phgN67nuX0kODAHihf4K9inAK5POYPXF7YE/oqGlkbF9fxqQqqygLKSw==
X-Received: by 2002:a1c:721a:0:b0:405:1baf:cedf with SMTP id
 n26-20020a1c721a000000b004051bafcedfmr29554424wmc.24.1697456618297; 
 Mon, 16 Oct 2023 04:43:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a05600c4f5600b0040303a9965asm7061561wmq.40.2023.10.16.04.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 04:43:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31FA11FFBB;
 Mon, 16 Oct 2023 12:43:37 +0100 (BST)
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, "Garhwal, Vikram" <vikram.garhwal@amd.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Date: Mon, 16 Oct 2023 12:40:36 +0100
In-reply-to: <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
Message-ID: <87lec2dc7r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 16-10-23, 11:45, Manos Pitsidianakis wrote:
>> On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
>> > diff --git a/include/hw/virtio/vhost-user.h
>> > b/include/hw/virtio/vhost-user.h
>> > index 9f9ddf878d..1d4121431b 100644
>> > --- a/include/hw/virtio/vhost-user.h
>> > +++ b/include/hw/virtio/vhost-user.h
>> > @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>> >     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS =3D 14,
>> >     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS =3D 15,
>> >     VHOST_USER_PROTOCOL_F_STATUS =3D 16,
>> > -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 17,
>> > +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>> > +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
>> >     VHOST_USER_PROTOCOL_F_MAX
>> > };
>>=20
>> May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well instead=
 of
>> a comment mention?
>
> Perhaps because we will never use it from Qemu code ?

Vikram's work on enabling xenpvh support will mean enabling grant
support and while I suspect most VirtIO backends will be within QEMU
itself if it ever want to off-load something to a vhost-user backend it
will need to ensure this flag is set.

>
> Anyway:
>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

