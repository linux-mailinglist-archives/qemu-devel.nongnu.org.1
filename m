Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7A7E2CC1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:19:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r057q-0004d6-3k; Mon, 06 Nov 2023 14:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r057l-0004c8-GQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:19:01 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r057a-0006HQ-BE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:19:01 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c5028e5b88so67775141fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699298328; x=1699903128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG34FRvELcoVg68kjiJlGSs8gWaZzLtMEhn0aubzvQA=;
 b=c14XLqUfJbuY2PAHO/B2cUVb55VrwiE3VDfE31z7pk29j5u+l3jSMNL51czah4x5W0
 tTjs9+bEIdm5opv1AcCSAnmDzdWHYXdDjakB47/oKhj0J5gnm2IBy+J77ITk36e01uqS
 WoXAfI7BEIjtGQTdWbyj4aYzX2cWSLMkBPjFSPOPth/5mYe2vf++o6jbMTjVPkh322mT
 zX3FVCT8S/Dw30lT5pKfZ4bgPFIvTeqJFkGczYBkH+2nL7NEJQWtKusutZrZlUowA8hE
 ZGC75x2YL78xXedsoAUriYPtlUqu38DoatuWaaG0IvsAiLzGCVQ/Dkjr9oigF2W+dY5V
 TvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699298328; x=1699903128;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NG34FRvELcoVg68kjiJlGSs8gWaZzLtMEhn0aubzvQA=;
 b=ut95sBLDJP0T17Thu1Ky2uU2WZSIYLgd/6CrgwnYxLMtMqN8a9wZUrM41qUrxlG52L
 R/owcobyC5qnl/paoqB77AB2wwT2j2HYvmInp8uEJpT7RjHnSevJvfZIIC8nMSLRJbbU
 Cjt+MMjYgr/0vn/msYuRN/70g0IoOUfozqzDuL2U+CmOGI7ZP4Rfevy2GDi9MZJSJrIS
 /QESoaVLrK3MwMvQUY/8as5lJUV9uUdHtQGahdAoDIlBSq7vBSTy46ioYL603b1VxI5+
 VcbkocfAk/bnM4hoJ44WsnF/1Gs5d8udNMLP7TEytSPRC66xJrafgOegZRtzmPUS0ZNC
 LryA==
X-Gm-Message-State: AOJu0YwXbDwCQ8sG+YtMjI6q252XpxnQpT9evaAAwALL+JY2IqrVbgbe
 4HyPztQMo51JDcOdaH8LncTQDw==
X-Google-Smtp-Source: AGHT+IECrCx04nZ0IoeAt21d+Lf41mIEw//3e+AayfW3nMq5OpDw85gtfCFlglta6Cz3wB4EfQsEGg==
X-Received: by 2002:a05:651c:19a4:b0:2bf:af49:daf7 with SMTP id
 bx36-20020a05651c19a400b002bfaf49daf7mr2732264ljb.42.1699298328040; 
 Mon, 06 Nov 2023 11:18:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x8-20020adff0c8000000b0032d9a1f2ec3sm370184wro.27.2023.11.06.11.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 11:18:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81EB765565;
 Mon,  6 Nov 2023 19:18:46 +0000 (GMT)
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
Subject: Re: [PATCH v5 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
In-Reply-To: <20231106125222-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 6 Nov 2023 12:53:39 -0500 (1 hour, 22
 minutes, 14 seconds ago)")
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-4-alex.bennee@linaro.org>
 <20231106121400-mutt-send-email-mst@kernel.org>
 <87ttpybxhc.fsf@draig.linaro.org>
 <20231106125222-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 19:18:46 +0000
Message-ID: <87il6ebsh5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, Nov 06, 2023 at 05:30:39PM +0000, Alex Benn=C3=A9e wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>=20
>> > On Thu, Oct 19, 2023 at 10:56:07AM +0100, Alex Benn=C3=A9e wrote:
>> >> Now the new base class supports config handling we can take advantage
>> >> and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
>> >> this doesn't require any target specific hacks we only need to build
>> >> the stubs once.
>> >>=20
>> >> Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
>> >> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> Message-Id: <20231009095937.195728-4-alex.bennee@linaro.org>
>> >> ---
>> >> -    case CHR_EVENT_OPENED:
>> >> -        if (vu_gpio_connect(dev, &local_err) < 0) {
>> >> -            qemu_chr_fe_disconnect(&gpio->chardev);
>> >> -            return;
>> >> -        }
>> >> -        break;
>> >> -    case CHR_EVENT_CLOSED:
>> >> -        /* defer close until later to avoid circular close */
>> >> -        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
>> >> -                               vu_gpio_disconnect);
>> >
>> > Hmm. Looking at this, it seems that the base device will handle close
>> > synchronously. No? Why isn't this a problem?
>>=20
>> I suspect it was a copy and paste from another vhost-user impl. But
>> testing has shown it works ok.
>
> Can you rebase on latest master then please? There have been
> changes exactly in this area.

Sent v6 to the list:

  https://patchew.org/QEMU/20231106191515.2801863-1-alex.bennee@linaro.org/

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

