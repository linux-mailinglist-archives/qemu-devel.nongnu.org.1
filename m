Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B6ABDFA9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 17:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHPJ1-0003iw-Gg; Tue, 20 May 2025 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPIz-0003iT-Jz
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHPIx-0003g1-2g
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747756497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iev/2aQ63t4hncGcriw79KOw4Xi2m11jziKoSBJIeck=;
 b=fR6V5jDZ7YuMBJ+KX4yxMFqZpgwbK6YSObX7xAZXcfjTeXyfKinZMpCDAde5KAl12I/oFp
 Xg74QaGRDBlf0ZVHQeqHmCqIRgkmJqsXieJBO9ocpU23qz1bwBWHcWh3/kFwFJJIycLlse
 RTIhL+imQN8hEgVJlxTsPU+g6aPfKJk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-IjhC_dfVNnayy-TD1mUt5g-1; Tue,
 20 May 2025 11:54:53 -0400
X-MC-Unique: IjhC_dfVNnayy-TD1mUt5g-1
X-Mimecast-MFC-AGG-ID: IjhC_dfVNnayy-TD1mUt5g_1747756488
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90DDC180036F; Tue, 20 May 2025 15:54:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DAE5180045B; Tue, 20 May 2025 15:54:42 +0000 (UTC)
Date: Tue, 20 May 2025 10:54:40 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, 
 stefanha@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru, 
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 24/24] block: add bdrv_graph_wrlock_drained()
 convenience wrapper
Message-ID: <u32fzgpu4cyrofmsagtpitqyjz3anekfln3ej2gm5xz25bainb@l3h75hxzordy>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-25-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103012.424311-25-f.ebner@proxmox.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 20, 2025 at 12:30:12PM +0200, Fiona Ebner wrote:
> Many write-lockded sections are also drained sections. A new

write-locked

> bdrv_graph_wrunlock_drained() wrapper around bdrv_graph_wrunlock() is
> introduced, which will begin a drained section first. A global
> variable is used so bdrv_graph_wrunlock() knows if it also needs
> to end such a drained section. Both the aio_poll call in
> bdrv_graph_wrlock() and the aio_bh_poll() in bdrv_graph_wrunlock()
> can re-enter a write-locked section. While for the latter, ending the
> drain could be moved to before the call, the former requires that the
> variable is a counter and not just a boolean.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


