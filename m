Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692A7915AE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6l2-0001AM-5Q; Mon, 04 Sep 2023 06:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6ki-00018q-05
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:24:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd6ke-0003hG-QH
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:24:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-402be83929eso12626795e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693823051; x=1694427851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uk396+0WQ3LQHUu863IzHDD9yguLEEYZ0PLtvh8nT+0=;
 b=HKj2Fjc7uKepnRApJAcL4AVdKsidd12IJ6a4Zb47OBovEEI/2ZKwI2ahfLPx485IHR
 CW9kU7D2K8A5N7DMQwzHSuy2HW1oKec0b+1LxoK88OhBNPDJLUSuxeHIuBH0tLrq+dwk
 XqQNqSEMX+w4tGuc1K9oZgBomPELyHHYMdcK4RwiU6HiKv9mU4NmGMaMkQwA3xitgctT
 fP2yi3e518OsA1mtgXKmUvqUDdFieKUJTUCxPy/eK9VWM2Yj3wByq5SK2viE1Lbl6SKQ
 HATHoq7yb/0SSfgB43yg3i/V61waxNNBcN7zRB9bt9xr8Q+AnX63oYmPKGXjWykQLRlJ
 6uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693823051; x=1694427851;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uk396+0WQ3LQHUu863IzHDD9yguLEEYZ0PLtvh8nT+0=;
 b=Nn5kUeNSZDA5PpWTYqzD/Bqd5fjZbSS8NV7SeTewAvFp+wRq5thiK7kfEt5EcUvoCh
 7YNc5sSTJOlqudxfPT/aoHsvQRXl6qyj1F8rFvJZIC8zQMauA38MZIvJw6XjVUTk+fY5
 AE8gPHg5XZWQakdUT3MyrczIIWn0z+6v30GxRSUIhZ8UEVTUVuaEH85xpephwP5/mwQm
 Civ6GdGES2t8K2DdJrh0AeRed20TssDgrkOjyFhkPJu4NYF98Z642AMuYofjhHrmUDNB
 siGEAhtrGRsiOig/zIYh4Po9L5OTp3TLNZbKZmtqXpWZ0+J8qeMXOmEBeE6kIEz+Mt+3
 dqrw==
X-Gm-Message-State: AOJu0Yx2wvfgr12rMJvJnvDc2KLzo5Xsl6avVlLBUnuKAmqHHKIjojqx
 yz7J1khYjPTJtD99djAX2fcTFQ==
X-Google-Smtp-Source: AGHT+IH4YQpQy/E0hGQnje/fHMDkZgjPHrJsNSfUxN/aV7b2YXdlL9FukNpo+OdGE4CJKapKMjjCJA==
X-Received: by 2002:a7b:c7d9:0:b0:3fc:1a6:7764 with SMTP id
 z25-20020a7bc7d9000000b003fc01a67764mr6193523wmk.16.1693823051139; 
 Mon, 04 Sep 2023 03:24:11 -0700 (PDT)
Received: from meli.delivery (adsl-194.37.6.163.tellas.gr. [37.6.163.194])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a7bce8d000000b003fe4548188bsm16794901wmj.48.2023.09.04.03.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:24:10 -0700 (PDT)
Date: Mon, 04 Sep 2023 13:18:42 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
 <e5f5edcf-6a53-bf61-25cd-4b5ea6dd1d4e@linaro.org>
In-Reply-To: <e5f5edcf-6a53-bf61-25cd-4b5ea6dd1d4e@linaro.org>
Message-ID: <0gi88.o687yqrpqd24@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
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

Good morning Philippe,

On Mon, 04 Sep 2023 13:08, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> +    iov_from_buf(cmd->elem->in_sg,
>> +                 cmd->elem->in_num,
>> +                 0,
>> +                 &cmd->resp,
>> +                 sizeof(cmd->resp));
>> +    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
>> +    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
>
>I have very few understanding of virtio, but I'm wondering here,
>since this function is called under cmdq_mutex(), could it be
>useful to batch the queue by calling virtio_notify() only once
>in the caller once the whole cmdq is processed ...

In the linux driver (sound/virtio/virtio_ctl_msg.c), the guest has a 
timeout for receiving the message. I found that if I did not notify as 
fast as possible, I got timeout errors on the guest.

