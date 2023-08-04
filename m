Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C198776FBAA
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpqX-0002ho-8H; Fri, 04 Aug 2023 04:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qRpqV-0002h8-3Z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qRpqT-0001K9-MR
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691136455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BPZ37OXbJ643jpjTI2tKOcZLiYPFQw0EhR+NrIxnbY=;
 b=Vh5kTcnvQ1Ik0C/C32ESe4f67HtdVr2yGdyZIzPdVNHHHyQjFEjHgI1x+xkXvx4YX9Zz6f
 y9P/XmemX5PsfUarF8AA6aNVwEK8jxyu3XJVu3PnzKG4ouwxHfxjez9wOjTTpSImIO5UYc
 O7D6D6LtmBk44Mk16brf+KAIrtTWYKM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-0OcuT5oqMLKdo0iPl8vVnw-1; Fri, 04 Aug 2023 04:07:33 -0400
X-MC-Unique: 0OcuT5oqMLKdo0iPl8vVnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57713280BC53;
 Fri,  4 Aug 2023 08:07:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A04492B03;
 Fri,  4 Aug 2023 08:07:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Subject: Re: [PATCH for-8.2] hw/s390x/s390-virtio-ccw: Remove superfluous
 code to set the NIC model
In-Reply-To: <20230804073525.11857-1-thuth@redhat.com>
Organization: Red Hat GmbH
References: <20230804073525.11857-1-thuth@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 04 Aug 2023 10:07:31 +0200
Message-ID: <871qgj5iyk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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

On Fri, Aug 04 2023, Thomas Huth <thuth@redhat.com> wrote:

> The check for nd->model being NULL was originally required, but in
> commit e11f463295d95aba ("s390x/virtio: use qemu_check_nic_model()")
> the corresponding code had been replaced by a call to the function
> qemu_check_nic_model() - and this in turn calls qemu_find_nic_model()
> which contains the same check for nd->model being NULL again. So we
> can remove this from the calling site now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


