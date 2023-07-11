Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60174E3B8
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 03:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ2VD-00074m-Va; Mon, 10 Jul 2023 21:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qJ2VC-00074V-6S; Mon, 10 Jul 2023 21:49:18 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qJ2VA-0001CZ-MM; Mon, 10 Jul 2023 21:49:17 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso81779561fa.0; 
 Mon, 10 Jul 2023 18:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689040154; x=1691632154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n1lDOOyCiJ6P94gzsIT7B88d9XJ3VD7qFQtBxios+kI=;
 b=j/pwPeHTC4GpXHH4UPHU2QNA0XELTlwIhAFlis9w8dY65ubhOf1fvsBPUbhkqCduph
 kfwvyKQRE0f35aL3W1QIPX3w/3wTyaHgvb0isI2TmFjlV2JCw1VtRFyE2C1EjZwYOqEs
 yvi6M06DVQq+CkR/Fjt/X0DR6uGjMc9lXUGgnN0jXK/l/ukhmjUpIgm/mHHSnPW/VOAF
 yggZK5YpLRu1c6L2IUuuAi857f47yYmEieNOL04+G1XaVvXPSFXBFGJryzDu8NbFAuN6
 4i6OF4BaOX1rEs6y7ePq7k+Q8gDb1EojyMr3l3Dz7Vs20FlIL88bEFuA3EoKm1pwU9At
 q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689040154; x=1691632154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1lDOOyCiJ6P94gzsIT7B88d9XJ3VD7qFQtBxios+kI=;
 b=URONLkxBYAXm0cRZ6JtjHjKuKrkfIy2BOvvFIIl53zTg8WR6MoAxY/eStu59EECXAa
 mzl2vZ6eqlrTGP/wGQaOzU4nuezMbyA+gp+PoU6J1/3rmzfhAL8zdUoggD3y+/zCTloK
 YJJEZEKsBmFnRY1cAl0qicsxGoOtHJmqu0G+8e9kh6najYm/uOiIFBRTjTVOX8i9XY1+
 GhBpYzcbTQvK71RYB9TqHhlA7it0NBhSu1PP+fsv/iGdpj7y76SZ5UgaOJNcEQnN84Yp
 2Pf1SkR90RrflQL/hHdQPPHKT2fDtYqUELBj8qAsUwkWurEbx5XvQN4aDlWVHWTT0cU+
 9NuQ==
X-Gm-Message-State: ABy/qLbthUOASIugovtxvvDqe7j+TTZ9ULseXeoJrAa1yYUI1ZbvSI6F
 53iLRTcqai4tlC3CkQKEqY2S+XaB+SRLZL8y608=
X-Google-Smtp-Source: APBJJlEzhIjNCwyoDnGHAQuI0ewr+45GB2Pf14np4gphVMzYQ9Q+vOaonkLihGQuLB5kDiBlArCRGvw805+t0lRu660=
X-Received: by 2002:a2e:b012:0:b0:2b6:e2aa:8fbc with SMTP id
 y18-20020a2eb012000000b002b6e2aa8fbcmr10845499ljk.8.1689040153763; Mon, 10
 Jul 2023 18:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
 <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
 <20230710145208-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710145208-mutt-send-email-mst@kernel.org>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 11 Jul 2023 09:48:59 +0800
Message-ID: <CAKrof1PCqSKbLUy673eKF19w9_kAh3C6sdMC0nm-4BXUwAmktA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/7/11 2:52, Michael S. Tsirkin wrote:
> On Mon, Jun 26, 2023 at 04:26:04PM +0800, Hawkins Jiawei wrote:
>> It appears that my commit message and comments did not take this into
>> account. I will refactor them in the v2 patch..
>
> does not look like you ever sent v2.
>

Sorry for not mentioning that I have moved the patch to the patch series
titled "Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands support" at [1].
The reason for this move is that the bug in question should not be
triggered until the VIRTIO_NET_CTRL_MAC_TABLE_SET command is exposed by
this patch series.

I will take care of this in my future patch series.

[1].https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01577.html

Thanks!

