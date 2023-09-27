Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E57AF808
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 04:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlK2N-0007Yk-8h; Tue, 26 Sep 2023 22:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qlK2K-0007YY-MO; Tue, 26 Sep 2023 22:12:24 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qlK2I-0003Jq-4v; Tue, 26 Sep 2023 22:12:24 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a645e54806so1227621666b.0; 
 Tue, 26 Sep 2023 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1695780739; x=1696385539; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szwqZSt719tNowx58fH54bCVU67vzt0Or7JlcQbVZZ8=;
 b=WZUJBM40LaGoqwCmlOJnOJFYcyagusHJKu37BcAdgkMHPXLnkNOegoQMqiNbxhBzHs
 OKNV8KlP61D1KNkG0HH4Tuqx2uYv3MJB+9IE8Be5+3GuL3JzulwXjXT8PIbzoXVIAl/5
 fea5/+3lc5NU04btAKgt8ZsAfgRCq9DuFpF9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695780739; x=1696385539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szwqZSt719tNowx58fH54bCVU67vzt0Or7JlcQbVZZ8=;
 b=nriD+LhxEpxUR9wERVHcXKOG5q7TFcX+MtMISKTENoWsBk1diqP4eAe6bD6vQSWIal
 qjSBeFvzs7dRjJOLrvyCzNuuZgXL/iDY37zdbAXLAO5ndJINLE1J1eE/D4Ol6rHt01bs
 46jjZQ4v6ZEASi/1pdVeSNXPazd1RX7qrnT7xkARKUFbWaddqFzC3QYqT4ayDm03Gmd1
 rZWt06DQv3K6ydpyDIN15J97ABNgjNzD6x9OnHz03BJPiq0HGYrloLXtEvHkx8mwzoja
 HAlKLw4IxfkbSDvwgRZNxgPhOUbRveQ4VhIuobZmJ98vljGHXJepQdxOqz/Y8/mCDleu
 hDpw==
X-Gm-Message-State: AOJu0YxO5omn8lp+UHxqjWS/ChExBgEXhCwwWOD05FdpgTezu5CaZoQI
 G4mH4rF6gwtXra5B5aeGewVEmnSVIVCtu8Mf7JE=
X-Google-Smtp-Source: AGHT+IEI6nylZicudAEus80WeZwpLHyorkMMHzFPDlXN2Bjf5h3sny2JVH2AaIMOuSiZsZShKYRM+hXtEnNk+lDKME0=
X-Received: by 2002:a17:906:32c1:b0:9ae:3d7b:6f46 with SMTP id
 k1-20020a17090632c100b009ae3d7b6f46mr385414ejk.46.1695780739140; Tue, 26 Sep
 2023 19:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-9-clg@kaod.org>
 <a4a62040-0127-4f39-4fc3-a1795e4daad8@kaod.org>
In-Reply-To: <a4a62040-0127-4f39-4fc3-a1795e4daad8@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Sep 2023 02:12:07 +0000
Message-ID: <CACPK8XcCn4hK5Lu-6o7LUyUFVH-dkbjJ-1_fHr4_90_4cZf_+Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 08/19] aspeed/timer: Fix behaviour running
 Linux
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 22 Sept 2023 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> > +    t->start =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
>
> This MAX(MAX(x, y), 0) looks strange to me. Would you remember where it c=
omes
> from ? Thanks,

That looks very strange. I think you've sorted it, so I wanted to
bring up the MAX macros themselves. It's unfortunate that they create
a non-unique local variable. Are we allowed to borrow the kernels
macros? They have some infrastructure for creating a unique local
variable name, as well as handling the const and non-const variants
with the one macro.

https://elixir.bootlin.com/linux/v6.5/source/include/linux/minmax.h

Cheers,

Joel

