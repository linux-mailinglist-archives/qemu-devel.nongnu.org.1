Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64BDA11F09
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 11:15:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0Q3-0003xP-PA; Wed, 15 Jan 2025 05:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY0Pz-0003wf-2P
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tY0Pj-0001rv-0J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736936057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Me9WQY6EBeV4wwEolMAXIhmUxCWUpgkVAiWnJ+WGn5A=;
 b=GNIU5q76dX94DU0weAOFIsw0Ra3j3xjpYqsXtbGZ4LCbRlE+ZJPz5DGMBKRda+3bXVkuFA
 psxg56CQIh8+1cXYnS99f48jp+ZTqvq58vSxs+WvZp1Sznvo/uX362BqO5NAtXJ5EDh5cv
 8F8xdrW4EfYzqGZuw3Vxwgqkxrwu0jw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-paUVVIG2OgyUXn1NTPkBAA-1; Wed, 15 Jan 2025 05:14:15 -0500
X-MC-Unique: paUVVIG2OgyUXn1NTPkBAA-1
X-Mimecast-MFC-AGG-ID: paUVVIG2OgyUXn1NTPkBAA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43631d8d9c7so3293465e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736936053; x=1737540853;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Me9WQY6EBeV4wwEolMAXIhmUxCWUpgkVAiWnJ+WGn5A=;
 b=LKmgLCKLGw7Yo0sUxE1f2uoHGOrqQB0g04BYDwR0GgQT1QNfaLBre9w6iC5PoENrRT
 Hdm+JfjVeWGOCm9z6ewWU+9HEZnUfxfTxa/hzS1T+EoIC4X7rogpHbn3v9snl0N7g19O
 igmFa7JTmA0A+vbZcN2tSAtk5eR7MlOXqyevYYlJIaxP4Ah53BPnxXZ9s80EG6e1sOYj
 OqRyJ4Yen5LpJ9FTizOR7VjGQkgq0/ZG9BnEfluhxHkaWzFO9r+drrMVTfojixUDcih7
 XxkJGCFbWxlcjFSgIswfKqWOs4oy53wTBLbMw1VNt1SYOj+o3YrkAqY++FHK/NAqEakP
 HSGw==
X-Gm-Message-State: AOJu0YxqczjUU4QnzrCS6enHY2agUv9nR99cZQjC7sqyxuVyIhSC02o3
 9ASSNEoJq/dhRzLFBt3UxezoRnXtbuT3JxllvExPAnWYKrtqBCUx/UQJoQkMTtToSz7zEl6TpFK
 RQJv95Wj10GpSBvFi+Kri068bKN/ds29QarIwm6SPngw1LecEcZtXj4Dbi2RWmPM=
X-Gm-Gg: ASbGncu26RzIwISaxUFejjU9YAeWTRuluci7dhxN2W4/4Pm0O+beWODLWq8u9TRmg82
 W7O8i8YQeVBNd3KZ3gcnRSuiISiTY67RLnFT0YXO3zLTVdz08Odg1k9gAd/W9tOIofWkLI1u0fv
 4oVQsLk5Up9v8Y3mYPIVSDK8pMF/M0j+oyh7m2YycJ/glx0TxlW3nGvOqvO2V7bx+LSoth91HNC
 123ccJPSqAjOHUT3GEInr+6CM2dfkGbD8OxUe0ldRVztGFmjsfh3vvD1Y8b
X-Received: by 2002:a05:600c:4c06:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-437c6a86b58mr17756265e9.0.1736936053435; 
 Wed, 15 Jan 2025 02:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUlQGFN224qrGoQhgJFBSJrA/2XZxUHpWk+JKYjYdrqzdiFC0XQ/W4fiLFT6f6ACcc1BpiIg==
X-Received: by 2002:a05:600c:4c06:b0:434:92f8:54a8 with SMTP id
 5b1f17b1804b1-437c6a86b58mr17756095e9.0.1736936053125; 
 Wed, 15 Jan 2025 02:14:13 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-437c74d8cddsm17781285e9.30.2025.01.15.02.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 02:14:12 -0800 (PST)
Message-ID: <9a0389fa-765c-443b-ac2f-7c99ed862982@redhat.com>
Date: Wed, 15 Jan 2025 11:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] rust: vmstate: add varray support to vmstate_of!
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-4-pbonzini@redhat.com> <Z33w1ykoafUl2WD7@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z33w1ykoafUl2WD7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

On 1/8/25 04:28, Zhao Liu wrote:
>> +    #[must_use]
>> +    pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMStateField {
>> +        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
> 
> I understand you checked VMS_ARRAY here since [T; N] has this array
> flag.
> 
> What if a Rust device just store a pointer to the array? If we allow
> this use, then it seems also possible to set varray flags...Then what
> about dropping this limitation?

Box can be added for that purpose:

impl_vmstate_pointer!(Box<T> where T: VMState);

Also I need to drop Option<NonNull<>> because of

             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
             }

in migration/vmstate.c.

> However, I also doube that pointer usage is bad; we should always use
> Vec.

Vec support is a bit tricky because the number of elements is not 
accessible from C.  But unbounded arrays are rare in devices.  We can 
think about it later.

Paolo


