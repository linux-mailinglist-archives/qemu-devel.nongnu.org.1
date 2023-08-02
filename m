Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4976CCA9
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 14:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRAx7-0004uD-Ut; Wed, 02 Aug 2023 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qRAx5-0004t2-0A
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:27:43 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qRAx3-0007QI-5Q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:27:42 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4039f7e1d3aso51184571cf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690979259; x=1691584059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ev3l6QsdRMxq9883MBRrMfEflcGk33UoNzvVCeuKLaw=;
 b=cb9j5WJOvhMJPYHYE6BQ4FEqq/jmcrNBOnSxP+TVVKukZqHd5W0LiOPBmEg9kzvPE3
 eFdX7VoIYkwp6+wxCI0KWnzrpm+G8I0IGeknEQaK9IrLCcEKTRGku6iuUFlILz4HeVMg
 bjohW+3a/4uG978kvjKAm63hpntpzrFrA4I9h0GCIwE7RzCblitnbU81HxrImnIE8D21
 v8QsoPUVmIeTlSmYXSDcm4jch6GeMeiXZ2UuGpY2xzBW4B/1M8beNVgyT23LNP3vSbZh
 JJIp24bQo6OKbvSW54GQlyU2nXqXgxdXF23gSjH7FoO/h11wFedqcCQwkCRPVeb2xetG
 vUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690979259; x=1691584059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ev3l6QsdRMxq9883MBRrMfEflcGk33UoNzvVCeuKLaw=;
 b=RaI/XrVtYSf97AHs9qx3ursNBP8rCcio6eqeqRr9TdEFTgCT8jXVOByFMzIjt0any5
 g9etrpIZybbRMpv/rfyk/GyO6f8WBzlDpxGx6SelK6a1bXWXSXBAalVyDZzCMrqgO9LH
 6VDaNxTo7EfK+oCZwb159dNmOeCpCpQADQlSa7mkrzTy4MxN6Oputi8nQUJ/MoMvEDps
 SGeyMpuSUnIHloKilPKcJCirQWMZ7V8bqBZat6i6kzbPrVyLaT2FAu7XE2a1uWgQfQeE
 G1iFeq78Ylza8+hwYa2rihTIvTtgbgLffE4unqXractAoS5NShGUKgXG1Nj3ZCA+iqA8
 KLgg==
X-Gm-Message-State: ABy/qLakRw+TGH6JQCpm1YCpUkAMt7nJIjppD/KKtUgfoqastM9qP0EN
 j8rs8UWj0RgbqO0LgclI2P3/C1wwzv2MkW5e/ljCCPe32/mqsw==
X-Google-Smtp-Source: APBJJlFR6nTGR2Cn3buiLtPtYaCOrMsskxk2FVeibblTJzOA2JOBrKGUG0n9oLDoL1G1Us0sn+hmISrekIeBUJiLoBc=
X-Received: by 2002:a05:622a:13d4:b0:403:b252:96ea with SMTP id
 p20-20020a05622a13d400b00403b25296eamr19693661qtk.21.1690979259630; Wed, 02
 Aug 2023 05:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230726173929.690601-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230726173929.690601-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 2 Aug 2023 16:27:28 +0400
Message-ID: <CAJ+F1C+V3bZEPgm0yQtMKY-Qr0n_qC60TDYGL65b441ELy7qvA@mail.gmail.com>
Subject: Re: [PATCH 0/2] virtio-gpu: reset gfx resources in main thread
To: qemu-devel@nongnu.org, Dongwon Kim <dongwon.kim@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

Hi Kim

Could you review those patches? I would like them for 8.1 and somewhat
fix your commit 0d0be87659b ("virtio-gpu: replace the surface with
null surface when resetting").

thanks


On Wed, Jul 26, 2023 at 10:53=E2=80=AFPM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> See the second patch for details.
> thanks
>
> Marc-Andr=C3=A9 Lureau (2):
>   virtio-gpu: free BHs, by implementing unrealize
>   virtio-gpu: reset gfx resources in main thread
>
>  include/hw/virtio/virtio-gpu.h |  4 +++
>  hw/display/virtio-gpu-base.c   |  2 +-
>  hw/display/virtio-gpu.c        | 48 +++++++++++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 8 deletions(-)
>
> --
> 2.41.0
>
>


--
Marc-Andr=C3=A9 Lureau

