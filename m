Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C27915D1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd72t-0007Lu-IP; Mon, 04 Sep 2023 06:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd72p-0007IW-Vu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:43:00 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd72l-0008Cj-Lp
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:42:59 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so178913666b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693824173; x=1694428973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MOZJzkZakFMckOaI4fXPgUEk0n7nzjmGUaJ5sMvdQtk=;
 b=eZnGz/rZC2VoYLiecuSrwXge0o91OBpldj5A2zEfcUINjvAJVHz+zZqmoxIVhKyWFM
 yc3dHTNGxKLKZ7Xazpy679l6W07j+8NP5RWjGd9KYecYLRA7YhIqqmMsKyxKlKmwBnEJ
 SkZxEYc5x/DE9swUITtXwNEqLzXNatP+3d93O29vItqp1jkiPUa5KJ0UrdlmyaZOI/Md
 3Ai5OE2WBemQ6dcAH4Hmb7lGO0LKSm+3BcFSF97IvoKOlamPblAnZeE8vHVW0B+ghvUE
 Z3elzi8N4Vbo7qF/s+O0h1TOzUQUczd07YtflivAG4ILZ8TLKt9zvHCMJR9G0KmSK+tU
 18iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693824173; x=1694428973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MOZJzkZakFMckOaI4fXPgUEk0n7nzjmGUaJ5sMvdQtk=;
 b=ZxphlxMDNKmneEx2y71ygC3BHmWntOSg1e76Lu16FoGF2G9bC6XkbLN57eZhje4Ghd
 QyeBQiW9uxEc50obeMWBd3cP8NuqP1tUmIJ4gR7FDbkqwtsNeZi3EqBCavFRR7ur4+W1
 XvkfIcAz2oQoewsY21Xw1bcCdMdznAkHTD+BfqIHa1Vvgnl41oflyjT7EuriAl4xx37G
 UY8V8x3XlshtUKLltR9UDoJCqLd2R1MNug35vCIAIV1Pa8KWkzTI988567JDSIkISbXq
 2RI4CdBJMVQNxkLAOIJ6O4cXjvMquzqfq8U/6GxGPnFArRQdq6mi8cB09B0nnn2xHj8J
 tJyg==
X-Gm-Message-State: AOJu0YxAXg4WBuyV1rfPB8IApkyG+yAd6fjADIjEXjZuu6HQv4EacHjm
 IaagSpmeMaSce8zA4em3HEZLag==
X-Google-Smtp-Source: AGHT+IEgXOMN+FFkI4j7xv9SbVYZNeITQuBn4QcZNpM4LAdwfZNESANAcbV29rcRmL0H81UD+0roYg==
X-Received: by 2002:a17:907:2cd9:b0:9a2:120a:5779 with SMTP id
 hg25-20020a1709072cd900b009a2120a5779mr6416125ejc.60.1693824173378; 
 Mon, 04 Sep 2023 03:42:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a170906365600b009a5f1d1564dsm5927328ejb.126.2023.09.04.03.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:42:52 -0700 (PDT)
Message-ID: <ac6f80a3-129b-ccf9-b1a9-822a382938e0@linaro.org>
Date: Mon, 4 Sep 2023 12:42:50 +0200
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
 <e5f5edcf-6a53-bf61-25cd-4b5ea6dd1d4e@linaro.org>
 <0gi88.o687yqrpqd24@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0gi88.o687yqrpqd24@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 4/9/23 12:18, Manos Pitsidianakis wrote:
> Good morning Philippe,
> 
> On Mon, 04 Sep 2023 13:08, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>>> +    iov_from_buf(cmd->elem->in_sg,
>>> +                 cmd->elem->in_num,
>>> +                 0,
>>> +                 &cmd->resp,
>>> +                 sizeof(cmd->resp));
>>> +    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
>>> +    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
>>
>> I have very few understanding of virtio, but I'm wondering here,
>> since this function is called under cmdq_mutex(), could it be
>> useful to batch the queue by calling virtio_notify() only once
>> in the caller once the whole cmdq is processed ...
> 
> In the linux driver (sound/virtio/virtio_ctl_msg.c), the guest has a 
> timeout for receiving the message. I found that if I did not notify as 
> fast as possible, I got timeout errors on the guest.

Ah, I see, 1ms per default:

sound/virtio/virtio_card.c:14:u32 virtsnd_msg_timeout_ms = MSEC_PER_SEC;


