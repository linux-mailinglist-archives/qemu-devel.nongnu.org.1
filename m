Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5F74AC91
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgYp-0002eU-GL; Fri, 07 Jul 2023 04:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHgYn-0002dp-Ni
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:11:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHgYk-0006yZ-2U
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:11:23 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so1557049f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717480; x=1691309480;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZSiuHkgL0yIE4O7HLzt7OeU1T4BdYuO8GxB/QwP7IE=;
 b=SgZzwzTmfrpJW45AQv4cZhlMtl0qUEkPbDYQ+zWBeemCu186kHjR5GziCLwNO/XVox
 8YowywwCKDz03LxFhgWqDriMP/EtGWsTDykREIXsIKoVLhpZmDUHDYSKMZt1sQvA2HoC
 zPkSbHeZoTVDmjM57QfaOXrep2/wgTnYnvPTpjXR3+hNti06z5YMuhivr+kXrGZ9FMII
 oKfRdBId1xzLwtr5pHC/SfEo40Faby7XiMYUFqEA7afDoANnnHQXQ9Y//sijqEqQpiE+
 KBqZN1wIMyLWcPmWudi/MJH+ShU4LfWLx+lMN1MTgxIZOAIK++azU7QObluJDM5jWRs1
 srmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717480; x=1691309480;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tZSiuHkgL0yIE4O7HLzt7OeU1T4BdYuO8GxB/QwP7IE=;
 b=mGCLD0ZNjISSEJoUEfZ//mA24nb9zoSMmIjnWFmnKoWBrQbL31dpQdiC6BlJuHmbka
 bLhvSRDj7sjQSwp05j45GmNpOgoGQ52QM36F5IDEz27yhskSG5rHDlXmy9A9JrWPrOTw
 QHw+b+4NZ0QHpkpMs97cyYxK6SGZD0N0e3AfqVHzay4URP8w2f7ZKZpE5UmgvOTKlOCg
 1LWhTlgPX3XGeFU7wTspF3EUT1Y/Xh/aiXLqr8SMfBfc+v/kujvRo9gskSHXyk2K+V0d
 lYBGJR6aONupk/00SRfB+3QJWBAA6SQzl1M44YUTeQLPebYGNPcXn1GgyGjo3M4t2bn7
 AI/g==
X-Gm-Message-State: ABy/qLYEGwF88esDz+s7iK2ReCSLIM7SOlSCOH1/4G3XyAclBCRpJKDf
 ALz70Kk5BM83h/yGbwD6r8d9AA==
X-Google-Smtp-Source: APBJJlELgNlFsG5To0sX/neKfbROvRH2npY/Vu4w+FYIb8dQp2oL4hHsoTptBpUvIg2XpjB0R41XKQ==
X-Received: by 2002:adf:f809:0:b0:314:421f:532f with SMTP id
 s9-20020adff809000000b00314421f532fmr3564042wrp.44.1688717480600; 
 Fri, 07 Jul 2023 01:11:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6552000000b0030fd03e3d25sm3801870wrv.75.2023.07.07.01.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 01:11:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA9481FFBB;
 Fri,  7 Jul 2023 09:11:19 +0100 (BST)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com, viresh.kumar@linaro.org,
 sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature
 for vhost-user
Date: Fri, 07 Jul 2023 08:58:00 +0100
In-reply-to: <20230706124347-mutt-send-email-mst@kernel.org>
Message-ID: <87ilawdtug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
>> Currently QEMU has to know some details about the back-end to be able
>> to setup the guest. While various parts of the setup can be delegated
>> to the backend (for example config handling) this is a very piecemeal
>> approach.
>
>> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>> which the back-end can advertise which allows a probe message to be
>> sent to get all the details QEMU needs to know in one message.
>
> The reason we do piecemeal is that these existing pieces can be reused
> as others evolve or fall by wayside.

Sure I have no objection in principle but we then turn code like:

        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STANDAL=
ONE)) {
            err =3D vhost_user_get_backend_specs(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_specs fai=
led");
                return -EPROTO;
            }
        }

to

        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) &&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGSZ) =
&&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINVQ) =
&&
            dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXVQ)
        ) {
            err =3D vhost_user_get_virtio_id(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_id failed=
");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_cfgsz(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz fai=
led");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_minvq(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq fai=
led");
                return -EPROTO;
            }
            err =3D vhost_user_get_virtio_maxvq(dev, errp);
            if (err < 0) {
                error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq fai=
led");
                return -EPROTO;
            }
            dev->specs.valid =3D true;
        }

for little gain IMHO.

> For example, I can think of instances where you want to connect
> specifically to e.g. networking backend, and specify it
> on command line. Reasons could be many, e.g. for debugging,
> or to prevent connecting to wrong device on wrong channel
> (kind of like type safety).

I don't quite follow what you are trying to say here.

> What is the reason to have 1 message? startup latency?
> How about we allow pipelining several messages then?
> Will be easier.

I'm not overly worried about performance because this is all at
start-up. I am worried about excessive complexity though. We already
have quite a lot of interacting protocol messages.

>
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> Initial RFC for discussion. I intend to prototype this work with QEMU
>> and one of the rust-vmm vhost-user daemons.
>> ---
>>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>  hw/virtio/vhost-user.c      |  8 ++++++++
>>  2 files changed, 45 insertions(+)
>>=20
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..85b1b1583a 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -275,6 +275,21 @@ Inflight description
>>=20=20
>>  :queue size: a 16-bit size of virtqueues
>>=20=20
>> +Backend specifications
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-----------+-------------+------------+------------+
>> +| device id | config size |   min_vqs  |   max_vqs  |
>> ++-----------+-------------+------------+------------+
>> +
>> +:device id: a 32-bit value holding the VirtIO device ID
>> +
>> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_=
GET_CONFIG``)
>> +
>> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
>> +
>> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, m=
ust be >=3D min_vqs
>> +
>
> looks like a weird set of info.

It's basically the information you need for -device vhost-user-device to
start-up (and what is essentially the information set by the stubs as
they start-up).

> why would we want # of vqs and not their sizes?

I thought the vring's themselves where allocated by the driver. We only
need to the number of vqs so we can allocate the tracking structures.

> why config size but not config itself?

We already have GET_CONFIG and SET_CONFIG but without knowing the size
of the config space we can't properly set it up.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

