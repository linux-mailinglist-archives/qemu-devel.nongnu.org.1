Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FAE70A849
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 15:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0MQk-00063w-TI; Sat, 20 May 2023 09:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0MQh-00062t-LM
 for qemu-devel@nongnu.org; Sat, 20 May 2023 09:15:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q0MQe-000202-UL
 for qemu-devel@nongnu.org; Sat, 20 May 2023 09:15:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 820E5746392;
 Sat, 20 May 2023 15:15:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 49B437457E7; Sat, 20 May 2023 15:15:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47458745706;
 Sat, 20 May 2023 15:15:18 +0200 (CEST)
Date: Sat, 20 May 2023 15:15:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, 
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, 
 linux-cxl@vger.kernel.org, linuxarm@huawei.com, 
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
In-Reply-To: <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
Message-ID: <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 20 May 2023, Peter Maydell wrote:
> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
>>
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>> specified as little endian.
>>
>> Define st24_le_p() and the supporting functions to store such a field
>> from a 32 bit host native value.
>>
>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>> used for the size part of the function name.

Maybe it's clearer to use 24 but if we want to keep these somewhat 
consistent how about using t for Triplet, Three-bytes or Twenty-four?

Regards,
BALATON Zoltan

>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  docs/devel/loads-stores.rst |  1 +
>>  include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
>> index d2cefc77a2..82a79e91d9 100644
>> --- a/docs/devel/loads-stores.rst
>> +++ b/docs/devel/loads-stores.rst
>> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>>  ``size``
>>   - ``b`` : 8 bits
>>   - ``w`` : 16 bits
>> + - ``24`` : 24 bits
>>   - ``l`` : 32 bits
>>   - ``q`` : 64 bits
>
> Can you also update the "Regexes for git grep" section
> below to account for the new size value, please?
>
> thanks
> -- PMM
>
>

