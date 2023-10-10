Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D47C41F4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:58:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJnr-0006cD-FU; Tue, 10 Oct 2023 16:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqJnn-0006aA-Pd; Tue, 10 Oct 2023 16:58:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqJnh-0001Ri-OQ; Tue, 10 Oct 2023 16:58:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690fa0eea3cso5490031b3a.0; 
 Tue, 10 Oct 2023 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696971475; x=1697576275; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7dmRkIS0GKwnKEsR4MYO0AB6h1LQzEcqMz8hZ40H+E=;
 b=m8iDy/6G3jL3qBIrXnWxKqHw+jDt4FrsOZWG33fvHNZ/uKe4uQgGbXsusOpa6L+Zxu
 MwrGFbJ+VgL3M3ZeH3S/IuKX3n+fYz3UD8llAlobAnVNwxJ3ofN3v2eZf66k/PJQGu4o
 YrKJcm2QD3SsxCWoBREDm6Q3CrdcQzKC+QtMXwjz3f6P6e49teS0qZ1CJP3j9IuITNJS
 KY4Bp6rqPQOS2GL2fxB3BgB1G4wTfNOaVk/FaOhB9jMU5i7b1FxLauBRP14ByBCjV+k3
 drH3JdWDl5VZLshwoKt3eSxuz7pGxz+BWjXS0g+TnqYJUA3GT646UMLOynr46aEFAppT
 WmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696971475; x=1697576275;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K7dmRkIS0GKwnKEsR4MYO0AB6h1LQzEcqMz8hZ40H+E=;
 b=l0D2ttsM71JZuOiBR1SUnpAmHeK9mEGA8mAMavLanJexH0FmEeqapq+zNzYxywHEfY
 cDIDkXrx92NzS2aeRsuMdwm8kDD5f+v33Tsus4F6JSrfUokMa4eqO/qhd2lWMWCm0HT/
 la9zlGNQ482tRNRfcth9u7ETsNFa2CEU+eeAnyrNszXQ8JXSOomuYqhvKM6O+9RJyCYb
 3r+je4XLFIB+J+xbx7kva68tO7oVhjUVNIpOmTjwvV1fcbgncx0Ds1KbMMa6iRbFQUvC
 IAQbpXY11kCKQrfKVwKOOxN2XJ2oegkJu7bKvSnH5nlbyJusBVuuc0N/pZVAMagmznZw
 ZWDQ==
X-Gm-Message-State: AOJu0YwB8nvAt2mBF60AwOMAzJcA70ST+y0wM5Y4TCP43MtzKbo1bJQ8
 FyD4QhKIilgRBugoOTgeGeM=
X-Google-Smtp-Source: AGHT+IE5LSd2tg453WG0zgjDINr4zQi1qTpqSTuK/+KxXCke6qlYHDVA3dwPiDub9fLdIiIgztUFYQ==
X-Received: by 2002:a05:6a00:cc7:b0:68e:2d9d:b0cc with SMTP id
 b7-20020a056a000cc700b0068e2d9db0ccmr24716719pfv.6.1696971475116; 
 Tue, 10 Oct 2023 13:57:55 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 s3-20020aa78283000000b00692b6fe1c7asm8942523pfm.179.2023.10.10.13.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 13:57:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 06:57:49 +1000
Message-Id: <CW526IRMLS2I.85TF1PIVGU0I@wheely>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 11/11] ppc/pnv: Change powernv default to powernv10
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-12-npiggin@gmail.com>
 <CACPK8XeLPd3yw=+jBtc1mj94cxF3e1HAaSZ-4mubh5XV4tvgXg@mail.gmail.com>
In-Reply-To: <CACPK8XeLPd3yw=+jBtc1mj94cxF3e1HAaSZ-4mubh5XV4tvgXg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Tue Oct 10, 2023 at 10:05 PM AEST, Joel Stanley wrote:
> On Tue, 10 Oct 2023 at 18:24, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > POWER10 is the latest IBM Power machine. Although it is not offered in
> > "OPAL mode" (i.e., powernv configuration), so there is a case that it
> > should remain at powernv9, most of the development work is going into
> > powernv10 at the moment.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Do we need to update the docs?

What did you have in mind? Add some powernv10 examples?

> We should consider updating the skiboot to the latest release too.

Yeah I will do that (and SLOF as well).

Thanks,
Nick

