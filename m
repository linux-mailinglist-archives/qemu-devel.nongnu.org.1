Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDBBB26685
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 15:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXiT-0002qJ-3S; Thu, 14 Aug 2025 09:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.zhang@huaweicloud.com>)
 id 1umMlU-0003XF-DE
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 21:28:25 -0400
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.zhang@huaweicloud.com>)
 id 1umMlM-00062W-Qs
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 21:28:24 -0400
Received: from mail.maildlp.com (unknown [172.19.163.235])
 by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2SKl4B24zYQtxZ
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 09:27:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
 by mail.maildlp.com (Postfix) with ESMTP id 320361A058E
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 09:27:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
 by APP4 (Coremail) with SMTP id gCh0CgAHgxOVO51oPzBtDg--.8664S3;
 Thu, 14 Aug 2025 09:27:52 +0800 (CST)
Message-ID: <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
Date: Thu, 14 Aug 2025 09:27:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>, LTP List <ltp@lists.linux.it>,
 chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>,
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
 Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
 Baokun Li <libaokun1@huawei.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAHgxOVO51oPzBtDg--.8664S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fAFW7tF4UtrWrWr1DGFg_yoW8Zw4xpF
 WrCF98tr45X345ArsFvw4IgFyUtrZ8Krn5Wr1rtw17C39IkryDZF4SgF1Y9F97Jr4DCFyr
 ZrsFv3sIyryDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
 6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
 vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
 xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
 0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
 6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
 14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
 Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
 6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
 j6a0PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
Received-SPF: pass client-ip=45.249.212.51;
 envelope-from=yi.zhang@huaweicloud.com; helo=dggsgout11.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 14 Aug 2025 09:09:24 -0400
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

On 2025/8/13 22:53, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
>> Hi Greg,
>>
>>>> 2)
>>>>
>>>> The following list of LTP syscalls failure noticed on qemu-arm64 with
>>>> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
>>>>
>>>> Most failures report ENOSPC (28) or mkswap errors, which may be related
>>>> to disk space handling in the 64K page configuration on qemu-arm64.
>>>>
>>>> The issue is reproducible on multiple runs.
>>>>
>>>> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
>>>>
>>>>   - fallocate04
>>>>   - fallocate05
>>>>   - fdatasync03
>>>>   - fsync01
>>>>   - fsync04
>>>>   - ioctl_fiemap01
>>>>   - swapoff01
>>>>   - swapoff02
>>>>   - swapon01
>>>>   - swapon02
>>>>   - swapon03
>>>>   - sync01
>>>>   - sync_file_range02
>>>>   - syncfs01
>>>>
>>>> Reproducibility:
>>>>  - 64K config above listed test fails
>>>>  - 4K config above listed test pass.
>>>>
>>>> Regression Analysis:
>>>> - New regression? yes
>>>
>>> Regression from 6.16?  Or just from 6.15.y?
>>
>> Based on available data, the issue is not present in v6.16 or v6.15.
>>
>> Anders, bisected this regression and found,
>>
>>   ext4: correct the reserved credits for extent conversion
>>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
>>
>> Report lore link,
>>
>> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)
> 

Hi,

This issue has already fixed in 6.17-rc1 through this series:

https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/


To fix this issue in 6.16, it's necessary to backport the whole series
instead of just pick 5137d6c8906b ("ext4: fix insufficient credits
calculation in ext4_meta_trans_blocks()") and 95ad8ee45cdb {"ext4: correct
the reserved credits for extent conversion").  Otherwise, this will make
the problem more likely to occur.

Thanks,
Yi.


