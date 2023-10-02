Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8B7B5468
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJW8-0000gr-Je; Mon, 02 Oct 2023 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnJVz-0000gV-2e
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnJVu-0002UM-9B
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696255388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7XnWDhouqu0DHJZkgL/gpUmJvqw6cqX+rdihwT1qzE=;
 b=Nhe/xAMjgQKq2rbQUrK7gq9uu/LqqKiHjgNnQVysh/RVgJL9659LAovMg/OwVVi2wTJrYR
 FmYM5CYGrfxyWnuF08LGhQF4AfdhzT8rD+RyDxABaw0DXWaIEXGOPL0BLx2D/aCoDcTT2n
 xYNSoTO9ZhlDcCXpCxd89WgQigJA3Lo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-ewqXacykNTS77tUSi0xyYw-1; Mon, 02 Oct 2023 10:03:01 -0400
X-MC-Unique: ewqXacykNTS77tUSi0xyYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E91A803508;
 Mon,  2 Oct 2023 14:02:56 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C00A3C15BB8;
 Mon,  2 Oct 2023 14:02:54 +0000 (UTC)
Message-ID: <8e403815-7ad6-7c98-e0d7-34733d4e38aa@redhat.com>
Date: Mon, 2 Oct 2023 16:02:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <90e566a6-2ac9-5adf-233c-085df81526c0@redhat.com>
 <c1ed25c6-1493-a1e2-b539-664bdb7d4127@redhat.com>
 <20231001152422-mutt-send-email-mst@kernel.org>
 <20231001152519-mutt-send-email-mst@kernel.org>
 <2d361bac-9f8b-0a3a-ddd0-f66cd1294159@redhat.com>
 <20231002025001-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231002025001-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/2/23 08:57, Michael S. Tsirkin wrote:
> On Mon, Oct 02, 2023 at 03:56:03AM +0200, Laszlo Ersek wrote:
>> On 10/1/23 21:25, Michael S. Tsirkin wrote:
>>> Not this actually - v2 of this.
>>
>> Thank you, but:
>>
>> - Stefan's question should be answered still IMO (although if you pick
>> up this series, then that could be interpreted as "QEMU bug, not spec bug")
>>
>> - I was supposed to update the commit message on 7/7 in v3; I didn't
>> want to do it before Stefan's question was answered
>>
>> Thanks!
>> Laszlo
> 
> OK I just answered. I am fine with the patch but I think
> virtiofsd should be fixed too.

Thanks. I'll prepare a v3 with an updated commit message on 7/7 (plus
picking up any new feedback tags).

Cheers
Laszlo


