Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C661707F6B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbtJ-0005EA-Hn; Thu, 18 May 2023 07:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbtG-0005Dj-Om
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbtE-0001XF-Id
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684409627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7fY8UHKcqBx7Ntq4hUVwG9qCcgVv6zTOEIp6CI7cIcg=;
 b=Um+xuJa67LRZlvbEfmmP2zYvCLXeCR3FC4ajhxC1NWYvoIkNQBwbttbt5BIsjwQGXji+h8
 Kzc92NKnueOeMxdVDPsB4btwRWFV7ODucipG0HWbiW1HM1z+04OvfiwWBpHotJfmJfGG1Y
 woeuvZHOjCibTt+NGJQQCZahhtknLNg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-X3vtubYvOxemYToB48YAFQ-1; Thu, 18 May 2023 07:33:46 -0400
X-MC-Unique: X3vtubYvOxemYToB48YAFQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f422654fa0so7197895e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409625; x=1687001625;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fY8UHKcqBx7Ntq4hUVwG9qCcgVv6zTOEIp6CI7cIcg=;
 b=CVZP/nH8KA8fZU8+FhER2H0SJYLU+Xv99LLCDZ4jGsWjdFZnm3MN+mBAgudLt4M97v
 Rx0UAAUEINcNrOcl0hOMHBWL+6yTTU1GKrvWOsZVQIfOIJCgBSiD2EhF3sUMZviryK8Z
 8vO7FwkAjFfeeUdH2EDiFIr3qboEaRbnIREHdHLBklzSku8c3C/DqqtQCeMHnfh/5yeN
 La1DI7ZpLvL6lHTW2iYtaT9vU3To4H/eV7Hhy8vi6zVw3hvsXHlzW7/wNqCVNHalsDNQ
 IHi/gIiye8L4VRqDS2CYOehXO1j/Y1QQh6n8JK/ILgGSYfds+t+EJuretGuGs2g7iMT4
 t0tw==
X-Gm-Message-State: AC+VfDwDcs5sFBDceYS7iOZKsenZ+4mbfAzWb0cC4V3MmCQjg+yshN94
 fWbex5T/eEwg+hzB+YzITF7nGwRoL6+D/91wuBOY33TcmWRQ1ogN1ShsIk4Locby2BiJegmGYte
 Mst9aTjr27tpkwwI=
X-Received: by 2002:a1c:7310:0:b0:3f5:4d4:4edb with SMTP id
 d16-20020a1c7310000000b003f504d44edbmr1259654wmb.21.1684409624984; 
 Thu, 18 May 2023 04:33:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ES7Rkwm9/sA42zmlgW10+RPXEElzpHg6xxn2076VvPu1b0uXLFlUWFEsFCgFU9e6enqdzmA==
X-Received: by 2002:a1c:7310:0:b0:3f5:4d4:4edb with SMTP id
 d16-20020a1c7310000000b003f504d44edbmr1259635wmb.21.1684409624600; 
 Thu, 18 May 2023 04:33:44 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w22-20020a1cf616000000b003f4289b18a7sm1817915wmc.5.2023.05.18.04.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:33:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fiona Ebner <f.ebner@proxmox.com>,  Leonardo Bras <leobras@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
In-Reply-To: <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 18 May 2023 10:34:36 +0300")
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
 <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:33:43 +0200
Message-ID: <87wn15dgbs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Michael Tokarev <mjt@tls.msk.ru> wrote:
> 11.05.2023 11:40, Juan Quintela wrote:
>> Fiona Ebner <f.ebner@proxmox.com> wrote:
> ...
>>> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1576
>>>
>>> AFAICT, this breaks (forward) migration from 8.0 to 8.0 + this patch
>>> when using machine type <= 7.2. That is because after this patch, when
>>> using machine type <= 7.2, the wmask for the register is not set and
>>> when 8.0 sends a nonzero value for the register, the error condition in
>>> get_pci_config_device() will trigger again.
>> I think that works correctly.
>> See https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02733.html
>> What we have (before this patch) (using abbrevs as in the doc
>> before)
>> Current state:
>> (1) qemu-8.0 -M pc-8.0 -> qemu-8.0 -M pc-8.0 works
>>      not affected by the patch
>> (2) qemu-7.2 -M pc-7.2 -> qemu-8.0 -M pc-8.0 works
>>      works well because 7.2 don't change that field
>> (3) qemu-8.0 -M pc-7.2 -> qemu-7.2 -M pc-7.2 fails
>> With the patch we fixed 3, so once it is in stable, 1 and 2 continue
>> as
>> usual and for (3) we will have:
>> (3) qemu-8.0.1 -M pc-7.2 -> qemu-7.2 -M pc-7.2 works
>> If what you mean is that:
>> (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
>> Will fail, that is true, but I can think a "sane" way to fix this.

Hi

> That's a great summary indeed.

Thanks.

>>> Is it necessary to also handle that? Maybe by special casing the error
>>> condition in get_pci_config_device() to be prepared to accept such a
>>> stream from 8.0?
>> Well, we can do that, but it is to the pci maintainers to decide if
>> that
>> is "sane".
>
> So, can we go from here somewhere? I'd love this fix to be in 8.0.1,
> either with or without the (un)sane part of the (3) variant above which
> might fail.  Or else we'll have the same situation in 8.0.1 as we now
> have in 8.0.0 (the deadline is May-27).
>
> We did broke x.y.0 => x.y.1 migration before already like this, such as
> with 7.2.0=>7.2.1. I'm not saying it's a nice thing to do, just stating
> a fact. Yes, it is better to avoid such breakage, but.. meh..

See patch for documentation:

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03288.html

Basically, the best we can do is:
- get the patch posted.  Fixes everything except:
  (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works

And for that, we can document somewhere that we need to launch
qemu-8.0.1 as:

$ qemu-8.0.1 -M pc-7.2 -device blah,x-pci-err-unc-mask=on

And mark someone that this machine is tainted an can only be migrated to
qemu's >= qemu-8.0.1.  And that we should reboot it as the user
convenience. (reboot here means poweroff qemu and poweron it back
without x-pci-err-unc-mask=on).

Later, Juan.





