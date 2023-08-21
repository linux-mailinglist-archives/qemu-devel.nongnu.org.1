Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C62E3782374
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 08:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXy6T-0005K1-44; Mon, 21 Aug 2023 02:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qXy6P-0005Jl-65
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:09:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qXy6M-0004Ld-P4
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 02:09:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fef2f05356so2505685e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692598160; x=1693202960;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2CikyQh+3tiAW4nK5STkJjfZ+hH7GAHtVgD/yjzgJfw=;
 b=l7Qfw5zJlv6hFecsieVAlA2/Hn3YPEOpLAyfZXbrS7xW8P2xLmbO1NvWwxm6OoEVd2
 tO0l/CW/gP0MYV4aEAn2v57iS6Lny0uNV2s0tvhZPlEffS6yChzJCWLMOwr0Kd8jlRJb
 lcvEt/id/YEN0MRvzdter5dQHl2iGhbFR/tC8/8f9eOg/ERZXMz5tCXAWOv0yXPZBAn0
 9Wr1ZfRXLTHWabgjYoaa+IoYAXwYSwN9j4Al5DnJcfqQntowSX4q/N5nOONuoMOCtcrG
 pGyWAKp2mRPhYiewmmZNvweNNRXeD2LlpkzEH6es9GV8KrlkZljvjtaqe6jU2rjaojDm
 PXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692598160; x=1693202960;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2CikyQh+3tiAW4nK5STkJjfZ+hH7GAHtVgD/yjzgJfw=;
 b=I3KN/45kW6t70fPV4lgQY7eGQ8tVVh5yiLfLST1HrnM6HujiMlPi6zhQEUb05/sYPk
 at+pgmGYsMkHUnueZnBqnI/y3oVWM8jVbomsHinh91eTt2K0NWjBx3eCI4EYErB+3haa
 Q/mGgnrMfMFzn/OLTEJ03/nXwEilP0Xg9aLfj9aNui+Qnacim+VseiUMug7FdMcFl9v7
 TM6ptroDbq3cSNKmM3FtoOC7MrTwl1beKnMb3OektEcanKXIqaj9mxFnjp1/XXNZhyUJ
 bdF0gU5ZK1HDXX8biVTIpWBfFTCYmLoVQbhCGeOXnHCUJNCo9xmlGHRZBvC6lnxaAgxU
 XeIQ==
X-Gm-Message-State: AOJu0Yy3i0RWl7wDs0MGGL62qeaJ/j+kqcl6Y7yblngCno+C/iCA/04r
 To64fZYrsWW5WKxwpq11Ev9o3Q==
X-Google-Smtp-Source: AGHT+IHwYCFp3HOCZU5zlWbsYAAmTENqSpSIkyPSdC8e6B39ir1pz7wbDA7ICwg56aarvvbSQgeWkQ==
X-Received: by 2002:adf:ef8e:0:b0:31a:d2b2:f28f with SMTP id
 d14-20020adfef8e000000b0031ad2b2f28fmr3903663wro.51.1692598160008; 
 Sun, 20 Aug 2023 23:09:20 -0700 (PDT)
Received: from meli.delivery (adsl-104.37.6.161.tellas.gr. [37.6.161.104])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adfe844000000b003196b1bb528sm11228163wrn.64.2023.08.20.23.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 23:09:19 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:06:27 +0300
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
Subject: Re: [PATCH v6 01/12] Add virtio-sound device stub
User-Agent: meli 0.7.3
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <86f98e0b7da6cf1a8b308b1e14400f66d18fd010.1692089917.git.manos.pitsidianakis@linaro.org>
 <f49650d9-f80f-bbbe-1c0a-4a42a6c6ec76@t-online.de>
In-Reply-To: <f49650d9-f80f-bbbe-1c0a-4a42a6c6ec76@t-online.de>
Message-ID: <zq93g.y1gwybb8v8l9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

Hello Volker!

On Sun, 20 Aug 2023 12:33, Volker Rümelin <vr_qemu@t-online.de> wrote:
>I think the virtio-snd.c code, the trace events and the Kconfig 
>VIRTIO_SND should be moved to hw/audio. The code for nearly all audio 
>devices is in this directory. This would be similar to other virtio 
>devices. E.g. the virtio-scsi code is in hw/scsi and the virtio-net 
>code is in hw/net.

This was where it was initially but in previous patchset versions it was 
recommended to move them to hw/virtio. I don't mind either approach 
though.

Manos

