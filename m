Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B675AC76
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 12:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMRJy-0000ZV-72; Thu, 20 Jul 2023 06:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMRJu-0000ZE-JT
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMRJs-0000a0-Ti
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689850538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jMiOZ/IRqYl4J4vf5/8YM0eWI+Wn2wKvfRNv3UjaJ94=;
 b=Pau8eGG+IBt8Bm6JvDefzcN8LcfiznUYzu8FvvyoAAaYm8Ey1nqWQfBFwJO4+Ry0obPwUW
 QOwZGAmRsu6lh8HTjiaL0NDVXhPcOZEIbQD5mzYbbtk1d9Ogi6bykHGMXs4575hqCMEo/k
 wXW9HXqcAR9qcIRqIN6dqJ6VpD0zgpE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-zwNTtDbHNWGUgG8jwnFRJw-1; Thu, 20 Jul 2023 06:55:34 -0400
X-MC-Unique: zwNTtDbHNWGUgG8jwnFRJw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b83988c45bso6457951fa.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 03:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689850533; x=1690455333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMiOZ/IRqYl4J4vf5/8YM0eWI+Wn2wKvfRNv3UjaJ94=;
 b=cA4KDrDAfBXoY2iQC9AYgbbz7/8W2w3FouZhZ1scDgK/TIV5AwqAH19oUVsu2YBBPN
 3gwSAGEHqtZn2uxwhoEpdAbg6FfrBEe8twh2XAZYrvbOSS9qTQpVQtNs8o8OBPlxkf+z
 qdUlLQQgN2swTmT6lKyzGKXow2dcu8TNr5ZxxuY5mQ5SrG5Qs1dM2e3gvCgERefzmVOS
 uIMzQEEnWnJmH3f92Ud0s6mcCBeSCw9kTUQHsf94lMWgNmQ1K9e9oqz/yVrxE/jxrndf
 I0cy8K2LkwLGjZVGYTlXdL13vQIH0MmGeX3KlHi/eeszujYsK2RwSW79nPLv/vFKMPwv
 23tw==
X-Gm-Message-State: ABy/qLb3AKkOldeyrpUoQDJYNtbWicqNpyJt17k/TazOvE9iwfOBKI1n
 lsTvvYIWCBCizl5y+Nbg+vlhdqnX6nAUZoL09g/TBPB7Fik5qazbvDTR534iB4+yP1Qsj0JWdXu
 K9zj2oIfLpAt1TMIX1GJQvDA=
X-Received: by 2002:a2e:9b17:0:b0:2b6:a05a:c5c with SMTP id
 u23-20020a2e9b17000000b002b6a05a0c5cmr2009486lji.1.1689850533231; 
 Thu, 20 Jul 2023 03:55:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpojkb7Ts5SUb/jVzThEBpOx2UGV/OyEzm8FnSPc1lJJN2N1BD9USFX5Ya99LmWTj1mRo5+Q==
X-Received: by 2002:a2e:9b17:0:b0:2b6:a05a:c5c with SMTP id
 u23-20020a2e9b17000000b002b6a05a0c5cmr2009470lji.1.1689850532884; 
 Thu, 20 Jul 2023 03:55:32 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 l8-20020a7bc448000000b003fb40ec9475sm898910wmi.11.2023.07.20.03.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 03:55:32 -0700 (PDT)
Message-ID: <655d66c7-9f42-0610-d1f8-224687e29761@redhat.com>
Date: Thu, 20 Jul 2023 12:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230720101037.2161450-1-mzamazal@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 20/07/2023 12.10, Milan Zamazal wrote:
> The QEMU CI fails in virtio-scmi test occasionally.  As reported by
> Thomas Huth, this happens most likely when the system is loaded and it
> fails with the following error:
> 
>    qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>    msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
>    ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> 
> As discovered by Fabiano Rosas, the cause is a duplicate invocation of
> msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
> 
>    msix_unset_vector_notifiers
>    virtio_pci_set_guest_notifiers
>    vu_scmi_stop
>    vu_scmi_disconnect
>    ...
>    qemu_chr_write_buffer
> 
>    msix_unset_vector_notifiers
>    virtio_pci_set_guest_notifiers
>    vu_scmi_stop
>    vu_scmi_set_status
>    ...
>    qemu_cleanup
> 
> While vu_scmi_stop calls are protected by vhost_dev_is_started()
> check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
> use an extra protection, see f5b22d06fb (vhost: recheck dev state in
> the vhost_migration_log routine) for the motivation.  Let's use the
> same in vhost-user-scmi, which fixes the failure above.
> 
> Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> ---
>   hw/virtio/vhost-user-scmi.c         | 7 +++++++
>   include/hw/virtio/vhost-user-scmi.h | 1 +
>   2 files changed, 8 insertions(+)

Thanks, that fixes the problem for me!

Tested-by: Thomas Huth <thuth@redhat.com>



