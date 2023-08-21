Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073278237D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXyBP-0007lv-UV; Mon, 21 Aug 2023 02:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qXyBN-0007ji-83
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:14:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qXyBL-0005DE-2q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:14:33 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3197b461bb5so2612642f8f.3
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692598469; x=1693203269;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D08Q4aa2DCHKeMMtvXnAJEjP0L4gTExLDraMT8Xh86o=;
 b=vVgr/1rlJV4oliKq6XEpswg2HkJ9x/fXuHi7gATZ38hQDlafuvtbn+Tv4BGPGRM9I8
 sGnwi9QytIEJ4Zx8y1SLs8dDCBlwAMHFX5BBmUpwqXstmRbIjdBD9kuxS2VSURW0jVNG
 HTSLchNRodeWhhRmwcwjap+KHHigUVfKn+F30v1kwjc+6UJw8cj3rYsM/3opXZFSVMPC
 vHLbkXLY79JWbnV51Bk+fmnlXFOCGl6dA+KqUk1m04K+2usdjLAz4OiYKrZcEPCQWu9+
 MnZvpc4KjcZlUc6xnK/Y98m3Cwy1T8UT4p7yLn/Ytb/QPA48IMv+KAwq28U4bHEF/Qxi
 0jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692598469; x=1693203269;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D08Q4aa2DCHKeMMtvXnAJEjP0L4gTExLDraMT8Xh86o=;
 b=LhFZJ0gv+mlisgHdvKGD4a9iy7r9GrotlHMuxTBUOuG7bPFPEsuSehgC/wJRxwL+CE
 DdU5pxXS95aqdYvITionJTUutaVw49pP6YsbiP4IErcQJuzt2mo3/Za3cQMEnwnHjnYQ
 cqLDu8o8yf3ROFjb46WBxUtjJG3kN12TFe9RFclDKGYdSONJDsVTlbpIqp8+GAq+e44L
 aXuaBrYVSSGIAp28h5VjNElck9MCmNtLTCi0WNe/vgSXYZD4cLdEZBQsRFMYS6o8wLWq
 TOfan6tDj9qOPkEnqfSnYmnFmOZ1pfkgEWuTraXzOe0XkK7tJCsr5e2dJjCGfaavUbqt
 K1Dw==
X-Gm-Message-State: AOJu0YyLW7C02+vdcfr6Bv6rMWVd1neHEWPrFH3b+EUjwsiFiy/1kNvH
 DI3McgRbi83D4zsQXuo5ynNhwQ==
X-Google-Smtp-Source: AGHT+IFrA25X5N/088807Y3C2QtmzTx4X+4Gcga2U1ndEmMzxhDjI/cUirT0+PRvSLL3f5rpHSqoHA==
X-Received: by 2002:a5d:65c5:0:b0:317:70cb:4f58 with SMTP id
 e5-20020a5d65c5000000b0031770cb4f58mr4105287wrw.63.1692598469386; 
 Sun, 20 Aug 2023 23:14:29 -0700 (PDT)
Received: from meli.delivery (adsl-104.37.6.161.tellas.gr. [37.6.161.104])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a5d644f000000b0031aef72a021sm5697273wrw.86.2023.08.20.23.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 23:14:29 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:10:33 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v6 00/12] Add VIRTIO sound card
User-Agent: meli 0.7.3
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <7d4e70f5-c930-e665-c0b0-44e3d8831743@t-online.de>
In-Reply-To: <7d4e70f5-c930-e665-c0b0-44e3d8831743@t-online.de>
Message-ID: <zq9c1.g47o7x4yagn6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

Hello Volker,

On Sun, 20 Aug 2023 14:46, Volker Rümelin <vr_qemu@t-online.de> wrote:
>I tested the virtio-sound-pci device. It seems the device works 
>unreliably. Audio playback has a lot of dropouts. I can actually hear 
>my mouse moving around. Audio recording with audacity doesn't work. 
>Either recording stops with an error or the recorded stream is silent.
>
>I'll see if I can change the code so audio playback works reliably. I 
>don't think it makes sense to review the current code as it is. I will 
>of course report any issues I find.

have you been having this bad performance with pulseaudio/pipewire? Are 
you using alsa for playback/recording in the guest?

I am asking because this was my setup and I was wondering if it affected 
the code I ended up with. For me I had normal playback, except for a 
short delay at first (maybe something to do with alsa buffer lengths, I 
am not familiar with ALSA much).

If you can share your guest and host setup you used for this I can try 
replicating it.

Manos

