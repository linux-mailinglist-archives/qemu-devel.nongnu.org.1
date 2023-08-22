Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AA7845C6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTTS-0001Qa-Fq; Tue, 22 Aug 2023 11:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYTTQ-0001Jk-5h
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:39:16 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYTTN-0007u4-NO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692718753; x=1724254753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9kngf6wYTpV66d+4lW1aCHCO61j099WF3nKx5ig4uLg=;
 b=AgdeKSw8ZyBqbbTXTZ4Iu44mQkoq1qW9iEhn7JhA57GPSZZMkU8LxPCY
 4LGYBqld9dFw45gw0vt5M4kqg82FI6itUZvJs/vb0wK4d66fR3DinCnyu
 fLMkF5mLiuLxpQ62aqiduaZQNBtmq1ilu/xWAuK+scNYmZUUVt8JA0++q
 A6P5LC9zMJTheYi40VQvFMt9htZ7hky8IcyQc5D7dAttd5obCietmCN0g
 cma8AVOD65hz9ineCLe0TN+t6B7kvWK2oowfgRA3uIORY/erLv6R0mzjz
 AFxow5yzyPBCcDFidbOQYdH1IpmWZo1IB4PiCKat/NEa+DP2KjqwtBnTS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377674913"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="377674913"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 08:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="1067105293"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="1067105293"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 08:39:04 -0700
Message-ID: <1241e07d-c9ee-1c63-7009-f5e9f2a040a4@intel.com>
Date: Tue, 22 Aug 2023 23:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 32/58] i386/tdx: Track RAM entries for TDX VM
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-33-xiaoyao.li@intel.com>
 <ZOMwin3eGaYLNNQh@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOMwin3eGaYLNNQh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 8/21/2023 5:38 PM, Daniel P. Berrangé wrote:
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> index bb806736b4ff..ed617ebab266 100644
>> --- a/target/i386/kvm/tdx.c
>> +++ b/target/i386/kvm/tdx.c
>> +static int tdx_accept_ram_range(uint64_t address, uint64_t length)
>> +{
>> +    uint64_t head_start, tail_start, head_length, tail_length;
>> +    uint64_t tmp_address, tmp_length;
>> +    TdxRamEntry *e;
>> +    int i;
>> +
>> +    for (i = 0; i < tdx_guest->nr_ram_entries; i++) {
>> +        e = &tdx_guest->ram_entries[i];
>> +
>> +        if (address + length <= e->address ||
>> +            e->address + e->length <= address) {
>> +                continue;
> Indented too far
> 

Fixed.

Thanks!
-Xiaoyao

