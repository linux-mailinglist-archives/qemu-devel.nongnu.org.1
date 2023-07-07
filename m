Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DDF74B1AC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 15:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHlNG-0005R7-Ui; Fri, 07 Jul 2023 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHlNC-0005Qu-4d
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:46 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHlN9-0001O8-Rl
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 09:19:45 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so2864145e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688735982; x=1691327982;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFETEHm3ABAGQiP2zk7MYYD08U3lBq2CA5WgGuw/fMQ=;
 b=c9RWvspnwjJhyI4i0xmH2bnK0pSubbku2J/BsywEBkYYxuATQNqe66nmFv6DbFpmxJ
 mZyF4XwWjIag76KxagAa2v18RfXfmFmZ2O/CbQb/bSERbXUMcqEphXA77dNhEBohblK3
 luzKDcsoTg3HusernurZt2g2nPJEg9awrgsFuERgnqq1rMenM6Bl+UqJKPgL02Rw2cIn
 XWIuaH30e1uQT9zI7ZFEZ22Eh+7ExU6IgL4cYyEa24J7X4I/aow+TbQTfS8NqllhaLqf
 lTwVEo4kKwZSKJNfb4+p4ffNSbzlupdPUBsfjDnfWbCidKwdHQim/DzwM1ZHBUooB85q
 /i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688735982; x=1691327982;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VFETEHm3ABAGQiP2zk7MYYD08U3lBq2CA5WgGuw/fMQ=;
 b=dHxNxflp5YnTZpwLD0f6XzOCtCFLHCr75itNxnz8iCCTgXJsvtlMFW+858PDHs1EyS
 clYVsevEXTFuNjtKfoTy/d43PMdW5I/H+DC5/sKvXUhObt6u2xq85PDwtqpyOwOJZH7g
 OHOv6BB+5OMpmEIMUkhcix8RjXlhwDUpKelNHoWS07P50NtDleq1rT3WITKa05YUQ/cP
 bCSBMj85R0T5ch4QkmL/ueJi9pWAeEDcJL+7wNLVN4bT/yjZaZ9tq0HUYapir0mxAJ1h
 FgZFVOK+ajKFqjvDL/A9ZJwxEcPaBV0tjPmhFNBoFAsCNvLl8RYvumQTo7k7SeuFfokt
 /OFg==
X-Gm-Message-State: ABy/qLYfqEVFt5/L/608m0DPEi84NwrxhtY1Eh0n+/eXYCv5ARgZM281
 h/0I+e25TePxnsRN/HBzi1qr9w==
X-Google-Smtp-Source: APBJJlFJrwJCJwHf/thg9C72g3BwOEwfKuTvlGwTvAMer8pco/B+AXrfX86mIiie1a/HyVe0Z8l3hg==
X-Received: by 2002:a19:4f10:0:b0:4fb:9129:705b with SMTP id
 d16-20020a194f10000000b004fb9129705bmr3907521lfb.6.1688735981859; 
 Fri, 07 Jul 2023 06:19:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6552000000b0030fd03e3d25sm4455975wrv.75.2023.07.07.06.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 06:19:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16CAB1FFBB;
 Fri,  7 Jul 2023 14:19:41 +0100 (BST)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <87ilawdtug.fsf@linaro.org>
 <20230707055141-mutt-send-email-mst@kernel.org>
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
Date: Fri, 07 Jul 2023 14:12:28 +0100
In-reply-to: <20230707055141-mutt-send-email-mst@kernel.org>
Message-ID: <87a5w7eu4y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

> On Fri, Jul 07, 2023 at 08:58:00AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Benn=C3=A9e wrote:
>> >> Currently QEMU has to know some details about the back-end to be able
>> >> to setup the guest. While various parts of the setup can be delegated
>> >> to the backend (for example config handling) this is a very piecemeal
>> >> approach.
>> >
>> >> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDAL=
ONE)
>> >> which the back-end can advertise which allows a probe message to be
>> >> sent to get all the details QEMU needs to know in one message.
>> >
>> > The reason we do piecemeal is that these existing pieces can be reused
>> > as others evolve or fall by wayside.
>>=20
>> Sure I have no objection in principle but we then turn code like:
>>=20
>>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STAN=
DALONE)) {
>>             err =3D vhost_user_get_backend_specs(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_specs =
failed");
>>                 return -EPROTO;
>>             }
>>         }
>>=20
>> to
>>=20
>>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) =
&&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGS=
Z) &&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINV=
Q) &&
>>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXV=
Q)
>>         ) {
>>             err =3D vhost_user_get_virtio_id(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_id fai=
led");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_cfgsz(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz =
failed");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_minvq(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq =
failed");
>>                 return -EPROTO;
>>             }
>>             err =3D vhost_user_get_virtio_maxvq(dev, errp);
>>             if (err < 0) {
>>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq =
failed");
>>                 return -EPROTO;
>>             }
>>             dev->specs.valid =3D true;
>>         }
>>=20
>> for little gain IMHO.
>>
>> > For example, I can think of instances where you want to connect
>> > specifically to e.g. networking backend, and specify it
>> > on command line. Reasons could be many, e.g. for debugging,
>> > or to prevent connecting to wrong device on wrong channel
>> > (kind of like type safety).
>>=20
>> I don't quite follow what you are trying to say here.
>
> That some or all of these might be better on qemu command line
> not come from backend. Then we'll want to *send* it to backend.
> All this at our discretion without protocol changes.

That doesn't solve the standalone problem though (not all VMM's are QEMU
after all). I'm currently putting together a PoC with the
vhost-user-device and I was intending:

 - no CLI args, probe and if nothing fail
 - CLI args, probe with no response, continue with CLI args
 - CLI args, probe with response, check args match (or in bounds for
   vqs) and fail if not

Stefan wasn't super keen on the vhost-user-device in v2 being user
creatable because things could go weird quite quickly in hard to debug
ways:

  Message-Id: <20230418162140.373219-1-alex.bennee@linaro.org>
  Date: Tue, 18 Apr 2023 17:21:27 +0100
  Subject: [PATCH v2 00/13] virtio: add vhost-user-generic and reduce copy =
and paste
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

However it certainly is useful from a development point of view being
able to plug in new VirtIO backends without having to copy and paste
another slightly different stub into QEMU. I was pondering a middle
ground of maybe making the CLI options all x- variants to emphasise the
"here be dragons please know what you are doing" aspect of them.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

