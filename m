Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB397B6B7E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngNb-0002vA-P8; Tue, 03 Oct 2023 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngNa-0002um-84
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:28:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qngNY-0006h3-M7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:28:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-327b7e08456so1026412f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696343283; x=1696948083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m5XqRQp04AsH44pLV6Aa8BlwoHTiJuARREuFYewK/oo=;
 b=KhWuIZKNyHNwfsqLfk6AvtJKskA96tlvuSHCNQA1RipIGUK8or1iWj1J6puv62+m4X
 lsAparkz8ZF850lor90FSZEFLXOzUE9nrw1KOOjSEdEfNQa/wMuRDlkyTBGSwXwsaosH
 EnNFr4HqUtoYiq0TwSigCusyw635k1wwNn1ND4RO3zdz7C0LeHjlgdKaSVaHMSya8u6e
 beoKId4lItVUUVhep6dnqYVB0X0cNDi1xMW9sVEM0Oc7xdEEGXbQio5Ms+xkvtLw8/pC
 gfpxOPgwTh0fe21++vikCeLRr8B5aErk/KAvhDHeOdhnL+5yLfdE5Df67DgI31KlKyca
 3lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696343283; x=1696948083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5XqRQp04AsH44pLV6Aa8BlwoHTiJuARREuFYewK/oo=;
 b=jbZ1f0amOsg+CRSUT64C3ZK+9XiPv9vTxkW63JgKuP9+jUIW3eYEPGYhYCI3b3mdI7
 IQbgRUraoeGJzOjF/UuDjyMVaCKOmFz95oxYp7+hihbR5RFrFRVop8XvYAwLLeu18mhb
 Ixh09c2deY5dyhd0cuPqHkxsJaAuiJq6fAfUFx4Z3EOsU/DG5EZHUQAyVfIbls6COw12
 momZfFxTWhWxQFZV2bB7VpYoTawtnjgKh9fI4mpwGSLmHGtQ2VZPdsXZKrYEiwSVTEnw
 LLLHXk+2yjGuw/xKHSplEEGoghPcxb2MOuZcLkvs/UiWN6dVG5jZd8dlB/Ck22yehBaI
 FTgQ==
X-Gm-Message-State: AOJu0YzsLM1M0MGTMwy461M8Sbgtb+dDjfftZlCY7hoaJupx9b7oS0Z+
 e7hICcXZO/YFlxPbIh3ysvJOrA==
X-Google-Smtp-Source: AGHT+IEuppAHHSPKnCizCWmTgCnSkYygN2Cidkd+gRa5at1QsjwM33Uc91g86pjFJMv0jMHa5f9WTw==
X-Received: by 2002:a05:6000:1112:b0:31f:d3e3:a53d with SMTP id
 z18-20020a056000111200b0031fd3e3a53dmr13356229wrw.2.1696343282467; 
 Tue, 03 Oct 2023 07:28:02 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-246.abo.bbox.fr.
 [176.131.222.246]) by smtp.gmail.com with ESMTPSA id
 i15-20020adfefcf000000b00317f70240afsm1712738wrp.27.2023.10.03.07.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:28:01 -0700 (PDT)
Message-ID: <12d588b8-a276-4de9-cce1-82b473494c25@linaro.org>
Date: Tue, 3 Oct 2023 16:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v10 09/11] virtio-sound: implement audio output (TX)
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr_=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R_=c3=bc_melin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6Egbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn_=c3=a9_e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <4cbb908742ba1820d72ac60086460df357976ba6.1695996196.git.manos.pitsidianakis@linaro.org>
 <1rgxd.z1377ck6xsdb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1rgxd.z1377ck6xsdb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

Hi Manos,

On 29/9/23 20:59, Manos Pitsidianakis wrote:
> On Fri, 29 Sep 2023 17:08, Emmanouil Pitsidianakis 
> <manos.pitsidianakis@linaro.org> wrote:
>> Handle output IO messages in the transmit (TX) virtqueue.
> [..]
>> +            if (!stream->active) {
>> +                /* Stream has stopped, so do not perform AUD_write. */
>> +                goto return_tx_buffer;
>> +            }
> [..]
>> +return_tx_buffer:
>> +                    virtio_snd_pcm_status resp = { 0 };
>> +                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
> 
> 
> It seems I was too hasty to submit this patch. It does not build with 
> clang on macos because it does not allow labels before declarations.
> 
> It needs the following changes to compile:
> 
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -1187,7 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int 
> available)
>                  buffer->offset += size;
>                  available -= size;
>                  if (buffer->size < 1) {
> -return_tx_buffer:
> +return_tx_buffer:;
>                      virtio_snd_pcm_status resp = { 0 };
>                      resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
>                      resp.latency_bytes = 0;


Extract a tiny return_tx_buffer() function, which you can then
call in the 2 different places.

