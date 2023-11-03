Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B457B7E000C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqcA-0002dN-BU; Fri, 03 Nov 2023 05:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqc8-0002WW-Lx
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qyqc6-0006du-3O
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699004233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VhjNHRzq9VtxrcdyWh8AOkAIjXeF9qfQFPPys8/HACY=;
 b=HYluKiMD+4QN31yRbcYIDf+Mlo0pCwn4fARXr3Im/OKtRoaRGrEOIKbu/jreM4d+dPdFcd
 2L0MrMSv0J2oFnSp4UDJG4jRIOJ5cXNLObLZ+As0sjGWRY28wTwTtyknL4Qzx7f6O8+XVk
 h5peqqdjQrjRbT64vX8k3+W3r5SlkB4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-YBqJ9X8GM5a1aXGiZBXAfA-1; Fri, 03 Nov 2023 05:37:10 -0400
X-MC-Unique: YBqJ9X8GM5a1aXGiZBXAfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE6D1811E86;
 Fri,  3 Nov 2023 09:37:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC2FF40C6EBC;
 Fri,  3 Nov 2023 09:37:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B056321E6A1F; Fri,  3 Nov 2023 10:37:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  den@virtuozzo.com,  t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 0/9] mirror: allow switching from background to
 active mode
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <87lec0uv1d.fsf@pond.sub.org>
 <78effcf7-1b4d-4f38-ab3f-1de3de9e405f@proxmox.com>
Date: Fri, 03 Nov 2023 10:37:08 +0100
In-Reply-To: <78effcf7-1b4d-4f38-ab3f-1de3de9e405f@proxmox.com> (Fiona Ebner's
 message of "Wed, 18 Oct 2023 11:45:09 +0200")
Message-ID: <87jzqzyy7v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Am 18.10.23 um 11:41 schrieb Markus Armbruster:
>> Fiona Ebner <f.ebner@proxmox.com> writes:
>>>
>>> Initially, I tried to go for a more general 'job-change' command, but
>>> to avoid mutual inclusion of block-core.json and job.json, more
>>> preparation would be required.
>> 
>> Can you elaborate a bit?  A more generic command is preferable, and we
>> need to understand what it would take.
>> 
>
> Yes, I did so during the discussion of v2:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg02993.html

Replied there.  Sorry for the delay!


