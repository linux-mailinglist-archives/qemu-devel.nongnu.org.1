Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F47C7E88
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCYM-0007My-VH; Fri, 13 Oct 2023 03:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCYK-0007MR-Az
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:25:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCYE-0008Fk-46
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:25:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so21534735e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697181935; x=1697786735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dtCZK8dBbcxuYHbsVWjjRmynwuPVyV8w8htevWks//4=;
 b=jgkmaK+rFNY67pZxbZp3xZuckehz/TEZJfupo4pJ0gATugk34yLnnrSQz3vVZv0gVA
 7bRDu+TXXC5rPKPQsRzTWoz1GbhpaiO89GVSWFZkzSs75IpNM+BPG6z9tunf3qPtmDuG
 cWpWVGc1oz/0RnfgjG3gVqzoO8fK1GScW72f5+Bu/ekxl0gpfor+RfZty+Sgum7i4X9F
 iIdkBklavf+ohhvyabQ9+49sR23AgFT4WZxtGaQAPnPaCR0rnIwBOr+oZWxokcLumngr
 rep80m+xbzRNvJkELGcZQZ9ICSdVO6Ycqkd2NKpPjt5kzQWahE2X6j5nvpyufdyLBeT8
 KWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697181935; x=1697786735;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dtCZK8dBbcxuYHbsVWjjRmynwuPVyV8w8htevWks//4=;
 b=ZibbUkh2J8QncyTpjy2NaNAha+OscKtVZXR4Tzl9N43X45WGF1S1vtfdYzgoXYEUZs
 OjTrG5LBi2G8cXz1o+u7uMWxAdqeRMP2B08i8ryhDoZYroM5ryuSbzVBULi6+Tjc/xNt
 AfD/Kg7fhW4VMH0wx0m/yU+X3uv/ouYrdANwm/CHo737vrj9W/aJ1mC2DzcMbGoMx5g5
 yEhZNcYprBc/lDmDrg5o5cgJ2cBfCeuyqYMJEwL+jxU9U/6t19MfgYUKDGShMeSMgSKB
 RxkJztsbSjuKYxIIAnfxvt9JS8LlOVnhSCbBDTtwhfaCKNgLLde06A7dwzANGtXA32VP
 mN8g==
X-Gm-Message-State: AOJu0YxY9Iw/K/0xr3l3Zi2ME4QXivY+2+eTqT1TqUTc9RQnoV1PsJvl
 h/EWAVYqjRvj9mZzmKSrFhnjHQ==
X-Google-Smtp-Source: AGHT+IFa85qIIdiTtMrNISDmY5oVzoCXJRqi4llBTWx7hsUgTGX9KRxJ+Q4Lq9sqcqlHf5iJGPxsiA==
X-Received: by 2002:a05:600c:22c6:b0:405:3a65:1b4c with SMTP id
 6-20020a05600c22c600b004053a651b4cmr827280wmg.6.1697181935064; 
 Fri, 13 Oct 2023 00:25:35 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b0040644e699a0sm1736790wmo.45.2023.10.13.00.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:25:34 -0700 (PDT)
Date: Fri, 13 Oct 2023 10:24:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 03/10] tests/virtio-scsi: Clean up global variable
 shadowing
User-Agent: meli 0.8.2
References: <20231009100251.56019-1-philmd@linaro.org>
 <20231009100251.56019-4-philmd@linaro.org>
In-Reply-To: <20231009100251.56019-4-philmd@linaro.org>
Message-ID: <2ghyk.0d8hmxqy8w5u@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Mon, 09 Oct 2023 13:02, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Rename the (unused) 'allow' argument, following the pattern

s/allow/alloc

Otherwise,

Reviewed-By: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

>used by the other tests in this file. This fixes:
>
>  tests/qtest/virtio-scsi-test.c:159:61: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>  static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
>                                                              ^
>  tests/qtest/virtio-scsi-test.c:37:25: note: previous declaration is here
>  static QGuestAllocator *alloc;
>                          ^
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> tests/qtest/virtio-scsi-test.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
>index ceaa7f2415..db10d572d0 100644
>--- a/tests/qtest/virtio-scsi-test.c
>+++ b/tests/qtest/virtio-scsi-test.c
>@@ -156,7 +156,7 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev)
>     return vs;
> }
> 
>-static void hotplug(void *obj, void *data, QGuestAllocator *alloc)
>+static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
> {
>     QTestState *qts = global_qtest;
> 
>-- 
>2.41.0
>
>

