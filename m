Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346287E205A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:51:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxtD-0002Js-LN; Mon, 06 Nov 2023 06:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxtA-0002E3-AZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:35:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxt8-00039m-8Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:35:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so38258285e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699270525; x=1699875325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Anlwitwd1iXN39tCos4+0yk+3pcnMhEpqbhdqjnwlQ=;
 b=uUditQkBKci+UzKs4zQc/MQdh2B2XWPozcjR1ot/QG9DdKaguxa48bMwDCoCK4Jm3d
 IjVfGRaIMcxcwbn8O709m1QzaeXOwDTXOoc6nLbJPtkdPD/uzpmZuZyjQR18PHrv68Eh
 ggtX0OkMC5xEirmXtSHts2+hv6xd5eTSts4FIwX34XmEfm++qRPqbgXQnVYPAW+3oogE
 lH0t29VLIXxqER9QGQi9HNlmUch7UOgl3867KPLMPAfk4bfS1aCNtjYRJQiswR8xlLb5
 PTUH9l3AtkkUAKmEwWUlXqMIILYCo8exCPwzetccBU8g3WwPz1hBE0+bTrumi+n5ip0G
 gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270525; x=1699875325;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Anlwitwd1iXN39tCos4+0yk+3pcnMhEpqbhdqjnwlQ=;
 b=IrDvgle/ESzzUiRrWO1EslssUIrdgA8cythn1+jEjlpKMbYNifv4d8PfH8TNHZTPGZ
 19e9z+O+TsTjEqB4dl/iqZUBSRWPrGmg9rCaHfMbbwecpy7cj0XmljEw0nYmQUqbRJY4
 ZPHetR9R2Dr2dc5sASQguf6W8DvB097dG2yjjC/pULcSAcVlAWEa3RpXnUNOf31cGNhC
 Chlym1hf1fQ3VV6n3zn/5nCjlWfMcYa6FK9Ei6++W9Cm6a3qVZq1pMu5zNCC+dXB/szB
 hzqV/gWx+KQBe30OtIQIqqpEIJ5CKcRnF9xC80w1KcYZpxC8Uo/MwKNncjX6pxN9gdBg
 /a7g==
X-Gm-Message-State: AOJu0YyeVdxk4V4B7e15PTsxegMeIEg+cEurs6Z9/7QXAxwuT3xVSpgf
 fXUKZZXsGD9uW34hXwsbr6v3Pg801qw5jQtEUSHhyg==
X-Google-Smtp-Source: AGHT+IHSjI+mH72wX0WeNwbA6QSBnVlWVhfRy0o/pd73VNvKwqizxAvl5iwL15iTyHVmVRCFUUiiwA==
X-Received: by 2002:a05:600c:1d18:b0:408:4eb2:3b1b with SMTP id
 l24-20020a05600c1d1800b004084eb23b1bmr24573895wms.21.1699270524730; 
 Mon, 06 Nov 2023 03:35:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c191300b004090ca6d785sm12025264wmq.2.2023.11.06.03.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:35:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 060765F79F;
 Mon,  6 Nov 2023 11:35:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Igor Skalkin
 <Igor.Skalkin@opensynergy.com>,  Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>,  =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?=
 <DirtY.iCE.hu@gmail.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v13 00/11] Add VIRTIO sound card
In-Reply-To: <20231106062140-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 6 Nov 2023 06:21:58 -0500 (13 minutes, 14
 seconds ago)")
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
 <20231101010813-mutt-send-email-mst@kernel.org>
 <87y1fbcern.fsf@draig.linaro.org>
 <20231106062140-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 11:35:23 +0000
Message-ID: <87pm0ncdxg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On Mon, Nov 06, 2023 at 11:17:16AM +0000, Alex Benn=C3=A9e wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Mon, Oct 23, 2023 at 03:03:17PM +0300, Manos Pitsidianakis wrote:
>> >> This patch series adds an audio device implementing the recent virtio
>> >> sound spec (1.2) and a corresponding PCI wrapper device.
>> >>=20
>> >> v13 can be found online at:
>> >>=20
>> >> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13
>> >>=20
>> >> Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c
>> >>=20
>> >> Main differences with v12 patch series [^v12]:
>> >>=20
>> >> - Fixed device aliases (thanks Volker R=C3=BCmelin <vr_qemu@t-online.=
de>)
>> >
>> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>> > to merge through the audio tree.
>>=20
>> This hasn't been picked up yet and I'm worried we'll miss the
>> soft-freeze. I guess this is the reason the entire audio stack is
>> currently on "Odd Fixes".
>>=20
>> Should we just re-spin with us as maintainers for virtio-sound and merge
>> it through my tree?
>
> Since there's no response I'll pick it up, don't worry.

Thanks :-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

