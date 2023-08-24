Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED06787831
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZFL0-0004LP-BI; Thu, 24 Aug 2023 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZFKx-0004L0-Gq
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:45:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZFKu-0001C0-LJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:45:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso76884f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692902738; x=1693507538;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7w3bQmY167TP25xTfeDwrRGb73gB8Q5/rW5IV74SR4=;
 b=oxUfkMcD11zqbpjb605cwG6g2fAI9JqRKCJj4SL4MO6SWUXGyLn4z7lBsc9kiSfLwg
 S+C29c7rWUwXpGP9IS0sQjJ1FK/xifyFv581pbEeYWZJz6uNWenFsgICBx346NVgtkBc
 QMUR/OoLFAupIfQEZMO7T1/I4lJEVbVj1stAEQZwr0RO9/mqEY9fW7pj+sVFPvPv74Cy
 JAd3GB7EJzRGJOrYrV6zN/uzl6f04rXK6Yqh4nX5l0wH8ypWKnCwca+VDSk2VT8bvSGi
 FLmcJWlZbUqbvbL5SITNHBcwxSN0P5vyX9zBA2KvTNovWgzoT1gBf4Cdek4rb7mlf8Ph
 FbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692902738; x=1693507538;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U7w3bQmY167TP25xTfeDwrRGb73gB8Q5/rW5IV74SR4=;
 b=EmbxT/GWXZRUAQoe83gGJhE3241PWjvGED6TM1XlAEv+n7Uf1kW4R4qKscx0NRA+iY
 Cs1XYU9oxTVc8TMBBMxyYRhmqKDWucIMSk6J9uQ0t6UWrMS9E1Qxcunhm+jxRTyn2a0h
 0tbzZjgVGf9KGr/EFBiCZv6D3QkxLsqHSYCnInlNARhHPiTJfPLk5Km6uDDPNBM/71iJ
 uONgY9A9jNWaHWe2i7Ukb1REUkRTi/YVD2mapLljBp8JDZDeJ301ohrY4tdcAEPs8QEg
 TnzN7YStpQjySJoimDNqBdw5n8BzF4ikX5Nu0inGL7KgMzH38Jg+WyYV/YUpFZ0Z2rCO
 aqpA==
X-Gm-Message-State: AOJu0YzMlKPQxEXa/O8QtcU/jZbkJwQhJZPL1BCP4gsGwBv6IINSihWH
 xOYEXL9WBmNTiPD5NYgyLYGFKw==
X-Google-Smtp-Source: AGHT+IGwk67txt+voGb5Lm/MJJKXjDv6G97uy1kRCOAV+xvGto8AleXs5jDP2ChlqQpmI3uZ8Nhu1w==
X-Received: by 2002:a5d:6811:0:b0:315:8a80:329e with SMTP id
 w17-20020a5d6811000000b003158a80329emr11950557wru.40.1692902738432; 
 Thu, 24 Aug 2023 11:45:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c210300b003fefaf299b6sm151575wml.38.2023.08.24.11.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:45:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BCBA1FFBB;
 Thu, 24 Aug 2023 19:45:37 +0100 (BST)
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 00/12] Add VIRTIO sound card
Date: Thu, 24 Aug 2023 19:44:27 +0100
In-reply-to: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
Message-ID: <87bkewffe6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This patch series adds an audio device implementing the recent virtio=20
> sound spec (1.2) and a corresponding PCI wrapper device.
>
> v7 can be found online at:
>
> https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v7
>
> Main differences with v6 patch series [^v6]
> <cover.1692089917.git.manos.pitsidianakis@linaro.org>:
>
> - Removed minor stale/duplicate code.
> - Addressed [^v6] review comments.
>   Notably, the audio driver name is now `virtio` instead of=20
>   `virtio-sound`.
> - Fixed some invalid pointer logic.
> - Fixed minor typos and updated documentation.

I'm seeing a bunch of CI failures:

  https://gitlab.com/stsquad/qemu/-/pipelines/979444077

Most of them will probably clear up when you fix the missing parameter
names.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

