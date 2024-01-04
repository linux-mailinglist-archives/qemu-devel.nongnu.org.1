Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9EB82479A
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 18:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLRh9-0003PB-Gd; Thu, 04 Jan 2024 12:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rLRh7-0003On-VY
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:39:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rLRh6-00026v-7n
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 12:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704389987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWYluG7mflE0wvMjptMazuT+lDtcvVxC9qL4w5BOcZ8=;
 b=VNEP+Io/DUozsLlh9TbR1EQzQO/ilxx3h3OdBrxzAidfSb+9pxm7xk/VwQmwfkbJWiEiPP
 7c9uZUF6Ob1NNfZudzsAVORLLQTmgr/CE3dcmKzI+OCUFCyxp4lXCwPza4PpA4k43Q4cCd
 zSsGYw0EHMNg78X5E4LNwzLRm9LjTzM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-AzoNlQ5TNduiZxQ9X_BnhA-1; Thu, 04 Jan 2024 12:39:44 -0500
X-MC-Unique: AzoNlQ5TNduiZxQ9X_BnhA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7ba97338185so56061539f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 09:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704389984; x=1704994784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWYluG7mflE0wvMjptMazuT+lDtcvVxC9qL4w5BOcZ8=;
 b=nXBqGL1xZU3u1ztlEjg5doPkIzj55mAJMvkzVvoZESAAkXUVWXVAL72ODJIkmFEXFk
 TQfjoQwJN+d5mgFj/4NM2uHUGgKfYOsIoYNc0yaV9SZcRICbG0Hv5bwO1KTVumiq1Xbp
 zrtT+IRY/CyuZ8BAYuh3TQdQW8hiF7WqW1JNdDM7J2rsGjPE1iDShJemOVWDVNEK0NyM
 xt3xfTogb78GOtXyyRvHm0d5gqBsY0LUVXqW9PN27V90hO8AZib881/WBpOMXNHMNEG3
 kw+/XOayvk4zBO65XoMmjhCbRzPWqUxGKlguM7HUlz6idF235jIVXLU8R7neoFiUeyv3
 JbXg==
X-Gm-Message-State: AOJu0YwuZRYG/4lwYbuxZKm1S2PtWj3pkuMGgj7smYncnaZkbzFCXLbA
 wfeuRyYSFgZsNrW0OEs6tk85EGKtlvJXXKKGzxUyvq6qVa/m2SLWl0h6vI1WikoyWGPQXobukhz
 bIOWmzv78rIKzU3BVZQXVRNo=
X-Received: by 2002:a05:6602:21c9:b0:7b7:ca3a:8e97 with SMTP id
 c9-20020a05660221c900b007b7ca3a8e97mr924966ioc.16.1704389983508; 
 Thu, 04 Jan 2024 09:39:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1hxjhXbgz40Y59pozM+FFH8/+Uw4oZPCLt7Dz9FU2rdWdcPV4d15gKpHxpc6pK//6CxqLbQ==
X-Received: by 2002:a05:6602:21c9:b0:7b7:ca3a:8e97 with SMTP id
 c9-20020a05660221c900b007b7ca3a8e97mr924938ioc.16.1704389983275; 
 Thu, 04 Jan 2024 09:39:43 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 v8-20020a5ec108000000b007ba744e8244sm7919510iol.40.2024.01.04.09.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 09:39:42 -0800 (PST)
Date: Thu, 4 Jan 2024 10:39:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun
 Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday
 Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <20240104103941.019f9b54.alex.williamson@redhat.com>
In-Reply-To: <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 4 Jan 2024 16:40:39 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Had a discussion with RH folks, summary follows:
> 
> 1. To align with the current spec description pointed by Jonathan, we first do
>      a separate object instance per GI node as suggested by Jonathan. i.e.
>      a acpi-generic-initiator would only link one node to the device. To 
>      associate a set of nodes, those number of object instances should be
>      created.
> 2. In parallel, we work to get the spec updated. After the update, we switch
>     to the current implementation to link a PCI device with a set of NUMA
>     nodes.
> 
> Alex/Jonathan, does this sound fine?
> 

Yes, as I understand Jonathan's comments, the acpi-generic-initiator
object should currently define a single device:node relationship to
match the ACPI definition.  Separately a clarification of the spec
could be pursued that could allow us to reinstate a node list option
for the acpi-generic-initiator object.  In the interim, a user can
define multiple 1:1 objects to create the 1:N relationship that's
ultimately required here.  Thanks,

Alex


