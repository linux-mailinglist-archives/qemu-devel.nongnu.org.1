Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BF79B7F0F
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 16:52:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XRb-0004dN-Q9; Thu, 31 Oct 2024 11:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6XRa-0004dF-8M
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t6XRY-0005uw-Tj
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730389840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JK4ii2m/JRazGr9tdncSLYx/ta/Sjz5+u6YvLYeTtsg=;
 b=LtnemjpxHLIlGOLGf9scIuy5FP1PKzDoYgFtO4Ab3dwzzhEWGJ0MvxSKZgQkwISHL5lC9a
 6kBRn9jI2qIcYEaJQmgITAeO+D1UtzTUbhv7DsHSx71judVYgCx7IPRDrmCQ+epW+R2BMn
 x1BgvR8WnZS/9/aEo9hoOq5nh7pvi9s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rhVVr_2CN2ilYCZi3J4uug-1; Thu, 31 Oct 2024 11:50:36 -0400
X-MC-Unique: rhVVr_2CN2ilYCZi3J4uug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so9067505e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 08:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730389835; x=1730994635;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JK4ii2m/JRazGr9tdncSLYx/ta/Sjz5+u6YvLYeTtsg=;
 b=mkeCS5pGcALL9ww7j6VRiB6wxgDfqHQX2bDTMajxEfuFHCw75iIyia4iO3jf96D9uD
 tgX0KDUH+gN/XDbdoTd3j8AHfwth/6MBEMeBi4O/GeEP/qar73/JvuwWTP33cRXpDpZ0
 oGyhtpYxbwy3EugPdXQfegtOK4Vghds78dUI+m3CVqYd2zSv25Hj32ptejrb9rHb7pWV
 Ep+iGVDyBWVmyO8BnGSQC6uxbBr8K2DhaB0cCBYhIbhv/KngGBVJoG+eTzQcFYlldL7+
 vcEbuxzhh/XKsCPN0NUlrZGUBH307DiRXo9up1HMUmuTgiEocIpchdE/ZE4rFULDbFjs
 v8+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7W8xqoW8xRs3y96YeR7q+wbixGHRW1DPyEZKrCvtQydaqucqh6OvA6Runu1F3uRlny3O52424yaCl@nongnu.org
X-Gm-Message-State: AOJu0YyjpgNJtxoq25QZpQckY+xbz0tyA9+2ANR4POqd1cLp2cc+eo1s
 jqH5rWcIktiwW8w5JkUtHPSCuUmSbAjrO/0yZeqK4YGjYyzTh/+7wxB4Y4LlgkXE69nnpreRri5
 u6sh2E6kMJhbyqqiS0+JgM74RsW6sx/ZzSpYKXE6jiRjdrnJdrmDG
X-Received: by 2002:a05:600c:3d8a:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-4328327e0bemr3263445e9.24.1730389834714; 
 Thu, 31 Oct 2024 08:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjgiMKhXiJn9vPyptg3bhuKfHp1F/mbKOqJEHDvWwOL5KGtMpy3kjlj9+HEZl1BakCseXKZw==
X-Received: by 2002:a05:600c:3d8a:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-4328327e0bemr3263335e9.24.1730389834404; 
 Thu, 31 Oct 2024 08:50:34 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-251.web.vodafone.de.
 [109.42.48.251]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e8562sm31449155e9.23.2024.10.31.08.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 08:50:34 -0700 (PDT)
Message-ID: <7800f880-d362-40b6-aaef-2085dcb78ad0@redhat.com>
Date: Thu, 31 Oct 2024 16:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/19] s390x: Add Full Boot Order Support
To: jrossi@linux.ibm.com, qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel@nongnu.org
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241020012953.1380075-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> changes v4 -> v5:
> - Fix a bug with per-deice loadparm support:
>      The machine loadparm is no longer overwritten by device values, which now
>      allows an empty machine loadparm to propagate to later devices even if
>      the primary boot device set an initial loadparm
> - Fix two instances where changes were squashed into wrong patch
> - Fix an instance where NULL_BLOCK_NR was returned instead of ERROR_BLOCK_NR
> - Fix an instance of logical AND being used instead of bitwise AND
> - Standardize all error values to be negative in all device type paths
> - Minor stylistic changes and code simplification

  Hi Jared!

Our QE Sebastian also had a try with the patches today, and discovered some 
non-working scenarios:

Try to boot from non-working CD image first, then from a working HD image:

dd if=/dev/zero of=/tmp/zero.dat bs=1M count=10
qemu-system-s390x -nographic -accel kvm -m 2G \
  -drive if=none,id=d1,file=/tmp/zero.dat,format=raw,media=cdrom \
  -device virtio-scsi -device scsi-cd,drive=d1,bootindex=1 \
  -drive if=none,file=good-image.qcow2,id=d2 \
  -device virtio-blk,drive=d2,bootindex=2

This outputs something like the following text, then aborts:

LOADPARM=[        ]

Using virtio-scsi.
SCSI CD-ROM detected.
Failed to IPL this ISO image!
LOADPARM=[        ]

Using virtio-blk.
Failed to IPL this ISO image!
ERROR: No suitable device for IPL. Halting...

Looks like the s390-ccw bios is treating the virtio-blk device as CD-ROM in 
this case?

Almost the same setup, first device is again a non-working CD image, but the 
second device is a virtio-net device - results in the same error message (so 
it's likely the same or at least a very similar problem).

Could you please have a look?

  Thanks!
   Thomas


