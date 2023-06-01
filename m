Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DC719E78
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4iZy-0005v0-6w; Thu, 01 Jun 2023 09:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iZw-0005sy-Dn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4iZu-0007gm-W3
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685626978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9DzCBzotLVAP/9aKe7SAtSy7h/nGdvjuvGWbdqlqKY=;
 b=F5ejigs/aHSrLISzkdp1oI56WSH6JtfNGB8V0Od9A94d5M72HfUaXUZy0f3Ui2fsL9aNwM
 /INbnaaCQuz0BkHRcJE6jLXVX1pYtKc0Z7XQ+yS3+CK9zJeARdMpfergjMA7rv/FPcyfaC
 T8Bd+Ga0cYUSAjjALOcfZw/2TMb3Hcw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-lEie-499OdqIVNAKDGtbRQ-1; Thu, 01 Jun 2023 09:42:56 -0400
X-MC-Unique: lEie-499OdqIVNAKDGtbRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2ED4C3C14AAE;
 Thu,  1 Jun 2023 13:42:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0192492B00;
 Thu,  1 Jun 2023 13:42:55 +0000 (UTC)
Date: Thu, 1 Jun 2023 08:42:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/3] block: remove separate bdrv_file_open callback
Message-ID: <fpjgdbgqxxknfjtz27qqcvw6pvpgifjia3a6k2g7syug2bmm22@x3xzgsganrg2>
References: <20230601115139.196369-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601115139.196369-1-pbonzini@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 01, 2023 at 01:51:36PM +0200, Paolo Bonzini wrote:
> The value of the bdrv_file_open is sometimes checked to distinguish
> protocol and format drivers, but apart from that there is no difference
> between bdrv_file_open and bdrv_open.
> 
> However, they can all be distinguished by the non-NULL .protocol_name
> member.  Change the checks to use .protocol_name instead of .bdrv_file_open,
> and unify the two callbacks.
> 
> Paolo
> 
> v1->v2: fix bisectability
> 
> Paolo Bonzini (3):
>   block: make assertion more generic
>   block: do not check bdrv_file_open
>   block: remove separate bdrv_file_open callback

Series:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


