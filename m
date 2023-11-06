Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B97E2B5A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:40:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03aG-0004T4-JL; Mon, 06 Nov 2023 12:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r03aB-0004SO-BF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:40:15 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r03a9-0005fL-JQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:40:15 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c594196344so63915131fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699292411; x=1699897211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6H/mte8zfCh+3ldKCUGNa3FTQcIRSEdRTK/aJwoLZeQ=;
 b=RP+ZSziZSVP8/UkbB8+FTYNYbxYe7xAE265pFkpYdx0EpLCpClPENBOSyB1S+9rcfJ
 9N1uq82z2GTHo6vzecWaZ/dwgACOpkR7vf2s0owRrnB9HP6BOMlqTQ+gncIfgkBeosxO
 GjJag/FB7cyhy6J5fiaS7ilm/Pzi9w1onjQpKuDip+ClhelID1PimjkeSTcVodBoQnVg
 Yw2+hbaqqeKywChv4Q8fAVs7NP9Rwj9HmVohDHcRvvUsBd00RHQEpYmA3MtXuCse+YpQ
 fDRGlZKKagsBfzD/7xshv3RX5xt8/MV2cBUmgs0PLXGrc0d5m3jH68r7TLG4kC/+9fK2
 3ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292411; x=1699897211;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6H/mte8zfCh+3ldKCUGNa3FTQcIRSEdRTK/aJwoLZeQ=;
 b=cmQRuipX7DUZcUxk1wHN1QVrGgkC5rMuDScK08hE9sVZfl7BPKhura4WXn4kRuZTGc
 40gPDRngZI2UflffVMVW1DAMdxDFv6yYQNCds4KeKSg4dVYDsrymEF34cJO1C9vbrB2N
 rrmpX1C2XEw8UDuD1igCxm31n3ply7+imQy3widR84L4uElwFqgT7Kltl/v4N8LaWjwe
 EFbi/2vOstLMOoXq5/zk/AQlekWC2VSIuo7me7qh+6zD3ySBKvKxhuJm0sakTYtbzU+k
 FdXfv4bCrSwpLI5gV+jU4EmCnEIFFZRE3POeUIMDCvA1Vw1KAdbLqK75Z0CHtIq2x8aU
 kSpg==
X-Gm-Message-State: AOJu0Yw5tozZjtBHf3ZO64f16GfwC2VPU8i3Th//WgT3ewQgn8cTqOIn
 LJGc78jj+JL5lh9AZHTalU0t9A==
X-Google-Smtp-Source: AGHT+IHVT5gn5TimAjBIIdQsTHObLBMJvvaeLLOQavsY87Z2VaeNWczQmGgtnBvEuY/0QQSV5Jg/OA==
X-Received: by 2002:a2e:9d08:0:b0:2c7:610:2dd1 with SMTP id
 t8-20020a2e9d08000000b002c706102dd1mr6625261lji.47.1699292411344; 
 Mon, 06 Nov 2023 09:40:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p29-20020a05600c1d9d00b0040772934b12sm13270393wms.7.2023.11.06.09.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:40:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A0F565565;
 Mon,  6 Nov 2023 17:40:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 virtio-fs@redhat.com,  Eduardo Habkost <eduardo@habkost.net>,  Fam Zheng
 <fam@euphon.net>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Raphael
 Norwitz <raphael.norwitz@nutanix.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 1/6] virtio: split into vhost-user-base and
 vhost-user-device
In-Reply-To: <20231106121755-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 6 Nov 2023 12:18:40 -0500 (15 minutes, 42
 seconds ago)")
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-2-alex.bennee@linaro.org>
 <20231106121755-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 17:40:10 +0000
Message-ID: <87o7g6bx1h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

> On Thu, Oct 19, 2023 at 10:56:05AM +0100, Alex Benn=C3=A9e wrote:
>> Lets keep a cleaner split between the base class and the derived
>> vhost-user-device which we can use for generic vhost-user stubs. This
>> includes an update to introduce the vq_size property so the number of
>> entries in a virtq can be defined.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
>
> I applied but I think for this release we are better off just
> preventing users from instanciating these on command line -
> developers can always hack code to drop this.

I guess if a user doesn't read the documentation and makes up some
random numbers for the properties they deserve what they get?

> Can you post a patch please?

Is:

    /* comment out if you want to use backends qemu doesn't know about */
    .abstract =3D true,

really worth it?


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

