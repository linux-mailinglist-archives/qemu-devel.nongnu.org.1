Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD67830455
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 12:14:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3rk-0006mU-3L; Wed, 17 Jan 2024 06:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ3rh-0006iZ-Np
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:13:49 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ3rg-0001oF-2S
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 06:13:49 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ddec7e5747so5218397a34.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 03:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705490026; x=1706094826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yuMog4OytUC0qTa0p0+h+nzTX8Z7/u+q0emkCrejNc=;
 b=lL60ob/AQYMZNqQPbYeYOTZJY6Zkc7GmwTv6KYB4irfnpI79eW5rQIxVwrMyEnS8gn
 o/WkuoOFjeoRGgPdQBzONUCt8aO0JYi6m7zYoGE0wwBIoFXlm2CzkQKx7HKme7fiZJVV
 3KGVPJfxePfehYRRy1/CdFbSE1wb6D92wjXFJ+wkgt6IsVXJZBDFRG+ei/CT/siBfzKA
 UKpCK3kSocpB3V5CjRJrbbthcW6a8zaPdRqY7Q0xaFTp5gO+DAvq2YbUEW8NYIyMRrUE
 r8+hycwxYKziJX7Fbwy9o0z647OLwZSMNhGkEVNJxqhFALx9yrTQ6Tm9xAZ+wdvmgBe3
 UwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705490026; x=1706094826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yuMog4OytUC0qTa0p0+h+nzTX8Z7/u+q0emkCrejNc=;
 b=kHIET9yW5gXc9Z6R/CTVqzVqd+7kS19+xkUTkIO3EeQVhUczRxyFS2k2ACI4XF4ApN
 fz6uPOYPy7Q6yWyNiiTMAs+wU8lH4y+OlyW9KLrg6XX4WPGk7RcTQD8SzcZkxshdUrTr
 Xit6Yyq5jqSWCFtCZhSWeEAZlSpQ5TjzkWiKR5oPF/S2SaUbYjLyT8Ij7ch7Ne5fNPV4
 l2LGl0RIld5XPuwcJxqa4J449bd+AowkZFHjx//6qgJQqCiLyw7QtroT/DaEV9Pn+EHL
 ksPXwKuezaH1GKK9YBCJ3h5ACfyZClePhufDnstRIqclqQcxkzTtmklcAKlbIlM1Trhz
 DvNg==
X-Gm-Message-State: AOJu0YyisJtULvBGpHBAzL9uuby671mdWB77q6q3azw+00MNw7pEWJ6P
 iIutOiH6G02WVByo62o/mHCCYm0G38KV7h59W4w=
X-Google-Smtp-Source: AGHT+IFjOztxds6OROXZbEq0AnDgHpcpBZaY3JEjTeMSAiINYmM3YSkf3VzL/B5S0Xe4eQCkmLncmsv/xeTNBocEHH0=
X-Received: by 2002:a9d:6219:0:b0:6dd:c275:afc4 with SMTP id
 g25-20020a9d6219000000b006ddc275afc4mr9568601otj.51.1705490025814; Wed, 17
 Jan 2024 03:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20240115154830.498304-1-marcandre.lureau@redhat.com>
 <20240115154830.498304-3-marcandre.lureau@redhat.com>
 <a67b8127-6445-a29b-ffc4-6c5409e93bbd@redhat.com>
In-Reply-To: <a67b8127-6445-a29b-ffc4-6c5409e93bbd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2024 15:13:34 +0400
Message-ID: <CAJ+F1CKx9orvOMXV-e4S2gZCsFvoOOdv4s2Vu5V7ONnBeJkD0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-gpu: fix scanout migration post-load
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi

On Tue, Jan 16, 2024 at 3:17=E2=80=AFPM Sebastian Ott <sebott@redhat.com> w=
rote:
>
> On Mon, 15 Jan 2024, marcandre.lureau@redhat.com wrote:
> > +            scanout->ds =3D qemu_create_displaysurface_pixman(res->ima=
ge);
> > +            if (!scanout->ds) {
> > +                return -EINVAL;
> > +            }
>
> "qemu_create_displaysurface_pixman() never returns NULL." ;-)

Right, I'll update the first patch.

Other comments about this patch?

thanks

--=20
Marc-Andr=C3=A9 Lureau

