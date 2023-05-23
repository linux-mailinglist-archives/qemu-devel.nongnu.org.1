Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717770D496
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1M9w-0008Dq-NG; Tue, 23 May 2023 03:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1M9u-0008DG-GW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:10:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1M9r-0008C1-TZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:10:14 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3093a778089so4517362f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684825809; x=1687417809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dWa6ZfaQ4eD7kOh7L6/xV2Uhhik+xgQKi6LWzgnefNI=;
 b=SUVzDCmgqHIxqyCtHdDT55l20t6HvZbzXk7hlwJREwtgMZdbxZEUgyG7kEli9/17Vd
 hkHtfAAWwXGeS8t0/G2NBUYDUd83ELUaFEunhphudfQ1AcruCGbXwrwzfLVBCg4wj564
 EyZ90tEg8GEoZOFspFAQYlEFRX6HT4P7P3FueMP9V8x/Rr/G6UaJXtwbAUJJgJzLkUKJ
 3+0VXLjUVFEwWoZwzDmLtbt/8pzv4DxM4C+sAqTpFuPI6AavSllLmKuv0LmowAxD3duV
 BCSxnyUtdOimsxnpLWuvF7uzK5ldL6y4gH31iM/BXqBSgSypirTksi1AsdX569+1ioRJ
 o12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684825809; x=1687417809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWa6ZfaQ4eD7kOh7L6/xV2Uhhik+xgQKi6LWzgnefNI=;
 b=lJDUPKD9QYHXRrwWoSQU3is+hu9o8y4/dbsCw47pZdI+JM0qk9N3E2l/YMBQQ/X44e
 Va1Fd4KXqbNqwf3WSNcaDPaD0UEryCiZLeXuE7jVyEfWQdH7CzC7/EbdRf1xxHTNv/oH
 /5TI4W6vR97XacBivvsTEzWQsqPgF1UKgZ5oSz7Sa/ywdm82CSqjNCOeGo6kAlyjN24R
 JP7DGyScAylbM5PX3vT4SGqHYWRFDX3ZjYDXPmaJFqNcPru9oF2ld+cxnFpzvpx1p7w8
 x6vJDHoPitNNJwvcpiONGwmrKP+UYOyfzcxM4OzaHWpDewjqn0rGSFLfeihXg8YoUHHm
 WczA==
X-Gm-Message-State: AC+VfDzZmN7rWWjIVKK6LjmJzLBECcmV4wIioYdS8xHiNd70FS2TKFUF
 HK5Rh1FWQDD1rhtjnHwGk7ZCHPfcboU641UMlsM=
X-Google-Smtp-Source: ACHHUZ6gwixnawd/9kM7Wf6SX6Vk7Kaag2nUE4UEEdZXQV83RPV2cEOsIpzsctkFTMzNVKDsQxXjeA==
X-Received: by 2002:adf:e781:0:b0:306:3284:824f with SMTP id
 n1-20020adfe781000000b003063284824fmr9597491wrm.8.1684825809608; 
 Tue, 23 May 2023 00:10:09 -0700 (PDT)
Received: from [192.168.69.115] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 n10-20020adfe78a000000b0030796e103a1sm10136767wrm.5.2023.05.23.00.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 00:10:09 -0700 (PDT)
Message-ID: <bfe359ae-96c9-5eb4-a4a3-56ad7927734e@linaro.org>
Date: Tue, 23 May 2023 09:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] hw: Fix abuse of QOM class internals modified by
 their instances
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Titus Rwantare <titusr@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230523064408.57941-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523064408.57941-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

(posted too quickly)

On 23/5/23 08:44, Philippe Mathieu-Daudé wrote:
> Bernhard warned for QOM class abuse here [*]:
> 
>> A realize method is supposed to modify a single instance only
>> while we're modifying the behavior of whole classes here, i.e.
>> will affect every instance of these classes. This goes against
>> QOM design principles and will therefore be confusing for people
>> who are familiar with QOM in particular and OOP in general.
> 
> This series fixes the cases I found while auditing.

Audited but not yet fixed:

- accel/xen
   xen_init() sets 'default_ram_id'
   -> need to figure migration compatibility (because using shared
      pc_machine_class_init and DEFINE_PC_MACHINE), will be posted
      separately.

- hw/core/bus
   qbus_init_internal() increments 'automatic_ids'
   -> need more thought.

- hw/core/
   machine_parse_smp_config() sets 'smp_props.has_clusters'
   -> dubious

- hw/remote/
   remote_object_init() and probe_pci_info() set 'vendor_id', 'nr_devs'
   -> need more thought.

- qom/object/
   object_dynamic_cast_assert() populates object_cast_cache[]
   -> QOM internal, likely OK.

- softmmu/vl
   configure_blockdev() overwrites 'machine_class->block_default_type'
   -> dubious

- gdbstub
   ppc_gdb_gen_spr_xml() sets 'gdb_num_sprs' and 'gdb_spr_xml'
   -> dubious, likely fixable (maybe like patch #3 of this series)

- tests/unit/
   smp_parse_test() set 'smp_props.prefer_sockets'
   -> dubious, probably tolerable.

> [*] https://lore.kernel.org/qemu-devel/0DAAC63B-0C0F-44C4-B7EB-ACD6C9A36BF1@gmail.com/

