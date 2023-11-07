Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0857E481A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:19:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qee-0007Le-VC; Tue, 07 Nov 2023 13:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QeZ-0007Kc-3j
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:18:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0QeR-0004a0-Mc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:18:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso4168979f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699381090; x=1699985890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/zw9rL/CKYchneRCkbxDcJIXqnT1dKme+sWq6fMio4=;
 b=MbCw+7H5UJOCkTaAky7X6eDVEl9vQ77AiPv1vKEAIA5L6odJbSWy9xn/Upg0B7xGvL
 v4iVNrYUquW/VThSp64rU0qdej0Efh7dp0EYn551L83ES2N07723djD+XvXFLAPmRPsh
 P2lynxbUC1iYt+REW+wnpWVERDOouD3aVH09M09LxDmHRefQaeMGf5ggBiLpWFWpKz5v
 k1dvKJ5Rwr9qlC/u90SYxlwT0MKqNeRtm1y10dQnuLtLhaaNv8xmrdLUVtUg9ha0WGQO
 /SvEwdBwpgs6+PiwTWY1OYrOZ4Aqj2xWmfFx2vPbOyNnPk0hpu0TAk0eANG0vMS+qGFH
 evQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381090; x=1699985890;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/zw9rL/CKYchneRCkbxDcJIXqnT1dKme+sWq6fMio4=;
 b=ooY+r0kTYwxnP4DI/wDTryLLplyUhkiIp+GX/UELCr3VceAba8QY5RRSjcy6LSFJig
 sn7UdoSJ34VD93xF65BC3vIuaxnPWuFCo6ScxkWjejdeImlrcnR+8tQJDD6SA10vRmSc
 hFjywGarGWfS1/2CXfreJMrn5LP/ETKM1J00QiK3CA8RL+vop4v/zLFzfbF/LUCXfTm/
 Bl5r8fax4mkVQoBf38EmYtkgmg8VzAuioYoBQCcJyd2riu/dLn1HS0Bmwhugdssf7sZ5
 xKJlhHkIarp+SA+Rehq7v5uC16dBGWH1x1B0apStJDX2V//TfN4i+ZjSUCZEPB92vRnk
 tRNg==
X-Gm-Message-State: AOJu0Yxir6qh2qjd5tpXzKJ6f1tbDA1fp9rk6AOjFc92h1evSXn0ETNu
 JBTSjqRvqurDANiwSXljDtXJzQ==
X-Google-Smtp-Source: AGHT+IE/xQHMLvyFkMKnuI0ZiRJ971oV+ltoK6nfvkdkc+qyTLE+V+pcqXy7xyDdtmoHGBUaNr5y3w==
X-Received: by 2002:adf:e788:0:b0:32d:9a7c:56ed with SMTP id
 n8-20020adfe788000000b0032d9a7c56edmr24122322wrm.10.1699381090123; 
 Tue, 07 Nov 2023 10:18:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4482000000b0032f79e55eb8sm3002359wrq.16.2023.11.07.10.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:18:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FAAC5F790;
 Tue,  7 Nov 2023 18:18:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  qemu-block@nongnu.org,
 Markus Armbruster
 <armbru@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 virtio-fs@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Raphael Norwitz <raphael.norwitz@nutanix.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Eric Blake <eblake@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
In-Reply-To: <20231107045207-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Tue, 7 Nov 2023 04:53:10 -0500 (8 hours, 10
 minutes, 24 seconds ago)")
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
 <20231107045207-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 18:18:09 +0000
Message-ID: <87cywlbf6m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Nov 06, 2023 at 07:15:09PM +0000, Alex Benn=C3=A9e wrote:
>> A lot of our vhost-user stubs are large chunks of boilerplate that do
>> (mostly) the same thing. This series continues the cleanups by
>> splitting the vhost-user-base and vhost-user-generic implementations.
>> After adding a new vq_size property the rng, gpio and i2c vhost-user
>> devices become simple specialisations of the common base defining the
>> ID, number of queues and potentially the config handling.
>>=20
>> I've also added Manos' vhost-user-sound while I was at it.
>
> Dropped due to CI failures. Pls make sure this passes gitlab CI.
> Also pls ping me after release to help make sure it does not get lost.
> Thanks!

Your intuition about the async tear down was right (or at least avoids
the racey qos-test failure). I've added a final patch and sent :

  https://patchew.org/QEMU/20231107180752.3458672-1-alex.bennee@linaro.org/

It's running the CI as we speak:

  https://gitlab.com/stsquad/qemu/-/pipelines/1064197949

>
>> Changes
>> -------
>>=20
>> v6
>>   - re-base to current master
>>   - make vhost-user-device abstract
>>   - mention abstractness in docs
>>=20
>> v5
>>   - addressing comments and tags
>>   - improved the docs
>>=20
>> v4
>>   - dropped the F_TRANSPORT work for another series
>>   - added vhost-user-sound
>>=20
>> Alex Benn=C3=A9e (5):
>>   virtio: split into vhost-user-base and vhost-user-device
>>   hw/virtio: derive vhost-user-rng from vhost-user-base
>>   hw/virtio: derive vhost-user-gpio from vhost-user-base
>>   hw/virtio: derive vhost-user-i2c from vhost-user-base
>>   docs/system: add a basic enumeration of vhost-user devices
>>=20
>> Manos Pitsidianakis (1):
>>   hw/virtio: add vhost-user-snd and virtio-snd-pci devices
>>=20
>>  docs/system/devices/vhost-user-rng.rst        |   2 +
>>  docs/system/devices/vhost-user.rst            |  65 ++-
>>  ...{vhost-user-device.h =3D> vhost-user-base.h} |  21 +-
>>  include/hw/virtio/vhost-user-gpio.h           |  23 +-
>>  include/hw/virtio/vhost-user-i2c.h            |  14 +-
>>  include/hw/virtio/vhost-user-rng.h            |  11 +-
>>  include/hw/virtio/vhost-user-snd.h            |  26 ++
>>  hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
>>  hw/virtio/vhost-user-device-pci.c             |  10 +-
>>  hw/virtio/vhost-user-device.c                 | 337 +--------------
>>  hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>>  hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>>  hw/virtio/vhost-user-rng.c                    | 278 +-----------
>>  hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>>  hw/virtio/vhost-user-snd.c                    |  67 +++
>>  hw/virtio/Kconfig                             |   5 +
>>  hw/virtio/meson.build                         |  23 +-
>>  17 files changed, 690 insertions(+), 1290 deletions(-)
>>  rename include/hw/virtio/{vhost-user-device.h =3D> vhost-user-base.h} (=
71%)
>>  create mode 100644 include/hw/virtio/vhost-user-snd.h
>>  create mode 100644 hw/virtio/vhost-user-base.c
>>  create mode 100644 hw/virtio/vhost-user-snd-pci.c
>>  create mode 100644 hw/virtio/vhost-user-snd.c
>>=20
>> --=20
>> 2.39.2

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

