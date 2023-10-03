Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D07B6E1A
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 18:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhwr-000496-L0; Tue, 03 Oct 2023 12:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhwm-00048w-Qp
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhwk-0000DB-OC
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696349309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIBa9W8WdALcKcmwXTyrhOLzyXyfazMTmfvDXSnyXdo=;
 b=BnsUJ6r12aCzRmKBP1mwHQ2U7nhmqt0pYOuzTAHuH88A38Fe52O0Co7fV/HdFxS+/rJpqA
 syrAdopROYWV2joBBYjZCriglirizZMYv41hTb8BxxqqWgYhVgzuzJZHFE40JOfoUrIkCu
 45z1e0cBZ/KH+h4pA9s6SUDWrux3/1Y=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-lks599UIOleZaNJXWYVd8Q-1; Tue, 03 Oct 2023 12:08:23 -0400
X-MC-Unique: lks599UIOleZaNJXWYVd8Q-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-452c988b8e7so515531137.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 09:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696349302; x=1696954102;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIBa9W8WdALcKcmwXTyrhOLzyXyfazMTmfvDXSnyXdo=;
 b=j2g2Q0zBmr9T6xd6WkdnOLvCbjidz5fGPHxbi+9ycttZgTdiVqLUVaiP8Vh9Zz2/17
 e6aQ9SQIJNMelAQsql6uLkeV5N5gXrNPk0bR06KnShB+gCXJKTeZSi1n5MrDowkoi5lO
 8vGTrkRFWHMz5US/Ae4eN2bJ9SAZ56k1y6LJo8O5AQPU68tY18opfebWSVq6a3L1MrY/
 oA67tcxLPvq1CvzBwjPHQxZzOqvO6cnAqP+Nbvucf9XWtKqlMoWQEKJSt0yJIpeh+qwV
 Zu+OcAcxWhwveqEADd+zitQIDvnwgXEniaXpMxv70KLqOi5Gc133jPHmq8GoLJDNNwwp
 udcA==
X-Gm-Message-State: AOJu0Yy38RwYo2O+8OkYizD2UYm9D1a13wQvisbleUyDiYpCM1IaoGld
 EK1fJZWiEoe6BwNDi5sqopA3vDkxK+PtbADn8Y3eftXxGHFOn4YhddVovKZywCOPEt3oJ5nCfiP
 ecd1RRfkehEfMU3c=
X-Received: by 2002:a05:6102:34f4:b0:452:819b:f7f5 with SMTP id
 bi20-20020a05610234f400b00452819bf7f5mr13183776vsb.25.1696349301086; 
 Tue, 03 Oct 2023 09:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdMHRycDHsrYUZFS1LY3jP0Ljs6Tnvcc/vzghJnThgp/UQ/NXTnh9ajLI6Nfh035PhtE8W9w==
X-Received: by 2002:a05:6102:34f4:b0:452:819b:f7f5 with SMTP id
 bi20-20020a05610234f400b00452819bf7f5mr13183706vsb.25.1696349299361; 
 Tue, 03 Oct 2023 09:08:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05620a004500b007742ad3047asm567118qkt.54.2023.10.03.09.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 09:08:18 -0700 (PDT)
Message-ID: <c030fcde-f82b-b174-6555-efd25896e90e@redhat.com>
Date: Tue, 3 Oct 2023 18:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 15/15] vfio/common: Move legacy VFIO backend code into
 separate container.c
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-16-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-16-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/3/23 12:14, Eric Auger wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Move all the code really dependent on the legacy VFIO container/group
> into a separate file: container.c. What does remain in common.c is
> the code related to VFIOAddressSpace, MemoryListeners, migration and
> all other general operations.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

We have lost :

-/*
- * vfio_attach_device: attach a device to a security context
- * @name and @vbasedev->name are likely to be different depending
- * on the type of the device, hence the need for passing @name
- */

with that back,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


