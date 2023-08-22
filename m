Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83A783C29
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYN9l-0005LU-C6; Tue, 22 Aug 2023 04:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYN9i-0005LB-QW
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:54:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYN9g-00012P-Hv
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:54:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so3749934f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692694466; x=1693299266;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urTJb1aQs4BGNT10UWqDE8xa4aEuKsS8SiGj19fvQYU=;
 b=zrrPLAedkzqVhhUpCyGwzHiPc4sTZL0dQ6DXv6A6xrQrMN//g40Nbdd6ipW3X5CpG/
 X8Go0aPgJ43Pvde+GFoHFu3B4MPrMOs5BJQr9lcyRlKKONxgO6mXl9ZlAF6O8n3apKsf
 MyrnUS01q3o46DKPE3bWeux7nA8V4h+Kvxdd/sCy6sCKTss3cq2R+9uylMrfCOsnCQZX
 yZLZoKiK3SCzDMJIXWDDiWbVgKErOEV2Z5P1zbo8iKLofmpy1lEuIp/1yjeYnONvj/M3
 IK62MpapoM2kVfMtFOuTILIFrV75XADKehL3mMBOgR3jBLtPJjsRK74nhWeUG2Jepri/
 fC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692694466; x=1693299266;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=urTJb1aQs4BGNT10UWqDE8xa4aEuKsS8SiGj19fvQYU=;
 b=Hq1rnHpt0n6R4R+mJqPHglT4vNAUkGeM+L5CdVfB9UxYsUMnfTS+GY2Hln+KcufEPy
 uwcBp3bxnKfRqiJC6eJHPWbil539/tpm8tJ7xP2EOkVgwCUfQ41OnEngIRj6xVzA8OLq
 +YOcYjX57W3CKBbXhUjSBQrVeTU6ap55y9284TQktiDg0PIsgEOYrml/CP6WLud9b29x
 CnVgXWOkSUUCyhmGNTpUMtKdoazUc9YjDLthrI+ZK8WmRVk/qOcs68TFKml4uqZya56J
 mBwN3GCHDeJSK2sYWIya93E2rpEKscdCDFvI4MoFhxjP4ST4NjApaxNzQWsqysJ46nHD
 KehQ==
X-Gm-Message-State: AOJu0YwVEVd3MqalejUWeCog/sjMZ3Rxe6oKWEG4iMqIGhHzzj9IkfAP
 PdSn9l9HrEYD47c1zM14m6ASmg==
X-Google-Smtp-Source: AGHT+IHNLlDZ8eXRUQ02tBfdkoQY2JmVRUVdGoKSMZORDFJHYzUguPz7N+Wd7okxrbjGuGCyAhzFYg==
X-Received: by 2002:a05:6000:1001:b0:317:5d60:2fea with SMTP id
 a1-20020a056000100100b003175d602feamr6129513wrx.52.1692694466487; 
 Tue, 22 Aug 2023 01:54:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adfea46000000b003197a4b0f68sm15310064wrn.7.2023.08.22.01.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 01:54:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D5581FFBB;
 Tue, 22 Aug 2023 09:54:25 +0100 (BST)
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <86f98e0b7da6cf1a8b308b1e14400f66d18fd010.1692089917.git.manos.pitsidianakis@linaro.org>
 <f49650d9-f80f-bbbe-1c0a-4a42a6c6ec76@t-online.de>
 <zq93g.y1gwybb8v8l9@linaro.org>
 <52573d37-cbcb-2d6c-b979-9a2a66b53c1d@t-online.de>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v6 01/12] Add virtio-sound device stub
Date: Tue, 22 Aug 2023 09:46:59 +0100
In-reply-to: <52573d37-cbcb-2d6c-b979-9a2a66b53c1d@t-online.de>
Message-ID: <878ra3ihj2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Volker R=C3=BCmelin <vr_qemu@t-online.de> writes:

> Am 21.08.23 um 08:06 schrieb Manos Pitsidianakis:
>
>  Hello Volker!=20
>
>  On Sun, 20 Aug 2023 12:33, Volker R=C3=BCmelin <vr_qemu@t-online.de> wro=
te:=20
>
>  I think the virtio-snd.c code, the trace events and the Kconfig VIRTIO_S=
ND should be moved to hw/audio. The
>  code for nearly all audio devices is in this directory. This would be si=
milar to other virtio devices. E.g. the
>  virtio-scsi code is in hw/scsi and the virtio-net code is in hw/net.=20
>
>  This was where it was initially but in previous patchset versions it was=
 recommended to move them to hw/virtio. I
>  don't mind either approach though.
>
> Hi Manos,
>
> Ok, then don't change the directory. I guess I will have to discuss
> this with Alex first.

Yeah we are not super consistent about this in the code base.

There are a whole class of VirtIO devices which are either stubs for
vhost-user or not the usual block/net devices where hw/virtio makes the
most sense to keep things together.

Things like virtio-block and -net often share or integrate more closely
with their sub-systems so that certainly makes an argument for including
them in the respective subdirs. You also get arch specific virtio
devices (e.g. s390x ccw devices) which live in the hw/$ARCH directories.

I would certainly argue they should all share the include/hw/virtio
directory for their type and structure definitions. Whether virtio-sound
deserves to be with the rest of the sound HW I guess depends on if it
makes things easier to integrate? There will be a vhost-user-sound
device at some point and that won't require integration with QEMU's
internal sound APIs.=20

mst what do you think?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

