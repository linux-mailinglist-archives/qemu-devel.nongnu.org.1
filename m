Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA87A7B01F9
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRqg-0005gX-6v; Wed, 27 Sep 2023 06:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlRqd-0005ef-Iq
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:32:51 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qlRqc-0006S2-2W
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:32:51 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-419628fb297so2378601cf.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695810769; x=1696415569; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjyDL8iNGPYuJQpbrJexg0MnMxE2exf/wAFDQ0fegio=;
 b=VlRAZ4yvWSv1DmTzPTslGiNDQFz4srCvEldEkHVRk+lGP/r2D9PIWho+X6nNf2qOQt
 pPivB0hcCGOLc3AMH0CHzup/RYXURJJD7rq75kUV1Iu+85qKnZaDilJ4aWqoV5c1w709
 T1layCTrHSRI3S3xLSJwX3BaAfpFPCj1ibCxi+P2L3Hjg1wnSwtGXn/4bjvf4Xbjiokj
 LtHVoRb1iyoz9ds/+OL+R31RS10gapOtk5mAibgemC8k1ZAid9svc+Zn0fnbFdIglc9Z
 APOvb7j5eW85jJKBMhG0j8gUezc6FiRIvE8ToqNQDbLowAaGBqJ8VyjfTxNK3BsmQ66V
 r3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695810769; x=1696415569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjyDL8iNGPYuJQpbrJexg0MnMxE2exf/wAFDQ0fegio=;
 b=vyu8lNIKw64kkcHfL5Xq/ILgDRx4N85rWw4LVvYptnoT/zWxBD/iONIpjLhCtfLQoZ
 zsafBE63geT5CGe8NcW43+KN5JJEcAxkZ1eIm1B5Ay3eRBy/MC0k7cJtWdVbPkT/DNNJ
 OkClgcRStmN77RCq+84+igU6vKxnfVrQ00i3utKcB19s5pe9Y2bHfJoaIku4jN8M3oVJ
 LnFPRPChKrE6+OR5PML9rAHnO9oIrkv2T8sBEL3rUKj+aTgisF64eC+8GiUAEZWQSECj
 W6PuD0HmEUow5m6+JR5i8NQqLtmVqbhtI7LK/z5E3O4tANCVuToi0wUX0ATDbf4jAj/s
 jLbA==
X-Gm-Message-State: AOJu0YxBJ9K+YyIBWPxsXXAxT/xiUVE6qMyi9pm4e6+z5CFBkXCE+EYB
 Te4uD078TnCAydk/DGov5Udd5L1STP2sGc//Xk8jYKzA5VU=
X-Google-Smtp-Source: AGHT+IHJe1EJYDCXGHdOaIx5l2tro1ii0I0K0o5GEfHhuYaCFmB3XoKeFGd1ghWPAEJMS8f84TId5HSasIt2uJpDhkg=
X-Received: by 2002:ac8:7e95:0:b0:417:9e48:44d7 with SMTP id
 w21-20020ac87e95000000b004179e4844d7mr1721063qtj.1.1695810768673; Wed, 27 Sep
 2023 03:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230926081819.433631-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230926081819.433631-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Sep 2023 14:32:37 +0400
Message-ID: <CAJ+F1C+r3Nz9vCUhkzRAdsGPZexW8ivcO2E=CFK1jhkUvOfPxA@mail.gmail.com>
Subject: Re: [PATCH] analyze-migration: ignore RAM_SAVE_FLAG_MULTIFD_FLUSH
To: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Juan Quintela <quintela@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

On Tue, Sep 26, 2023 at 12:19=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Traceback (most recent call last):
>   File "scripts/analyze-migration.py", line 605, in <module>
>     dump.read(dump_memory =3D args.memory)
>   File "scripts/analyze-migration.py", line 542, in read
>     section.read()
>   File "scripts/analyze-migration.py", line 214, in read
>     raise Exception("Unknown RAM flags: %x" % flags)
> Exception: Unknown RAM flags: 200
>
> See commit 77c259a4cb ("multifd: Create property multifd-flush-after-each=
-section")
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

cc Peter and Juan

> ---
>  scripts/analyze-migration.py | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index b82a1b0c58..082424558b 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -111,6 +111,8 @@ class RamSection(object):
>      RAM_SAVE_FLAG_CONTINUE =3D 0x20
>      RAM_SAVE_FLAG_XBZRLE   =3D 0x40
>      RAM_SAVE_FLAG_HOOK     =3D 0x80
> +    RAM_SAVE_FLAG_COMPRESS_PAGE =3D 0x100
> +    RAM_SAVE_FLAG_MULTIFD_FLUSH =3D 0x200
>
>      def __init__(self, file, version_id, ramargs, section_key):
>          if version_id !=3D 4:
> @@ -205,6 +207,8 @@ def read(self):
>                  raise Exception("XBZRLE RAM compression is not supported=
 yet")
>              elif flags & self.RAM_SAVE_FLAG_HOOK:
>                  raise Exception("RAM hooks don't make sense with files")
> +            if flags & self.RAM_SAVE_FLAG_MULTIFD_FLUSH:
> +                continue
>
>              # End of RAM section
>              if flags & self.RAM_SAVE_FLAG_EOS:
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

