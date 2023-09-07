Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303A979717F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCMA-0006du-GG; Thu, 07 Sep 2023 06:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qeCM7-0006dh-O7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qeCM5-0000gq-Ms
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694082909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azyorQxjECKYWSy+Mt2CU3t9r6NYRJhmlonGBrUGhx8=;
 b=LDaampkRgZE/ETzqRulWLwBwxys3OMKfimXhWZR6D2vruAAafZXdMYfd4tmcOF6/Vto5o/
 Z3lgcifofVZkhVTQHm8kDz4CDeTsU07527ONmLabDMvcG4bR/YfqFsC0tTLuWTb8sibb48
 Er0dMWl7mLMCiVeLSbsISXyRKOUy2KM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-W4vazGcFOpewevNuLKTxKQ-1; Thu, 07 Sep 2023 06:35:08 -0400
X-MC-Unique: W4vazGcFOpewevNuLKTxKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso6175815e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694082907; x=1694687707;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=azyorQxjECKYWSy+Mt2CU3t9r6NYRJhmlonGBrUGhx8=;
 b=F0OffK4+ho3ufQ9mDzFW6AArBfV0xnKyaVSPDxCp4rL6CqbQJYjG1YIrPUyDr0ETag
 KRfqNblOk0iuunVQzncjLLIdbKDsCJacPc/ed+T4SnbJwICIFero13DecSZrWmPR/luK
 09VQnrVqhVjRjoFcF/TTbOF1dZzguLV5haIXIJm/khLYk1WSQIKLtP2M5RKzw4XAUKSz
 /2GnsdyzfyGUalW7TmAggFX3cY0JsTmevpS00o49NmWnfIio0Jn7mScoqRHksm5THt2q
 h6kMY5AtY8hbzsZo5u3o5R+z2k+qO8ABSOeCIBUKLlB5MK+4zFjc0AIb/FwZAEgb+U3e
 Uvtg==
X-Gm-Message-State: AOJu0YztCN4iQAZM0Boe+JGqNZp5ZWbr04HbNVp7gYGYQUXRbJMOUtG+
 Dc2dg+9VeYk9yC7kND6yrH/36GrJgqNlISYmPdYArbHgYIMeG6Vtrcg7pQtJtuMbs+CVB2cwRCn
 mnumWJ6HY9wrrLn4=
X-Received: by 2002:a05:600c:2409:b0:3fa:97ad:2ba5 with SMTP id
 9-20020a05600c240900b003fa97ad2ba5mr4710627wmp.31.1694082906858; 
 Thu, 07 Sep 2023 03:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ4FYl1Ws79+OxjgwI+o3NQWaa2nmnBSIBVIjoY535d3+fQ39lU68Tm6Q8aq0ITwaebdO2Gw==
X-Received: by 2002:a05:600c:2409:b0:3fa:97ad:2ba5 with SMTP id
 9-20020a05600c240900b003fa97ad2ba5mr4710594wmp.31.1694082906430; 
 Thu, 07 Sep 2023 03:35:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:cb00:d8c3:e672:87cb:e4d9?
 (p200300cbc711cb00d8c3e67287cbe4d9.dip0.t-ipconnect.de.
 [2003:cb:c711:cb00:d8c3:e672:87cb:e4d9])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a5d4d88000000b003179d7ed4f3sm22932127wru.12.2023.09.07.03.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 03:35:06 -0700 (PDT)
Message-ID: <c9e9d345-6749-9c2c-a829-35839872f0a0@redhat.com>
Date: Thu, 7 Sep 2023 12:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 07/11] softmmu/physmem: Never return directories from
 file_ram_open()
Content-Language: en-US
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230906120503.359863-1-david@redhat.com>
 <20230906120503.359863-8-david@redhat.com>
 <CAMXpfWu_AC87EkAHT-H5LaYNSEHsbjMfEN2PXrX5fN=QFcB+0A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMXpfWu_AC87EkAHT-H5LaYNSEHsbjMfEN2PXrX5fN=QFcB+0A@mail.gmail.com>
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

On 07.09.23 12:31, Mario Casquero wrote:
> Tested-by: Mario Casquero<mcasquer@redhat.com>

Thanks Mario!

-- 
Cheers,

David / dhildenb


