Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9D76E5E1
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 12:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRVqf-0006l4-Ce; Thu, 03 Aug 2023 06:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRVqd-0006i8-6m
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRVqa-0003OG-OW
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 06:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691059583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IRncGgZritQX9csnT8j8c3HMEsg3ev6mBGYAsXfFZE=;
 b=NDzE5Y7IOkqdpd/gfKoYu1m78vO3Mo/hCq6h8QLSduMQoLfrDF0uVIWcIjjDgKFUFIBmjZ
 ZIaEUKecNkIjs2psFLee9jzFX1wqF80VGsokR26km83os8++F+zrr8ixG4S9yJ8Oum//ut
 EemiuaiW+/yQMj+DHO4pK+7CDhV96Kw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-r_q2rg3aOSGBIi3xNhhrOw-1; Thu, 03 Aug 2023 06:46:20 -0400
X-MC-Unique: r_q2rg3aOSGBIi3xNhhrOw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-406c0193f36so8515781cf.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 03:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691059580; x=1691664380;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IRncGgZritQX9csnT8j8c3HMEsg3ev6mBGYAsXfFZE=;
 b=hvU9q4huKvinQMJZgKJ9PhjRT23kUbVZO/CsxLajbSpQwOMese50IML0UNpEiZGtlI
 u9/zTeiNVM3060EZYppKopcUvoGxvYU9cxtGJS3Espzx+agU7ocT6nruZNJXYWyUTxPt
 MfqU9W7/kyV5I8VcU2CqAVzN2fQssyzHH0SKMOi+/bmM5d6HdD2WV4zT3+tfHbMctaH+
 naNv/ezNiPeIu6HbDKKgSosFVpqzZcbNJRr77dLmp4+qEvvp5Fg7oLWI0XiPGmiZbQ7i
 VlkGNJYCOw9sGmMdrSj1/cHIGYokY0fL6OZPuzUgD0q7Jhg2b6FZAq/EPubmlO95NmZF
 9IFQ==
X-Gm-Message-State: ABy/qLb4Lz30dhMvyxG8WtKYNOA1ifEu8A8uIFO/EPigQI5AsxXyZ9Ff
 D6LoR1Ukb15WfDRvF7olaYUzAqv8T+QyRexN5r9c0pHvkxkb8njR6s1N5EkuWJm7YHvYpFo51+Y
 D7YX/1+l5uqOqXVc=
X-Received: by 2002:ac8:5992:0:b0:40f:5510:d74d with SMTP id
 e18-20020ac85992000000b0040f5510d74dmr13092293qte.13.1691059579980; 
 Thu, 03 Aug 2023 03:46:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFFkA4NBEzkxKxdNwgXffpJ4qs/7KSaIeo/99fFHybPY4VnOcR/g0rqgekzBGMGmpkOKpnjvA==
X-Received: by 2002:ac8:5992:0:b0:40f:5510:d74d with SMTP id
 e18-20020ac85992000000b0040f5510d74dmr13092273qte.13.1691059579709; 
 Thu, 03 Aug 2023 03:46:19 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-179-99.web.vodafone.de.
 [109.43.179.99]) by smtp.gmail.com with ESMTPSA id
 b16-20020ac844d0000000b00406b11a54b8sm6089227qto.7.2023.08.03.03.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 03:46:19 -0700 (PDT)
Message-ID: <be8ba7f5-418f-607f-fefb-860a66efe1b4@redhat.com>
Date: Thu, 3 Aug 2023 12:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230720101037.2161450-1-mzamazal@redhat.com>
 <87edl2sr34.fsf@suse.de> <87o7josisk.fsf@redhat.com>
 <c06a5138-170e-d696-38f1-3060ea164932@redhat.com>
 <20230803054946-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230803054946-mutt-send-email-mst@kernel.org>
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

On 03/08/2023 11.50, Michael S. Tsirkin wrote:
> On Thu, Aug 03, 2023 at 09:38:20AM +0200, Thomas Huth wrote:
>> On 03/08/2023 09.10, Milan Zamazal wrote:
>>> Fabiano Rosas <farosas@suse.de> writes:
>>>
>>>> Milan Zamazal <mzamazal@redhat.com> writes:
>>>>
>>>>> The QEMU CI fails in virtio-scmi test occasionally.  As reported by
>>>>> Thomas Huth, this happens most likely when the system is loaded and it
>>>>> fails with the following error:
>>>>>
>>>>>     qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>>>>>     msix_unset_vector_notifiers: Assertion
>>>>> `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier'
>>>>> failed.
>>>>>     ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected
>>>>> QEMU death from signal 6 (Aborted) (core dumped)
>>>>>
>>>>> As discovered by Fabiano Rosas, the cause is a duplicate invocation of
>>>>> msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
>>>>>
>>>>>     msix_unset_vector_notifiers
>>>>>     virtio_pci_set_guest_notifiers
>>>>>     vu_scmi_stop
>>>>>     vu_scmi_disconnect
>>>>>     ...
>>>>>     qemu_chr_write_buffer
>>>>>
>>>>>     msix_unset_vector_notifiers
>>>>>     virtio_pci_set_guest_notifiers
>>>>>     vu_scmi_stop
>>>>>     vu_scmi_set_status
>>>>>     ...
>>>>>     qemu_cleanup
>>>>>
>>>>> While vu_scmi_stop calls are protected by vhost_dev_is_started()
>>>>> check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
>>>>> use an extra protection, see f5b22d06fb (vhost: recheck dev state in
>>>>> the vhost_migration_log routine) for the motivation.  Let's use the
>>>>> same in vhost-user-scmi, which fixes the failure above.
>>>>>
>>>>> Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
>>>>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>>>>
>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>
>>> Please note that this bug fix should IMO definitely go to 8.1, to not
>>> have a bug in vhost-user-scmi and to not have broken tests.  Any chance
>>> to get it merged?
>>
>> If nobody else is planning a pull request with this patch included, I can
>> take it for my next PR (since it is fixing the CI, I just saw another
>> failure here:
>> https://gitlab.com/qemu-project/qemu/-/jobs/4790457938#L4784 )
>>
>>   Thomas
>>
> 
> I picked it up but if you like I can drop it.

I think it better fits into your tree, so if you plan a PR before the next 
RC, then please go ahead. I'll drop it from my branch again.

  Thomas



