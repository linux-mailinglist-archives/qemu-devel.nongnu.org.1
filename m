Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39D7E589D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:23:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jS8-0002bV-Jf; Wed, 08 Nov 2023 09:22:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r0jRu-0002ZI-RM
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:38 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1r0jRs-0003hJ-3S
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:22:29 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3592fadbd7eso24321345ab.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 06:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699453346; x=1700058146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=80z/D5E8TnJkZKSvU1rCHH3CpCDBEqmub4z8N65gkT8=;
 b=gakL6Mlm2vUfMA9eKcnZilhMTPSdKoNHejOjOmFzX+NOnZx0GH4C8EnS6MLiFsFR02
 XssoJA1B/rAYmSYg30pibnBjLX0W+SD47/YwhWtQRxUNsIpyaSwYYilMs+bic0kDDW/r
 sqbZ/2Q1EjH2F5rEybxzsoUcRaIsQAZklerH0j+VQAMFLVIHm/1KzvuP/GrTj0Ppp+Pg
 IaZr6TpoJRydKdRq44iGPBKwkfV5PeB76brbPMORMzie54znOSbbzuDHy4GBgUQX6ZiO
 BXBaztUP+EpHUqAvoa17tnj4g70blOTbdHqAFz4aj7cTitzY7LbngRanfBiA1b0tkUEh
 Je/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699453346; x=1700058146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80z/D5E8TnJkZKSvU1rCHH3CpCDBEqmub4z8N65gkT8=;
 b=NWcDbbj7qE4Ij2GZobW4YcAtiGS6gowk++b2TfivNLs7G1OzRhN93GBnipCg56F6Uw
 jD9zXfmg7kPXQTLK9U0qaV4mNO3qzPLxRsUH41Ht9hPe46IvwhwN9zL0qLoI3iB9Yi4R
 aDMmuAwhEoJOiMIzny4W5RljuchNn2TxctBXrp4dtcOL9XkFV6i1uwge6HdpBPjYTWUR
 zAsI4QCQqaPMeM3v582G3Dqsboay0dayU7YRb0GofYUCdEIzaiIlkgx7mEQLMoAId8Av
 bce6nl87/MiCRWLVs9DvkEbgSuwGQRROHT7dssZiBzXTs8mcpBweJuD+GmdrZFgSDiYr
 VQ6g==
X-Gm-Message-State: AOJu0Yz1pV/de2P2vVqh8byrtjAxgQ3kFal+R/3C6/fgsopua6ivzdXc
 RHpBpgxSxcvPX29CIDW2LTI=
X-Google-Smtp-Source: AGHT+IEHWiyypfMtGM3Cykwpc+eGkhOWlt6HQq1kK/WEAm62lDtfz9TxtkiXep7U1k8OmTwaroxuGw==
X-Received: by 2002:a05:6e02:1a65:b0:351:5b43:5ecd with SMTP id
 w5-20020a056e021a6500b003515b435ecdmr2629534ilv.14.1699453346180; 
 Wed, 08 Nov 2023 06:22:26 -0800 (PST)
Received: from ?IPV6:2001:ee0:50f4:9050:34bc:f29a:1eee:56b8?
 ([2001:ee0:50f4:9050:34bc:f29a:1eee:56b8])
 by smtp.gmail.com with ESMTPSA id
 29-20020a63185d000000b005bcea1bf43bsm3155430pgy.12.2023.11.08.06.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 06:22:25 -0800 (PST)
Message-ID: <34300309-aa29-4a78-9e6b-aa91b05ff4af@gmail.com>
Date: Wed, 8 Nov 2023 21:22:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] amd_iommu: report x2APIC support to the operating
 system
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
 <20231024152105.35942-6-minhquangbui99@gmail.com>
 <20231106193841-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20231106193841-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=minhquangbui99@gmail.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/7/23 07:39, Michael S. Tsirkin wrote:
> On Tue, Oct 24, 2023 at 10:21:05PM +0700, Bui Quang Minh wrote:
>> This commit adds XTSup configuration to let user choose to whether enable
>> this feature or not. When XTSup is enabled, additional bytes in IRTE with
>> enabled guest virtual VAPIC are used to support 32-bit destination id.
>>
>> Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
>> 0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
>> features only the legacy ones, so operating system (e.g. Linux) may only
>> detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
>> is kept so that old operating system that only parses type 0x10 can detect
>> the IOMMU device.
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> 
> 
> changes IVRS without updating expected files for tests.
> result seems to be CI failures:
> https://gitlab.com/mstredhat/qemu/-/jobs/5470533834


Thanks Michael, I am preparing the fix in the next version. I've read 
the instructions to update the test data in bios-tables-test.c. It says 
I need to create some separate patches to update the test data. Are 
there any reasons for this? I intend to change the binary and include 
the ASL diff into the commit message. Is it enough?

