Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8077CD85D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2zs-00068D-HT; Wed, 18 Oct 2023 05:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt2zq-00067Y-6W
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt2zo-0001f6-PG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697621863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fKA1+njlaHE3acQEe6Ar+lqnlHqSoget4WgSQ5cmvSw=;
 b=Sxf2nxola9KUjUirXKziShVXBaZ4DxSpz/8LwWG4ZHjnmi3sREBPc9ITLTOD86Tk8xM9q2
 0B0V57M1ktAxck4Ed7li/WHOA4VYc89iGRKOMchYzRNKR24vsR3jMALovB7uJmlxGEiESy
 keDUlElj2uUvJWbzLTE5Z4u286vg1y0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-jOwnyJH-PSu0m2Qe7bz7_Q-1; Wed, 18 Oct 2023 05:37:40 -0400
X-MC-Unique: jOwnyJH-PSu0m2Qe7bz7_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2ED889059;
 Wed, 18 Oct 2023 09:37:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF56C2026D4C;
 Wed, 18 Oct 2023 09:37:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E278021E6A1F; Wed, 18 Oct 2023 11:37:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  den@virtuozzo.com,  t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 6/9] qapi/block-core: use JobType for BlockJobInfo's
 type
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-7-f.ebner@proxmox.com>
Date: Wed, 18 Oct 2023 11:37:36 +0200
In-Reply-To: <20231013092143.365296-7-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 13 Oct 2023 11:21:40 +0200")
Message-ID: <87ttqouv8f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> In preparation to turn BlockJobInfo into a union with @type as the
> discriminator. That requires it to be an enum.
>
> No functional change is intended.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Replacing str by enum makes sense whether we need enum for a union or
not.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


