Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08B78C7CE
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazvC-0000gL-Br; Tue, 29 Aug 2023 10:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazvA-0000du-Fy
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:42:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazv8-00030P-AI
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:42:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso41585115e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693320136; x=1693924936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zCsRcU4gamP71uJM1oFyNFH7u3ozsV3ge3/YUq3jGNg=;
 b=jUYXjrGiTJD7B8FBzSpccyasQb5F6Rpwt4ZL6pMqkdatLTWXpsYf1ukPRefHEzricb
 hifjeDch/Jd0UNkWBc8c9DYYkUxI0qlfpKV3ksqldw4zR1gqImmr9wRjxmplI8I5VkRp
 4Joj+rOx1Mh3xZVzkHLZZVz+NqLNwjOikOepjUF0A2PwZooDmyhxvwW7//wAY1vgbS/K
 prSEFo5XsgsuQZ4OnksK7+qQogpl2Hg5qjRH+rHXzy7avkh6gpaazV/1xydAWtYcVV2E
 Tw2pzH+XZxSmdXOyo8sFlYVYPYgQs3/1xmSeXdkHQxXKEjXH1in2n/bYPIsIV6t3UFN5
 ZJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693320136; x=1693924936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zCsRcU4gamP71uJM1oFyNFH7u3ozsV3ge3/YUq3jGNg=;
 b=gDbkrwLdr6hxzGoxryyh74nXVbHaIKrdzq0QnC4D4pRoNBe7Is5ZE06W9EMleFngLU
 BRGUQJy0Ob/qrrkbAfMYa6f2LvfvrqqRzz5ZAnu8dfZMXjN94uHs0FXQeMbCKmfxl0oa
 nFf3hiLt7QQbe27+recfBqHBc3CtgkT0YKUTo8M9VVl+o2yPrK1g5knEvsZZx+2jfZH0
 2ZRynmFWxdVtaGuV8FZ8vuw9J5CFcW87FuGOb835/EnzwjSs9aBTHxk1QVLR4Jr4piCV
 676pXH1tK4K3A896N4YzZ+cJex30DVyjJzCfz1+LDmE3CzEJqYb0DRvzzkydudFsTvIL
 r1tA==
X-Gm-Message-State: AOJu0YysAqF/TYKItadXcfqj2BDvRN40/zdgJy7NYeEmfUmm2NXESB69
 v+CJmX9BIdkQNWI/zNhoo9smcQ==
X-Google-Smtp-Source: AGHT+IHSOWPCEK2FwOefP15TZzbwruJfPjs2r4cB3ufVZ31dQCxqaPACviBrv3kdlrCWig3ybUNiCw==
X-Received: by 2002:a7b:c34d:0:b0:3fe:2e0d:b715 with SMTP id
 l13-20020a7bc34d000000b003fe2e0db715mr22876289wmj.18.1693320136071; 
 Tue, 29 Aug 2023 07:42:16 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 x16-20020a5d6510000000b003143c9beeaesm13965977wru.44.2023.08.29.07.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:42:15 -0700 (PDT)
Message-ID: <9c8195b6-e9ce-9be6-4fdc-5fe1347580fc@linaro.org>
Date: Tue, 29 Aug 2023 16:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 04/58] target/i386: Introduce
 kvm_confidential_guest_init()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-5-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818095041.1973309-5-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18/8/23 11:49, Xiaoyao Li wrote:
> Introduce a separate function kvm_confidential_guest_init() for SEV (and
> future TDX).
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 11 ++++++++++-
>   target/i386/sev.c     |  1 -
>   target/i386/sev.h     |  2 ++
>   3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


