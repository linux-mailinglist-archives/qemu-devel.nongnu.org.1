Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9157EA07D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ZBE-0001ja-En; Mon, 13 Nov 2023 10:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2ZBC-0001jO-SY
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2ZBA-0007z3-Nf
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699890527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IITMFv/EI7Zu33pKhb7Vv7h1zZ2hSj6yV0+8SNIvySA=;
 b=Xb8L0kuIjG5VT1DQqV0V6GTZkB1TYxZy5XGvnmvfORyaam2/rdlnyK/95l+HVUnNwbVb6D
 Y3oaxuZU4QLpkDLdlCMXpZ8JApq5Cc2nF0VcQUuj4IHN2KIoCYYzSyahSJuBeDRR0OmH2c
 gAY1S6FzoahNaNnJgjmmTFjaFqIUnbA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-hFbg0MtdNPuHuGT26SSz9A-1; Mon, 13 Nov 2023 10:48:45 -0500
X-MC-Unique: hFbg0MtdNPuHuGT26SSz9A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d026cae6eso52493406d6.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699890525; x=1700495325;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IITMFv/EI7Zu33pKhb7Vv7h1zZ2hSj6yV0+8SNIvySA=;
 b=ZJkUG+QF7zYlbuMwh0LjVJ+BDYYSVuUFQUP2dVvSK68wCX5TP2zgSgHPmZR/ofTVIq
 0eJW1jcFc8z6vqtbZS35lxuq8fvmMe6kUZDfy7jvoopHCXan8Juw98JmpUik7E+IZMEp
 vxItqYbLEHO4WQGSkrEWcgphhy9teB5CYzaaQLUCRaFDq0V6ka/2z1UvzAyOMcOU+y65
 5EWNSDM27nh1ZHJFG8wzY6Tpw4jddeZi6ffLIg8vaZJ5fI3NIrL709L6xDEDo7ViWv8I
 6ZdW2Lf9+jb1zE9mfQTklsbZDIhknDIx5HQbbd/HC41YSXHQf90JncBYxRCwCzsH0O6a
 LKdg==
X-Gm-Message-State: AOJu0YwjxMqNqIz7b57rMJVsqar6ZjFUCTWxV2O/KmG7N7+BrMyZw9+w
 PFj3/Dv6g5eHcawe27d2q2JwqYqwMKNqNpHrr/bqs3QWa1As9v/6J62XlSteQwkwkFp0xPgD/ma
 FmkYEBc+ZMvgGn4M=
X-Received: by 2002:ad4:4e0f:0:b0:65d:475a:a2f6 with SMTP id
 dl15-20020ad44e0f000000b0065d475aa2f6mr7232458qvb.40.1699890525577; 
 Mon, 13 Nov 2023 07:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl7nNJRjcLUkz3pHEuz/Qc19Tkk7JN0ni/2kPt6s94q2jfzcYrtlIi0vSk6NRfPCJphBnMyg==
X-Received: by 2002:ad4:4e0f:0:b0:65d:475a:a2f6 with SMTP id
 dl15-20020ad44e0f000000b0065d475aa2f6mr7232435qvb.40.1699890525294; 
 Mon, 13 Nov 2023 07:48:45 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 mg3-20020a056214560300b0065afcf19e23sm2134863qvb.62.2023.11.13.07.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 07:48:45 -0800 (PST)
Message-ID: <55daeff7-8595-4f9d-b69a-cbc02b42517e@redhat.com>
Date: Mon, 13 Nov 2023 16:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_s390_ccw_virtio.py: Fix
 SyntaxWarnings from python 3.12
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
References: <20231113140721.46903-1-thuth@redhat.com>
 <2d938d82-d7ca-4cd1-b4eb-a24bc4b6c337@linaro.org>
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <2d938d82-d7ca-4cd1-b4eb-a24bc4b6c337@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/11/2023 15.47, Philippe Mathieu-Daudé wrote:
> On 13/11/23 15:07, Thomas Huth wrote:
>> Python 3.12 now warns about backslashes in strings that aren't used
>> for escaping a special character from Python. Silence the warning
>> by using raw strings here instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/machine_s390_ccw_virtio.py | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/tests/avocado/machine_s390_ccw_virtio.py 
>> b/tests/avocado/machine_s390_ccw_virtio.py
>> index e1f493bc44..ffd914ded9 100644
>> --- a/tests/avocado/machine_s390_ccw_virtio.py
>> +++ b/tests/avocado/machine_s390_ccw_virtio.py
>> @@ -36,8 +36,8 @@ def wait_for_crw_reports(self):
>>       dmesg_clear_count = 1
>>       def clear_guest_dmesg(self):
>>           exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
>> -                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
>> -                    'dm_clear ' + str(self.dmesg_clear_count))
>> +                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
>> +                    r'dm_clear ' + str(self.dmesg_clear_count))
>>           self.dmesg_clear_count += 1
>>       def test_s390x_devices(self):
>> @@ -121,15 +121,15 @@ def test_s390x_devices(self):
>>                                       'cat 
>> /sys/bus/ccw/devices/0.1.1111/cutype',
>>                                       '3832/01')
>>           exec_command_and_wait_for_pattern(self,
>> -                    'cat 
>> /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
>> -                    '0x1af4')
>> +                    r'cat 
>> /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
>> +                    r'0x1af4')
> 
> Do we really need to escape the hex number?

No, technically not, but it look kind of ugly to me if the strings that are 
indented on the same level start with a different prefix, so I'd prefer to 
keep them.

> 
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

  Thomas


