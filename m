Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B653749D99
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHP16-0000SU-0U; Thu, 06 Jul 2023 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHP0r-0000BV-SQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHP0p-0001fx-QN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688650030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gS2cQ+S5rZhTae0BZLo3iZATEyRpOoyacznuVsEpcGQ=;
 b=UZy5Bfv87qjS+xv1h9SGPlsN7mWxNbVw9yfFumfxkkP4vJu4tVBprDAZRR+2QXjKKAvTco
 l7A9RAwt0NZAlkiKXyzGDJjd6jg7FG7RRIBRy9FtuuoreD90kTZc434pKtlA1dt1XvP9nH
 soQgP/9PtZczls7/vmNVPwT1llL5ELQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-LuDksfOLNluwqWt-YaSf6A-1; Thu, 06 Jul 2023 09:27:09 -0400
X-MC-Unique: LuDksfOLNluwqWt-YaSf6A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbdde92299so4075825e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688650027; x=1691242027;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gS2cQ+S5rZhTae0BZLo3iZATEyRpOoyacznuVsEpcGQ=;
 b=Sm5EpWZjpZFNC9NZ6JlpUdmyPZwLlnW2AA29l2r3Zws72S0NauFi0GjI6ix0u1hBU5
 UUzqdwHdTI4s9qVe5XuLGzNalAiZxU4hCmF/BMFoz+pDQcAlJAK+5KHF5UHsqCR5p9+0
 k1G0hXvEWuaL9kAd6XSgUYtxLRTfcbc2yx/tVkh8yDMjpKSVIyQmvuFMP9qEN+41ASAO
 AJ6xPdjo0xc4TFDU6KHw5BGe37r+KBum3bRRKVVNMBA2O08S242WifrnX6W6Li1jy3Pa
 MjG6IveknsBkELFQacQ5lGoNgvJcQAT3qJKo2lNoIqHCjp2bphsvXoy8fdvT7YnIl8Cz
 4h5A==
X-Gm-Message-State: ABy/qLYiIF/yLn0Krk5SqOMdKokmumS6mQCW4lIHmGs/jh5q0zpPDJvM
 F9/5NID8+/2LBAKIUj2MG0+B5DVbHyIAU/z2zqgwhGJMQSbBvsynHk+cAbEmJXpu2MVAyIfwam1
 0K6vvsLI12N9WgE0=
X-Received: by 2002:a7b:c4d1:0:b0:3f8:2777:15e with SMTP id
 g17-20020a7bc4d1000000b003f82777015emr1343195wmk.31.1688650027529; 
 Thu, 06 Jul 2023 06:27:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFrhutM6gNqzbU35KNhtQ0rrBTTSQ/Iahf3fpV/y8SliSJ9K0eIounBiF0PlEX3cDaM6GmxrQ==
X-Received: by 2002:a7b:c4d1:0:b0:3f8:2777:15e with SMTP id
 g17-20020a7bc4d1000000b003f82777015emr1343169wmk.31.1688650027205; 
 Thu, 06 Jul 2023 06:27:07 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 s14-20020a7bc38e000000b003fbdf8292a7sm2085503wmj.46.2023.07.06.06.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:27:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-mem: Skip most of virtio_mem_unplug_all()
 without plugged memory
In-Reply-To: <02c15d72-b29f-b0da-42a6-f77040d4f8ab@redhat.com> (David
 Hildenbrand's message of "Thu, 6 Jul 2023 10:38:09 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-3-david@redhat.com>
 <87fs61bglq.fsf@secure.mitica>
 <02c15d72-b29f-b0da-42a6-f77040d4f8ab@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 15:27:05 +0200
Message-ID: <87v8ex6uhi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
> On 06.07.23 10:15, Juan Quintela wrote:
>> David Hildenbrand <david@redhat.com> wrote:
>>> Already when starting QEMU we perform one system reset that ends up
>>> triggering virtio_mem_unplug_all() with no actual memory plugged yet.
>>> That, in turn will trigger ram_block_discard_range() and perform some
>>> other actions that are not required in that case.
>>>
>>> Let's optimize virtio_mem_unplug_all() for the case that no memory is
>>> plugged. This will be beneficial for x-ignore-shared support as well.
>>>
>>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> It works, so ...
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Thanks!
>
> [...]
>
>>> +        bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
>>>           vmem->size = 0;
>>>           notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
>>>       }
>>> +
>>>       trace_virtio_mem_unplugged_all();
>>>       virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
>>>       return 0;
>> Once that we are here.  Do you remember _why_ do we allow virtio-mem
>> plug/unplug in the middle of a migration.
>> We forbid to plug/unplug everything else.  Why do we need to
>> plug/unplug
>> virtio-mem during migration?
>
> With virtio-mem you tell the VM the desired size for the device
> (requested-size), and the VM will select blocks to (un)plug and send
> (un)plug requests to the hypervisor in order to reach the requested
> size.
>
> So changing the requested size in the hypervisor (by the QEMU user)
> and the VM processing that resize request is asynchronous -- similar
> to memory ballooning.
>
> As the VM can send these (un)plug requests any time, and we exactly
> don't want to allow (un)plug during migration, we have
> virtio_mem_is_busy() to reject any such requests to tell the VM
> "please try again later".

Ahh.

I see it now.

Thanks, Juan.


