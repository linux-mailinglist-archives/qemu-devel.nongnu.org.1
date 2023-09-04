Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E083279159D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6ei-0007zu-2v; Mon, 04 Sep 2023 06:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6ed-0007zg-6h
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:18:00 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6ea-0002K5-QG
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:17:58 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so18138821fa.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693822673; x=1694427473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sgJpiZE6C8AYlcmSg1yXNke86TocuIxa1oO8uUdFeGw=;
 b=YTxw6rbbr50e6Oqzv4nAGgrpaPG6RaT9p4QMRNNGErWfPLW80n5vU99xu4wRu+fBlc
 /AkaidTzO4L6lhJhKFi4EdGZBRiiXllVcYiou27+wpIHXR/D7Fomtla2ehwbSIrIGccd
 RfkTzgfeGok+RYtVVvxVot9x6Lb6HGk1b/B5wwbJZL8Hno8Ef29lpr/jPqx0bDVCUJUk
 lhEa9SbxXgtugmnEWzaIGGlGT8AMTStdFU74wjJmrfAO3B0WP5pBKvgNEYQkGnTR+qPe
 yYvNP5njNAxk27koKlx4HlVJ6yFOMc/64PgVSDyhgcScjuAB5JMEDbNVP0leviY/6WeU
 QlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693822673; x=1694427473;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgJpiZE6C8AYlcmSg1yXNke86TocuIxa1oO8uUdFeGw=;
 b=N2reQX9bfkgkoEDjLWb0tnCaQgTQi8D4iBShCGK7RKq6km9MDH3581LBNh3jQ1llnA
 3bK2lmIVaAcihJN478R1laWR55C26ky/5AhrUjC+oWlCMJQ50ghJE5BPbjw6NGL2HIes
 h9QmI8UZjPwJwEt2v+B4nK1bQAFFccXbHb6cklrCaa56k1DzCNo1j9JFQbHx35SbOJ/z
 WTcj22S2L1CZ86XzJsGH/SKtUvFXXWYGsQXCJxjGpszZy95waGsOscThO6FubPYReoDK
 E1YdAl7GA0fz4hEe7/u0aFYVyDvfTQ3VQDsyENGaJP3dhkDI5dcdI97pGMJcfD1G5Qly
 lsug==
X-Gm-Message-State: AOJu0Yw31q48JUYklt28bDePk95ORKeViabsEahUrRFF8EnfMTPGqcWl
 TBRmKqDDfBxmu7figyCC2slHMQ==
X-Google-Smtp-Source: AGHT+IFlBPKhIT4LDGxjZ2QS2+gkC83oFtu3B8rs/B1NCmhyir4gEkttus5HuMJSjqn28JMZNSq7KA==
X-Received: by 2002:a2e:9996:0:b0:2bd:d4d:7fb6 with SMTP id
 w22-20020a2e9996000000b002bd0d4d7fb6mr7299006lji.2.1693822673552; 
 Mon, 04 Sep 2023 03:17:53 -0700 (PDT)
Received: from meli.delivery (adsl-194.37.6.163.tellas.gr. [37.6.163.194])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c215300b003fef3180e7asm16754857wml.44.2023.09.04.03.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:17:53 -0700 (PDT)
Date: Mon, 04 Sep 2023 13:01:39 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <4b115410-9c0e-96aa-2f62-e82b7897ede5@t-online.de>
In-Reply-To: <4b115410-9c0e-96aa-2f62-e82b7897ede5@t-online.de>
Message-ID: <0ghxq.3r60jgujq0t@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x233.google.com
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

Hello Volker :)

On Mon, 04 Sep 2023 10:20, Volker Rümelin <vr_qemu@t-online.de> wrote:
>All qemu_log_mask() format strings need a trailing \n.

Thank you, will fix it!

>I still hear a lot of playback dropouts. I had planned to look at the 
>playback code, but I didn't have the time until now.
>
>Compared to v6 audio recording has improved but there are bugs. When I 
>start QEMU with -audiodev 
>pipewire,out.frequency=48000,in.frequency=48000,id=audio0 there are two 
>either uninitialized or stale samples every 25ms in the recorded audio 
>stream.
>
>To reproduce the issue start audacity on the host and generate a 2s 
>square wave tone with 315Hz and an amplitude of 0.8. Use pavucontrol to 
>select the monitor of your host playback device as QEMU recording 
>device. In the guest start recording with audacity. Start playback of 
>the generated square wave on the host. Stop recording in the guest and 
>have a look at a 200ms sequence of the recorded square wave and notice 
>the wrong samples every 25ms.

We've noticed this and decided to fix it in the future. I think the 
problem lies when PCM release is called from the guest. Quoting the 
spec:

  The device MUST complete all pending I/O messages for the specified 
  stream ID.
  The device MUST NOT complete the control request while there are 
  pending I/O messages for the specified stream ID.

When RELEASE is received, buffers are simply dropped. This is pure 
conjecture but I think creating an in-device buffer could solve this.
Unless the bug is found to be caused by something else, I settled on 
accepting it for this patch series because it is spec conformant.

>When I start QEMU with -audiodev 
>pipewire,out.mixing-engine=off,in.mixing-engine=off,id=audio0 audio 
>recording starts but the recorded stream immediately stalls.

Can you elaborate? Do you mean you repeat the same process as before, 
but the stall happens immediately? I personally rarely get any drops I 
could notice, only one or two for many minutes of playback / capture. I 
also could not reproduce exactly the same behavior you had in the 
previous version. The bugs *were* there but it was not as severe. Maybe 
it's a hardware performance issue? Can someone else test this too? It'd 
be helpful.

Thank you very much for your help,
Manos

