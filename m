Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B447BFE58
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqD4e-0004ez-J5; Tue, 10 Oct 2023 09:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qqD4a-0004eK-Qh
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:46:57 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qqD4Z-0000Lx-2z
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:46:56 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41811e7ac3dso34322351cf.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696945613; x=1697550413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4oHiETDkXo5Bkvahfp3TCQINrCl9OxOdeZYhk/G+jY=;
 b=C+jtLCF0O1WK1rI9qqqT6XloB+vMn3SgkyjnUynjinwH1/qN8FJoIq08BI2419QYtB
 AGR56/Hh6qxPRT/Ra7ATfy4eLzebuIdCpS1Yti5ZoVOtCSfeE4zrZXnVmtDvuBZVkmKV
 vDLH8qrcWeUkZyBDSoJHHGE9TDcV9foWxD6Pyo70v4aajt8C230zeXouBXERPuA997B2
 exDEbM0qHSpCZEUZW5YlriXXKmyfPtwP42t6IpX8YhDb2xe5YAWFVxdQ0not/yfB+Ucy
 g9vyGZwrq29qrivaPS7Z8VOPuxEJCIYyKzfDHzL8bXVne+y6UrAMRQrw0ezGGHx+Bn1j
 UOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945613; x=1697550413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4oHiETDkXo5Bkvahfp3TCQINrCl9OxOdeZYhk/G+jY=;
 b=SgQUpRA8rSnHRS61sXFzoj/5gPvgEvwv205Y4HhnB0VrE7jOGclG4725klyuC9hlEF
 AgZoJwi6tLZBIHnXI6+fHMo0jpZEK6r/gcE3N1JMgj2wOmqWnCCB68act/kH6sfjEA22
 TdHdxMfo9zeaJHHsLmG6qQnOCvYUb/y3l2HqSjJnl49k6kzxYF3KnRawbX8xYeLJy0pE
 zB23v5m4tZeFi6NyZPrdiciHW84sl7ZrpiFnTdA8b3ZN+gdP63heCCdwHn1Poi6Z2taj
 p/0SiO/kxa74UHfHy9GRB2wMu3zZd30TYI+VXojVigP64YTbGXY0+hAXxB0rCkXy80V2
 EgVA==
X-Gm-Message-State: AOJu0YxvjZa3uv7NicDtfQgO3MnZ0q62Sdv3ZydS6ROQCOjnTqVQOrcv
 O5Vj9Bc3UpznxAXltlQa56lqdCPiDYy5wXUjeOs=
X-Google-Smtp-Source: AGHT+IEWPsTtPMmAgRtETgLYEO1L4RGFi2auF1DHXALKkk8RdCf7Ssc6WZaD7AfemiJ1DkEiYn5FEA9nwJBKQum6dhU=
X-Received: by 2002:ac8:58c5:0:b0:418:1dbb:95d8 with SMTP id
 u5-20020ac858c5000000b004181dbb95d8mr22318059qta.48.1696945612722; Tue, 10
 Oct 2023 06:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
In-Reply-To: <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Oct 2023 17:46:41 +0400
Message-ID: <CAJ+F1CJ+yKL8aSg=OdBBHzdfsaRj+fvD8y1QLgxT4UbjxAbUZg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] ramfb: migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x835.google.com
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

On Tue, Oct 10, 2023 at 4:49=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello,
>
> On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > Implement RAMFB migration, and add properties to enable it only on >=3D=
 8.2
> > machines, + a few related cleanups.
>
> Should this series go in vfio-next ?
>

That's a good option for me.

thanks

--=20
Marc-Andr=C3=A9 Lureau

