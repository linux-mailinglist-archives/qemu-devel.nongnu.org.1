Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DE7A46CC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBM5-0000mD-Gn; Mon, 18 Sep 2023 06:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBLz-0000bi-NS
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBLx-00079f-Hh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695032380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6HzzUv2eVXiw/tlDsswhW1r0fwxdNuW0M7xYeiSyxM=;
 b=On4D+DIHpnjP1NBo/SRZsP3Z1cH0M9QZOJlAeK4i9XfOjS9ScCHevRJUxWDS5tYoJdiMVu
 8Plo7pRFiS4UdfkeisFDivMYWVOjeD7c5MvIfSShWIMG/VgFSB+lH3ddlhAj5mgpY2fJUh
 JwRZDlMUVHB4ZSLTJLxj6gecxHd5Gd4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-WI-E56QMOF226Wqc-j8-dg-1; Mon, 18 Sep 2023 06:19:38 -0400
X-MC-Unique: WI-E56QMOF226Wqc-j8-dg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f8e062cadso3023801f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695032377; x=1695637177;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6HzzUv2eVXiw/tlDsswhW1r0fwxdNuW0M7xYeiSyxM=;
 b=NU1bV0J8QoM2FICRUl6W8M5CEbXJZLdSjsvDyRQc39DF5MaRc92xtoz3odUhpnoLdY
 d8eIqB84aXvpnz/lIXGA5yowIpSrSFqP2COxtKTbrFYr5OK/uyKGeBUCWah5vnnC7/u5
 BLMh791mBmaOXQ+GTaEUyjRPQrDIvjIMYD9u6xqrOqHYSLb62ET7Ypz0z7MsbkgO4osA
 BPriauou7n+Hk9qpv21FNwbKbo9H+T7zjftlPvaaX6V0MXUliy3pMowWabclL/I+9zta
 dqi2F90SokanidqSFw1Eyzedb/LCthICWJM5aGUNfKdXdYaxpQYENzQTBDrRONoXMbgW
 dPGw==
X-Gm-Message-State: AOJu0YzasuOZqbFHABmdWmhkMNFoHj0PVPYpEsRHa0KFH9rEh8Ig4b1h
 mJcX0zzsxU9LB5bzKlblITdZSctiBkjUfqzGaGXduppVXM125ZWF9sQH58koSRPrJbSBkWUTyD7
 TkJHtCef6PcxkAzs=
X-Received: by 2002:a5d:6084:0:b0:313:e98b:7de2 with SMTP id
 w4-20020a5d6084000000b00313e98b7de2mr6170452wrt.0.1695032377784; 
 Mon, 18 Sep 2023 03:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmimjocvYsObhsUHf7zY1tpTbngS0jsJ6hNCmne41oVHDW5uIsl6ULKuQzwrU5vniXjau8uw==
X-Received: by 2002:a5d:6084:0:b0:313:e98b:7de2 with SMTP id
 w4-20020a5d6084000000b00313e98b7de2mr6170435wrt.0.1695032377397; 
 Mon, 18 Sep 2023 03:19:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 v15-20020adff68f000000b0031433443265sm12196211wrp.53.2023.09.18.03.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:19:36 -0700 (PDT)
Message-ID: <5b22fff5-270f-0ab5-1ee5-2e54f491aefd@redhat.com>
Date: Mon, 18 Sep 2023 12:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
 <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
 <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
In-Reply-To: <CAK3XEhMTSP7TkJgKX1_VxUVxaoU1jX8d_i-0H4t=bNktY5wo5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 18.09.23 12:11, Ani Sinha wrote:

> 
>     Ok hopefully my last question. I am still confused on something.
>     Does the above mean that the hole64 will actually start from an
>     address that is beyond maxram? Like basically if you added all of
>     ram_below_4G, ram_above_4G, hot plug_mem and pci_hole64 then can it
>     exceed maxram? I think it will. Does this not an issue?

If you'd have a 2 GiB VM, the device memory region and hole64 would 
always be placed >= 4 GiB address, yes.

As maxram is just a size, and not a PFN, I don't think there is any 
issue with that.

ms->maxram_size is usually only used in combination with ms->ram_size to
detect if memory devices will be enabled, and to size that region for 
memory devices.

-- 
Cheers,

David / dhildenb


