Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 448297B3A5D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 21:04:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmIlp-0005Qs-0c; Fri, 29 Sep 2023 15:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmIlm-0005Qe-Qn
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 15:03:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmIlj-0003Pr-44
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 15:03:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405497850dbso124991125e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696014197; x=1696618997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C2RrLFazV6CorvkOiaJ653GbpZ5qoTmRNtA8l7dGzUk=;
 b=Xi1NK7U6EKQyjQrhwtey9mDSbxCGhhbjyYxTe0zFRwqx1jUw48JdXajODv3KkqYE+R
 udOgIe1zjh9b7dJ2b/ZYQqpYHP0BrsPqAXCs0flMIceQUtomrK1jNhWWSrhi+jEWRFaL
 c7Vhl6fq45AhUG7rIscD/V67ljPpNTW18X+8jqxFuVdqzz+aZHD8e2YmHHdpbVaUWFlp
 73E2nwg+UwmlO+YJeZxf9+pkMjL4oZZ2qzbXIFuGZ87aMuJWA8Y1yEbcXe1Li2MxUuRq
 VCzngMkJgB7M1Wd0kd+R/fuVeABUPW2t52vlEtHe0RamnnBB/Gv1klPOdlUHKeY2ce3T
 Adww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696014197; x=1696618997;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C2RrLFazV6CorvkOiaJ653GbpZ5qoTmRNtA8l7dGzUk=;
 b=WNYRB44moDL6f8bexpCTH1V5Y1g0HUwS5BChYd5xFtMxsuzbYYGX4/+3E7qZiPqNAa
 6UajFG8BwQ2MbQb8qsaFPByMdShHV5z0eGB+uno2HQkIYqZ/pG/hhLWl2KfBHlZbS8d0
 EP6FE5Uzyss5JempBf160wHFEPVXfZgUy+qrBXW+TpJ0Lv55q8vudKGDh+VbnLf+iYHj
 LAcRTRZjmHZvL/qBfmFMVVD6atfCwGZJhEV9OwiLN74X31NubvHkZn8fuNIBfv7wYCEN
 T9k1wPgzphlBhlmvokFytt/jjQE1esqDdrZZtqK0ldOoyaNSTr+xOVRZHGjjcsHzUWPp
 lJpQ==
X-Gm-Message-State: AOJu0YwD1JdXx6hktLuv5KxiJmsW/56Kgy4Y1/DsTnCg+aF+KzcgU3ZZ
 avzdMgok7nWxykas0SlYc1koRPcTcSzku4MOzPQ=
X-Google-Smtp-Source: AGHT+IFE5VmB3CZrsgSfiTbpTtmAhzfcN7RVet5qDVeu8ef3i6BjyDzAyfoKoi/rnReZDakIDtUHTg==
X-Received: by 2002:a05:600c:2948:b0:405:3f06:c07e with SMTP id
 n8-20020a05600c294800b004053f06c07emr4450139wmd.15.1696014196800; 
 Fri, 29 Sep 2023 12:03:16 -0700 (PDT)
Received: from meli.delivery (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 n24-20020a1c7218000000b003fefb94ccc9sm1988975wmc.11.2023.09.29.12.03.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Sep 2023 12:03:16 -0700 (PDT)
Date: Fri, 29 Sep 2023 21:59:53 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [PATCH v10 09/11] virtio-sound: implement audio output (TX)
User-Agent: meli 0.8.2
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <4cbb908742ba1820d72ac60086460df357976ba6.1695996196.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <4cbb908742ba1820d72ac60086460df357976ba6.1695996196.git.manos.pitsidianakis@linaro.org>
Message-ID: <1rgxd.z1377ck6xsdb@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Fri, 29 Sep 2023 17:08, Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>Handle output IO messages in the transmit (TX) virtqueue.
[..]
>+            if (!stream->active) {
>+                /* Stream has stopped, so do not perform AUD_write. */
>+                goto return_tx_buffer;
>+            }
[..]
>+return_tx_buffer:
>+                    virtio_snd_pcm_status resp = { 0 };
>+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);


It seems I was too hasty to submit this patch. It does not build with 
clang on macos because it does not allow labels before declarations.

It needs the following changes to compile:

--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -1187,7 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 buffer->offset += size;
                 available -= size;
                 if (buffer->size < 1) {
-return_tx_buffer:
+return_tx_buffer:;
                     virtio_snd_pcm_status resp = { 0 };
                     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
                     resp.latency_bytes = 0;


--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -1251,7 +1251,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                 buffer->size += size;
                 available -= size;
                 if (buffer->size >= stream->params.period_bytes) {
-return_rx_buffer:
+return_rx_buffer:;
                     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
                     resp.latency_bytes = 0;
                     /* Copy data -if any- to guest */


- Manos

