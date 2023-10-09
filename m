Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0F7BDAAD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:06:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpp1D-000502-Sd; Mon, 09 Oct 2023 08:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpp18-0004e3-6u
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpp16-0007KL-1R
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696853143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7HipwnD7mZzeF01bQBOZpKdKkUqoTw3zU0e9zcjkvM=;
 b=c1XL7UA876cCgJp08XScLO4lRdqkvIlalMGlS6LXc0C4IyzTpRbEYLwJxziZSEziTDyN2c
 Q7rASW2nZfIQrTfHv8yH6zdi6zRsjP1OgXwaICWL8ABSs1jEIiiXzwkMwsLKqlLC8Av2Bb
 BpXOD6/xybyeW0kcTazUlnuQr2H+WS8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-PgJ_lZYqPmyblk8fw_tAmw-1; Mon, 09 Oct 2023 08:05:26 -0400
X-MC-Unique: PgJ_lZYqPmyblk8fw_tAmw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65afa60d118so55895376d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696853125; x=1697457925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c7HipwnD7mZzeF01bQBOZpKdKkUqoTw3zU0e9zcjkvM=;
 b=obReq/1iUp5r9R6KQ7ONuuhemcfmztjH3PYbF7jaipapHnkvmcU/n5ADtbRQ+EweYa
 ZGjDO/FcoW2QOKPGch7g7uyD7TDkfkP+7DRspOKp1g4eQm4JnHTXc/WZublKF1rZx6Mv
 l3/bZUKKjVApfZvYFO7nLZuUgViEOsdIUO0bpqp0+soZhoeDbhnNeBV+i8PRAlOaBjju
 o+sgUT9F1SJtWxOD4I3cgJArg6wN6g0NpoIUwsECL2heuxvmqMYw1N/h8FYb9ka7DS8k
 eLQ6EEOetFuGoEgBrxIpszuZaQVudkZz9i8WbsGcIHx78x2Fo54bE6OGgiH7GAwAZuMU
 JA0w==
X-Gm-Message-State: AOJu0Yznn2qit2Qkus6i7vGAfr3BCJRyemLElVYzkE3Y/0hWKfBmsw0h
 vmt56RW/MuosNANJK1+sJ9edQRz9zhR+NU+1KHRVh+LIcH6FwG6Xwt6huabfnBTPx21Jag97amD
 D4UDGc8GdXC8cUlU=
X-Received: by 2002:a05:6214:b84:b0:656:3046:986b with SMTP id
 fe4-20020a0562140b8400b006563046986bmr13891874qvb.10.1696853125652; 
 Mon, 09 Oct 2023 05:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLNKDsRbz5lB3aFpWNdv+z2Nflh5QdprErlJWZpSIVQyRD7vjCoDz/mQY1KBCdaph0aHYWhg==
X-Received: by 2002:a05:6214:b84:b0:656:3046:986b with SMTP id
 fe4-20020a0562140b8400b006563046986bmr13891830qvb.10.1696853124705; 
 Mon, 09 Oct 2023 05:05:24 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 l17-20020a0ce091000000b0062ffbf23c22sm1685606qvk.131.2023.10.09.05.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:05:24 -0700 (PDT)
Message-ID: <59c76034-62d5-c94c-8b3b-fa206768ee1d@redhat.com>
Date: Mon, 9 Oct 2023 14:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20231009083726.30301-1-thuth@redhat.com>
 <20231009074333-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231009074333-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 09/10/2023 13.45, Michael S. Tsirkin wrote:
> On Mon, Oct 09, 2023 at 10:37:25AM +0200, Thomas Huth wrote:
>> Rename some variables to avoid compiler warnings when compiling
>> with -Wshadow=local.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Renamed the variable to something more unique
>>
>>   contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
>>   contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
>> index 509b679f03..654c392fbb 100644
>> --- a/contrib/vhost-user-gpu/vugpu.h
>> +++ b/contrib/vhost-user-gpu/vugpu.h
>> @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
>>   };
>>   
>>   #define VUGPU_FILL_CMD(out) do {                                \
>> -        size_t s;                                               \
>> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
>> +        size_t vugpufillcmd_s_ =                                \
>> +            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
>>                          &out, sizeof(out));                      \
>> -        if (s != sizeof(out)) {                                 \
>> +        if (vugpufillcmd_s_ != sizeof(out)) {                   \
>>               g_critical("%s: command size incorrect %zu vs %zu", \
>> -                       __func__, s, sizeof(out));               \
>> +                       __func__, vugpufillcmd_s_, sizeof(out)); \
>>               return;                                             \
>>           }                                                       \
>>       } while (0)
> 
> I think I prefer VUGPU_FILL_CMD_s or VUGPU_FILL_CMD_s_ - makes it clear
> it's related to a macro.

I have to say that I don't like that ... it's a variable after all, and 
naming it with capital letters looks rather confusing that helpful to me. I 
think it should be enough to have the underscore at the end here to make it 
unique enough.

  Thomas


