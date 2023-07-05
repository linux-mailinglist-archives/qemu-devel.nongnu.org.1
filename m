Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05474821D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzif-0001dM-OT; Wed, 05 Jul 2023 06:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzid-0001d5-KE
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzib-0001dw-OI
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688552800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFbPNA1JPoApPh83wOpxfN2kwsdBECeboggBXc7fBWU=;
 b=ixPz4NWPbqNgAuphUgPHWwbnMstP5q7NIZCfGxYOEjFddlR8Lh2T/jUCk0GWWrD7mlhEv0
 fuSCxRDXR7W7WIZ0bIXeC500MA39DDJMXAOupYg3BhgJovd981lc8UMBbYOCx8IdP2ZmdU
 L9isPSncmn/QVyeWyMKtS0OJGBdAJh8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-v6B_wIhhNoyA1WPOYr7EpA-1; Wed, 05 Jul 2023 06:26:39 -0400
X-MC-Unique: v6B_wIhhNoyA1WPOYr7EpA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63511adcf45so70363506d6.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688552799; x=1691144799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EFbPNA1JPoApPh83wOpxfN2kwsdBECeboggBXc7fBWU=;
 b=bpguuUvYqw1L4+9tqUycW6FWmDdFXzQXeuYUSCsJeC7B1huGbgxzfPwLvQCls3oDzX
 fHP7toS4u9Vgs++5kpm/BVd/64Duu8Ru1unpE9x0DUSa0jWv+rVcPZ1GJXSYiwV5DXX7
 u7e9e/YVMQJdFqTHL+8VjiRPzzk1ORNIreTGK5ck3Hajz9IBpTyQs6Oq3fybAj9yp3+z
 UaRfFchRMHa3ywDuQeQ9AzBTMuYirAnlWe5g66bJSu71xi3gmIZbsq8H1iGX3riZnPh3
 yWydHecn2Z9dQ+zpskdAY46rrhlhMbD90/NI+h2h8wNI6NlHGqA+ftQuAw1Ji9sEpLpS
 Le9A==
X-Gm-Message-State: ABy/qLaq6jzs31TlXjNjewf9kG0FNANo+fKMQH+ZAuTCO3m8qIIsDXZB
 A0VEIyQH1mcsHYT3YVZwRuJ8Wg8TnC8ZGWQkr0ncpZaIMpKwReRsw3RPfcMWwXMXE5EYEvd/vLc
 Y91kUvH3L9gRVJpU=
X-Received: by 2002:a05:6214:da9:b0:625:af4b:415a with SMTP id
 h9-20020a0562140da900b00625af4b415amr24836753qvh.19.1688552798852; 
 Wed, 05 Jul 2023 03:26:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDgM8Tt5YKkvYP+0aWuEcIqpWhvUVvSVZXSI+G3YI4DrugO9rCsrR381GmVgW6c9Pk4ozOlQ==
X-Received: by 2002:a05:6214:da9:b0:625:af4b:415a with SMTP id
 h9-20020a0562140da900b00625af4b415amr24836733qvh.19.1688552798648; 
 Wed, 05 Jul 2023 03:26:38 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 jy19-20020a0562142b5300b00635e9db359bsm10504628qvb.82.2023.07.05.03.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:26:38 -0700 (PDT)
Message-ID: <917541c2-65b6-18b5-cf83-e72bf570eacf@redhat.com>
Date: Wed, 5 Jul 2023 12:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 18/20] tests/avocado: s390x cpu topology test socket
 full
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-19-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-19-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
> This test verifies that QMP set-cpu-topology does not accept
> to overload a socket.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index cba44bec91..0003b30702 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -315,3 +315,28 @@ def test_dedicated(self):
>           self.guest_set_dispatching('0');
>   
>           self.check_topology(0, 0, 0, 0, 'high', True)
> +
> +    def test_socket_full(self):
> +        """
> +        This test verifies that QEMU does not accept to overload a socket.
> +        The socket-id 0 on book-id 0 already contains CPUs 0 and 1 and can
> +        not accept any new CPU while socket-id 0 on book-id 1 is free.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.add_args('-smp',
> +                         '3,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
> +        self.vm.launch()
> +        self.wait_until_booted()
> +
> +        self.system_init()
> +
> +        res = self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 2, 'socket-id': 0, 'book-id': 0})
> +        self.assertEqual(res['error']['class'], 'GenericError')
> +
> +        res = self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 2, 'socket-id': 0, 'book-id': 1})
> +        self.assertEqual(res['return'], {})

Reviewed-by: Thomas Huth <thuth@redhat.com>


