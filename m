Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C653781BFFA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQVn-0006Lm-VL; Thu, 21 Dec 2023 16:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGQVl-0006LV-Cb
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGQVi-0007Az-RO
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgA8r/f47Y/noQiHaOcXsDch9yKFkuzTgcFzdHePbjQ=;
 b=ABeq/uUIUakvm13YEnZ6Ef3DcqK00HHgkbtrFp2/iJNR9TnTZsPAInzNBpYnEHnnp3Xhtz
 6s/YNXUvXYmJcUwS8MOIlrepQaMttP+ABSIswZQd6pLI0kB1GC2DnlXIa4zsDYSKxMJXgx
 zQHM51wfLcLKaNwG3qNowBircmD7P8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-ifIs_JZ_Nd25uofv-gv0jw-1; Thu, 21 Dec 2023 16:23:15 -0500
X-MC-Unique: ifIs_JZ_Nd25uofv-gv0jw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3366b71bcf6so879061f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 13:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703193794; x=1703798594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PgA8r/f47Y/noQiHaOcXsDch9yKFkuzTgcFzdHePbjQ=;
 b=mNJswilzuQraG19QddK+mziG2hYswnPJcLsYX0lt/rZkI2kPkGFLJzO6sOLW3diMAO
 ssoP41omL96zvKFneT/4jsjvaRRN6LH0mncA/a4QcsafxKAOg5gIlOWZyurl9JrVd1D8
 5Z4uILdTy3MNOJCgeatfAFzwpkBWzpj7HGGfbooBsk8HklV5W3ZB/LR8/20h8rU5hqNT
 hdzWecrZr18kuj7n7okWTgYYIZGfhVoO9jvDU9wflLqPwCGBEMqNVg2cvFdQkg6+8vT/
 sw/SloT0DP254CU9m3ra5jZqUbwsQDTPa/eFp35ZSLvrFatxdoHMV+V3BXD+v+loMkQ3
 iElQ==
X-Gm-Message-State: AOJu0Yyuae9YUr4XuSBNyDkyBFH2dHYbBFkeSpIbu/E0iX84kHQ2LwSc
 gllEQHSQq8NRJJ1T85lxg45Co5+gl2L+T5S6UiT0yMLvd1ZBhSZLCm/dgvQLSyivQiA3DoWehB9
 MN0rJvGMOw6IxtaFPSiD4ojc=
X-Received: by 2002:adf:e448:0:b0:333:4295:8f72 with SMTP id
 t8-20020adfe448000000b0033342958f72mr223529wrm.118.1703193794299; 
 Thu, 21 Dec 2023 13:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Jv7q97331MXx2PgcPJquCdBG2L4RTxIdkFoRfXWqbjyASXr+bBF9ViCLEUk9UMxkDc8Ylw==
X-Received: by 2002:adf:e448:0:b0:333:4295:8f72 with SMTP id
 t8-20020adfe448000000b0033342958f72mr223515wrm.118.1703193793972; 
 Thu, 21 Dec 2023 13:23:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 i2-20020adffc02000000b003364aa5cc13sm2859760wrr.1.2023.12.21.13.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 13:23:13 -0800 (PST)
Message-ID: <be7753c5-399a-4bd5-ad7d-2b37b9cbc080@redhat.com>
Date: Thu, 21 Dec 2023 22:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/47] backends/iommufd: Introduce the iommufd object
Content-Language: en-US
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20231219185643.725448-1-clg@redhat.com>
 <20231219185643.725448-21-clg@redhat.com>
 <c6daa302-8da3-4931-812d-88dbb156a17a@redhat.com>
 <c9aeeb21-30cf-4f86-8ff5-0eb909830071@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c9aeeb21-30cf-4f86-8ff5-0eb909830071@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

On 12/21/23 18:14, Eric Auger wrote:
> Hi Cédric,
> 
> On 12/21/23 17:00, Cédric Le Goater wrote:
>> [ ... ]
>>
>>
>>> +static void iommufd_backend_init(Object *obj)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +
>>> +    be->fd = -1;
>>> +    be->users = 0;
>>> +    be->owned = true;
>>> +    qemu_mutex_init(&be->lock);> +}
>>> +
>>> +static void iommufd_backend_finalize(Object *obj)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +
>>> +    if (be->owned) {
>>> +        close(be->fd);
>>> +        be->fd = -1;
>>> +    }
>>> +}
>>> +
>>> +static void iommufd_backend_set_fd(Object *obj, const char *str,
>>> Error **errp)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>> +    int fd = -1;
>>> +
>>> +    fd = monitor_fd_param(monitor_cur(), str, errp);
>>> +    if (fd == -1) {
>>> +        error_prepend(errp, "Could not parse remote object fd %s:",
>>> str);
>>> +        return;
>>> +    }
>>> +    qemu_mutex_lock(&be->lock);
>>> +    be->fd = fd;
>>> +    be->owned = false;
>>> +    qemu_mutex_unlock(&be->lock);
>>> +    trace_iommu_backend_set_fd(be->fd);
>>> +}
>>> +
>>> +static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>>> +{
>>> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(uc);
>>> +
>>> +    return !be->users;
>>
>> Coverity CID 1531549 reports a concurrent data access violation because
>> be->users is being accessed without holding the mutex.
>>
>> I wonder how useful is this mutex anyhow, since the code paths should
>> be protected by the BQL lock. If you agree, I will send an update to
>> simply drop be->lock and solve this report.
> I am not totally comfortable with the fact BQL covers the same
> protection? Please can you elaborate.

These routines are called when a device is created which is called
from the QEMU main thread which exits holding the BQL. It should be
fine.

Thanks,

C.



