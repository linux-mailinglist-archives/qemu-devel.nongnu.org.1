Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29FA825301
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:38:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiWT-0005wW-IR; Fri, 05 Jan 2024 06:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLiWR-0005vP-Hk
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:37:55 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLiWM-0007B5-7i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:37:55 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ccbded5aa4so17761251fa.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704454668; x=1705059468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFkjv9dxhyJHBDfpyQf/cncDrZs0NtSHgpm16fB1J+0=;
 b=cNo1E6EHgt47MyF53TXLxTawbnJYqNmbRmC9AclOTKn9Kpej+HUUhbFkpUQuuNg5oi
 1PWcQUFZTURTvWkZW/fO8oetekVoZasC1NLPKrFzYDUrfLMkGhTl0NmVG99HSVCttbyS
 Gu5g0sugICi493HLqdLUTB+K9RkDuKlQBcBAh57yb7fOhoc+XjclG4xoSRcbScL+UoEK
 yoZu9DO1QWthajjkFs5ZbFYJuTwr5BP+blO5aMScZOqnNKWPKmO/k5itp/YDjDrcjabm
 LvJRDhRRFsX1tuEyB0YqH+xbgMosL1dIjZY3+eumsVTfaH53RVvFx4CGHKRcJV8UjrpI
 FRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454668; x=1705059468;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TFkjv9dxhyJHBDfpyQf/cncDrZs0NtSHgpm16fB1J+0=;
 b=ZS4SE2EcHH8ERAltLVlTnxHiFMZYqnqYnD7TFaC4mQErnLICyQfxmzbAEFczeO9msw
 yMEzSjQCJOcOAIfDshkSHq6A6B2QdfINm6L7K8cjxadVC9iWQe4/2/1NgzLvAvu8j7Yx
 oqs0isuRI9/8XpQ/i7bvA3+a/mx1RJdbbwlL08ZIjjBLq35WdN12xZo41AJH1e3jzkRG
 YNefQMc+07bxHHP5mzprxSgYAC8zVY39r7iLWNaTn6ec5m1Lb5ReIlq1RdzpwUkt5Wvs
 4ERl8NC3NrW2JIP9iRrSUW4I4Ev+fyYCSW/u6Ce2aBO85El3NTCgNXtHLLgsm/+tWLzt
 F+Dw==
X-Gm-Message-State: AOJu0YyUbTZJ0jhz8jVS4WFJU0cznRpY0DtSaRPosjL3PdeFyAtxmFJ6
 /tovQH+Jv++V/DTOgcaXYJQfIQ0vfp6CeQ==
X-Google-Smtp-Source: AGHT+IG3/MAf/jl/vf11S3y/bYYZLCTYkxC67I8J4pmltzjjKJPKqRJBvlXtOBF8WkUv1Xncmijo1w==
X-Received: by 2002:a19:9156:0:b0:50e:10e8:d544 with SMTP id
 y22-20020a199156000000b0050e10e8d544mr1045215lfj.68.1704454668387; 
 Fri, 05 Jan 2024 03:37:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040d85a1fad9sm1303495wmb.46.2024.01.05.03.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 03:37:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 759DC5F933;
 Fri,  5 Jan 2024 11:37:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Mathieu
 Poirier <mathieu.poirier@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Jason Wang
 <jasowang@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-A?=
 =?utf-8?Q?ndr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 virtio-fs@redhat.com,  Hanna Reitz <hreitz@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  qemu-block@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Raphael Norwitz
 <raphael.norwitz@nutanix.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v9 01/11] virtio: split into vhost-user-base and
 vhost-user-device
In-Reply-To: <98246d7d-0e6f-45c3-91c2-2b2e1cd7fe93@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 5 Jan 2024 10:49:03
 +0100")
References: <20240104210945.1223134-1-alex.bennee@linaro.org>
 <20240104210945.1223134-2-alex.bennee@linaro.org>
 <98246d7d-0e6f-45c3-91c2-2b2e1cd7fe93@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 11:37:47 +0000
Message-ID: <87plygf1tg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 4/1/24 22:09, Alex Benn=C3=A9e wrote:
>> Lets keep a cleaner split between the base class and the derived
>> vhost-user-device which we can use for generic vhost-user stubs. This
>> includes an update to introduce the vq_size property so the number of
>> entries in a virtq can be defined.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> v5
>>    - s/parent/parent_obj/
>>    - remove left over vhost-user-device.h
>>    - use DEFINE_TYPES
>> v6
>>    - rebase and set .abstract =3D true for vhost-user-device
>> v7
>>    - checkpatch line length + MAINTAINERS
>>    - s/abstract =3D true/dc->user_creatable =3D false/ for both mmio and=
 pci
>> ---
>>   MAINTAINERS                                   |   6 +
>>   ...{vhost-user-device.h =3D> vhost-user-base.h} |  21 +-
>>   hw/virtio/vhost-user-base.c                   | 346 ++++++++++++++++++
>>   hw/virtio/vhost-user-device-pci.c             |  13 +-
>>   hw/virtio/vhost-user-device.c                 | 338 +----------------
>>   hw/virtio/meson.build                         |   1 +
>>   6 files changed, 383 insertions(+), 342 deletions(-)
>>   rename include/hw/virtio/{vhost-user-device.h =3D> vhost-user-base.h} =
(71%)
>>   create mode 100644 hw/virtio/vhost-user-base.c
>
>
>> @@ -358,6 +42,9 @@ static void vud_class_init(ObjectClass *klass, void *=
data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>>   +    /* Reason: stop inexperienced users confusing themselves */
>> +    dc->user_creatable =3D false;
>
>
> What about making VHOST_USER_DEVICE_PCI and
> TYPE_VHOST_USER_DEVICE TypeInfos abstract instead?

I had in a previous iteration (v7) but AIUI abstract really means
something different - the device can be instantiated but we just want to
stop the user from creating it arbitrarily.

>
>> +
>>       device_class_set_props(dc, vud_properties);
>>       dc->vmsd =3D &vud_vmstate;
>>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>> @@ -366,14 +53,11 @@ static void vud_class_init(ObjectClass *klass, void=
 *data)
>>   static const TypeInfo vud_info =3D {
>>       .name =3D TYPE_VHOST_USER_DEVICE,
>>       .parent =3D TYPE_VHOST_USER_BASE,
>> -    .instance_size =3D sizeof(VHostUserBase),
>>       .class_init =3D vud_class_init,
>> -    .class_size =3D sizeof(VHostUserBaseClass),
>>   };

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

