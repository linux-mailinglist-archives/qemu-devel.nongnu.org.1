Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE227A4C4F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:30:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGCG-0001IL-7X; Mon, 18 Sep 2023 11:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiGC9-0001EQ-Sw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiGC2-0004a0-Ph
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695050985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDWtT7+f+XkOJ5yehFgutjK1/U8s5BiB6a4xz0l/dTg=;
 b=MabKwVl01n323Bigxy+GWQ+J5l8Rae6a7jCkgvq1LnDzxl8DArURLrPKA2+P5hgJLXztbB
 dCL6i3QZUphvit5sZSevWfsbLqTU3DS5TY7Ztz0K5IDCvBxoaSF8uxZ3X+TFy9QSA6Jh3y
 Z3qRnF1KK9o2Kxis366meQzWYulVaQk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-h5ckPnQ9PQuduIpdIRetJQ-1; Mon, 18 Sep 2023 11:29:43 -0400
X-MC-Unique: h5ckPnQ9PQuduIpdIRetJQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso36801425e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695050982; x=1695655782;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDWtT7+f+XkOJ5yehFgutjK1/U8s5BiB6a4xz0l/dTg=;
 b=fecy2hONvNcrNiIuEb3zXP/DnA0vO63nbVMIhDe0QYcbxMrtyaCwnEKLRLABkxL/fU
 PJ0NJSEb0AoaQg7Av8CTBGu8IUfyW30WaBSHiOugtKGRo8p5wN42MG/jiAr4EuooE0g+
 xyuKhCv8jO/9JR3K2mkeZLBYgDTNoZLfC4j2Ub1Tnde3lYbw5WBDkd7zeajfrfxO2tr1
 JaIqbHrA7bHakDa/ajRh+uL1gGIeOpeJ5v6r0zCkRzGVfVhYk59hvDdxU546tmY00uvm
 jVqaOwxk87xw/lPYYjjR/5vq4KBtOGRqLCzUxKWYEPUyUwWzAnMCDGHps67VjXDUF89R
 LBLA==
X-Gm-Message-State: AOJu0Yzj//U68PBrIupbhFt2hvcU4ajtGk7ZL3I/mlKjk5pRhcff6vck
 QOCwCQaRN92bD+eofQ/8Dl1jKQG8g6QVhEk4uqH1xm0ascEna6w3sraH/Pg4Ert2TvbHM0ZnaL0
 KdXHRySPnm1H0fiQ=
X-Received: by 2002:a7b:cbd1:0:b0:404:34d3:6110 with SMTP id
 n17-20020a7bcbd1000000b0040434d36110mr8296976wmi.0.1695050982630; 
 Mon, 18 Sep 2023 08:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJCet1HRFk2XATgOMQfdnMSqI9dOTxApgRR9eti69GvKri7LEdWlGvxHHtOR4T3uqJTHuSsA==
X-Received: by 2002:a7b:cbd1:0:b0:404:34d3:6110 with SMTP id
 n17-20020a7bcbd1000000b0040434d36110mr8296961wmi.0.1695050982242; 
 Mon, 18 Sep 2023 08:29:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:9d00:cf36:8603:a1f5:d07?
 (p200300cbc7029d00cf368603a1f50d07.dip0.t-ipconnect.de.
 [2003:cb:c702:9d00:cf36:8603:a1f5:d07])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a7bce0a000000b003fee53feab5sm12791729wmc.10.2023.09.18.08.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 08:29:41 -0700 (PDT)
Message-ID: <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
Date: Mon, 18 Sep 2023 17:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: philmd@linaro.org, qemu-devel@nongnu.org
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 18.09.23 17:22, Ani Sinha wrote:
> On Mon, Sep 18, 2023 at 7:25 PM Ani Sinha <anisinha@redhat.com> wrote:
>>
>> 32-bit systems do not have a reserved memory for hole64 but they may have a
>> reserved memory space for memory hotplug. Since, hole64 starts after the
>> reserved hotplug memory, the unaligned hole64 start address gives us the
>> end address for this memory hotplug region that the processor may use.
>> Fix this. This ensures that the physical address space bound checking works
>> correctly for 32-bit systems as well.
> 
> This patch breaks some unit tests. I am not sure why it did not catch
> it when I tested it before sending.
> Will have to resend after fixing the tests.

Probably because they supply more memory than the system can actually 
handle? (e.g., -m 4g on 32bit)?

Agreed with MST that we should glue this to compat machines.

-- 
Cheers,

David / dhildenb


