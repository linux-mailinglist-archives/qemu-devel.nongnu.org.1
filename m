Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 743E57BDC5F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppYI-0005bl-Mo; Mon, 09 Oct 2023 08:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppYF-0005bM-Ps
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qppYE-0005mk-5B
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696855197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7wq9nD9ZTllgCEzkcIUGxen7ub2aHjlb3OByNkJyYQw=;
 b=gwjuxKrQcrWsDNJaysC+RzEqAwom/2IycYf5A1j9H1bL8HJvFXmsMu3ljr/vxanYq9QmDJ
 hl6LXBbihZHbbubiQo1wIzQRkq//KTZ4VF8+tqvyTjdwJ4UPglmNVbSMFrOXe3GRL7JvRf
 3TKmogi0KnFy5MYlklLFdqS7OVXoAMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-y7eWINRiNw6D2LYSHp2VkQ-1; Mon, 09 Oct 2023 08:39:55 -0400
X-MC-Unique: y7eWINRiNw6D2LYSHp2VkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59CF138116E3
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 12:39:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39BA5140EBB7
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 12:39:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 448A221E6904; Mon,  9 Oct 2023 14:39:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org,  Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH v2] contrib/vhost-user-gpu: Fix compiler warning when
 compiling with -Wshadow
References: <20231009083726.30301-1-thuth@redhat.com>
 <20231009074333-mutt-send-email-mst@kernel.org>
 <59c76034-62d5-c94c-8b3b-fa206768ee1d@redhat.com>
Date: Mon, 09 Oct 2023 14:39:54 +0200
In-Reply-To: <59c76034-62d5-c94c-8b3b-fa206768ee1d@redhat.com> (Thomas Huth's
 message of "Mon, 9 Oct 2023 14:05:22 +0200")
Message-ID: <87cyxo2cmd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 09/10/2023 13.45, Michael S. Tsirkin wrote:
>> On Mon, Oct 09, 2023 at 10:37:25AM +0200, Thomas Huth wrote:
>>> Rename some variables to avoid compiler warnings when compiling
>>> with -Wshadow=local.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Renamed the variable to something more unique
>>>
>>>   contrib/vhost-user-gpu/vugpu.h          | 8 ++++----
>>>   contrib/vhost-user-gpu/vhost-user-gpu.c | 6 +++---
>>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
>>> index 509b679f03..654c392fbb 100644
>>> --- a/contrib/vhost-user-gpu/vugpu.h
>>> +++ b/contrib/vhost-user-gpu/vugpu.h
>>> @@ -164,12 +164,12 @@ struct virtio_gpu_ctrl_command {
>>>   };
>>>     #define VUGPU_FILL_CMD(out) do {                                \
>>> -        size_t s;                                               \
>>> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
>>> +        size_t vugpufillcmd_s_ =                                \
>>> +            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
>>>                          &out, sizeof(out));                      \
>>> -        if (s != sizeof(out)) {                                 \
>>> +        if (vugpufillcmd_s_ != sizeof(out)) {                   \
>>>               g_critical("%s: command size incorrect %zu vs %zu", \
>>> -                       __func__, s, sizeof(out));               \
>>> +                       __func__, vugpufillcmd_s_, sizeof(out)); \
>>>               return;                                             \
>>>           }                                                       \
>>>       } while (0)
>> I think I prefer VUGPU_FILL_CMD_s or VUGPU_FILL_CMD_s_ - makes it clear
>> it's related to a macro.
>
> I have to say that I don't like that ... it's a variable after all, and naming it with capital letters looks rather confusing that helpful to me. I think it should be enough to have the underscore at the end here to make it unique enough.

Concur.  Plenty of precedence in the tree.


