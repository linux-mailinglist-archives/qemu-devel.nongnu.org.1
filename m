Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1F7BCE41
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 13:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpSHp-00044p-Ho; Sun, 08 Oct 2023 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpSHm-00044X-Kt
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:49:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpSHk-0005pH-Q4
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:49:26 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso647150166b.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 04:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696765763; x=1697370563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3cconwyIFv0+XYrTp+vRkHjfl3rpZz6yiX3/dmaz5I=;
 b=YnT+1QtBbh8biy5oBGuoXfaSkY9t4r09B5ZCFMdFycNKFUx9MSkzS0mewIAAkuc+6K
 Y1JkZfnsTP+w7p/306+eAlXROTh/K5ZN7K+nTA3gyNZHLa+0CujfEu+5p6B9aIvod8Kn
 UsHGPLbX5WYGeoLuMTmwp/33v6zrXQ8NgtaJDrAHVcr7EvItxJesc21CqzqHRf52Esys
 oCYOZvCgFoo5nemy+m+R1kPNxo+1wdUMbBPal5NOMXcVLu6suKBtlc849v2A16IrCBjO
 UwyeXFjUGDJUCX/TwIfB25Su2tENIrVBwYiLQra0ftbhRJHzJJbOMOLysOHZzgKBYruI
 UWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696765763; x=1697370563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3cconwyIFv0+XYrTp+vRkHjfl3rpZz6yiX3/dmaz5I=;
 b=gdf7X4p/OP6UP3smCUqL6cFWE8J1mT/5AC+5YvP9IVS9Qv+SyfPVgaHA6nYr8ZN+zm
 0uyAfyRfQgQOId2FP/5FfentXpw59UtY0GKWK2p2QlNnDpcMwep0lWpiFvf26hd2Ny7Z
 lv+p/QDXNz8+30ntanS5JnDDSyidjpA4glA4MrfWFsKQE7qtTRR2P2pCbpi5zCORF20I
 xPZklSq5yo2goj6EVw4MWVvC/noV2nbELHrs3JkWyGdBQzi2Xpk/wamFnFOFOn8sCQ5b
 SyLEkbE84K6briyWhpQI3x4bvbZ3CgfdJyW8JxcxtM1CCBupuHZau2Y3uB0gBOSNUdBk
 TbiA==
X-Gm-Message-State: AOJu0YwHXc2FVaI0lHOv8AD4I95LNGcJIYr4aGhVy2dcIZ0pYkDboKL5
 MGZGBkS18/g7puEptVDMSza7R5KsNkcNoqs6se4=
X-Google-Smtp-Source: AGHT+IHAx/8Z5m/0vKRIfVgxCkOPigDcoGU/ZYFmaiJ1u7SLV2a9+k+C16fgrHyYnW8qwTWlk4eagw==
X-Received: by 2002:a17:906:1ba1:b0:9a2:1d09:4eee with SMTP id
 r1-20020a1709061ba100b009a21d094eeemr12085443ejg.49.1696765762874; 
 Sun, 08 Oct 2023 04:49:22 -0700 (PDT)
Received: from [192.168.69.115] (4rc44-h01-176-171-215-42.dsl.sta.abo.bbox.fr.
 [176.171.215.42]) by smtp.gmail.com with ESMTPSA id
 l17-20020a170906415100b009ad87fd4e65sm5412914ejk.108.2023.10.08.04.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 04:49:22 -0700 (PDT)
Message-ID: <b1b95481-60ee-8607-2944-a7d595a17e3a@linaro.org>
Date: Sun, 8 Oct 2023 13:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/virtio/virtio-gpu: Fix compiler warning when compiling
 with -Wshadow
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20231006164508.536406-1-thuth@redhat.com>
 <20231008045425-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231008045425-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 8/10/23 10:57, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 06:45:08PM +0200, Thomas Huth wrote:
>> Avoid using trivial variable names in macros, otherwise we get
>> the following compiler warning when compiling with -Wshadow=local:
>>
>> In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
>> ../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
>>   In function ‘virgl_cmd_submit_3d’:
>> ../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of ‘s’
>>   shadows a previous local [-Werror=shadow=compatible-local]
>>    228 |         size_t s;
>>        |                ^
>> ../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro
>>   ‘VIRTIO_GPU_FILL_CMD’
>>    215 |     VIRTIO_GPU_FILL_CMD(cs);
>>        |     ^~~~~~~~~~~~~~~~~~~
>> ../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration
>>   is here
>>    213 |     size_t s;
>>        |            ^
>> cc1: all warnings being treated as errors
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/hw/virtio/virtio-gpu.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index 390c4642b8..8b7e3faf01 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -225,13 +225,13 @@ struct VhostUserGPU {
>>   };
>>   
>>   #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>> -        size_t s;                                                       \
>> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
>> +        size_t s_;                                                      \
>> +        s_ = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,         \
>>                          &out, sizeof(out));                              \
>> -        if (s != sizeof(out)) {                                         \
>> +        if (s_ != sizeof(out)) {                                        \
>>               qemu_log_mask(LOG_GUEST_ERROR,                              \
>>                             "%s: command size incorrect %zu vs %zu\n",    \
>> -                          __func__, s, sizeof(out));                    \
>> +                          __func__, s_, sizeof(out));                   \
>>               return;                                                     \
>>           }                                                               \
>>       } while (0)
> 
> This is not really enough I think. Someone might
> use another macro as parameter to this macro and we'll get
> a mess. We want something that's specific to this macro.
> How about VIRTIO_GPU_FILL_CMD_s ?

Or unmacroize as:

   virtio_gpu_fill_cmd(struct virtio_gpu_ctrl_command *cmd,
                       const void *data, size_t size);

