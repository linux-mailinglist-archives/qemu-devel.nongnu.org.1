Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 677BAAD335A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 12:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOvyl-0006uW-4l; Tue, 10 Jun 2025 06:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOvyX-0006tp-Se
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uOvyT-0005BO-TV
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749550374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s7FOc2SY/YBaFoWfcGiJ4UIZ/gBq2K5p+rIbl8QyGTo=;
 b=R0a324l6+YmY0RQ5IHV/gtNpJ7C8nuk4j7O9hNtZXpE0na62hKNoFJGEAGlQYrcNid9HS+
 BIWN1hZqvIj0TuYp2U/VddP+84WaHCk+6WNSZQkDUwZHMWdyNfWk4riNa3MORyVoC2QQvO
 K8K+yh5yPXhXEkkRCCmY2FiQ4moYe/o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-ObVuM07WOgyqskWMWe_zzg-1; Tue, 10 Jun 2025 06:12:52 -0400
X-MC-Unique: ObVuM07WOgyqskWMWe_zzg-1
X-Mimecast-MFC-AGG-ID: ObVuM07WOgyqskWMWe_zzg_1749550371
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2528876f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 03:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749550371; x=1750155171;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7FOc2SY/YBaFoWfcGiJ4UIZ/gBq2K5p+rIbl8QyGTo=;
 b=NVGKk7zefyoZ5k3Lx1S8VwDGMBbT8IjvnmJ0SkCogXvwb2QWZR2SWBWzPOSYNsQtna
 l79DCWhbbBFG+VnDyJUNbNlKolIt9oI4JLZ+3VZcpXmJf3u6uSpt6t6zv2vzEDUcAwRF
 UH5BAnpXwWO4zDYs/J8VLl24G8A5IaT0NcFb8y5g0HTkU0XNYp0mHNRaU4FDayR5Z5zx
 NGTiGOx+4gug7G7e3qq63VmwaY61nrQ68tDBJyq3IUKgYU0EZnYKmUSF2otYpk32lbft
 0HiLpYNXksLSs+pWUHcIjNwl52DiZuzgZcRRq+daUfFLlHNFp2rEpUkqeo/dw6GkSUgk
 CbjQ==
X-Gm-Message-State: AOJu0YyApbqKdDo+Ho9uvfoew1bnKrLSrVQFCovXFyU8GovaG4U3Y/2r
 Dg1gwYCp3n7tdcYf35qDv595MXZcDshAJC8H05qXs3zE1O2Rzp2F7S5CSOeAIE0KdUfTs+ti74g
 YRyUnLBK8VhpjX2FSmxVXi7kkidvRnUzdZGnnYApS/hFdldveaQLngSfw
X-Gm-Gg: ASbGnctG58ghQscI4IpuyR9uhFkiX90HwXemKHdz+B63XqxTbg+Q7dWrEDzS/kHA8ob
 B90TbqtFocYNEHxZgpCdKsCSSytS6B/KL1nzHmBs5CPU/GnrO9PS8RvVBFvi0hqB0NRGpGJll95
 EqNPVCBU0QS+aDqVVzts7uPa6fRyIe4vwtyjIGVGyxrgi+ecCOfZyokS+ZB5NwuznfC0HReI4jn
 CqzzTbre1Lfkb3FecyU6TaS/u2qdsjG/7bhFtBaKIPi5A93QJ1cLoCTToBx7lpW2FG5aSTL225f
 vhV42SohtAzC5zGvWc4fK/CvKguwiPJ0N1d/tyIDjFg8i8kLCMCIr34OC8W7
X-Received: by 2002:a05:6000:220f:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3a5513edd39mr2507032f8f.10.1749550371440; 
 Tue, 10 Jun 2025 03:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLgcKL6oLcn6T1H50bQHegkl+PI0ggPEl9WiKUTTvcNMZri4+jlZ2lDZH0k9lSbIWhAw22UQ==
X-Received: by 2002:a05:6000:220f:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3a5513edd39mr2507012f8f.10.1749550371106; 
 Tue, 10 Jun 2025 03:12:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532436871sm11736334f8f.49.2025.06.10.03.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 03:12:50 -0700 (PDT)
Message-ID: <4cb65486-7443-452f-8c82-da16576c7e47@redhat.com>
Date: Tue, 10 Jun 2025 12:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/23] vfio-user: introduce vfio-user protocol
 specification
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-6-john.levon@nutanix.com>
 <ef16fe1a-92b1-4523-a214-08d90c844519@redhat.com> <aEgA_U5SZiYWs__7@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aEgA_U5SZiYWs__7@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 6/10/25 11:55, John Levon wrote:
> On Tue, Jun 10, 2025 at 11:38:29AM +0200, Cédric Le Goater wrote:
> 
>>>    docs/devel/vfio-user.rst       | 1522 ++++++++++++++++++++++++++++++++
>>
>> I think this file should be split in several smaller files. The
>> protocol specification part belongs to "System Emulation Management
>> and Interoperability" section.
> 
> I can move it to interop/ sure. Why must it be split up ? It's nearest analogue,
> vhost-user.rst, is one file, and I think that's better for a protocol
> specification.
> 
>> We already have a docs/system/devices/vfio-user.rst which needs some
>> care.
> 
> My series adds this file. This is the user docs, including a device
> example, so independent of the protocol specification.

ah yes. The QEMU documentation is a bit messy. Not your fault.

> Please let me know what care it needs!

sure.

>> (and functional tests)
> 
> Mark is working on them, there are some difficulties...


Which kind ? This is important to have and I will be reluctant to merge
any support without tests. It is OK to merge a dummy device implementation
for the tests since they provide a good example.

C.



