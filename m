Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8676E203
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 09:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRSum-0004dx-PW; Thu, 03 Aug 2023 03:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRSuk-0004dl-KR
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 03:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRSug-00024i-QG
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 03:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691048305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Up3GJOekf2QKB4eJASc6Wmp9m2ZqQpdIfQ3Z3DPm3/I=;
 b=QLtksjgJyvSmgMlnHFsYWP0y81om0KixzmhjorjqkRx3ZjWrdBe4ZhzrJURg5Ibi+rhmxp
 QaT0pWJE5sjmwbQkqvSZGGTT1HT9fKU9WNC7QuddUF8qX2Mc5T0atbV6Wu++FfJHVEBrSi
 /4CGzAJwWYo8Jlo/DumA84N5xbeRS6c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-0Y7W4AOiNdGftp73NbIvgQ-1; Thu, 03 Aug 2023 03:38:23 -0400
X-MC-Unique: 0Y7W4AOiNdGftp73NbIvgQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so41762966b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 00:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691048302; x=1691653102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Up3GJOekf2QKB4eJASc6Wmp9m2ZqQpdIfQ3Z3DPm3/I=;
 b=UOoZt9cuaV6ZDkgwMslv1nydfbzB0xLQJpqIqTv3CfOzU8Rj46JDJskExL1L2ZSfO7
 YNoq2UEIW6tK3Gnw9vIKV4GMP55hFSjpwI+jEz/AIp/GbVeV8F3YieoIOWyH3qFyjgG8
 adIsaUBx6dkrigOat/TG1sCXjgBz84mNs8ypesGUJu9blXJIhtnHcymGWx8JQWuMyPSE
 OatfYhDb+43WvlfpB/k9R/8SjAEMq4Lj5Sk0RPND+9QDnzOabykl6K7OA6eJtexSzMae
 K8MjS71qid9M4+5fQV1g9hSY4MG03hxhyo14tDvcMlLsSa4mekLbQwBWdqiaUmZm4UAh
 D/oQ==
X-Gm-Message-State: ABy/qLYia3/5t0hevVG8lEl8/ngVGbk5AWuv+hbYECkfHrPOilmVdaZV
 4qqg9TgDvV43cggrZuUEV0Kmlp0OFgelDiK2CiVK4oVNE0/0bJL/3VWXupCQR1u1yUNrjVDSvcg
 HHTt9gt6TTiQ6vKE=
X-Received: by 2002:a17:906:51cc:b0:993:f540:5bb1 with SMTP id
 v12-20020a17090651cc00b00993f5405bb1mr6327853ejk.41.1691048302501; 
 Thu, 03 Aug 2023 00:38:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPKiFpJolemnwSiwSa7FGu8aV9dE/CbJvacl244gNcXwMqjlfuuth2eampD6eXFIDTIGkrfw==
X-Received: by 2002:a17:906:51cc:b0:993:f540:5bb1 with SMTP id
 v12-20020a17090651cc00b00993f5405bb1mr6327842ejk.41.1691048302203; 
 Thu, 03 Aug 2023 00:38:22 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-179-99.web.vodafone.de.
 [109.43.179.99]) by smtp.gmail.com with ESMTPSA id
 kt7-20020a170906aac700b0099ba3438554sm10084622ejb.191.2023.08.03.00.38.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 00:38:21 -0700 (PDT)
Message-ID: <c06a5138-170e-d696-38f1-3060ea164932@redhat.com>
Date: Thu, 3 Aug 2023 09:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
Content-Language: en-US
To: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230720101037.2161450-1-mzamazal@redhat.com>
 <87edl2sr34.fsf@suse.de> <87o7josisk.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87o7josisk.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03/08/2023 09.10, Milan Zamazal wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
>> Milan Zamazal <mzamazal@redhat.com> writes:
>>
>>> The QEMU CI fails in virtio-scmi test occasionally.  As reported by
>>> Thomas Huth, this happens most likely when the system is loaded and it
>>> fails with the following error:
>>>
>>>    qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>>>    msix_unset_vector_notifiers: Assertion
>>> `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier'
>>> failed.
>>>    ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected
>>> QEMU death from signal 6 (Aborted) (core dumped)
>>>
>>> As discovered by Fabiano Rosas, the cause is a duplicate invocation of
>>> msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
>>>
>>>    msix_unset_vector_notifiers
>>>    virtio_pci_set_guest_notifiers
>>>    vu_scmi_stop
>>>    vu_scmi_disconnect
>>>    ...
>>>    qemu_chr_write_buffer
>>>
>>>    msix_unset_vector_notifiers
>>>    virtio_pci_set_guest_notifiers
>>>    vu_scmi_stop
>>>    vu_scmi_set_status
>>>    ...
>>>    qemu_cleanup
>>>
>>> While vu_scmi_stop calls are protected by vhost_dev_is_started()
>>> check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
>>> use an extra protection, see f5b22d06fb (vhost: recheck dev state in
>>> the vhost_migration_log routine) for the motivation.  Let's use the
>>> same in vhost-user-scmi, which fixes the failure above.
>>>
>>> Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> Please note that this bug fix should IMO definitely go to 8.1, to not
> have a bug in vhost-user-scmi and to not have broken tests.  Any chance
> to get it merged?

If nobody else is planning a pull request with this patch included, I can 
take it for my next PR (since it is fixing the CI, I just saw another 
failure here:
https://gitlab.com/qemu-project/qemu/-/jobs/4790457938#L4784 )

  Thomas



