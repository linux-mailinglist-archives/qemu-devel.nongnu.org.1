Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8D767ECA
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPi9Y-0006rT-G1; Sat, 29 Jul 2023 07:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPi9V-0006qg-Rn
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 07:30:29 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPi9U-0001gb-EZ
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 07:30:29 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so29635345e9.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 04:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690630227; x=1691235027;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m9UsT2cOyEeIxawdE2Nodx9wt3WNuhrUH5k/+M4t62Q=;
 b=UkhZir2x9ir9uZ2YfGxomDAf3gB10CMq/sT0MFUFyM6WYTYqFkNhWgcXS+mc4ndifm
 R4N2wuxogeHADSja0KKHr1A4iSUOAYz48vs6ALlgPPiVsg4O1AR7sC59s3pZRa5rLgyJ
 32/EQ8nutCHRjsqx0sS6abquEAvSgg/1VyVDYwxszVa6LLrNitWpKOeoDfy1R/gVkie+
 A2O1q6Ak/V2VEpzLtUEKZK/uj7Ou2iBe3H9DUVRXstWnW529aU0vnKoQS0sNK41T9bct
 HpsEswRNDlY3EDj2FWnAWKWbSZW1fTWmNhWrRrDbZ5V58+PGXOnyoIyuN2g8hmN/kb4B
 /XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690630227; x=1691235027;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m9UsT2cOyEeIxawdE2Nodx9wt3WNuhrUH5k/+M4t62Q=;
 b=DihiXhnWC2eY1GhYIdSkQXWb/SaFpLTU0bWL7yyECiHPosorPFj4nCMxfu+T4oxTAe
 If2P38VuAAn7O9hDjKjh39rVNHie4AcckesT5xTJi3EqbeUPSH7NlN/4Cus3JAK0YT9C
 4N1ql06qgdxKE4GHwPGv86VbXMGt/OcRLu5UFFN5kJvcnUSMyg2o+Lg0LzWx/xdgT8r5
 jGq8a755i3FcH5izc7M0mMfTcy/aHTVeY5QK0jaO0GSBQ+TJ9uQitWeLVmpwNJbaCtED
 SFDEARUWUKJbGn7BgmI0gSyCahSI6ItITd8R5cgGHvGfHX/yCfz2MI8cjbBv8sWEA46W
 bgSA==
X-Gm-Message-State: ABy/qLbWBYiz7BJ/7CvtfChGmqRu/A0+/S9MmDH5k0qG42CrgXcgVN+S
 kPVZ+YzFDU86u/9iLtBvBst71g==
X-Google-Smtp-Source: APBJJlHX3GMB9C6ewn7q+QPWvuRxzckHxexnfLdvtRqILA2KiVJ5PoSfBnzJBN8GGzn3QkVyfTpYhg==
X-Received: by 2002:a05:600c:2307:b0:3fb:a1d0:a872 with SMTP id
 7-20020a05600c230700b003fba1d0a872mr3732644wmo.20.1690630226842; 
 Sat, 29 Jul 2023 04:30:26 -0700 (PDT)
Received: from meli.delivery (adsl-248.37.6.0.tellas.gr. [37.6.0.248])
 by smtp.gmail.com with ESMTPSA id
 ay12-20020a05600c1e0c00b003fe1afb99b5sm251234wmb.0.2023.07.29.04.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 04:30:26 -0700 (PDT)
Date: Sat, 29 Jul 2023 14:27:38 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Bennee <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v5 05/12] virtio-sound: prepare PCM streams
User-Agent: meli 0.7.3
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
 <19d95e841157a6a6d88e60e749025f487f010d22.1690626150.git.manos.pitsidianakis@linaro.org>
 <CAMxuvay5x2A1vu_0E4df+s3cSAkkFbH-FCFKbNCtKxE995aLGw@mail.gmail.com>
In-Reply-To: <CAMxuvay5x2A1vu_0E4df+s3cSAkkFbH-FCFKbNCtKxE995aLGw@mail.gmail.com>
Message-ID: <yk2mo.2jd1kyhx0ule@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Sat, 29 Jul 2023 14:00, Marc-André Lureau <marcandre.lureau@redhat.com> wrote:
>> +
>> +    s->pcm->streams[stream_id] = stream;
>
>Same remark as v4:
>Shouldn't it close & free the existing stream? Or return an error?
>

Hello, yes you are correct. I missed that comment on the v4 reviews :)

Will send a v6 with a fix, I will wait a bit in case any other patch 
gets a Reviewed-By this time.

