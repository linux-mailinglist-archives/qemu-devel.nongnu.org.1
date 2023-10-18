Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9607CD869
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt345-0003Qb-51; Wed, 18 Oct 2023 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt342-0003AM-Cl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt340-0002fh-Cn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697622123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p3SIiBchNR1V5iriYG4l/tY0NNMp2lAGW3tid8RV3Es=;
 b=QlLp1g8SANLKK0hEhkUE7yN0PXabCS5L9w9jaQuB+CKrn40eCLPl6bzabpQD0YOjB3yrk7
 LSZ4dMuOrtfkCsbZ+WYHTNWNB4oe2FOZvP+q9sb5W3xq91l1nwGHMhmcm/ZvVwzGQciDUr
 9LLWoYhrEj/CtMpdsnENVREH7pYXPzI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-NjQLFBIzOkSCIIH6-wpHxg-1; Wed, 18 Oct 2023 05:41:52 -0400
X-MC-Unique: NjQLFBIzOkSCIIH6-wpHxg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5A861C051A4;
 Wed, 18 Oct 2023 09:41:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82DF7492BFA;
 Wed, 18 Oct 2023 09:41:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C24621E6A1F; Wed, 18 Oct 2023 11:41:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  armbru@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  den@virtuozzo.com,
 t.lamprecht@proxmox.com,  alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 0/9] mirror: allow switching from background to
 active mode
References: <20231013092143.365296-1-f.ebner@proxmox.com>
Date: Wed, 18 Oct 2023 11:41:50 +0200
In-Reply-To: <20231013092143.365296-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Fri, 13 Oct 2023 11:21:34 +0200")
Message-ID: <87lec0uv1d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Changes in v3:
>     * unlock the job mutex when calling the new block job driver
>       'query' handler
>     * squash patch adapting iotest output into patch that changes the
>       output
>     * turn accesses to copy_mode and actively_synced atomic
>     * slightly rework error handling in mirror_change
>
> Changes in v2:
>     * move bitmap to filter which allows to avoid draining when
>       changing the copy mode
>     * add patch to determine copy_to_target only once
>     * drop patches returning redundant information upon query
>     * update QEMU version in QAPI
>     * update indentation in QAPI
>     * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
>       doc comments to conform to current conventions"))
>     * add patch to adapt iotest output
>
> Discussion of v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02290.html
>
> Discussion of v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-02/msg07216.html
>
> With active mode, the guest write speed is limited by the synchronous
> writes to the mirror target. For this reason, management applications
> might want to start out in background mode and only switch to active
> mode later, when certain conditions are met. This series adds a
> block-job-change QMP command to achieve that, as well as
> job-type-specific information when querying block jobs, which
> can be used to decide when the switch should happen.
>
> For now, only the direction background -> active is supported.
>
> The information added upon querying is whether the target is actively
> synced, the total data sent, and the remaining dirty bytes.
>
> Initially, I tried to go for a more general 'job-change' command, but
> to avoid mutual inclusion of block-core.json and job.json, more
> preparation would be required.

Can you elaborate a bit?  A more generic command is preferable, and we
need to understand what it would take.


