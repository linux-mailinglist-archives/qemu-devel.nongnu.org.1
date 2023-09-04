Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5F7916DB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AT-00055w-8F; Mon, 04 Sep 2023 07:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd8AB-0003tH-P9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd8A9-0000BC-G7
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c479ede21so1205337f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693828475; x=1694433275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HcKgmTmCcGWunmhSdCqcjhXbreVU/eaR0QL/etK7uWw=;
 b=u73SJSnBRKJhi+6mfthGrTkfdo3J9vCBI6SFkdsuNepelQYiFNxNHN/7pKNO4vNmY7
 vUJpd4rAi8R7ILMTBOfXhJ60/czgeYGgloMoOMKIN4CuO+xzQrqmlyX7xaZzgtfUuil1
 hjmOCoO1m8wWwzVQq1e8LXiX6Hb8+bY8KbMwDVcg25dfwbOYxq1KFHun4SKd7h/pDjC0
 pNUyS2QBwA7KN85A5szU/Su3LsGn/0PfpfA2mSo5XZqlmo7wX/i48V0ubOChyBiSHLoH
 RXYxufnXGsHHQZslA5yhHV8QXiiKZHQMLodmFoz8qudnsWrfRzV1teUWh4NM2741dS35
 ScrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693828475; x=1694433275;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HcKgmTmCcGWunmhSdCqcjhXbreVU/eaR0QL/etK7uWw=;
 b=WGdByrjGnJi1FcViGUJsesaGRrf1ggnZajx/xTF+bUwyky2mQ/fm+2tAmCUYmORpyA
 MYnq9jizCwWOw6v49tMDguLOk9A76iF1BgBr8pf+D/FKVQasZguv+u/2nDE3jQ9T4cvu
 i/EfCBqLlHb3HgpoHTpFEOJsbo+G6fCVq782ri5DFCIIMiOqCU85BAFvMmv7n7jMee6h
 A2J/kORBGlrVRxrx+34IUxXSCa1RXpNeBELzrSBBaBtAvMNH17zyHJzgAd+R+TbExJlN
 WIye9cd71Dbb8ftv1++uBfbbk5A39uRPzd/kRJtFL4sz/7Js9J4BPR8cA/9yWDuOVZgu
 2hEw==
X-Gm-Message-State: AOJu0YzqeyULoWGEjZ9CDOyZjmgLpjL8ErKpdv8Jw+6ZBtL4TNZUvtOq
 KzCx5yOS1sJCLj+2g+FSv+EgTQ==
X-Google-Smtp-Source: AGHT+IF0guqwP+mPksxe61f/f3Y9HMjqkIoi72U6PEtp/UY50+M6XMJ9Vc23v0b1zPO8TU71BVO2Dw==
X-Received: by 2002:adf:f2cb:0:b0:317:e68d:f862 with SMTP id
 d11-20020adff2cb000000b00317e68df862mr6622487wrp.37.1693828475492; 
 Mon, 04 Sep 2023 04:54:35 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fc080acf68sm16942567wmf.34.2023.09.04.04.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 04:54:35 -0700 (PDT)
Date: Mon, 04 Sep 2023 14:46:28 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "chael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R =?UTF-8?B?w7wg?=melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZEg?=v=?UTF-8?B?w6Eg?=g=?UTF-8?B?w7Mg?=,
 Zolt=?UTF-8?B?w6Eg?=n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
 <198a502c-d7bb-5e83-08b4-f29222dd4d83@linaro.org>
 <0gk8g.5plunv7mgoh9@linaro.org>
 <df5e9f4e-9985-6c06-916e-48bd7b7a2dcb@linaro.org>
In-Reply-To: <df5e9f4e-9985-6c06-916e-48bd7b7a2dcb@linaro.org>
Message-ID: <0gmex.y2a8jrzqq435@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Mon, 04 Sep 2023 14:30, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>On 4/9/23 13:00, Manos Pitsidianakis wrote:
>> On Mon, 04 Sep 2023 13:46, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>>> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
>>>> +                           cmd->elem->out_num,
>>>> +                           0,
>>>> +                           &cmd->ctrl,
>>>> +                           sizeof(cmd->ctrl));
>>>> +    if (sz != sizeof(cmd->ctrl)) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                "%s: virtio-snd command size incorrect %zu vs \
>>>> +                %zu\n", __func__, sz, sizeof(cmd->ctrl));
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
>>>
>>> IIUC the spec, this structure is in little endian, is that right?
>>> So shouldn't swap various fields in this series?
>> 
>> Not sure about the answer to this. Need input from someone more 
>> knowledgeable in virtio.
>
>You can test running a big-endian guest (m68k, s390x, sparc64) on your
>little-endian host.

The linux driver uses le{32,64}_to_cpu for reading fields, if there's 
any problem then it would be with the host?

