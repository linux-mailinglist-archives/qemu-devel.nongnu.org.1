Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B127B6E40
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qni7C-0000ju-Db; Tue, 03 Oct 2023 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qni7A-0000jK-6P
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:19:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qni74-0002Gw-2E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:19:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso11850955e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696349947; x=1696954747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=22pgLXrfHfm/RuyGMk7LygGpjbQHwUWsKtrXSvR9SQg=;
 b=BH2Af+WJUZNE52nqtsrLE5DO3Ch0RAl1OkU097HTk0lMTVe3jXx0U/pczvam8bPDKB
 wUzPOKNwzhHi8TPMtuNe5qHWgAkZqQGbLu8tDGX6Vz+hM04WJLyJz9ZZ4/AZjt0tMvDC
 V9oAaJuOpZgfz04nEa2EUdEix6qPjKeezCqwdMTvB9c4+tBHFxNw+abKAcqC9dnXPJMw
 cKjn3luHl7t8RqWdKYeqnj5wjKkjKuyZO7mOoYX3RuInzb7x4bf3osfirE1ZrrNTNWqB
 Fc1pxyRHTr26IxhaGE8zYGOv7OMJg9BNnEM/6UU6QJJo3WQ87vc7pODoInrd5UQa41ja
 pAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696349947; x=1696954747;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22pgLXrfHfm/RuyGMk7LygGpjbQHwUWsKtrXSvR9SQg=;
 b=ihPvOGcK4uE/tCoukox+Jy4F88TC1s61rJ0LY71mIo0RlkC1Lg2BxO54nylf4/fSxo
 o4u0Q++NF1+FTqRncyGE+kMhj1yu0OGEKHzTx6OqpSZtkfqzw7sIQdbtL9E/Zi0fntq3
 XmbWBIrOhHPBWMSqAmtWnVS+vYavSZp1lRJ/A/LLCgHUX56i8EWI8Es5+lI5540pYu3a
 127Dp94hUkBXNibyeH3J+7RuaA3Ut59uTh6zOClywa/1HyqLfIQLpwuxr1cgYuFS7adu
 Vl66DPA6dcK06VooGUA2zvOLTbEqvvJa3Shtji3DM8Qow25V2I2b6xr9rwvKQJAfcbiI
 uCKw==
X-Gm-Message-State: AOJu0YxqmJlPMFmJ+uzVdWO9ZFo8Bp4hFNDUoHTzI3bUH/CRT8pZUbi+
 Kx+6Fy6195hODHoGm3HHR7tdhQ==
X-Google-Smtp-Source: AGHT+IGsdTe7zqOkuDCHm1SRSE/m0PCL3/z2eih3fOmC8KpOO+G+ZxqCaXTrDofkw54iBLBAclg4Gg==
X-Received: by 2002:a7b:c7d2:0:b0:405:48ba:9c with SMTP id
 z18-20020a7bc7d2000000b0040548ba009cmr13907202wmk.16.1696349947097; 
 Tue, 03 Oct 2023 09:19:07 -0700 (PDT)
Received: from meli.delivery (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c211600b004063d8b43e7sm9678334wml.48.2023.10.03.09.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:19:06 -0700 (PDT)
Date: Tue, 03 Oct 2023 19:09:14 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v10 00/11] Add VIRTIO sound card
User-Agent: meli 0.8.2
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <20231003101002-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231003101002-mutt-send-email-mst@kernel.org>
Message-ID: <1ynzs.rzef353l0yhq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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

On Tue, 03 Oct 2023 17:10, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>I hope you are also fixing the linux driver to fix this in a robust
>way, yes?

Hello Michael,

You can find pertinent discussion on the virtio-comment list here:

https://lists.oasis-open.org/archives/virtio-comment/202309/threads.html#00175

Fixing it is on our radar but it may prove non-trivial if it requires 
changing how the virtio-snd driver interacts with the kernel alsa API. 

Meanwhile AFAIK the qemu device conforms to the virtio spec in this case 
both with the previous version behavior and the current one. The change 
was made to compensate for the linux driver's behavior, not because it 
was previously incorrect.

Manos

