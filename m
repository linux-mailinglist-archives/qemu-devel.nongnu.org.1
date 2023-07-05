Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2F74820C
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzf5-00080y-8Y; Wed, 05 Jul 2023 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzf1-00080Y-2q
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzez-0000cG-I9
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688552576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYAoDgqG5yTL6DKSA2l6Eg5bMpx7MIVjW+RNb0aXYqA=;
 b=cbCYh6Nd8VA2gRa2jvVjib21eGEiUBldSfn0BJfNH8IcaTnn0cVT9Bd6xMhcyDUAdtahrc
 aX6QMi0v2kY0yRvve44Xe7yGEB6A2ZTbMm2n0Eip+E/Iw0PMXrxjoOgR78gtsFEOWJQBHH
 aoLnEOSbg7t1yVmNWJcR4uvTu1SuZbU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-__pgihY-MICNaX2KHC9XNA-1; Wed, 05 Jul 2023 06:22:54 -0400
X-MC-Unique: __pgihY-MICNaX2KHC9XNA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-634dacfa27bso65219886d6.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688552574; x=1691144574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eYAoDgqG5yTL6DKSA2l6Eg5bMpx7MIVjW+RNb0aXYqA=;
 b=cK22Gnn4XBUVAYnlrVI7gubsI+VUUOTl8+PNz+HYcBdXhB+97JjfGykty0tEQ8fOl7
 /XtcOOfu1MtgorGkYNsK0Q/0MNy/UHuM4n9AGkALvv01wkwf+qHHAAXXeDvF1dyDWJ7J
 9iIUQUAoo34EDCbn7LC66SDUgeRpvAltB1UCE89QcdEZxlBMqT83oxvqhppILP8K5FaO
 VBeIuKrpNxtE/+huHDCrhcnnsQS0BGL+1Buod+/mV0GehvxEqwyUIJpZmPcq9GbQ+Wj5
 qt0p2VW5wFfSBpNINDwa1KX3IHe/o3NYoOgU4D0+WI+7lh5kt+6gg0Ysg2nDcl5wZ/95
 HEAw==
X-Gm-Message-State: ABy/qLarF1p8yNQXdTUOI/HcIdYxvKLJfp/uDiMaCBYoU6+PUysTitYa
 i4AZx7RUl7xoBc8RccSSWX5k+c1BefdLWGlTL05VqEvZqJWiv6VEIWzD4Rz5I1YGPLfRjUl2v12
 TXbyh9dGodl6Ni+k=
X-Received: by 2002:a05:6214:2aab:b0:632:32ce:7947 with SMTP id
 js11-20020a0562142aab00b0063232ce7947mr15924657qvb.28.1688552573943; 
 Wed, 05 Jul 2023 03:22:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/+9TE2hrEG1oXksRbybS1ZXPdsjMo4JpFFl21cSp3oQfVTKVMBUx1/UbAW7HT8lkP3N+k4g==
X-Received: by 2002:a05:6214:2aab:b0:632:32ce:7947 with SMTP id
 js11-20020a0562142aab00b0063232ce7947mr15924627qvb.28.1688552573635; 
 Wed, 05 Jul 2023 03:22:53 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 cj25-20020a05622a259900b00401e04c66fesm11317353qtb.37.2023.07.05.03.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:22:52 -0700 (PDT)
Message-ID: <dfeeeaa1-0994-9e1e-1f10-6c6618daacff@redhat.com>
Date: Wed, 5 Jul 2023 12:22:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 16/20] tests/avocado: s390x cpu topology entitlement
 tests
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-17-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-17-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
> This test takes care to check the changes on different entitlements
> when the guest requests a polarization change.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 47 ++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index 2cf731cb1d..4855e5d7e4 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -240,3 +240,50 @@ def test_polarisation(self):
>           res = self.vm.qmp('query-cpu-polarization')
>           self.assertEqual(res['return']['polarization'], 'horizontal')
>           self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +    def test_entitlement(self):
> +        """
> +        This test verifies that QEMU modifies the polarization
> +        after a guest request.
...
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)
> +
> +        self.guest_set_dispatching('1');
> +
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)
> +
> +        self.guest_set_dispatching('0');
> +
> +        self.check_topology(0, 0, 0, 0, 'low', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'high', False)
> +        self.check_topology(3, 1, 0, 0, 'high', False)

Sorry, I think I'm too blind to see it, but what has changed after the guest 
changed the polarization?

  Thomas


