Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2BA0AF62
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 07:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXE75-0000oj-2v; Mon, 13 Jan 2025 01:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE6w-0000oD-Np
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXE6v-0003L4-0v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736750380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dmvSsBQ65czULd4QG6FbEdUpqNR2FCcvLHCA6exd86I=;
 b=cyKSp7+TCYBWYPX0F/9APT9CxqHJ+u5okE8SvfUx5mLTjtwld7ACz68TcXkhx8r5H844x/
 8yX1Cy6ZFv5jPDClJ2ar5RlzslxuAm+JwNGHtTqkhqMQw0jhY6uAL4/qHEEfbPJ/FQTN9t
 w/9C7xgnlBtZIF2oloHTlFXZWZMXNwM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-GrL_EFn4PGugy20wbwILqA-1; Mon, 13 Jan 2025 01:39:38 -0500
X-MC-Unique: GrL_EFn4PGugy20wbwILqA-1
X-Mimecast-MFC-AGG-ID: GrL_EFn4PGugy20wbwILqA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3cef3ed56so3745879a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 22:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736750377; x=1737355177;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dmvSsBQ65czULd4QG6FbEdUpqNR2FCcvLHCA6exd86I=;
 b=lVMZ9Hu7slQRzWwUrnPqs8FC8hpl20ed2RIZPVglj3qdeLhDv2R0X5erPEEeW+jXNb
 RL+B6e7ouu+uE/bGMGCfe5oI8YuOITdEL8no4jg7XBCOYtkrfgkGfMreMPCEv/+0zKA5
 JqyKH/L7WkEKamADTj/YtJgmkkEG7OaFINgIdg9qwsjx2Tl7ZoKapsmaCm2grTaZwk50
 C8GBFvbUhEpWlqyDgssGdPFXGCWEXLAkezUhu6CGCPZj2RdJbYmnyK/ZcXmb04w8ERAl
 13V7mn8AxrJp8bmmxxv4BsW2kstQWMlW79Jicq1LG3xQFp8vk6JdcIlMb3QQliBQoCEM
 s/cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnDIICoqBubJ6jLLAV4YikRC9D2+oE2cwAlN2CPCzplQEmxr5eIxV9gHUhqpYn12Ly4mIlmUeiKlSO@nongnu.org
X-Gm-Message-State: AOJu0YxJkUxmp87hPI1X5hQc2e9tUEBTjyC9KiaiNBgignZAw/ip6IBu
 NRKuA/MOOVwaIkozMYic+4QD4bpVPZLKUH+lR10HhmEol02XtYiTpBnTbm7OXTOKxX5nTVGo2P4
 QzofGTbI4HfZD96rQ1x9T+gwXMr99cXObeS5GDY5qFou9vynZdLhx
X-Gm-Gg: ASbGncujzpcUT0UVZbPBGVlieZrYmHjs9wz0wSTMRlb9pbz1fC4z5w4Opd2UvQRn3yg
 5CyH3tGL4Y1yUR7f3p1/oiueYEDnA0gDXZoZaA4kWGGvFshZXmhuI5inWt7ns0WvcS5v+HlKFE8
 /x4T1wzuOWPR3vGu7WS5DIoVFs7Hd0TmKIQ31L0G1a9bqvomNI4rUIibjVY8sYj+5I0L1vlTExt
 uHA/GRoGxTTWZsKcnWbAgj3Gnlpgro7rrhK0m1tfZpA6tLJM+zN+GE8DniHJdRA6JsbJ4z8s9ET
 thYs9g+WYQ==
X-Received: by 2002:a05:6402:26c4:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d972e04ba8mr19117333a12.10.1736750376785; 
 Sun, 12 Jan 2025 22:39:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfY1/b6d9IJI0+riN5YTaoxIJ/zDhU4f0lF8CRWTjyN8O4so9RcOmJLSeNQGBXuN3fefmacg==
X-Received: by 2002:a05:6402:26c4:b0:5d0:cca6:233a with SMTP id
 4fb4d7f45d1cf-5d972e04ba8mr19117313a12.10.1736750376456; 
 Sun, 12 Jan 2025 22:39:36 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046d822sm4307055a12.56.2025.01.12.22.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 22:39:35 -0800 (PST)
Message-ID: <3cc941b1-b09d-4076-9234-9a385c762d3f@redhat.com>
Date: Mon, 13 Jan 2025 07:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] migration: Fix parsing of s390 stream
To: Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-4-farosas@suse.de>
 <35911935-6f5c-40a3-aa73-3586dfdf3268@tls.msk.ru>
 <de853776-69cc-4605-9f9b-e3a60964c3b6@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <de853776-69cc-4605-9f9b-e3a60964c3b6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/01/2025 15.29, Michael Tokarev wrote:
> 12.01.2025 16:06, Michael Tokarev wrote:
>> 09.01.2025 21:52, Fabiano Rosas wrote:
>>> The parsing for the S390StorageAttributes section is currently leaving
>>> an unconsumed token that is later interpreted by the generic code as
>>> QEMU_VM_EOF, cutting the parsing short.
>>>
>>> The migration will issue a STATTR_FLAG_DONE between iterations, which
>>> the script consumes correctly, but there's a final STATTR_FLAG_EOS at
>>> .save_complete that the script is ignoring. Since the EOS flag is a
>>> u64 0x1ULL and the stream is big endian, on little endian hosts a byte
>>> read from it will be 0x0, the same as QEMU_VM_EOF.
>>>
>>> Fixes: 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py 
>>> for s390x")
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> This looks like a qemu-stable material (if not only for tests), is it not?
> 
> This one, when applied to 9.2 together with "s390x: Fix CSS migration",
> causes s390x-migration-test failure.
> 
> First, it goes:
> 
> # starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/ 
> qtest-1137270.sock -qtest-log /dev/null -chardev socket,path=/tmp/ 
> qtest-1137270.qmp,id=char0 -mon chardev=char0,mode=control -display none - 
> audio none -accel kvm -accel tcg -machine s390-ccw-virtio-9.2, -name 
> target,debug-threads=on -m 128M -serial file:/tmp/migration-test-T987Z2/ 
> dest_serial -incoming tcp:127.0.0.1:0 -bios /tmp/migration-test-T987Z2/ 
> bootsect     -accel qtest
> Traceback (most recent call last):
>    File "/tmp/q/scripts/analyze-migration.py", line 704, in <module>
>      dump.read(dump_memory = args.memory)
>    File "/tmp/q/scripts/analyze-migration.py", line 641, in read
>      section.read()
>    File "/tmp/q/scripts/analyze-migration.py", line 477, in read
>      field['data'] = reader(field, self.file)
>                      ^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/tmp/q/scripts/analyze-migration.py", line 450, in __init__
>      for field in self.desc['struct']['fields']:
>                   ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> KeyError: 'fields'
> # Failed to analyze the migration stream

I think you need to backport patch 1/7, too?

  Thomas


