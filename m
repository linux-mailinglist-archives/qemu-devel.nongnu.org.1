Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03379BE66E2
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Oct 2025 07:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9d4Q-0005nt-Df; Fri, 17 Oct 2025 01:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d4D-0005NW-VM
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:31:59 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v9d44-0002Fb-Me
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:31:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.222])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4cntjS2TnNz5vpM;
 Fri, 17 Oct 2025 05:31:40 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 17 Oct
 2025 07:31:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001f12d9d3a-9a75-4460-9390-78b17ef9ed53,
 48F321F6F3AAA1B288770452BCFEC79A981EE5C7) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f1bd1978-2f2f-4df3-9a09-77e15ccb46cf@kaod.org>
Date: Fri, 17 Oct 2025 07:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits
 basis
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Coco Li
 <lixiaoyan@google.com>, <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <flwu@google.com>,
 <philmd@linaro.org>
References: <20251015011830.1688468-1-lixiaoyan@google.com>
 <20251015011830.1688468-2-lixiaoyan@google.com>
 <dbd7c26cf0a77545bffaccaed7c9a364f97ac7af.camel@codeconstruct.com.au>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <dbd7c26cf0a77545bffaccaed7c9a364f97ac7af.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 4c64469f-f015-44d4-94a4-632657ccf278
X-Ovh-Tracer-Id: 15329127232020450153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGy39/g7VddYU7IHDk4EFM/ak3RdrvKVj+Np12/GC/DF0dbH739MkJ5BayWbb2JSFN8mRPdjBtj7D9aLud5MkJSgFUeSf7451/+/qTJzp/K7GJ9hnLAfO9GNM2Nr2UD02lJGpMGTlUOpVvcskP6qrO438xEiN7fHe1e9FehZnhTYfTVk7l6UwDQV1gsMr+FNnZR+oeHhaIFYcUrv8RD66fhEGmP9Tpq327G0rXvRNS1DZIjN+yGuqpjsgMt+CXriQC4FFZzCWu9jRUn1LDQ58u9VOOchHpV0RQjFSz4QKAmav3e6YF+g7XxMi/nwC/ewcUm1EtaxlFsidJ3ZEstwdBSojwUqH2rY3KqnHLGoGQwGtCsQ3IsnhPPGXMph7hdl6RseXnrnAVaQ3HTLdolscY6LTLb+I9cVlDep+euDpQ8r5rFhhLfsbb1H7BRBhHz6hJEU+oHCGKXHleRSau2ENajTDEWn3QeOLs+HkbKsx9MhbqlITvR3Mo3ZCc1lbFRIwGV/Bsnfb8lkOZmhxYZQoLUJVmIO32H/txzpxylMNy5g7/S3cuZhXEIo0UREAzgaGJy+irXltuJNyzr9aNw5Z1XmmQQvbPdoLJfozMg0g9XusQOUfugmfBKy45BY0rIQ0CHoBT2U0H/xlO0LAcOq/qQuIADWHtWwCRCD73ZReLHpg
DKIM-Signature: a=rsa-sha256; bh=036JagTWklqcsM7825S7Bf/5Pda4V47gxaXL61jjmRA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1760679100; v=1;
 b=F8eMTPmU5hzLXIwgLuvKs/uoHe1jdYnPFmkYCP0ayBVbtw7WutcmddUj61b1zGhM9+tlAyck
 IKl1Ap5rZODaC8zkRzn9q03HiN1eD0OZszt6lXkUjShWhQtf0pEDMCnSEiSVV8BVNadiNIC2L83
 KgykS2viOnI/4hah+ESWCjEbRy4mqrxEkxwVmYUeXOz2X8tIM93UIxazANpFqYdn4+H8tF7MNQu
 3wgoKOIPgVVWrtWXCLvbYCZzkPkkveYBonxjuJMD2Uy6WcGX4lbqt+IkHBqaS4tyuczLN1ms2Pa
 ac6IHfwRfO22ZEGLq5NxyJ1nin8rn2LREevSGfrVyanUA==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/17/25 00:56, Andrew Jeffery wrote:
> On Wed, 2025-10-15 at 01:18 +0000, Coco Li wrote:
>> From: Felix Wu <flwu@google.com>
>>
>> Added 32 bits property for ASPEED GPIO. Previously it can only be access in bitwise manner.
>>
>> The changes to qobject is to index gpios with array indices on top of accessing with registers.
>> This allows for easier gpio access, especially in tests with complex behaviors that requires large number of gpios at a time, like fault injection and networking behaviors.
>>
>> Indexing multiple gpios at once allows qmp/side band client to no longer hardcode and populate register names and manipulate them faster.
>>
>> Signed-off-by: Felix Wu <flwu@google.com>
> 
> Thanks for updating the commit message. It should be properly wrapped,
> but I expect that can be done when the patch is applied.
> 
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

yeah. I can do that.


Thanks,

C.



