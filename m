Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B689EE252
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 10:12:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfDd-0001Jn-1b; Thu, 12 Dec 2024 04:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfDN-0001Ix-MU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLfDL-0007gR-El
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733994628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/x8X7Pm93eP7Vhx6RXSbloXA+topfP51f9yhV9IolxM=;
 b=I5Q6OstFL2NWlbu+P99Y44C8KPryZeDBRhVrxPw8Lz+85TzYdXhCFUBHX9Srz2utTOfhN8
 rxVOpREEiNXxwDYh84WyaQJQJJsKRtbvfusiwuR9JRbXq5mS8c5JlliRlEbnzeluFPjqxE
 7InKYaXAUrqACZ9X6qLRhz3IDvxjfSA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-Q1dU3vMtNAuko8CdP7NwDg-1; Thu, 12 Dec 2024 04:10:27 -0500
X-MC-Unique: Q1dU3vMtNAuko8CdP7NwDg-1
X-Mimecast-MFC-AGG-ID: Q1dU3vMtNAuko8CdP7NwDg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so2100025e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994626; x=1734599426;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/x8X7Pm93eP7Vhx6RXSbloXA+topfP51f9yhV9IolxM=;
 b=hgW3OvXA5mSVLOJK5a11GhdlugGqaQojgTAv5Moawnx5YHpP8QjcNfFOql+zPioXQA
 agF6v4Dzu+S0utUk77dUt+kMc2Ul1/ClScU2CJqCmXmuoJW1zsTE/t+7KZltOMXW3y09
 qg0HWbJ4TFJVJZLIsz3gEf7Zq3tjt+Ay0ypn0yailWu5s+icAMIw/y15ja82s2tdNoFj
 zliAsR9DtY4oPYH73s+xWG1NRqMWMaVNfMCYOIhxGJKrnDLw5gv+WhMZm99l4XNZJmZk
 YCstMGUwXfbdLKkZKh/6Ah8KKe4PTnw8cOT4a91dZaIwvpC70UplbphrrKXHlwb4uvaV
 OqRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5KqiByQAre5i2u3zVPxovsj9VNmn0oGYZ57oxZGeBWLau395id4io2FNVtga3PdknNNUmprJozeDF@nongnu.org
X-Gm-Message-State: AOJu0YwFEiBVeDXDEVkiI0MJ0dSRrMkmaE7yzUwFN6IYt/0YF7zk8uY5
 3IHGEgSLJxOQPXQJex8X0neTa2tMG8SJG3WfmEqBQHi0DzyjSPSF61iIH8Zcbx2KEAq61LbUE9K
 StpLBKzwWrVLL31rPfyp9C1yPjLGf++12ciTCDoXDX+fgJcD7Kr+m
X-Gm-Gg: ASbGncss66Nc5jk4jnjHCmv9BYaTGSdX0OsKTLIJJi6h94WoXvS/hY9IaQT8idqmx+p
 bf2fzHj/4RLPmc6t0FRnEh0n2D2We0iSgtYiVDTrm7oeKlzZZEUjZXsOwNsnEncE36mbjth2Xet
 HOtl4bLIGqWZCP3q/m9iDd5x+rKxcQONbt5leOvL69EI8t638TUHsKKcG6RqiHjfqEIeiKLEBNJ
 N19bVqPPBxozDWfjem8031ZmwKOzq8Yrq79b3ZMWu8S9eTA6L7JYhgkBnvo472QrJ4cMitqnWGw
 spYA8w==
X-Received: by 2002:a05:600c:1d1d:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4361c419464mr54880945e9.31.1733994626365; 
 Thu, 12 Dec 2024 01:10:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw/eAhAZlNojDb5VyuZyA/ruV+cBvl2/VZLWX5UxONoNed7ZjK/H4dLXodwRW8E5GRzSbfUA==
X-Received: by 2002:a05:600c:1d1d:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4361c419464mr54880545e9.31.1733994625972; 
 Thu, 12 Dec 2024 01:10:25 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c457sm10491965e9.15.2024.12.12.01.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 01:10:25 -0800 (PST)
Message-ID: <990f5ccd-b05f-4e25-bc68-60793d4d21ad@redhat.com>
Date: Thu, 12 Dec 2024 10:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390x/pci: relax I/O address translation requirement
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, clegoate@redhat.com, qemu-devel@nongnu.org
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241209192927.107503-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 09/12/2024 20.29, Matthew Rosato wrote:
> This series introduces the concept of the relaxed translation requirement
> for s390x guests in order to allow bypass of the guest IOMMU for more
> efficient PCI passthrough.
> 
> With this series, QEMU can indicate to the guest that an IOMMU is not
> strictly required for a zPCI device.  This would subsequently allow a
> guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
> PCI devices.
> 
> When this occurs, QEMU will note the behavior via an intercepted MPCIFC
> instruction and will fill the host iommu with mappings of the entire
> guest address space in response.
> 
> There is a kernel series [1] that adds the relevant behavior needed to
> exploit this new feature from within a s390x linux guest.
> 
> [1]: https://lore.kernel.org/linux-s390/20241209192403.107090-1-mjrosato@linux.ibm.com/
> 
> Matthew Rosato (2):
>    s390x/pci: add support for guests that request direct mapping
>    s390x/pci: indicate QEMU supports relaxed translation for passthrough

  Hi again!

One more thought: This is a guest-visible feature, isn't it? So do we also 
need some migration handling for this? For example, what happens if you 
start a guest that is aware of this feature on a host that has a QEMU with 
this feature, and then try to live-migrate the guest to a QEMU that does not 
have this feature? I guess the guest will crash? It would be better to fail 
the migration instead. At least we should disable the feature in older 
machine types and only allow it for the latest one.

  Thomas


