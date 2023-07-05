Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C3748239
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 12:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGzoA-0004Ze-G9; Wed, 05 Jul 2023 06:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzo8-0004Wj-7l
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:32:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGzo6-0002sL-M4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 06:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688553141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kahp1TYXfK3xFb5kDtYp3xFLKu91U0oYiaYra3jA+Ok=;
 b=VcaNm/l5U14Q+ffWA01TpsPb+eaY+2wATjRHvggjqPOfU779LIggrjhN6WOmMl9CPdOxuL
 r8vxzlkbcbdMW8H+0PH3TE8DsIen9YVw+MxDtcqLL7B2/GxHPkGexwBXaYXIfXgeAlLEug
 4315MwfQsynKCnqzpgq7beN326y6i6k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-5aFs3dg3PWy18C1Zio77Xw-1; Wed, 05 Jul 2023 06:32:20 -0400
X-MC-Unique: 5aFs3dg3PWy18C1Zio77Xw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7659b44990eso557135485a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 03:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688553140; x=1691145140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kahp1TYXfK3xFb5kDtYp3xFLKu91U0oYiaYra3jA+Ok=;
 b=IaT7PSRgWEvvfcfOLeHK7BsIPqo1E8ZkDOmUtSYbnDg7RgaAkqm+70zCQCOJySKbMP
 rtr9uGqDqBtzaj/O1wIRKv2Br1zIHWNEvj003wxdiuHd3sTGx+G0RJm5V4bLbR13ZyNs
 OgMa/YFBbNj6uMlYFZBdAicsAZUwBCMD8hi/EGogXuDD+aiQ2paJo59CsgQyzEM8xmK7
 aT79ZoIX2Tqv8BQzYqGivpC3pQUgTolcBACD6iZRC3VCJ756k8jtGLB3r6Wxok4N6C+a
 foOpHogjTydTI4GIbzZAxzQf4IeuBwpTho7JbYsgVKHkM6DJ0xAsNUxONjJY/OrPLJdA
 AJ6Q==
X-Gm-Message-State: AC+VfDzJx6PwnFsGnppeiAIil9XIRoA2p6QAZ9vuSmgNvfYeAG5/zqUg
 zi7tJutrMx7M84PbLuHTlW6yCas80uJxY8B8ki5lmvgsOF9vcZP5Rnl9Vl5lU6l6zLL3W+5z0jC
 UPf+HTGrYffqEznI=
X-Received: by 2002:a05:620a:2a14:b0:767:15ee:cc51 with SMTP id
 o20-20020a05620a2a1400b0076715eecc51mr18686075qkp.6.1688553140023; 
 Wed, 05 Jul 2023 03:32:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7u4eKFfMzAChBGZiqwciT2EqJ38wfkBY6Dtz/orTBUdImYSABG2EapIz6ck93aENU8yKbu2Q==
X-Received: by 2002:a05:620a:2a14:b0:767:15ee:cc51 with SMTP id
 o20-20020a05620a2a1400b0076715eecc51mr18686044qkp.6.1688553139698; 
 Wed, 05 Jul 2023 03:32:19 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 oo26-20020a05620a531a00b0076715ec99dbsm8554926qkn.133.2023.07.05.03.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 03:32:19 -0700 (PDT)
Message-ID: <2b7a0291-dd7d-a6b6-d269-d23d115a76a4@redhat.com>
Date: Wed, 5 Jul 2023 12:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 20/20] tests/avocado: s390x cpu topology bad move
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-21-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-21-pmorel@linux.ibm.com>
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
> This test verifies that QEMU refuses to move a CPU to an
> unexistant location.

s/unexistant/nonexistent/ ?

> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index 99d9508cef..ea39168b53 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -388,3 +388,28 @@ def test_dedicated_error(self):
>           res = self.vm.qmp('set-cpu-topology',
>                             {'core-id': 0, 'entitlement': 'medium', 'dedicated': False})
>           self.assertEqual(res['return'], {})
> +
> +    def test_move_error(self):
> +        """
> +        This test verifies that QEMU refuses to move a CPU to an
> +        unexistant location

s/unexistant/nonexistent/ ?

With the words fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


