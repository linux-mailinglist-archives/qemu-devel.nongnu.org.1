Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D782AD3F70
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 18:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26p-0001oT-OK; Tue, 10 Jun 2025 12:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOygR-0000ma-2w
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOygM-0003hM-04
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749560783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X/j4ArwQVR9KwvHinhtY6/Mtcbuh45O69MOpFOYHhDc=;
 b=EpiLxM1mihIwDLgz5SYuE1z0AIE8ojXmGuyiZ5KAq+K1eMFF9bSDuo9L+xTe6W+vlL1tNX
 9iJYWVu4cR5SycTiTtIIHICrHnTZVXNZk+7ZbW7P8Cnh/5fzA8VDJrUf8JA/NDRSLWV+3d
 m0kAhQL6WIJW/lLZdD5k+9esJKVGEZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-4XqtPetTMweq2w3vyysTEQ-1; Tue, 10 Jun 2025 09:06:21 -0400
X-MC-Unique: 4XqtPetTMweq2w3vyysTEQ-1
X-Mimecast-MFC-AGG-ID: 4XqtPetTMweq2w3vyysTEQ_1749560780
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso29482325e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 06:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560780; x=1750165580;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/j4ArwQVR9KwvHinhtY6/Mtcbuh45O69MOpFOYHhDc=;
 b=ZtsjamIdKQC2vqc7H7VeFUNTeL2pjbOp6K2FqbiIXFnhXXEtnoNLXB4eV6miB0PJhF
 CMb4i26QiJZrPcwmxMZjEq4xkR4A0Yku4ew+LDK+yI5C+TdV765ht7Cgh/j8OHRANahc
 z5tqWg3nZkMKkl2Mq0Zgtr4F3c+mwlK2Sn0yfuJJm/93Fm7QeBpyNhnDMkt73KFubmmC
 oBD5XD8dKLchjseuR03dTE2AJcDmEjNMwlFJyMmTmr5ElN/pagRVQCaRnt+shbTlKEYl
 R8PD3f45q2y8gP7m6lSGPqW4q9PI5Zp/wzNH4cLvmk8RYTS8pN3x17FafmhQLi2r8Z7g
 TVgw==
X-Gm-Message-State: AOJu0YyK0u4sz/5YyWfvbGwMIszVe9qiW4j9vlgrpX56hCv4kSP2GPUN
 /EY93FT2ljEK2qnJlje8O5+bt91Mk6PllJTux5GvSIDsC0zwBvG4qk9bdBOyLdxCIHu7XrV+pvo
 5KRjTJfNB/fYBUCBYCDoKuQ68VqJFD5StcVjRbaH53KtPTqR/OI8wfnVo
X-Gm-Gg: ASbGnctCLZY/Vafsyc+QekpByXsKueNPgV+FdrM60pJU0p22d52y+BrywCkBzppaz8W
 3yHLbk4KRizq4KI/6rP5Mj0vaRthIASrGzS565G/loA+nY2ltrWLI5jeHF72TWz0c5HYEhJmfKS
 K7UJAVZzOn0z9nBhkZBTXMXea+pPtyZZ+pgZMempTUO92qb1bgNexBnkGIgyRkUhlukHhsWVEI5
 1NyPf2Ef62/tvUxKP/kadr6Ikfs+F41ohmx0R04lLPsu+9RLG+dCB6Hd6v7DfFPrYDj6uQuqTnI
 8sHx2ORdu0XG2EfA0GPVAJ1i3EiK4+CdcGF5w8KN9BVEP0SHwL0DV+juEyCn
X-Received: by 2002:a05:600c:4f88:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4531cffd001mr34040215e9.14.1749560780224; 
 Tue, 10 Jun 2025 06:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRT3bHlDs46pF/FiM45Ti/L3b6JrGOczwXDNXxY1vgiJw/YyR/uXeFpqXmR/9kim6J57Xw2w==
X-Received: by 2002:a05:600c:4f88:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4531cffd001mr34039555e9.14.1749560779639; 
 Tue, 10 Jun 2025 06:06:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c73b8sm138205345e9.29.2025.06.10.06.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 06:06:19 -0700 (PDT)
Message-ID: <01dd63b1-ee13-4ad9-873e-93a44448bb28@redhat.com>
Date: Tue, 10 Jun 2025 15:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/23] vfio-user: introduce vfio-user protocol
 specification
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-6-john.levon@nutanix.com>
 <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com> <aEgA_U5SZiYWs__7@lent>
 <4cb65486-7443-452f-8c82-da16576c7e47@redhat.com>
 <fecc3847-02ed-46cd-9be0-900d39fea5e7@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <fecc3847-02ed-46cd-9be0-900d39fea5e7@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/10/25 12:22, Mark Cave-Ayland wrote:
> On 10/06/2025 11:12, Cédric Le Goater wrote:
> 
>> On 6/10/25 11:55, John Levon wrote:
>>> On Tue, Jun 10, 2025 at 11:38:29AM +0200, Cédric Le Goater wrote:
>>>
>>>>>    docs/devel/vfio-user.rst       | 1522 +++++++++++++++++++++++++++ +++++
>>>>
>>>> I think this file should be split in several smaller files. The
>>>> protocol specification part belongs to "System Emulation Management
>>>> and Interoperability" section.
>>>
>>> I can move it to interop/ sure. Why must it be split up ? It's nearest analogue,
>>> vhost-user.rst, is one file, and I think that's better for a protocol
>>> specification.
>>>
>>>> We already have a docs/system/devices/vfio-user.rst which needs some
>>>> care.
>>>
>>> My series adds this file. This is the user docs, including a device
>>> example, so independent of the protocol specification.
>>
>> ah yes. The QEMU documentation is a bit messy. Not your fault.
>>
>>> Please let me know what care it needs!
>>
>> sure.
>>
>>>> (and functional tests)
>>>
>>> Mark is working on them, there are some difficulties...
>>
>> Which kind ? This is important to have and I will be reluctant to merge
>> any support without tests. It is OK to merge a dummy device implementation
>> for the tests since they provide a good example.
>>
>> C.
> 
> I have a bootable test image available for testing basic functionality, however there are a few issues with the functional test framework: in particular the test framework doesn't currently allow logging of multiple VM consoles correctly.

What about test_aarch64_aspeed_ast2700fc.py which boots multiple SoCs ?

> I am continuing to work on this in the background, and hope to be able to provide an integrated functional test soon.

Nice ! That would be great.

Thanks Mark,

C.



