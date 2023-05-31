Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD0718111
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LYP-0003HU-TZ; Wed, 31 May 2023 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q4LYM-0003Gi-LE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q4LYK-00019m-U6
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685538467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=szJTSpBbiv9Zh1Oe17TS0drlU30mEcd4o5y4igVtzS0=;
 b=iJCOIUMTDqpMQ3O2ruHQNYzUsmxEY/hYOh5MRbkgpO6hyDHzwqBDDAHgB5beGAGqndgpTy
 uw4BmWADmG5NPIFPqt1FDWmqw4tU4x1yWv14JR4kat4O4H8InqGZGbIIYFQ3yZCf0qn8Xs
 Ew/JXHqhqC/PX6yPI/js80xuJ/QGdVI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-Jp-RIAjWOh-Foi5ZJEufiA-1; Wed, 31 May 2023 09:07:42 -0400
X-MC-Unique: Jp-RIAjWOh-Foi5ZJEufiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7024E1C03DAF;
 Wed, 31 May 2023 13:07:41 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3931620296C6;
 Wed, 31 May 2023 13:07:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 fiuczy@linux.ibm.com, thuth@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com
Subject: Re: [PATCH 1/2] linux-headers: Update with vfio_ap IRQ index mapping
In-Reply-To: <76dd7f44-56a5-91fd-13c2-fb1579c588ab@linux.ibm.com>
Organization: Red Hat GmbH
References: <20230530225544.280031-1-akrowiak@linux.ibm.com>
 <20230530225544.280031-2-akrowiak@linux.ibm.com>
 <06630472-57c8-89dd-ad80-75fb4d0d7de9@linux.ibm.com>
 <76dd7f44-56a5-91fd-13c2-fb1579c588ab@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 31 May 2023 15:07:40 +0200
Message-ID: <87sfbck5sz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31 2023, Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 5/30/23 8:56 PM, Matthew Rosato wrote:
>> On 5/30/23 6:55 PM, Tony Krowiak wrote:
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   linux-headers/linux/vfio.h | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>> 
>> Worth nothing here that linux-headers patches should be generated using scripts/update-linux-headers.sh.
>> 
>> Since this linux-headers update includes changes that aren't merged into the kernel yet, I would still use update-linux-headers.sh -- but also include in the commit message that this is a placeholder patch that includes unmerged uapi changes.  Then once the kernel changes merge you can just have a proper linux-headers update patch in a subsequent qemu series.
>
> I guess I do not understand the procedure here. I first determined the 
> latest kernel release in which the vfio.h file was updated with the 
> following command:
> git log --oneline origin/master -- linux-headers/linux/vfio.h
>
> According to the git log, the vfio.h file was last updated in kernel 
> v6.3-rc5. I cloned that kernel from 
> git.kernel.org/pub/scm/linux/kernel/git/stable and checked out kernel 
> 6.3-rc5. I then made the changes to the linux-headers/linux/vfio.h file 
> and ran the update-linux-headers.sh script and created this patch from 
> that. Where did I go wrong?

I think your procedure is fine for changes that are local to a single
header file. The one thing I'd recommend is to put an explicit "dummy
patch, to be replaced by a proper headers update" note into the patch,
so that it doesn't get merged by accident.

(For complex changes, headers update + explicit note might be better,
but the simple approach works in most cases.)


