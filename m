Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8427BD4FA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplOY-0006Y9-8u; Mon, 09 Oct 2023 04:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplOV-0006Xs-M2
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qplOU-0005J7-6N
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696839216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzh/ArdQ//HbMpIq9MAlaZjqYFnY009k76HcLQ74FCk=;
 b=UHtalar7Dk8cGIyOqzzLWhYNBQ6NBRRxT5MX5xv9YknWzYGXc+9CsFG0ddUsdg+suoty+D
 7+kkqoQ3OEf6SFql2Oq5vuv57yRv/9Xco13veAggI/vB7rZEH13ZYrjQDuraYiG/0o/2xy
 VnOAE53ELM0DnfN+pViIEohT8b2Blko=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-akWzbryDMv-QQVMk1vpfvw-1; Mon, 09 Oct 2023 04:13:25 -0400
X-MC-Unique: akWzbryDMv-QQVMk1vpfvw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77415adf76fso507158785a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839205; x=1697444005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzh/ArdQ//HbMpIq9MAlaZjqYFnY009k76HcLQ74FCk=;
 b=wDtSoNw++fjlImnWxfEMnDqGitUIjffwYbeYn4/pM25/P+KXexkZntYuhupS36R0Hd
 NhuDlwyi0sCvnd0WT7gMoIpNP4WItGLKW0rM7/HivlhsETJVLatAA7WXRU1G0sA9M9On
 qXOtcrqtZh1O/LA10UAGvZRG5/nd0+LIGFr1Omr0zZ+4zGPylfdBnGDFezhvRzZtF5nX
 ozOJ//tNljlRODe7iBGCa9DvKCCVWxkE9QG2nr4y2Utoq5Fb+zoAItMy0BhmDCCgSn9m
 Mp3Y6kcwO/lO6K4Pq5qg3oOIljhl/LJLAN4zsXaIpe5nSf9OhSsp6a7K8FQP6zCvzwbP
 WJPg==
X-Gm-Message-State: AOJu0YzpelqhMN6PgWTUrZGdyQwsIp6rLuC6IG9CwTV0mtHpYwQK6SFX
 tcjCW6ya7iYrRLlmK0VQf4C+uZUW1lJa+dQlfMfVTffzfdY5h/VdcMY5Z0nz7WU0PKzkE+0Tfdk
 7E1pRsOI0rJ75xyY=
X-Received: by 2002:a05:620a:404a:b0:773:b543:5989 with SMTP id
 i10-20020a05620a404a00b00773b5435989mr17927740qko.2.1696839205188; 
 Mon, 09 Oct 2023 01:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi2hzblkV+Zs1tuo4CQOkmqO3yyoPdVGx4TWXFOgXpQ7iDydNAW1Xr6MsPvg4JsTmIINKPiw==
X-Received: by 2002:a05:620a:404a:b0:773:b543:5989 with SMTP id
 i10-20020a05620a404a00b00773b5435989mr17927731qko.2.1696839204929; 
 Mon, 09 Oct 2023 01:13:24 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05620a120e00b0076ef2816ff0sm3357992qkj.16.2023.10.09.01.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:13:24 -0700 (PDT)
Message-ID: <a77ffd02-db1f-d85b-5253-6b9b51b75339@redhat.com>
Date: Mon, 9 Oct 2023 10:13:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/virtio/virtio-gpu: Fix compiler warning when compiling
 with -Wshadow
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20231006164508.536406-1-thuth@redhat.com>
 <20231008045425-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231008045425-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 08/10/2023 10.57, Michael S. Tsirkin wrote:
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

Sure, can do (also for the other patch).

  Thomas



