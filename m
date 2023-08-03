Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C7E76E0FE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 09:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRSTd-00089S-1O; Thu, 03 Aug 2023 03:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qRSTa-00088x-EU
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 03:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qRSTY-00035d-Rx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 03:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691046623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=763hhOUgT4u1Wn7iE0ZXasp29TIZcWAF1B24GfwF0XA=;
 b=Yse9GOGODDljMDCVCZArKyy5SiDLOfzDrEu+D9LbYRqxCqR8QXNpshwPLYT6fa0zoI7Gbn
 DWDaSnaRuzposFythMfZEmiyvDqOkn157mK09BPkEA6CzIZQvnSniUTfXHrTaMyjfxWowZ
 BCvMjUqpusgaiyc6EmElvu7Erwtscso=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-6ugsXiGCPRqD-S5PF7t5Vw-1; Thu, 03 Aug 2023 03:10:21 -0400
X-MC-Unique: 6ugsXiGCPRqD-S5PF7t5Vw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso39734066b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 00:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691046621; x=1691651421;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=763hhOUgT4u1Wn7iE0ZXasp29TIZcWAF1B24GfwF0XA=;
 b=ShyJhJrWWhOA2JDvddPwD+lm/tWepFMqrSBj4r4xE0XsdaWcJqa4CbGs/2TPVaLNtj
 2PD+2LP4e5zyZfUao+XXgrzdWCRN/2ehv3YLWdq8XvveZ7fuPwUG8I26jSKu6uew38VI
 PROcpUJz19xyXFK2XOCZXxiNAJHcKM4jjGmgvkp44K4Gn/LzJXKTG5+Aupnp+0iMhzrQ
 oOKw/a6274+nbMQwGcYCcC4DFLCB1MHD2hkKN3mFHI/ZlhXJoQ7ZwRyx5hCAIwV6ABmP
 WUcee7OlEI+y9dTAaHexcP/wWP/XoqVPQH0zx4M/5B2Kwq1UZSr0GYnvWGoa/9ikw+m8
 vyYQ==
X-Gm-Message-State: ABy/qLbY4mrSz2Pn+nvmJ5MzLdKFcVzSB4/Z0d+ieb2v5q9oel/YlEUU
 fZuBHZpytIS8TNQxE+f94BpX4ubMuhkc4ciejV/BspZTMf2wuyK306ynONE5wKCAklhzBQXCYpm
 a5fJLDhQPZEPPv9o=
X-Received: by 2002:a17:906:224b:b0:99b:8c6f:f3af with SMTP id
 11-20020a170906224b00b0099b8c6ff3afmr6912828ejr.12.1691046620855; 
 Thu, 03 Aug 2023 00:10:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaAmx6VnRb3+U7nSEx2KKn/Tv9DGJ6dm1Dcct1W5qJVDSUKzcgG78jQ4aW5rnGY1ud74AQ6w==
X-Received: by 2002:a17:906:224b:b0:99b:8c6f:f3af with SMTP id
 11-20020a170906224b00b0099b8c6ff3afmr6912820ejr.12.1691046620585; 
 Thu, 03 Aug 2023 00:10:20 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170906490300b0099307a5c564sm10099352ejq.55.2023.08.03.00.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 00:10:20 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,  Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Laurent Vivier <lvivier@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
References: <20230720101037.2161450-1-mzamazal@redhat.com>
 <87edl2sr34.fsf@suse.de>
Date: Thu, 03 Aug 2023 09:10:19 +0200
In-Reply-To: <87edl2sr34.fsf@suse.de> (Fabiano Rosas's message of "Thu, 20 Jul
 2023 09:30:23 -0300")
Message-ID: <87o7josisk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Milan Zamazal <mzamazal@redhat.com> writes:
>
>> The QEMU CI fails in virtio-scmi test occasionally.  As reported by
>> Thomas Huth, this happens most likely when the system is loaded and it
>> fails with the following error:
>>
>>   qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
>>   msix_unset_vector_notifiers: Assertion
>> `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier'
>> failed.
>>   ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected
>> QEMU death from signal 6 (Aborted) (core dumped)
>>
>> As discovered by Fabiano Rosas, the cause is a duplicate invocation of
>> msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
>>
>>   msix_unset_vector_notifiers
>>   virtio_pci_set_guest_notifiers
>>   vu_scmi_stop
>>   vu_scmi_disconnect
>>   ...
>>   qemu_chr_write_buffer
>>
>>   msix_unset_vector_notifiers
>>   virtio_pci_set_guest_notifiers
>>   vu_scmi_stop
>>   vu_scmi_set_status
>>   ...
>>   qemu_cleanup
>>
>> While vu_scmi_stop calls are protected by vhost_dev_is_started()
>> check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
>> use an extra protection, see f5b22d06fb (vhost: recheck dev state in
>> the vhost_migration_log routine) for the motivation.  Let's use the
>> same in vhost-user-scmi, which fixes the failure above.
>>
>> Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Please note that this bug fix should IMO definitely go to 8.1, to not
have a bug in vhost-user-scmi and to not have broken tests.  Any chance
to get it merged?

Thanks,
Milan


