Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1767D227F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 12:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quVQn-0004tv-85; Sun, 22 Oct 2023 06:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1quVQk-0004tX-Eo
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:11:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1quVQh-0007eB-VZ
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 06:11:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1554094f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697969489; x=1698574289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w8JFUCot8S9eu44AKIhTfrXVeCLin4WSAbWUtGjztnA=;
 b=sC1QGPZ8REAJPLKe0PUyelzRZ4jkh1mlcTzVDwVYsdoGJG6wR3i9P5qt1eJsxa7KRF
 W4gqsTpXSVnXuiiNSIlr6ON1DKWMggWZ8WeAd/f0L4o5irg7zphHK0efPoaR7MVbUJ6Z
 6UCA2zkRt7k5oF7pToY/WDdqmlS/yZtAw+OUSfPyifDpelAwa/ZI+DX4c8nQmoAYEOUs
 8CPsLxCUkDPacNJ0z8fYLiB2AwY78x4gXYi4O3uTUwNhFYcM6ARbOJPsVSphXoJTZXz0
 Lnq7JYn24XnKp25kWdWvn6NoTSe1JWRu+rEzlCoiQf6rAuyaA1ysh8sXLj9T87I6rykU
 QLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697969489; x=1698574289;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w8JFUCot8S9eu44AKIhTfrXVeCLin4WSAbWUtGjztnA=;
 b=F8bAyA7SMno8eUg8KE9LRlLB/OcU73AYNl5LbofXvMy3QjDuD2KqeNUzj2IgLwfjJo
 6VQAdhaH8DeFdhDuvreLPEtSE96zuCsVjcEziFyhdGi8v5PT5SQcFKFPJ8kZjSCyixIF
 HPcGCBpY3c0xahm+nof1abihUjskkEPd6mG0efU+jdfyMsPoPf4RJFkRzQoBPIdRHvPX
 MWySuZhewtPbOV+SZ7BvwmCc9zJGxkyFUy+WgwTGGb3VOmOVecMcidA70IKzzl6NcMQB
 p2iMqgzTdsdqM3bVP0n/WERYGNeU/aUbH1dXoP34G88qIIXOmszlPVxRga9Bjm56ONi3
 v/lA==
X-Gm-Message-State: AOJu0Yw7nxZW01QClFO6jjHR7C8g+F6pMNpAJVVNiM6xRtumrQ9BLS8x
 +M3d1QzqbQr9YrGrdVVTDm9UNA==
X-Google-Smtp-Source: AGHT+IH+GyMgXZDKR3gwjIl4BEO9/O4v0mVLVIDvnWqcZRx1PXY/pNTeUHYn0xFnycCX2ut8A+qOqw==
X-Received: by 2002:adf:e848:0:b0:32d:a404:404e with SMTP id
 d8-20020adfe848000000b0032da404404emr4689096wrn.60.1697969489362; 
 Sun, 22 Oct 2023 03:11:29 -0700 (PDT)
Received: from meli.delivery (adsl-141.37.6.162.tellas.gr. [37.6.162.141])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a5d68cb000000b003247d3e5d99sm5368951wrw.55.2023.10.22.03.11.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 22 Oct 2023 03:11:28 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:58:44 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v12 02/11] Add virtio-sound-pci device
User-Agent: meli 0.8.2
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
 <f68a8f30642a95f2a64a943beede32815c43fcdb.1697709630.git.manos.pitsidianakis@linaro.org>
 <235cbc94-8de9-4960-bb4d-3d861784436a@t-online.de>
In-Reply-To: <235cbc94-8de9-4960-bb4d-3d861784436a@t-online.de>
Message-ID: <2xdn2.m5cl6s6mv22s@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

On Sat, 21 Oct 2023 12:07, Volker Rümelin <vr_qemu@t-online.de> wrote:
>the virtio-sound device alias doesn't work.

Yes, there's no virtio-sound alias hence why it does not work.

I will wait a bit before spinning a new version of the series because 
the goal post keeps moving forward everytime there's a new version while 
there is still stuff to address. If this is the only change I'd like to 
hear from Gerd if this is ok to merge otherwise, and perhaps I can send 
a new version of this patch only?

Manos

