Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF23B1CA49
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 19:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhbX-0006il-90; Wed, 06 Aug 2025 13:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujgTV-00038f-GH
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujgTT-0003Nf-TK
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754495682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EIEji9Eqki5ALEg2qh1z0G+6HF4P5wC1eIhCXQwtZus=;
 b=YJX/BsUQLyqddoIReqj+sbNSmoMU8sAiXUPeT6wM2fZ+IZlvz+ZEH2TQo0wQ+oMj6YLpbY
 AUjk4TFFvcj8PWEaaUvnYtdEBf0i0IJ/Y8Mbpmi50q4+Lw8COFUbHmePrI/PmsSL4/t/uS
 XOwyAg3VMQfum9YCddMsBEo9yMkFr48=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-ptJAf4ckMQqGPD9-dtaQGQ-1; Wed, 06 Aug 2025 11:54:41 -0400
X-MC-Unique: ptJAf4ckMQqGPD9-dtaQGQ-1
X-Mimecast-MFC-AGG-ID: ptJAf4ckMQqGPD9-dtaQGQ_1754495680
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-458bb0e68c6so360815e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495680; x=1755100480;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIEji9Eqki5ALEg2qh1z0G+6HF4P5wC1eIhCXQwtZus=;
 b=cFSy+6EmB0s9HjYOUZOLj2yxKYkQQeswTE9FmCIbRVB7t+z6Qo8xMjMFSIFxxyxhxO
 oehUg0pzwg9j+lp1aeYv0BWlKJmhu7sgU0Na/fl5uNgkKRkEQJIUoajORdi/eYPmOTpM
 ++Pea1hlokmADwvnln4kHaaivmI0xjmzfijT5xlI/s7S0fitfGp5bv23sFTkUJqHRpCF
 UBhjBLK4s1596cGpiJgtv7WJg09Oxv+JfwYZWIeFc91klqdkncHQoawYLmbChJtY+prB
 vUQ9awyDqwTthIcKRfkDRxteV4SgnrNjbPkfe4bUCSZtp4f9C0HKh/fJeN5BWRfAs9+g
 hOgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnFLl5bV+9d0UbDmKP66EUy2YXnx+1jyuPNjKV+x/q9Qh8f+bjclEJ4lccCE0WiCWQxIcErM96CBKt@nongnu.org
X-Gm-Message-State: AOJu0Yx6Dm4uhS7Dk/kiIIYhmFBYAbBV5W2ibBQvTKbPfILZusbILjl+
 jDESkHH+xu757IDxuDvQiWJIFckIXjx8r4h0UP9Wf3Kgcba/8feoXVHGU6wTMcBNAwtnnapXSzy
 unh/ndDyw3bKT2WCA7qHGPF/QxzEYPVUQQ8n/0HBlGjSxyFkY0tEeqngX
X-Gm-Gg: ASbGncsHaQS4O/6hpg2oxKB70KaWxA+1d+007JD/AWARSsSdHHJB38ld5hrXEo33U1p
 A1oLljV/RzSSFTvzV6hJ1gso+U375pYSfnXbhGf7VdUm4q7/7GyYpaJLUkqNbG1D/lwjnlPnsZd
 xZe69c9vfEFr9C9XkMDHDlIL5/0OfgoTuVRKDjJKIkh/2kFnTUpDP6hpbswwuRV+4d7A0Rcg49a
 pK+SvmuWxGLHyW0x/ShfMnfpSl6g9rYj4kSLBdkU5iiDtH4chAUBNxXouBoXyflvFf7cMHt4qlQ
 roEW8OBYvWevFz8ZphLBHSTvTGM/2Iqn33tESYkS+TwuiXZRUHS8uG8ZxWmXIZyRRT6yU8MlErL
 XdE7+OZ3zQK94R0tc3BVBDwIgEjUr7SNRjxmJxL5bNnem9vGJWNjWLjiGLTXL3bm24g==
X-Received: by 2002:a05:600c:828f:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-459e92c38d3mr26933785e9.0.1754495680036; 
 Wed, 06 Aug 2025 08:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19szrNjTaOGDyRJz5R0orRkPYvA40KmDB+SLidKfDN7lk8B94unxT2sfnKmrZ9QAVy7F7sA==
X-Received: by 2002:a05:600c:828f:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-459e92c38d3mr26933515e9.0.1754495679576; 
 Wed, 06 Aug 2025 08:54:39 -0700 (PDT)
Received: from ?IPV6:2a01:cb01:833:e4a9:b423:d450:c87f:f1f0?
 (2a01cb010833e4a9b423d450c87ff1f0.ipv6.abo.wanadoo.fr.
 [2a01:cb01:833:e4a9:b423:d450:c87f:f1f0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5869cccsm61110435e9.17.2025.08.06.08.54.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 08:54:39 -0700 (PDT)
Message-ID: <0a634c90-847a-4b75-b36a-bca923527060@redhat.com>
Date: Wed, 6 Aug 2025 17:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2 0/4] vfio: Remove 'vfio-platform'
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250731121947.1346927-1-clg@redhat.com>
 <22bb66b6-998c-4cb9-a16b-386ff88bb197@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <22bb66b6-998c-4cb9-a16b-386ff88bb197@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Eric,

On 8/6/25 14:51, Eric Auger wrote:
> Hi Cédric,
> 
> On 7/31/25 2:19 PM, Cédric Le Goater wrote:
>> Hello,
>>
>> The VFIO_PLATFORM device type has been deprecated in the QEMU 10.0
>> timeframe. QEMU 10.2 is the time for removal.
>>
>> The last patch moves vfio-region.h under hw/vfio since it no longer
>> needs to be a public VFIO interface.
> "tout ça... pour ça!" as we say in french ;-)

It was not for nothing !

vfio-platform explored device passthrough on DT platforms.
It had limitations which were difficult to address without
common FW specifications to expose devices. The result is
neither good or bad, it had its time.

However, the wrong choice would be to keep unused code in an
upstream project. This would be a burden for the maintainer
and the overall community.

> Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks,

C.


