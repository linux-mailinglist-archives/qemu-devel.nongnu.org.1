Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10582BA2AC6
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 09:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dl-00034X-35; Fri, 26 Sep 2025 03:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22ba-0008Qt-M9
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22bJ-00078o-CN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758870634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0K0LTKFIfWtWq/ncnJeZZBY7UP+S0QGSXyf3nqKABxc=;
 b=N1Dg73Gr7KyPpR8NqKUx3SAQ/91zc/RTpDVem8xbscHUF+tMCL0mDcuYtQDD0iQrQam1fA
 q13r9FK4neHUtZT9OriZavnuLahN84f1N8ufctlAE6ilNpGqF5RtkH1kC39n7ByYmuKsOn
 JQUvGQ8XKZi5NRJWPtnYqdzk0Jub3uQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Bd4BnkXAN_SEmdYg6WI2zQ-1; Fri, 26 Sep 2025 03:10:32 -0400
X-MC-Unique: Bd4BnkXAN_SEmdYg6WI2zQ-1
X-Mimecast-MFC-AGG-ID: Bd4BnkXAN_SEmdYg6WI2zQ_1758870631
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45de07b831dso11560945e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758870631; x=1759475431;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0K0LTKFIfWtWq/ncnJeZZBY7UP+S0QGSXyf3nqKABxc=;
 b=eAda40xEg0jB2EQJoC5t2NOWrYvzDpGC9bBLc7M6lkPTU6QhTIddpLB38Ij+7YnDqm
 pYuDRWwrWx6WLz+47vTGRbM7rpZH9QoNAsGZZlQZIlogNJS/8uOWHaGXUHNMR4kk11ER
 BwiiPdGy24F4eQoKkfuGDZTYjYRHxi8HJQa4Dwe74eD7wYzeqicL52M0HK1LNYYd/4Mw
 Y7+RyI9fRPGn7LYNtL7Ul1Zm1PeEXXjhR3aOSv8AG84fgNblCLByJr8b2A9AXgDMLejV
 NBE2fkmxv6VoIqEL39aO6/x6sUENRDsibxjULyfmyjjtMmii3T6EpLgDQ7g7dYt+zkrZ
 sYmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQp4cTRgoVfWeuX3ZxQTC1/S8+YxQXWPUBHfmWEMs8b0b1eSxSTnXydvUgf5wh3MOMZwBFmvgc10Yr@nongnu.org
X-Gm-Message-State: AOJu0YwDG6HYzqK2NNW9Ef3Cj8WTJ6goVfrRJ1LWaXb9w+tXv45TSBEo
 NxlmvFoL5l4l8QyXBUlnkBA7tDrV2qkuHrreGW/Hu2qlPijkAluOJlNMty5Ecp8Pr7Jxv+JFnr5
 JT+FoSNP0+soInNPh8HBBLOP9l+5+gt9fzdsMXdrsQ0FnDEM5s1qdx4dI
X-Gm-Gg: ASbGncuOI2DTQ1Ukf7ENL+TaOYFgUNqk1TY1VRNfHpS1iD5pRHo0tlBtRjDaWsj1R0B
 R2QvC1rKIjlJim/ofm3wm4Gv42HOyUHCswwkc/+aNyeOvWoQvw5frbPaHZL6MKCwpc8+yigTB/W
 AMXvUIK84cmDUS1wgkn+SS8MB/7A0pc8mJVADOcAEtik+9MWKOVi3g8hJyPMKGklNtE1TuZd3XH
 8kTL34QgvqACZEmOAxRGjBbyro8G4onO3TxHm9ASM7RSRcZBQzkO9sAM02WlAj39kREyQpKS4rh
 x8ESihPSZGrmGYb8iGaPpgLetjMBwiVvKCFk/5ldW6RjQsoZ/or/YGn9xgaT8y6wgTLNm027wZR
 D8CGHOw==
X-Received: by 2002:a05:600c:8b5b:b0:46e:3dcb:d9a3 with SMTP id
 5b1f17b1804b1-46e3dcbdc9bmr7845485e9.12.1758870631338; 
 Fri, 26 Sep 2025 00:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC8ApxEEqCcyTQzXfYCRorE+Ba5GYsjFeBZSU5DNqZ1F0BFBhHw8m/J0DY3CYjBWx7oLaq+w==
X-Received: by 2002:a05:600c:8b5b:b0:46e:3dcb:d9a3 with SMTP id
 5b1f17b1804b1-46e3dcbdc9bmr7845105e9.12.1758870630881; 
 Fri, 26 Sep 2025 00:10:30 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b562d8sm62795155e9.0.2025.09.26.00.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:10:30 -0700 (PDT)
Message-ID: <650efc3c-26e5-46e7-bd3c-c186e443939d@redhat.com>
Date: Fri, 26 Sep 2025 09:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] tests/functional: replace avocado process with
 subprocess
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-6-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250926051542.104432-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The standard python subprocess.check_call method is better than
> avocado.utils.process as it doesn't require stuffing all args
> into a single string.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/reverse_debugging.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
> index f9a1d395f1..a7ff47cb90 100644
> --- a/tests/functional/reverse_debugging.py
> +++ b/tests/functional/reverse_debugging.py
> @@ -11,6 +11,7 @@
>   # later.  See the COPYING file in the top-level directory.
>   import os
>   import logging
> +from subprocess import check_output
>   
>   from qemu_test import LinuxKernelTest, get_qemu_img
>   from qemu_test.ports import Ports
> @@ -100,7 +101,6 @@ def vm_get_icount(vm):
>   
>       def reverse_debugging(self, shift=7, args=None):
>           from avocado.utils import gdb
> -        from avocado.utils import process
>   
>           logger = logging.getLogger('replay')
>   
> @@ -111,8 +111,9 @@ def reverse_debugging(self, shift=7, args=None):
>           if qemu_img is None:
>               self.skipTest('Could not find "qemu-img", which is required to '
>                             'create the temporary qcow2 image')
> -        cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
> -        process.run(cmd)
> +        out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
> +                           encoding='utf8')
> +        logger.info("qemu-img: %s" % out)
>   
>           replay_path = os.path.join(self.workdir, 'replay.bin')

Reviewed-by: Thomas Huth <thuth@redhat.com>


