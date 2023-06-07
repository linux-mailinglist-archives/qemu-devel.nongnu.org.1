Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7B725612
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nmv-0003Ad-U5; Wed, 07 Jun 2023 03:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6nmu-0003AE-5v
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6nmr-0002f9-JF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686123656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDNPkea7B+111P2vERsbeA8uwD2ApZrYH0pEIQjLcWU=;
 b=UV1wG6NrwCvrZMd1L5Js2upORo61Kb9JfZv0VsxqCmgQMXvrmlwGef4ldk0Q/QPfCvkMaN
 jeY//aCTq9V7KAPkk2V4yGj6RYAU+Bprpm86Xb44+fhU02huGkpAwnh9JjlLU2DpFy3Mi3
 N7kGdAVj5mjmxSr91PcN1uruAQntuNc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-mCWF3_DOMXGagcVLXKXUJw-1; Wed, 07 Jun 2023 03:40:54 -0400
X-MC-Unique: mCWF3_DOMXGagcVLXKXUJw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30af6a5b6b0so3068517f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686123653; x=1688715653;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDNPkea7B+111P2vERsbeA8uwD2ApZrYH0pEIQjLcWU=;
 b=P6NGDJ0Q2eS20HS3eYlC1Qvhg6yNOmfscdMpXtUXokSyBST3BMtuNZHDSsc/vJHl+Q
 k0N2MZEnHJkJVWLDfVUu9Jhp3fbev2s1BNWcw3xcYIKsbc7Yihb/kpzbzd+NpRSZ1AU/
 al1EsH5wq5GIKI2LjdRAuZpSWvJtPLwsr6Dxh0zHQnzLvg7HCinI4xV1hVMDuu/+OM6X
 SrRzKBxXO3BnTAVEZFtOiiUiYrFFPXrLrl+DidwwdDULsSyZObJQwBWtYkJTJfI1TSlQ
 sefhfyuFpEMw6z6XzTPKLlW/NelZLO8XN23W9FR9vA+JUuOa1pHIqmRHB4YSwWpF0SUA
 hfiQ==
X-Gm-Message-State: AC+VfDy0We8toq4mxEyYr7hVNAXzltCYqtqq/ndXR4kftOQi33lKuUMB
 /x2vgJfESZKEHGxYz798+pShvFhcQ9b2sp2n4FAeqF7TxPrpCa/JrDcTtuJ/Xom4LM7dTB+edBc
 yzPNiq/ZD2ysm9LY=
X-Received: by 2002:a5d:5088:0:b0:30a:e4f0:40f7 with SMTP id
 a8-20020a5d5088000000b0030ae4f040f7mr3623250wrt.2.1686123653890; 
 Wed, 07 Jun 2023 00:40:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q1RosoyRBZjM8M2/uW+GkLhjCkM3NcrgyKTFMbBadNz91oX5Sl+cWnuGebEkkAFyOU38+cQ==
X-Received: by 2002:a5d:5088:0:b0:30a:e4f0:40f7 with SMTP id
 a8-20020a5d5088000000b0030ae4f040f7mr3623233wrt.2.1686123653526; 
 Wed, 07 Jun 2023 00:40:53 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 d17-20020a056000115100b0030af15d7e41sm14734657wrx.4.2023.06.07.00.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:40:52 -0700 (PDT)
Message-ID: <563434f6-c495-6354-58b6-5e6b50406d5b@redhat.com>
Date: Wed, 7 Jun 2023 09:40:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-ppc@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Kautuk Consul <kconsul@linux.vnet.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230606192802.666000-1-thuth@redhat.com>
 <CACPK8XcFC5pYwnu9gtMQx7i8kM5p+m3=TJ2cGG0ZgzKVn8u7fQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
In-Reply-To: <CACPK8XcFC5pYwnu9gtMQx7i8kM5p+m3=TJ2cGG0ZgzKVn8u7fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 07/06/2023 06.22, Joel Stanley wrote:
> On Tue, 6 Jun 2023 at 19:28, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The ppc64 tuxrun tests are currently failing if "slirp" has been
>> disabled in the binary since they are using "-netdev user" now.
>> We have to skip the test if this network backend is missing.
> 
> Do the boot tests require networking? I doubt they do.
> 
> You could instead remove the -netdev user option if slirp is not present.

Yes, that's an option. Not sure whether it's worth the effort here, though, 
since most of our CI pipelines run with slirp enabled anyway (it's just one 
job, avocado-cfi-ppc64-s390x, which is failing due to this missing check)

  Thomas


>> Fixes: 6ee3624236 ("improve code coverage for ppc64")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/avocado/tuxrun_baselines.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
>> index 3a46e7a745..e12250eabb 100644
>> --- a/tests/avocado/tuxrun_baselines.py
>> +++ b/tests/avocado/tuxrun_baselines.py
>> @@ -184,6 +184,7 @@ def common_tuxrun(self,
>>
>>       def ppc64_common_tuxrun(self, sums, prefix):
>>           # add device args to command line.
>> +        self.require_netdev('user')
>>           self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22',
>>                            '-device', 'virtio-net,netdev=vnet')
>>           self.vm.add_args('-netdev', '{"type":"user","id":"hostnet0"}',
>> --
>> 2.31.1
>>
>>
> 


