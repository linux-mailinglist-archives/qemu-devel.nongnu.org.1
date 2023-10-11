Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D47C492A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 07:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqRfN-00024P-DG; Wed, 11 Oct 2023 01:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqRfJ-000242-AH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqRfD-0007u0-Ik
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697001701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1gdC2cYCvYgQHBP8nlVUSNLRNe556ZkwOK5uEMyGQsk=;
 b=EQGi5Mycuy5GskjiuV8dB7nor0rU2vhSUnZbQIqFHWzoyh2e/Qz78iyC0F6FzfMfvRnBwi
 5gAniL77dZtsv38EdkTGfs1j/w/sJDhKOBvmyQiR2R3pvLH7DbCTTa9GHNbWYUp8yIJJ17
 JVjAXmTsqM7yJUDJ9dQQ8a9AqcjfIWk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-sBXqiGxxNr6JiPfgEx3umA-1; Wed, 11 Oct 2023 01:21:40 -0400
X-MC-Unique: sBXqiGxxNr6JiPfgEx3umA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7742bab9c0cso681532185a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 22:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697001700; x=1697606500;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gdC2cYCvYgQHBP8nlVUSNLRNe556ZkwOK5uEMyGQsk=;
 b=uuciyiTVDDVuojhiEoNBQGCUWsBGf8TkzH60Av0/FuJVSn7f/r2DwcAbPeJ4JeemzG
 mtlBd5DdQV6C3TSTTmzOcSBgwGxS+kqDmxNxtfLMCOcWBhGo2HX9w1ePCYEJz5y9Wn3m
 2agft+qfNxnC0CpxclRG2JaE/qLfIjBzqhBwY6KY8AG43z/gmb0nwZYL1uhxky7WLRn8
 ssTNMH7Oz/rlvUGKF6jwI7vxrSHq0Ai2aHfrMCd0CNaRZB87Ah5sLPMzUM5nsKqfyjKv
 3BYb+qg5a59RM5TPXZ45kqjMYzjr6G9Ol4NE75tEKJospmJ15R0Tg2DLWUibqHXwhrP1
 c+4A==
X-Gm-Message-State: AOJu0YxHDIOzSoihTZrNbZ5ZUmnZ+Ntrjty/Ij3WDV1HA3n6hx1Ev08T
 EtLerfjVRW7+8vNfiiNpNvz77le2DQ+qES8ECtD+6ic4RZjB83g/ugRRiC/vzps3znvJJ9CAfXH
 z/KpB5mPSWTTn9O8=
X-Received: by 2002:a05:620a:2907:b0:775:c5cc:7ce4 with SMTP id
 m7-20020a05620a290700b00775c5cc7ce4mr21905644qkp.13.1697001700054; 
 Tue, 10 Oct 2023 22:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnLIQgURXhWHaXzspHEe4MHsKXbYRkwRSBlbNG3RDOjVJ8DvTdf/k/HxYEaTCmvuBEM1EPTw==
X-Received: by 2002:a05:620a:2907:b0:775:c5cc:7ce4 with SMTP id
 m7-20020a05620a290700b00775c5cc7ce4mr21905636qkp.13.1697001699764; 
 Tue, 10 Oct 2023 22:21:39 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 w22-20020ac843d6000000b0041b12c06bcfsm3548411qtn.40.2023.10.10.22.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 22:21:39 -0700 (PDT)
Message-ID: <781330fc-85b3-4ef1-8f07-1cc5fc5e4ad2@redhat.com>
Date: Wed, 11 Oct 2023 07:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230725113632.2386874-1-peter.maydell@linaro.org>
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
In-Reply-To: <20230725113632.2386874-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 25/07/2023 13.36, Peter Maydell wrote:
> In query_port() we pass the address of a local pvrdma_port_attr
> struct to the rdma_query_backend_port() function.  Unfortunately,
> rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
> and the two are not the same length.
> 
> Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
> long, and ibv_port_attr is 52 bytes, because it has a few extra
> fields at the end.
> 
> Fortunately, all we do with the attrs struct after the call is to
> read a few specific fields out of it which are all at the same
> offsets in both structs, so we can simply make the local variable the
> correct type.  This also lets us drop the cast (which should have
> been a bit of a warning flag that we were doing something wrong
> here).
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know anything about the rdma code so this fix is based
> purely on looking at the code, and is untested beyond just
> make check/make check-avocado.
> ---
>   hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index c6ed0259821..d31c1875938 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>   {
>       struct pvrdma_cmd_query_port *cmd = &req->query_port;
>       struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
> -    struct pvrdma_port_attr attrs = {};
> +    struct ibv_port_attr attrs = {};
>   
>       if (cmd->port_num > MAX_PORTS) {
>           return -EINVAL;
>       }
>   
> -    if (rdma_backend_query_port(&dev->backend_dev,
> -                                (struct ibv_port_attr *)&attrs)) {
> +    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
>           return -ENOMEM;
>       }
>   

  Hi Peter,

this seems to fail with Clang:

../../devel/qemu/hw/rdma/vmw/pvrdma_cmd.c:144:59: error: implicit conversion 
from enumeration type 'enum ibv_port_state' to different enumeration type 
'enum pvrdma_port_state' [-Werror,-Wenum-conversion]
     resp->attrs.state = dev->func0->device_active ? attrs.state :
                       ~                             ~~~~~~^~~~~
../../devel/qemu/hw/rdma/vmw/pvrdma_cmd.c:146:33: error: implicit conversion 
from enumeration type 'enum ibv_mtu' to different enumeration type 'enum 
pvrdma_mtu' [-Werror,-Wenum-conversion]
     resp->attrs.max_mtu = attrs.max_mtu;
                         ~ ~~~~~~^~~~~~~
../../devel/qemu/hw/rdma/vmw/pvrdma_cmd.c:147:36: error: implicit conversion 
from enumeration type 'enum ibv_mtu' to different enumeration type 'enum 
pvrdma_mtu' [-Werror,-Wenum-conversion]
     resp->attrs.active_mtu = attrs.active_mtu;
                            ~ ~~~~~~^~~~~~~~~~
3 errors generated.

Could you please have a look ?

  Thomas


