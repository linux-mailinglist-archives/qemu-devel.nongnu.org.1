Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FEB06499
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 18:46:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubinZ-0007tl-AB; Tue, 15 Jul 2025 12:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubiM8-0003KP-S2
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubiM7-0006mo-21
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752596290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CNUh0svRZ2Q06RSt8cVthOcqLfiFbwX5W3NbsN+5rAg=;
 b=i/C1kI9YxlZvbRqk6srN7H9LTHwMZTux/gOxQwpX4/Ja+7C5x6a8R1E2DT/ymU5qH9T8C3
 YkNYcdBATtj6TLHopNTxgbjYhPqvtdGzcWX6B7KbzLj7G0hyKk88xAR8uIjkQPoAnXXO2F
 WSw8RnDc3gNq3CbPFMl8g7UEPMlpTw8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-OUSVqgukNS--sCObeyjoeg-1; Tue, 15 Jul 2025 12:18:05 -0400
X-MC-Unique: OUSVqgukNS--sCObeyjoeg-1
X-Mimecast-MFC-AGG-ID: OUSVqgukNS--sCObeyjoeg_1752596284
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so16042f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596284; x=1753201084;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNUh0svRZ2Q06RSt8cVthOcqLfiFbwX5W3NbsN+5rAg=;
 b=lf80jt4pCaMA7iv+xIFynHUIp4suVx4knu0ErJDoj6CMAoGKf+pGwhvQ/VIkxBp52D
 OytGR3Ip0LnZbpctX5jqEC1AdD1YbNkLfn1aJZfQ7z8A3+L7rlStX8Ay/t8K+Trnl6rV
 Ui0x62U9ZrhPt706pe7zrK/Dfu3PIdqsme9G0jk4wvcEaLeFQZK0KKzWNK9CtMCXdcNA
 GB5NPPHuyWhLLc/mjDLAfb4MDG2+G4YUg5SooBw3yEkct0RXPXavQy7vXnQVWmRycVdH
 Rmw1RXJ8j30gq8WdCj3PQvnJvk/Al0LGI8fQKtH3e4kBGlh9b9B21a8azMd1lcmR6ziS
 3TPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeihxchfTmju/jkmkaXV72usqsvMhd9YuvAAR5OTlqyT9VO2rSOXIGri062EuvoPyuvNJx2gZe9V3j@nongnu.org
X-Gm-Message-State: AOJu0YwTxQYAqHMefCiaXVlE3reRQng02If329G2Jpc/9nnC9G5fwNUu
 b48jEkvslLA43XZYmj347nspvbfSDDQtcCuYhmgHRWopdojg7WautdPlQOaxy8FCXuXkZDRI/xy
 Ue2KpaajUCpY4HeCUilyFhSrdQ8lqPaBQ1JHtL/4VT86cuOF+ohQyuzL+
X-Gm-Gg: ASbGncvWcmhEBgwp6yqd4iqXu5O3Boqztm+CHbh1QD5PO4jeGE9IJpEf3CZt9GwBEEk
 7rpIn/kJjfIo0x4ep/+C4RUGezmvyPL9q2tsTRCES1N3dzKzoVGc5i5iCGARxWyTcfqXd09Qryn
 fNzHZTa8rk3xVPnn+okq2SAqRQbgn50jZyyN88eROf3tK0mG/72r4VwD2cxFdJkjPMkStcOwkVf
 yVM8xKq4F6mDysS6hluZcbARRVZOCClu2p5mvTZiMD1CmrlktPUC2+/b4PvdtIu+VCnclrZS4jS
 GkK3ZVH7FOrboSd3UmheA8dw6aK+jjF2ksR/078ET1tyvBLF0ysfcfc7lqabPouHXGujaTEEdk8
 =
X-Received: by 2002:a05:6000:2307:b0:3a5:1388:9a55 with SMTP id
 ffacd0b85a97d-3b6095201d8mr3048110f8f.5.1752596284038; 
 Tue, 15 Jul 2025 09:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJypmsiXdwn/NAR0ELKPLAna7QbUav+q4ZOjMzdT8iV7DOtiCfCx9rpwSmKr3/DdurXLVSww==
X-Received: by 2002:a05:6000:2307:b0:3a5:1388:9a55 with SMTP id
 ffacd0b85a97d-3b6095201d8mr3048088f8f.5.1752596283554; 
 Tue, 15 Jul 2025 09:18:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032fcbsm206750835e9.6.2025.07.15.09.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:18:03 -0700 (PDT)
Message-ID: <887d991d-a8cd-40fb-99f4-2c02b23eaa6a@redhat.com>
Date: Tue, 15 Jul 2025 18:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] VFIO multifd device state transfer patches for
 QEMU 10.1
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <cover.1752589295.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cover.1752589295.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/15/25 16:37, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v2 patch series of the v1 series located at [1] of the
> leftover patches of VFIO multifd migration patch set that was merged in
> QEMU 10.0.
> 
> Changes from v1:
> * Drop the in-flight VFIO device state buffer *count* limit, leave
>    the *size* limit only.
> 
> * Add a small target-dependent helper to hw/vfio/helpers.c to avoid doing
>    strcmp(target_name(), "aarch64") in hw/vfio/migration-multifd.c.
> 
> * Mention that VFIO device config with ARM interlocking enabled is
>    loaded as part of the non-iterables as suggested by Avihai.
> 
> * Collect Fabiano and Avihai Reviewed-by tags.
> 
> [1]: https://lore.kernel.org/qemu-devel/cover.1750787338.git.maciej.szmigiero@oracle.com/
> 
> Maciej S. Szmigiero (2):
>    vfio/migration: Add x-migration-load-config-after-iter VFIO property
>    vfio/migration: Max in-flight VFIO device state buffers size limit
> 
>   docs/devel/migration/vfio.rst     |  19 ++++++
>   hw/core/machine.c                 |   1 +
>   hw/vfio/helpers.c                 |  17 +++++
>   hw/vfio/migration-multifd.c       | 100 +++++++++++++++++++++++++++++-
>   hw/vfio/migration-multifd.h       |   3 +
>   hw/vfio/migration.c               |  10 ++-
>   hw/vfio/pci.c                     |  19 ++++++
>   hw/vfio/vfio-helpers.h            |   2 +
>   hw/vfio/vfio-migration-internal.h |   1 +
>   include/hw/vfio/vfio-device.h     |   2 +
>   10 files changed, 171 insertions(+), 3 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.




