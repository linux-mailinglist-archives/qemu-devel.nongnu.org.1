Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA9A1B1ED
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 09:50:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbFNr-0002CF-1w; Fri, 24 Jan 2025 03:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFNm-0002Bu-5O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFNj-0005Qw-T1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737708578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VWKq5lt+btIUVKKKt8+LYjvKd/1E1dYR/tC8tsMUUUo=;
 b=cC4uPXv0aLsBmYBSuvHtnuejjW5n1qd71v++/oca0lXA+Mb04MuiGT1RGfAyQ9K/KAVtjP
 upZ3GCRJaqLfXcnrXHbJo5n6CI3F+NGccJ6HQftqFUZc0E6Y9tpHO9R7gPnxfQEtJkMDkH
 OIbliEKx6BGUWLAwjs7X+PRueU8z/Zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-UzMC4ZYfOF6dpDm5P9RIgA-1; Fri, 24 Jan 2025 03:49:36 -0500
X-MC-Unique: UzMC4ZYfOF6dpDm5P9RIgA-1
X-Mimecast-MFC-AGG-ID: UzMC4ZYfOF6dpDm5P9RIgA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so12585755e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 00:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737708575; x=1738313375;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWKq5lt+btIUVKKKt8+LYjvKd/1E1dYR/tC8tsMUUUo=;
 b=LSVX7YkRBqjjyEajFRTJnL9ykZQAk+Vf5mnyQMG4crbASfO65COkvsrNCyb4iok/Zn
 KyMNXIvyKOkQi5S8M+4mhKzZXeoarwbxMjqJBuL4H1Ooi6+jzpdartO1qVpZGpZms+CC
 SU5oCLTKpcd7eoxLZbMmJjzyMQuxisPtVQ3jwaiLS2UV1zCylWBUUOpxwMvWNOIjQD9c
 jooIXW6aIAGodSwXZPNnW7YSHN4gAStbEvHBCaXyH8rsHB/Ai5cWQFTFAUeqEW+6NBZw
 0SWjU3aGkXrDsolpQ3j5FFZjcPxkYw5NitoJOcJIxI9wAC+9N9zqpsNIEAiujSn4OLTb
 v9HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm9pxQbAze5JIJ3/t2DsgNL9MU3xiGmBHJCPW0Ye3JCWpc9Foh+AxqYiMUWV+HDZZx92+Q+SvAyt5A@nongnu.org
X-Gm-Message-State: AOJu0YxELMRGR+Vt4rA8orGH5WtsDEOm3BbDRTPTTmUJsp1kANRhELJb
 SjGosT8i9vK6Mj39rhkeHH0xUCckOIcqOkubiEKqTQNPNVtDRgT8wTbRVyJMhHaNgF/rNv2Z77X
 hWv5H0h/IL7O/Y1uadct33PAnS6OtJ5lT5jhsIAyqzMQcFB7faqjE
X-Gm-Gg: ASbGncvQETrR136zpHJHi3UCV5PQmPwyP9RuDSOhDZ7xPfj4UGCl8oNpHesQ3/oDsmj
 Et0i7Ob1EtoNhRr1ZQtUj7+Txkk7YcjB9LuJjLPPnfY4+SBWhnkv1tPkA5YiY800pBKQzgTQKqi
 32flExuDtDOGcGa9fTZTVyhGdnQ4VhXVBxgrOxaki6BvwyzMukGjjWsaxuC5HiDcIn02n5PBBMq
 R12dHn74DknOlFNOrLESDo/IcIk6X6dBDba6xoFj3tG/Lm6D9eu2rOsG5rp5w5w+85u3grNVziR
 45Px5FcLghElG9afawrdHXx7aat9BIMF
X-Received: by 2002:a05:600c:4684:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-4389141c420mr217048405e9.21.1737708575419; 
 Fri, 24 Jan 2025 00:49:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVLBwdv5P/n8qaOMbrwHfI0MAOja1HPio+988JVMQfx9ti3c0+lVvcZJa65UsaHISyWqKEhA==
X-Received: by 2002:a05:600c:4684:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-4389141c420mr217048135e9.21.1737708575094; 
 Fri, 24 Jan 2025 00:49:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9984sm18959965e9.28.2025.01.24.00.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 00:49:34 -0800 (PST)
Message-ID: <f8ce74c9-e4f9-40fa-8d58-c96f68aaed84@redhat.com>
Date: Fri, 24 Jan 2025 09:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: Eric Farman <farman@linux.ibm.com>, Rorie Reyes <rreyes@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-2-rreyes@linux.ibm.com>
 <f0213486-c0f5-4415-869a-99a851c8a4cb@redhat.com>
 <dd1b07c4-1b72-4051-acbb-d679d0a0f534@linux.ibm.com>
 <52b7868e00271d49baddd64432332859c8314d1d.camel@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <52b7868e00271d49baddd64432332859c8314d1d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/25 20:55, Eric Farman wrote:
> On Tue, 2025-01-14 at 13:51 -0500, Rorie Reyes wrote:
>> On 1/8/25 2:29 AM, Cédric Le Goater wrote:
>>> Hello Rorie,
>>>
>>> On 1/7/25 19:43, Rorie Reyes wrote:
>>>> This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to
>>>> specify
>>>> an IRQ index for signaling that a change has been made to the guest's AP
>>>> configuration. This is a placeholder for QEMU patches that use this
>>>> value
>>>> since it is a linux-headers update which includes changes that aren't
>>>> merged into the kernel.
>>>
>>> Is there an upstream proposal for this change that we could look at ?
>>> It is nice to mention related series in the cover letter.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>> Hey Cedric,
>>
>> There is no upstream proposal for this. It is an s390 internal line item.
> 
> Rorie,
> 
> I think Cedric was looking for the matching kernel code you proposed, which this QEMU series depends
> on:
> 
> https://lore.kernel.org/r/20250107183645.90082-1-rreyes@linux.ibm.com/

There is a v2 in the works, right? is that 6.14 material ?

Thanks,

C.


> 
> Thanks,
> Eric
> 


