Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339872A8D6
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 05:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7pP5-0001Ei-74; Fri, 09 Jun 2023 23:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1q7pP1-0001EU-Dc
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1q7pP0-0004vH-2d
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686368192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unKyx6NoQURBJQCD6seCUlVOQQKt29TKNA7/9UsZOeU=;
 b=RU8Gq9HKz4i8riA+NgI3kN92C62hNOmqnNZsh/yrOU0K697EZ6Mxj5fmOfaNuI7bS8Ua9Z
 xtWWophYuofC+asuGeQ05pr9z+wJD01i4eJ27pJ/FZseYFqrDyRwGjRkxys+b7ah0fenVx
 qjVLGO9B16+Wgkp2WFKppVhgRHO+gP0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-5ME023HmNDmRUFNMqlZKyQ-1; Fri, 09 Jun 2023 23:36:14 -0400
X-MC-Unique: 5ME023HmNDmRUFNMqlZKyQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0FBB3801FFB;
 Sat, 10 Jun 2023 03:36:14 +0000 (UTC)
Received: from [10.64.54.21] (vpn2-54-21.bne.redhat.com [10.64.54.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C126D492B00;
 Sat, 10 Jun 2023 03:36:13 +0000 (UTC)
Subject: Re: QEMU virt (arm64) does not honor reserved-memory set in device
 tree
To: Mohd Yusuf Abdul Hamid <mohdyusuf@gmail.com>, qemu-devel@nongnu.org
References: <CALKsAjDBgWvuG5Q8r6N44-VdX8+8zozkN=EZhXJ-8n8DXz2DqA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <cfc21135-0f27-8af5-c864-d969dd42e4c0@redhat.com>
Date: Sat, 10 Jun 2023 13:36:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CALKsAjDBgWvuG5Q8r6N44-VdX8+8zozkN=EZhXJ-8n8DXz2DqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Reply-To: Gavin Shan <gshan@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Mohd,

On 6/10/23 10:01 AM, Mohd Yusuf Abdul Hamid wrote:
> I am trying to reserve a portion of the system memory in QEMU (arm64 virt), v7.2.1 - but the kernel never honors the reserved memory area and keeps using the area.
> 
> Say, I dumped out DTB and added:
> 
> reserved-memory {
>    #address-cells = <0x02>;
>    #size-cells = <0x02>;
> 
>    rsvdram@50000000 {
>    no-map;
>    reg = <0x00 0x50000000 0x00 0x20000000>;
>    };
> };
> 
> When booted, /proc/iomem still shows the kernel is using the entire space - eg 2GB.
> 
> Is this a supported feature or I would need to modify the virt.c and define scratch area for some device driver scratch area.
> 

It relies on the guest kernel to handle the device-tree and the device-tree node
for the reserved map. I doubt if you had ACPI over device-tree in the guest kernel's
configuration. In this case, the reserved memory regions need to be specified in
ACPI tables instead of device-tree.

Thanks,
Gavin


