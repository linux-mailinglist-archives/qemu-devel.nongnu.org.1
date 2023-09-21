Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B57A92E0
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFUA-00074l-7D; Thu, 21 Sep 2023 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFU8-0006zh-HY
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qjFU6-0005jK-09
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695286589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQo3cP8ubnIFxn8GyzNBkh6mW/MSQ9HqXpxlK6ZJiTA=;
 b=KH6gcGqj+yEFbUZVktaQ47LvxK+GVeFvKBAn1Ei2VaZTkj4HxxQWEuRm/1L1p0b49MTyW7
 7sWPhkIQpasc2ZUd90JETaeN0NkFdBooXjKAmSbr0N6vWfjw1BjbLlh/YX+FTKCjUIEiOf
 JAWigOwXOZITixLzc0+J91/uL+nZ3m4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Yoz01GlQPpqRaOKTh8QsBQ-1; Thu, 21 Sep 2023 04:56:27 -0400
X-MC-Unique: Yoz01GlQPpqRaOKTh8QsBQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-321f75cf2bdso195558f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695286586; x=1695891386;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PQo3cP8ubnIFxn8GyzNBkh6mW/MSQ9HqXpxlK6ZJiTA=;
 b=mexdJ5yB2NYr920qk0jm08qPy31zJJdtrigWWEu9H/8pr8h35jaE3kChm302I2oyM/
 rEETbbGRf3ldChKZJ57VzKESd1AFsZlsBVc/crrc4kK5qBfDTfwgNx6tS5Y5CaNM+ao0
 ZWYfNBi+qftaHuoHTdxt0sr3LKjnO6LtzSrVkuFZ/q9IOAX4DO+sWf9HJ6zMDlYWOsjM
 1f5tm+Ej/7EPUvbhnQIOAxeRWq/dPcUEUfzykG/7XuTkbThFCwL9AB4muVC2VScBG7Mc
 xiGg1LkqX5JusFcyrMEzDpGKQyyMnpPWiuVoWic22HFa7mzfMgAqInO+U1wsweziTR9T
 5eZQ==
X-Gm-Message-State: AOJu0YyT7mpeSF913BDIjRhH4wgq5IiWM8CgXCmfHPpKwU7H1Yg/Caf5
 bcOchy4w1mGLyVN0cEL3f1DFT1toOXrKTrR3fTdu/Rk3MsK7eBYx98eS2rf+adgnO3triMVs8oP
 yzbf6kNAxmlYC0B4=
X-Received: by 2002:adf:e253:0:b0:31a:dd55:e69c with SMTP id
 bl19-20020adfe253000000b0031add55e69cmr4279916wrb.60.1695286586213; 
 Thu, 21 Sep 2023 01:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4a6zpCosFq3hmujQ4zTcT38YOWqiaKd28jQERYVCmRpaHM+ECvPdd2GHEzhC9vCufTHkxJg==
X-Received: by 2002:adf:e253:0:b0:31a:dd55:e69c with SMTP id
 bl19-20020adfe253000000b0031add55e69cmr4279904wrb.60.1695286585929; 
 Thu, 21 Sep 2023 01:56:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626?
 (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de.
 [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a056000111000b003176eab8868sm1131747wrw.82.2023.09.21.01.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:56:25 -0700 (PDT)
Message-ID: <3f8955f6-c261-d3f3-08a2-54f0bd9caf8e@redhat.com>
Date: Thu, 21 Sep 2023 10:56:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 05/21] kvm: Enable KVM_SET_USER_MEMORY_REGION2 for
 memslot
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-6-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914035117.3285885-6-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 14.09.23 05:51, Xiaoyao Li wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Switch to KVM_SET_USER_MEMORY_REGION2 when supported by KVM.
> 
> With KVM_SET_USER_MEMORY_REGION2, QEMU can set up memory region that
> backend'ed both by hva-based shared memory and gmem fd based private
> memory.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>

"Co-developed-by".

-- 
Cheers,

David / dhildenb


