Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 733AF90E6E4
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jun 2024 11:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrYJ-0002QE-D5; Wed, 19 Jun 2024 05:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sJrYH-0002Pd-4C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:24:25 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sJrYE-0004wp-Ii
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1718789062; x=1750325062;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=P5qUMmTvxRhRm+xvXml4/gq2sDOAqp/7/NAm9NbVRRo=;
 b=ChxMDk33ExFY5kUKyNwx4BRCUy9yzGNy6MpAhr7lBU5LYlEyArpdFNpb
 kmsoGN7+KPjJA67wDkt2RSZux/NCPeI8YgIXGmXIsJX2RbvV3If2EKfm8
 6XSpczDnezh9Gu4K58eM6nR1N6l/t4Gkl1Hi7q1n7On3n5tFASf/QXBhc
 J2Lvo9wS1flAmW4WmXNAwPtSRvriHz4QsMufZjCNXktUT9G7wn0mS+tgs
 LA6pSNcgnAMo8LNZme+4csFGongEvAfrjw4ueTVwubac5TKFoEAyO7v7C
 Sv/8HpYzlQE7c0bd5Moh6RKCIK1U7zVguLaEcH/huk6n3GcxXm/UuR2rZ A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="164163246"
X-IronPort-AV: E=Sophos;i="6.08,250,1712588400"; d="scan'208";a="164163246"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 18:24:19 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DDD62D800A
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 18:24:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 26BA9D8B0F
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 18:24:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 974BEE3690
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 18:24:15 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 840D11A0002;
 Wed, 19 Jun 2024 17:24:14 +0800 (CST)
Message-ID: <b9bbf3bc-9125-4cbb-b127-613b841dc9a8@fujitsu.com>
Date: Wed, 19 Jun 2024 17:24:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Dave Jiang <dave.jiang@intel.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net, 
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
In-Reply-To: <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28462.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28462.006
X-TMASE-Result: 10--16.853000-10.000000
X-TMASE-MatchedRID: NuHz/06ZeuaPvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
 jjdoOP1bp3Z/y3zTL9+zN6XcSN8uuHerlGbz8OXFolVO7uyOCDUXivwflisSrEJsNXD374+pO+W
 Rk1kOc5MCcJ+0x3yT8twnF1a+MpDfC5dVqsgzBjuOFfLQqF6P0tUEOicf335WUoV94zwLp3VJ9L
 43nm/22bqZhYf6F5ZElyW1ZrZx68b/awIuxLRW1EhwlOfYeSqxlDt5PQMgj00zAwv94MqCLh8aR
 hKglPt8mNVEdxRO2BKiQrGQ0QrIUcfdkIlEiI2knVTWWiNp+v9AApRfVHzqNN9RlPzeVuQQunqB
 IQj+1Jm8HpxVQnR8jFIgVt7sAjKWDOQhvAmAT8UDccazfMVOqLFcDzCo2ZtWmWGz8DF0pgYRRLf
 e6UPgvOt2gGXLArR6zG7gfWFsstqR9GF2J2xqM4MbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM5
 rqDwqtjBK61ITomYqktjwv041Qk/+6+AIb3vIoeBQZ5OZ7tJxxR93z5vKGpA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



在 2024/6/19 7:35, Dave Jiang 写道:
> 
> 
> On 6/18/24 9:53 AM, Shiyang Ruan wrote:
>> Background:
>> Since CXL device is a memory device, while CPU consumes a poison page of
>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>> which-First path is configured.  This is the first report.  Then
>> currently, in FW-First path, the poison event is transferred according
>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>   -> CPER -> trace report.  This is the second one.  These two reports
>> are indicating the same poisoning page, which is the so-called "duplicate
>> report"[1].  And the memory_failure() handling I'm trying to add in
>> OS-First path could also be another duplicate report.
>>
>> Hope the flow below could make it easier to understand:
>> CPU accesses bad memory on CXL device, then
>>   -> MCE (INT18), *always* report (1)
>>   -> * FW-First (implemented now)
>>        -> CXL device -> FW
>> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>      * OS-First (not implemented yet, I'm working on it)
>>        -> CXL device -> MSI
>> 	      -> OS:CXL driver -> memory_failure() (2.b)
>> so, the (1) and (2.a/b) are duplicated.
>>
>> (I didn't get response in my reply for [1] while I have to make patch to
>> solve this problem, so please correct me if my understanding is wrong.)
>>
>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>> to check whether the current poison page has been reported (if yes,
>> stop the notifier chain, won't call the following memory_failure()
>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>> page already handled(recorded and reported) in (1) or (2), the other one
>> won't duplicate the report.  The record could be clear when
>> cxl_clear_poison() is called.
>>
>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>

...

>> +
>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>> +{
>> +	struct cxl_contains_hpa_context ctx = {
>> +		.contains = false,
>> +		.hpa = hpa,
>> +	};
>> +	struct cxl_port *port;
>> +
>> +	port = cxlmd->endpoint;
>> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> 
> Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.

OK, I'll remove this.

> 
> Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
> guard(cxl_regoin_rwsem);
> before the if statement above.

Got it.  I didn't realize it before.  Will add it.


BTW, may I have your opinion on this proposal?  I'm not sure if the 
Background and problem described above are correct or not.  If not, it 
could lead me in the wrong direction.

Thank you very much!


--
Ruan.

> 
> DJ
> 

