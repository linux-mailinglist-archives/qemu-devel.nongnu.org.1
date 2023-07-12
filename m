Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4C67511B8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgBy-0006E3-Nm; Wed, 12 Jul 2023 16:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJgBr-0006DO-5q
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJgBk-0002qW-TS
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689192709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Etu2k6zwAG9Me27JlIKcIeXqzfl+VhnaqZBcAwslO4o=;
 b=S7CngY5oetCPc/c5ingoFtndLVImuU4LtjucS7xSHJaiGc08kdohRrbXyvl0LQ0DrSrNzh
 AjQKnO8rEwue8wvhhFaC3obSxlc9qkZZseXGiuxroUm7CRVdd9ShTvKKEqNNhvWY0KRCR0
 dYrA1h0t4Qy5Vjz4065H7lbx4Rcgwfk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-a40IMha2P3KJh-9UgqZFFA-1; Wed, 12 Jul 2023 16:11:47 -0400
X-MC-Unique: a40IMha2P3KJh-9UgqZFFA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b7c5c7c843so8237640a34.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689192707; x=1691784707;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Etu2k6zwAG9Me27JlIKcIeXqzfl+VhnaqZBcAwslO4o=;
 b=DycCbD2u6ELa0NL3NpMLiXwLZlfq4sSJdqElhy8wUp7Ykf3exrlq8qyklVzdxTsQlu
 JO16eup51nAII+WZPhcaiIMtKcATBnkowhX8ALiWc16c2GAacyHPNYTUtuFugO1jGwiR
 wSPXsvfvdNUQUDOlTblInyN88Zd5E9ylKn1XkJor7J+dN9RnmjLCTNeRikaq3ByetPBg
 gQa/H5beBQ7H37mUMQYWcQOOPwYPJEIaoQjvrjSDUw6KZyLPQtF1vdTH4UPeoGwSEDxI
 funNkdhfXPPKgAUak/tcRokAmKFKLGAsm1EYkX3BCL8VmuXOP+ecNH++9Ho811ubfsOC
 9z1Q==
X-Gm-Message-State: ABy/qLZt+a6CDp5ZRAKzK9f2XPxVB1FClqYdR2AH2lojrg/Ju/j+tC5n
 MGijnYbGBvSQuI/O2i1fVUfov4Hw2K6rEsGjmpsMF2C4yEHcFwbou5/jzMJRYOhMo00ybYciq6V
 vHe0EYfBrTjghISc=
X-Received: by 2002:a9d:6451:0:b0:6b7:54cd:2115 with SMTP id
 m17-20020a9d6451000000b006b754cd2115mr17043491otl.3.1689192706970; 
 Wed, 12 Jul 2023 13:11:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+sazM801XOOJtQYqWIKxx0R77N3fs10T9jRDTeix2fq2bXvU1kvzcIS4DHtUCKxuYz0P0uA==
X-Received: by 2002:a9d:6451:0:b0:6b7:54cd:2115 with SMTP id
 m17-20020a9d6451000000b006b754cd2115mr17043463otl.3.1689192706732; 
 Wed, 12 Jul 2023 13:11:46 -0700 (PDT)
Received: from [192.168.8.101] (tmo-097-78.customers.d1-online.com.
 [80.187.97.78]) by smtp.gmail.com with ESMTPSA id
 x12-20020ae9e90c000000b00767d8e12ce3sm2407027qkf.49.2023.07.12.13.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 13:11:46 -0700 (PDT)
Message-ID: <88070b30-36ea-8112-41c4-0d93fc76cf80@redhat.com>
Date: Wed, 12 Jul 2023 22:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-17-pmorel@linux.ibm.com>
 <dfeeeaa1-0994-9e1e-1f10-6c6618daacff@redhat.com>
 <aa1fbe820f23bc487752ee29ee114f5d4185352a.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v21 16/20] tests/avocado: s390x cpu topology entitlement
 tests
In-Reply-To: <aa1fbe820f23bc487752ee29ee114f5d4185352a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/07/2023 21.37, Nina Schoetterl-Glausch wrote:
> On Wed, 2023-07-05 at 12:22 +0200, Thomas Huth wrote:
>> On 30/06/2023 11.17, Pierre Morel wrote:
>>> This test takes care to check the changes on different entitlements
>>> when the guest requests a polarization change.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    tests/avocado/s390_topology.py | 47
>>> ++++++++++++++++++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>
>>> diff --git a/tests/avocado/s390_topology.py
>>> b/tests/avocado/s390_topology.py
>>> index 2cf731cb1d..4855e5d7e4 100644
>>> --- a/tests/avocado/s390_topology.py
>>> +++ b/tests/avocado/s390_topology.py
>>> @@ -240,3 +240,50 @@ def test_polarisation(self):
>>>            res = self.vm.qmp('query-cpu-polarization')
>>>            self.assertEqual(res['return']['polarization'],
>>> 'horizontal')
>>>            self.check_topology(0, 0, 0, 0, 'medium', False)
>>> +
>>> +    def test_entitlement(self):
>>> +        """
>>> +        This test verifies that QEMU modifies the polarization
>>> +        after a guest request.
>> ...
>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>> +
>>> +        self.guest_set_dispatching('1');
>>> +
>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>> +
>>> +        self.guest_set_dispatching('0');
>>> +
>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>
>> Sorry, I think I'm too blind to see it, but what has changed after
>> the guest
>> changed the polarization?
> 
> Nothing, the values are retained, they're just not active.
> The guest will see a horizontal polarization until it changes back to
> vertical.

But then the comment in front of it ("This test verifies that QEMU 
*modifies* the polarization...") does not quite match, does it?

  Thomas



