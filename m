Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926AAC1012
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 17:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7yU-0003V9-JV; Thu, 22 May 2025 11:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI7yR-0003Uc-T6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI7yG-0002Tu-3h
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747928193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iEdSawLK5YISq9P3UfNvhblYeKj2QR21UD1W5pGO258=;
 b=YBlYpPlLB8Wq6YuHv3PgCN/ZN92wRZwKViB/CozJz8huQ9YSfbD2JF9iPWjKoe2HAVrCHH
 YEj2F7dRzpXdqnWdmmdcZAsrc0JOnSBv7iJjpBSBDviu/sz9NfUO26etPcH4ODnhsAG93I
 UOPHHFLPqcDN+gY3PhtJLBvE2AKeLYc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ZsKrDNOKOp2rMZ-2-tVxaQ-1; Thu, 22 May 2025 11:36:32 -0400
X-MC-Unique: ZsKrDNOKOp2rMZ-2-tVxaQ-1
X-Mimecast-MFC-AGG-ID: ZsKrDNOKOp2rMZ-2-tVxaQ_1747928191
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso32530635e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747928191; x=1748532991;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEdSawLK5YISq9P3UfNvhblYeKj2QR21UD1W5pGO258=;
 b=JzkdeqXosEXeWpNgaMh2iXGQMJQN5jfj/PEGAa5mqsuidLuELsfUNpv7/8bBwi6GnX
 K92r936uqIDFBnjsDyaeQ/tuRuQINKdXupf4eQPZkxoFgal7Zk+NdgXH0S/sFVjeV65V
 PTG+Vr+69BTUzqRd5+DYOUV7wV4gRvuCzCcLcwIaRaS2edu06eC2M/wMDZvRw0Go3b9a
 KhygeI1iJVrmbTyKnztBb1s/qfH0XX/LBfkvyA5S54yJUa/rm4cZLk+I9Yv0ATN/P4yK
 /PKbQ8e9PyLSyrWq2VvQthtLjwCKA7bR6QpY2dxhkyKnLXmZlIgtx0RdUnt8wrBapvej
 AmIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBBC9JNnfWFSNrkdWW/saReuhjQ2SoRGFT/PO/JFJyLehd+FopvbOobRKWmhRj90jLPN3QTMcdD4u@nongnu.org
X-Gm-Message-State: AOJu0YzwZJVV9AuuLJRTbdxcqDI7USFSWqtNWm6r0wV0bfjM/tV8Xayz
 5kBkD+Z5NUUFdJ3vPuyqCxkFMhjuSNAQNSfwAappij7N4NSXHwAvrfbgHANHTUb0ezzB4dF3t0R
 O4qwx8qW1TUf12kp3B5H8qDT1rYhP7821x9v3q8Fd3/xdz0JzoERHNcPQ
X-Gm-Gg: ASbGnctlrtTtHmhkUWrLQYzPazn9fNkWbJpS5euVmwuIUhHOiwql4ULLhmBoWOV5WS6
 RfsEVG+k9vVUo6eTRM6vIQBoWWBpgku7PuOoep4SAal+fwlE6LsYOJWdYhhmN2bvBDGFdlV0+kP
 sNjR92MaI8YAF3rdozBjcLiMY1AIyQJ2Eu2seLmk+HxO2dA44XJy4du4QQfiVQgyNIDRROGNJBY
 SjH9lyHTOp5HboaOhkKVogf55zip/pos85+FAaPnWERTKRPCd+WQrr6sAW9b+pKz0IiGCTo2/je
 LMgziTI9mbVM7DhYSpoRY/sHRhRfmv46vDfexEQw/PQuXyhnAw==
X-Received: by 2002:a05:600c:3e88:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-442fd6724bbmr272828095e9.30.1747928190820; 
 Thu, 22 May 2025 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOwcnCCJT7sjoqUgOX3PzqTKYr5wWuK5Ltb439qcCHLX2BXjfq5zESHGLJwa+MjiK9IucEQA==
X-Received: by 2002:a05:600c:3e88:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-442fd6724bbmr272827785e9.30.1747928190421; 
 Thu, 22 May 2025 08:36:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78aea59sm113089805e9.25.2025.05.22.08.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 08:36:29 -0700 (PDT)
Message-ID: <73d159e9-abde-4f97-8d04-4f8f8783975d@redhat.com>
Date: Thu, 22 May 2025 17:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 2/4] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-3-rreyes@linux.ibm.com>
 <f917f4f3-836b-4bdf-8dde-4d83cb226334@redhat.com>
 <38ba5741-e564-4812-87e2-ba6235e077b1@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <38ba5741-e564-4812-87e2-ba6235e077b1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/22/25 16:28, Rorie Reyes wrote:
> 
> On 5/22/25 9:27 AM, Cédric Le Goater wrote:
>> On 5/12/25 20:02, Rorie Reyes wrote:
>>> Creates an object indicating that an AP configuration change event
>>> has been received and stores it in a queue. These objects will later
>>> be used to store event information for an AP configuration change
>>> when the CHSC instruction is intercepted.
>>>
>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>> ---
>>>   hw/vfio/ap.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 3d0af7a54a..5ea5dd9cca 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>>>       EventNotifier cfg_notifier;
>>>   };
>>>   +typedef struct APConfigChgEvent {
>>> +    QTAILQ_ENTRY(APConfigChgEvent) next;
>>> +} APConfigChgEvent;
>>> +
>>> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>>> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>>> +
>>
>> Could cfg_chg_events be static ?
>>
>>
>> Thanks,
>>
>> C.
>>
> You make a good point, Cedric. I'm only using this variable in ap.c. Having it as a static would prevent it from being modified anywhere else
> 

Good. Would you have time to send a v10 ?


Thanks,

C.



