Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A247916FE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8WW-0005Zh-4l; Mon, 04 Sep 2023 08:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8WU-0005ZZ-NX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:17:42 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8WS-0006ej-Ab
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:17:42 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bcfe28909so202002066b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693829859; x=1694434659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JTtM7XOZ1r/iBc4hWPftr7NRzFwdU9CwaJVGZA36fhY=;
 b=IKuR/nL6vJn+ph9y2JYEhG6QhBUnKg9PTjUUpM3MenZ8Ynbdm4GrqiljXun5mlxmh9
 6w+8IzAbNlqLCWs0Vh6tzqEbel9HSW1pFb7VmuBra9yGQVRjUMavkf+XVPl/ygvVxb9K
 W3RKJHaIHoHKMbvHJRdCTr7AvNNBI35lAUEK4MWwOScyczl37+r4nNyUjbTokjo2/gx9
 EviW2HdXdiS2b6/wODd0Qai1wQNpo3naBKHtzbm8W7xntPbOSeJlONfsILOZRIFTceMM
 w9Zujy0KJhiUqHd41rGwhA+rMlHsNNfZxjp/kcyfTTYTwpXH+J1xqhoXU4DD2b236feW
 ehWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693829859; x=1694434659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JTtM7XOZ1r/iBc4hWPftr7NRzFwdU9CwaJVGZA36fhY=;
 b=MaSltqnUyIq6JhNkmXcc2vKzmphx3hxPoLLdzeOqhChoMO3hMGqXoACrU+I94nqRa+
 ckS1ke9NSSiaLspahNF8Toyx9X7l97s3IiaylntVOajlSZHzyNSz904BFNjwRQHU8xqg
 6CFhtl2HRWog/irudXWMbZ0OcO+arKXA11EY3PVfe0ZTlVMmCkuevy3ktVOs1a4pold+
 EJQzEq4L7rqqFVM4cKI9LgnTuibIBs8/rWy8X7SSpRWO3KeWol9/M8NRKIgGtKEdpNfV
 j1RECZowh7fDG5hJCXLVD/0Fi3F/kKTS/EvJR1MH8X/FLuAuUOgrkDjhH9KgfGBQC/eD
 L0dw==
X-Gm-Message-State: AOJu0YyxD+N+jzXQPXVQjbW31J26lONX51Pi89RXnJ6uGrJFpOTQd9Fz
 F9qgzI/ZfAVjXI/aaxAVq5Axgg==
X-Google-Smtp-Source: AGHT+IE6dkpx9En4+Zf9EIqXar89zgsUq3+bWP2/QB7Hzt5InprNzm5O5EgkvdlHbNeHuVG5kDCrWA==
X-Received: by 2002:a17:907:2cc8:b0:99d:de25:89bb with SMTP id
 hg8-20020a1709072cc800b0099dde2589bbmr6651532ejc.0.1693829858705; 
 Mon, 04 Sep 2023 05:17:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a1709061d4d00b0098733a40bb7sm6063902ejh.155.2023.09.04.05.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 05:17:38 -0700 (PDT)
Message-ID: <837a910c-2f45-4aeb-0ed6-fd934e270e35@linaro.org>
Date: Mon, 4 Sep 2023 14:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "chael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr_=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R_=c3=bc_melin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6Egbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn_=c3=a9_e?= <alex.bennee@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <e3e57dd125611eeb5e563eb7fab8eb89194ed50e.1693252037.git.manos.pitsidianakis@linaro.org>
 <198a502c-d7bb-5e83-08b4-f29222dd4d83@linaro.org>
 <0gk8g.5plunv7mgoh9@linaro.org>
 <df5e9f4e-9985-6c06-916e-48bd7b7a2dcb@linaro.org>
 <0gmex.y2a8jrzqq435@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0gmex.y2a8jrzqq435@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 4/9/23 13:46, Manos Pitsidianakis wrote:
> On Mon, 04 Sep 2023 14:30, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> On 4/9/23 13:00, Manos Pitsidianakis wrote:
>>> On Mon, 04 Sep 2023 13:46, Philippe Mathieu-Daudé <philmd@linaro.org> 
>>> wrote:
>>>>> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
>>>>> +                           cmd->elem->out_num,
>>>>> +                           0,
>>>>> +                           &cmd->ctrl,
>>>>> +                           sizeof(cmd->ctrl));
>>>>> +    if (sz != sizeof(cmd->ctrl)) {
>>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                "%s: virtio-snd command size incorrect %zu vs \
>>>>> +                %zu\n", __func__, sz, sizeof(cmd->ctrl));
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
>>>>
>>>> IIUC the spec, this structure is in little endian, is that right?
>>>> So shouldn't swap various fields in this series?
>>>
>>> Not sure about the answer to this. Need input from someone more 
>>> knowledgeable in virtio.
>>
>> You can test running a big-endian guest (m68k, s390x, sparc64) on your
>> little-endian host.
> 
> The linux driver uses le{32,64}_to_cpu for reading fields, if there's 
> any problem then it would be with the host?

Ah right. Since using a BE guest is often simpler for most developers
than accessing a BE host -- in particular to test recent kernel -- I was
hoping this would be an easy enough suggestion.

Anyhow Linux swapping the fields confirms the virtio-sound model has to
do the same.

