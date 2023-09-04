Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8C791642
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:31:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7nI-00035Q-0l; Mon, 04 Sep 2023 07:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd7nE-00034C-Om
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:30:56 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd7nA-00038t-8g
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:30:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so1698746a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693827049; x=1694431849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1cJImKQYPuZWar6+eVvt2iM8UgFHQ+Tv9pbU2ZOLM3w=;
 b=uH59F5Eg1ucGO+k+aPy2JSYYD90n/fCDOzHpI1PCMr68NP6zhKJyMN+G8L0C8xnbow
 /AnOR3Qpj2FgN1MiZxDYSaIaT7/G39fFcAMQ2k5VkGNL5dr8F5jNOGBQglyqm7RG6LDW
 iT6InTC7w9m7sdOnjxH/Wz0pUQxtJMhwMdK6h7NO0B72HsJIl2s0BC26RcwuSNIdHNGk
 NwDMpntbSf6GnSU4YL0ztpw1XrhwFMKQUewrPskHNFb9/SweCFp9xCzzetmjGGbX56iG
 kq5azv9G3LIxrEfaxVdbXT3AHv0BBgAPTkt7SfvBsonH32DokcM5kUxExDb0+SUdOUpu
 lz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693827049; x=1694431849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1cJImKQYPuZWar6+eVvt2iM8UgFHQ+Tv9pbU2ZOLM3w=;
 b=bv78zQmlRU6MRxAeLEbJdWVpeOyOWKhXaUQNAnu9qbJ9n9sl8IJyIwiB584E1Zoi8J
 5rnnZDzmNCaGu9oi6jN/sTVWz4w2cF/pvdiR82fomBIYFgR1Rk7L1qucLsVzx3FDPACK
 DKHqWLJLQH0hoOSyxFXGg4Q9tesMHXUjhdt1+20ahBB8n6H+hP/s4Ertb8MroBqFaWz+
 mzELsaSvxOk0hiikYjEmVOVGFx2/DkimnqDDeCBS2gDi12S9MnxFC2/BWV2UEJSlydmi
 QO653rX2aNyrLYpPcmMN/kPEfo+199UfC7BQDv2ykipJG1++GRCx4uusMVVq149N1afF
 hkRQ==
X-Gm-Message-State: AOJu0YxVLS2EL55Mq5vMRj17GLfRp4kvdBn21dd2xPe0EDV1wFLgALbS
 xqs72eTV34yQ/5E5OfQ21KdfOg==
X-Google-Smtp-Source: AGHT+IHJY8zxIxvnDu0mrMMKkM9xBTM7af2bG3Q4pmKU3Iwr0Pk9lNyj4nxxg2uTrKg7EighYBV7Xg==
X-Received: by 2002:a05:6402:1f86:b0:52c:9f89:4445 with SMTP id
 c6-20020a0564021f8600b0052c9f894445mr3916848edc.21.1693827049560; 
 Mon, 04 Sep 2023 04:30:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm5666581edw.63.2023.09.04.04.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 04:30:49 -0700 (PDT)
Message-ID: <df5e9f4e-9985-6c06-916e-48bd7b7a2dcb@linaro.org>
Date: Mon, 4 Sep 2023 13:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 03/12] virtio-sound: handle control messages and streams
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0gk8g.5plunv7mgoh9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 4/9/23 13:00, Manos Pitsidianakis wrote:
> On Mon, 04 Sep 2023 13:46, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>>> +    size_t sz = iov_to_buf(cmd->elem->out_sg,
>>> +                           cmd->elem->out_num,
>>> +                           0,
>>> +                           &cmd->ctrl,
>>> +                           sizeof(cmd->ctrl));
>>> +    if (sz != sizeof(cmd->ctrl)) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                "%s: virtio-snd command size incorrect %zu vs \
>>> +                %zu\n", __func__, sz, sizeof(cmd->ctrl));
>>> +        return;
>>> +    }
>>> +
>>> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
>>
>> IIUC the spec, this structure is in little endian, is that right?
>> So shouldn't swap various fields in this series?
> 
> Not sure about the answer to this. Need input from someone more 
> knowledgeable in virtio.

You can test running a big-endian guest (m68k, s390x, sparc64) on your
little-endian host.

