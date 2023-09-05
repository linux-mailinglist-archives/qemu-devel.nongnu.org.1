Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E7792B66
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZTk-0002Gt-29; Tue, 05 Sep 2023 13:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdZTi-0002Gh-Jr
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:04:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdZTg-0006ap-0Q
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:04:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so19514385e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693933473; x=1694538273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekx867mHXd66kuN1xrBjKNaFWHlYvLgGYX8Lg7d62g0=;
 b=ZYPkKfz2IdOH74H0G07JnX/b7UqJvXvv/IfgFlxsY/snwyazTWGsarHmfWcaOTMvZP
 9sr2H0yFRDDfBOwi6vhSYGxpusWp5/CaxuvIQvJgtdsNZT05/S/z+OT2jSJxwFkstp99
 A+Gqtyee93jZjO6LIOfdIzYPzUuIXErsVUhDeX/TqfKo/tNRK5VDacOhJbrrPBmaDD6n
 rymP9tkn7GXX6UB3/kKtkgpgrKOrnCedIeDamQzejdEcM9qbqkyKOZSHww/uLfqXYliy
 jXfw7dnMi3N5ngSbt9Hz/SXhCtkbsKVElMtv94ownEk95iB6tF9vi00+FCPaB8yrUooC
 jCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693933473; x=1694538273;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ekx867mHXd66kuN1xrBjKNaFWHlYvLgGYX8Lg7d62g0=;
 b=iHmut5mPnWHe0Oef8XwS6OI97tK94d+xQEX0EpzJvxx3tlotca+VgFSQfuzOaFIJ6v
 W0tfqOG9w40ZIt3ytu++sYpdvHgnIwzUUEp55bqWTijjYQ/1NjuBEohfOSIlOqVnP0Kz
 Wm/wR/atpSvyLjFl4H4sKRup3evTKlpL4+gKgv14Rsv9G93BmodxOTLRgEUqLsLutmWE
 OPejyoahkf0Cf/OGotaWoQhKxZ7Q8Kc5j0RmF97OKDi6Xw2fibq2Wt/Rd7MghwiCPQHD
 clil0QKhlu2CmxsUcNP5Ygxz08p2IUwbKX4rHwCgjJg2sp9GuAedCGW8Lz+HC+mFBJHD
 JmAA==
X-Gm-Message-State: AOJu0Yw6Aac/X8LEj7BL0p6Y+a/h2bwGF/Cbf7puOFmKdIQJjmuZzwZf
 +4b7ztZ6eXjK5vGJKq6EIeu96w==
X-Google-Smtp-Source: AGHT+IFJxsC3rYi0Gm8vwrYAI6LeQhzedFqbbXrdw1aqnAWwgxe1ooMUdLesqaruRWd4WDCx2GnIug==
X-Received: by 2002:a05:600c:21c5:b0:3fc:dd9:91fd with SMTP id
 x5-20020a05600c21c500b003fc0dd991fdmr291847wmj.40.1693933473280; 
 Tue, 05 Sep 2023 10:04:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a05600c3b9a00b00402c0a8a084sm12145575wms.17.2023.09.05.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 10:04:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7C6F41FFBB;
 Tue,  5 Sep 2023 18:04:32 +0100 (BST)
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
 <20230710153522.3469097-8-alex.bennee@linaro.org>
 <ZPc44//qJCPNAOXE@fedora>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mathieu
 Poirier <mathieu.poirier@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Eduardo Habkost <eduardo@habkost.net>, Fam
 Zheng <fam@euphon.net>, virtio-fs@redhat.com, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v3 07/20] virtio: add vhost-user-base and a generic
 vhost-user-device
Date: Tue, 05 Sep 2023 18:01:56 +0100
In-reply-to: <ZPc44//qJCPNAOXE@fedora>
Message-ID: <87ledkh7q7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Matias Ezequiel Vara Larsen <mvaralar@redhat.com> writes:

> On Mon, Jul 10, 2023 at 04:35:09PM +0100, Alex Benn=C3=A9e wrote:
>> In theory we shouldn't need to repeat so much boilerplate to support
>> vhost-user backends. This provides a generic vhost-user-base QOM
>> object and a derived vhost-user-device for which the user needs to
>> provide the few bits of information that aren't currently provided by
>> the vhost-user protocol. This should provide a baseline implementation
>> from which the other vhost-user stub can specialise.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - split into vub and vud
<snip>
>> +
>> +    /*
>> +     * Disable guest notifiers, by default all notifications will be vi=
a the
>> +     * asynchronous vhost-user socket.
>> +     */
>> +    vdev->use_guest_notifier_mask =3D false;
>> +
>> +    /* Allocate queues */
>> +    vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
>> +    for (int i =3D 0; i < vub->num_vqs; i++) {
>> +        g_ptr_array_add(vub->vqs,
>> +                        virtio_add_queue(vdev, 4, vub_handle_output));
>> +    }
>> +
>
> Hello Alex, apologies if someone already asked this. If I understand
> correctly, the second parameter of virtio_add_queue() is the len of the
> queue. Why have you chosen "4" as its value? Shall qemu query the len of
> the queue from the vhost-user device instead?

Hmm yeah that is inherited from the virtio-rng backend which has a
pretty short queue. I don't think it is intrinsic to the device
implementation (although I guess that depends if a device will have
multiple requests in flight).

I propose making is some useful ^2 (like 64) and adding a config knob to
increase it if needed.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

