Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6021376BC40
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQu0Z-0008Ou-VA; Tue, 01 Aug 2023 14:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQu0X-0008OU-VD
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQu0W-0007z6-16
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690914125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMWEXE4289OW2fxAgx+5sZCtzAKdDRTIROOvE7k4EBM=;
 b=OgVrHeEVob5Nyxv+IJmH8tR91vIcHlAK3MXfIO+duGftJ/77d/ryCV6RrboJpmujIeYgXb
 xQzjFozLcgXwIxRJzsDXzOHqr74KjsV4ZYRTpz7RYueT5VXZ0AiVwUnu4c20Ngr/PGnxJ2
 7p2v7sEIUVZnFBqN13G0jk3IRZ4VH7A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-tF5VX6IpMN-LO7n-6Lv4bw-1; Tue, 01 Aug 2023 14:22:04 -0400
X-MC-Unique: tF5VX6IpMN-LO7n-6Lv4bw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76c939bc1adso591597285a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690914123; x=1691518923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMWEXE4289OW2fxAgx+5sZCtzAKdDRTIROOvE7k4EBM=;
 b=fW62xbRSYcbPahJgiaKNtQtvx8N0oCdKUuFe6UoeCJKTr2lSZBxQYYPqGZFz4OihEO
 z5D4y7cHdCzKe6dLedCPGOa+NAKuZ1z5rZp8TL00IT3sGr/5Kxu4jmhEqx6Zf1ArxQ0C
 CkBkchG5iku3fO+lpEJ6qH0Ga27uo+xdl83s7V/pGHUZr/46uPsYxTm8E0eOdpE0B/Jw
 +fpH1KmCufOqsQ8DPSbGF3DZolauLsxq3DkbBy6MzP+Bf4TSKWMcz9culLXvEfOkxWEP
 pR7IsqqVdvyfkdEj9bw0/KoOzbvyYzKYms7U5twvteDHWfsR9n1OpMNpCsgcuUKQbdEx
 RYNw==
X-Gm-Message-State: ABy/qLZUkAt52zHyVcNKH25+2Gq0vsMy5PJnhGPxnl9Irjh+cfYM1rRh
 3pPiIi86YxiITLQbhXcVXaYKyy5ws3Fqs4j/pJ+2Wxqqy6J+YBm4DrU29cGhT1sZko0YU0VNHaH
 ZuTmatxL77SrJDKE=
X-Received: by 2002:a05:620a:2948:b0:76c:56c6:8c9f with SMTP id
 n8-20020a05620a294800b0076c56c68c9fmr18773960qkp.48.1690914123610; 
 Tue, 01 Aug 2023 11:22:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/JEIRkkqZoFSwaBy007vV9igQXiwtqhxv+GWX1k5Y39prb/YV18fKRN+AcnuOp4tKrUN56w==
X-Received: by 2002:a05:620a:2948:b0:76c:56c6:8c9f with SMTP id
 n8-20020a05620a294800b0076c56c68c9fmr18773943qkp.48.1690914123358; 
 Tue, 01 Aug 2023 11:22:03 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 m12-20020ae9e70c000000b007339c5114a9sm4334859qka.103.2023.08.01.11.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:22:02 -0700 (PDT)
Message-ID: <6c4e3b3a-8767-8591-f40e-84cbcf0cccde@redhat.com>
Date: Tue, 1 Aug 2023 20:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/8] gitlab: speed up msys windows jobs with GCC
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <87bkfqyilp.fsf@pond.sub.org> <ZMkYQoTh+KS9rkLW@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZMkYQoTh+KS9rkLW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/08/2023 16.35, Daniel P. Berrangé wrote:
> On Tue, Aug 01, 2023 at 03:53:22PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> This is an alternative and/or complementary to Thomas' proposal
>>> to use CLang with msys:
>>>
>>>    https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05402.html
>>>
>>> First of all, the current msys installer we're using is over 12
>>> months out of date. Thus after running the install, pacman then
>>> replaces most of what we've just installed with new downloaded
>>> content. Using the most update installer cuts 3+1/2 minutes off
>>> the msys install time - 7 minutes becomes 3+1/2.
>>>
>>> Secondly, QEMU defaults to compiling with -O2 and this is more
>>> computationally expensive for GCC. Switching to -O0 drops the
>>> build time from 60 minutes down to 45 minutes.
>>
>>  From the fine manual[*]: "The effectiveness of some warnings depends on
>> optimizations also being enabled.  For example '-Wsuggest-final-types'
>> is more effective with link-time optimization and some instances of
>> other warnings may not be issued at all unless optimization is enabled.
>> While optimization in general improves the efficacy of control and data
>> flow sensitive warnings, in some cases it may also cause false
>> positives."  Do we care?
> 
> In general, yes, we do care.
> 
> In this specific case though, we're battling to figure out the lesser
> of multiple evils.

I agree. Additionally, we also test compiling for Windows with the MinGW 
cross compiler suite in a Fedora container, and we still use the default 
optimization there, so we should have that covered.

  Thomas



