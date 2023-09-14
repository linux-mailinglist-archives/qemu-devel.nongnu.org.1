Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B47A012F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjC8-0006sb-LW; Thu, 14 Sep 2023 06:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgjC4-0006sM-HD
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:03:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgjC2-0005rb-Qp
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:03:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso5110975e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694685803; x=1695290603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=z3fsj11AVU6SnD0ZPRjyi3XjR7+z19MVYiMVELU5ioI=;
 b=wQJaK6jO2Hzx26+WCesGcvm4cE/bzoVWG6xIUwYuhpkpNrmZ1xZP2Xa3m4cnUAKq1M
 H8Lm1YhA0Z0SNX1+nO6F3uj2qU3Rx8iP/xlIkwez3VAJNjo7odRLdSlPcRvn6S9+VJEW
 uGFOUNYInoQTJTM5nbhoDhuUkf5+m5mFpXihx/U04cHy3tmkn7Lf3tpwXmj8GkIt6Gmi
 0QgENlTNoqPbj2icJ1Ov3RW95WZbx/BshM4tv6wPH1k25o0mWUMM/Xn3m9PSlqyH6zar
 15goYlyf+CWHOG0QI6wLruIK8Rf1pdqIkQK/42DKRb56h03hcRhwFPgMH9Go40v2ZygE
 f2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694685803; x=1695290603;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z3fsj11AVU6SnD0ZPRjyi3XjR7+z19MVYiMVELU5ioI=;
 b=wUpXEGpc8Li+dqDGjaxSVD8vpVAdMpfzeMXtl/T6lCdBfIEKGtI/CUN62b9W9UePD+
 Ialcum5pGj0Gd1C7HpdBbXDFQPIW6LrDQ73OmeTm4EIyHpu/B3L7OMFNTjXJuFP06RJL
 XhYaKgvvntssmb/B2KAo17ifhp2gSA4WlaZo4dgVgsD/Dbn7/k+rSC+EnrOlMzwhGq+F
 zJFtqqhHmzJwSSLMjB/ANfqHdHR9pL3DnUCuHJi5DDj4PkWcGKhIUCYu9mfKSsuR5dN6
 nXHhfAffLSpIgIivasBqY2AAZxYK6n0TuMnsRDYLGkdGyLz9LG3jUn+E05/lAr4wCh5P
 0E1g==
X-Gm-Message-State: AOJu0Yws8nIotawz/K/XiRFIy3ji++8UhlbhDylFyYhvmPnbpn1NwyNn
 gpNLL+rsGU1wf6mBhPPmZxAmDw==
X-Google-Smtp-Source: AGHT+IGZonbeukA/amzJww/6BgJycvhllOioJaIjGG9BKuVEMHC3/3ySzFy8GiU3jDi3YdJscb7bQA==
X-Received: by 2002:a7b:c847:0:b0:402:ea8c:ea57 with SMTP id
 c7-20020a7bc847000000b00402ea8cea57mr1013594wml.7.1694685803305; 
 Thu, 14 Sep 2023 03:03:23 -0700 (PDT)
Received: from meli.delivery (adsl-98.37.6.3.tellas.gr. [37.6.3.98])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031fb91f23e9sm1333967wrx.43.2023.09.14.03.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 03:03:23 -0700 (PDT)
Date: Thu, 14 Sep 2023 13:02:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
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
Subject: Re: [PATCH v9 00/12] Add VIRTIO sound card
User-Agent: meli 0.8.1
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
 <2gm4wkfnjopd7l5zvzepzknl4hfomkxvtgvw72daazne2n34wy@fgqmh3mi3r5l>
In-Reply-To: <2gm4wkfnjopd7l5zvzepzknl4hfomkxvtgvw72daazne2n34wy@fgqmh3mi3r5l>
Message-ID: <0yzxl.gd0zk711fja@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

On Thu, 14 Sep 2023 12:54, Stefano Garzarella <sgarzare@redhat.com> wrote:
>We are seeing something strange with the virtio-sound Linux driver.
>It seems that the driver modifies the buffers after exposing them to
>the device via the avail ring.

I need more information about this bug. What is the unexpected behavior 
that made you find that the buffer was modified in the first place?

Manos

