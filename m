Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323297E1FD5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:22:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxbj-000530-Ux; Mon, 06 Nov 2023 06:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxbd-0004gU-VY
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:17:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qzxba-0007Fe-W4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:17:21 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so3206113f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699269437; x=1699874237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt35xeXej7i+0tGiAHfwAu3NY9J6Qrkflu6pwKtoEe4=;
 b=zoy7GG5pq8pQB+worubQLQS3ZEhJD1d9TdjtGlJq8ncaUr6Y27ijJ1yFRVzW4LwLbQ
 98WsodK8qBpg6/eJuoj82V/QFYnBW+ecn7idq5EIoemGVwTnE6GIjO4VUogfBbKdOyBo
 FZ/TMESdcZCynkOgQku/V3Ri+q1e2J6Om6lNAXAwEQkephUgIiylz1ktQhrE/ehw2BCE
 6wmAS39h8BK9bfqI3ujzXxZWDKTS3O9E8Zwe1q3WJuo6Mi5eBonI7kJjGv1m3n/s9DBQ
 ALuWti3awiy6v7LA0Vn1GqAkQUbS+axSG9r4mj6KgSWkJqCtY3g26B1PtMbCRd8dfxzP
 OXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269437; x=1699874237;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nt35xeXej7i+0tGiAHfwAu3NY9J6Qrkflu6pwKtoEe4=;
 b=oX9zVGXAC7VYqEf6FSCfk4GMUCPor9K0AjFfyiCmhJ9sIc/98JqIYHxr8kpf8OKS3n
 un/0KnHV5Yb4h14qx550naLPTPQt2kGUz7KQFjvQ3K3stBfKORHd3B69ajcSA8PnyNd0
 BTCy8VddBsmYwx7iZ9lwPujIdkiEx005ADrXLLylZ+DLu+jAXwOxpQKtTnOBeWlL7jXV
 mMnofcrlDf07c3JRfNb+SCh8JZ09LNMaDd7fLweh1CUxItl4DZufTgFzK3VSYC+pmbbx
 J+DbR2TBNObJwFAkoCTACBEmq8SAXzL+9l2aN3xtjn51QScoN9jqbpqBD6vf/8jbNsX7
 PNmA==
X-Gm-Message-State: AOJu0YzFOdERjemlwPycKjkWOLBNbBF0pBk8uEvk23DV+JZLQZWWb+0p
 XcQjtd1t+34s0VmRY9M/XQmlww==
X-Google-Smtp-Source: AGHT+IEY7NDKoJiWY0sZp1SdX5yQ+rt6ABIhLX9b2+3bjrlg6t3Jp2Vx48DDuRtXQzSayuUPyz6Y+A==
X-Received: by 2002:a05:6000:144f:b0:32f:75d2:5a32 with SMTP id
 v15-20020a056000144f00b0032f75d25a32mr11180154wrx.6.1699269437471; 
 Mon, 06 Nov 2023 03:17:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p1-20020a056000018100b0032fab28e9c9sm9141953wrx.73.2023.11.06.03.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:17:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D3A15F79F;
 Mon,  6 Nov 2023 11:17:16 +0000 (GMT)
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
In-Reply-To: <20231101010813-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Wed, 1 Nov 2023 01:08:46 -0400 (5 days, 6 hours,
 2 minutes ago)")
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
 <20231101010813-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 11:17:16 +0000
Message-ID: <87y1fbcern.fsf@draig.linaro.org>
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

> On Mon, Oct 23, 2023 at 03:03:17PM +0300, Manos Pitsidianakis wrote:
>> This patch series adds an audio device implementing the recent virtio
>> sound spec (1.2) and a corresponding PCI wrapper device.
>>=20
>> v13 can be found online at:
>>=20
>> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13
>>=20
>> Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c
>>=20
>> Main differences with v12 patch series [^v12]:
>>=20
>> - Fixed device aliases (thanks Volker R=C3=BCmelin <vr_qemu@t-online.de>)
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> to merge through the audio tree.

This hasn't been picked up yet and I'm worried we'll miss the
soft-freeze. I guess this is the reason the entire audio stack is
currently on "Odd Fixes".

Should we just re-spin with us as maintainers for virtio-sound and merge
it through my tree?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

