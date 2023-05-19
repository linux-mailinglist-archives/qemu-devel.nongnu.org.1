Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0480D709B3B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01wW-0000HR-KB; Fri, 19 May 2023 11:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01wT-0000HF-K9
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01wQ-0005Zm-V4
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4JrQZjQQRhkm8AVV2mK34OzdHiptkm8MNAuFGetyQgk=;
 b=SaaKFVAYTu3EjBYyT0P9ccPT5vM0qu6OPJ01vnEVmEvaexKNmFrchOb3KzbC/+Td2em5tB
 IgC6NIZD8IiNi3LiqguxA1yEEoGrXH+1Mje4bjQagnwB5HHPc4TgpEXEgMy7ogkB2uqDwv
 NGWnkBWwnCtw7MKfwLlJGmUcyMhNe2M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-YFq4fWM2NcCotAUJ7EsJOw-1; Fri, 19 May 2023 11:22:48 -0400
X-MC-Unique: YFq4fWM2NcCotAUJ7EsJOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 702063806735;
 Fri, 19 May 2023 15:22:48 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE709C54186;
 Fri, 19 May 2023 15:22:47 +0000 (UTC)
Date: Fri, 19 May 2023 10:22:45 -0500
From: Eric Blake <eblake@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, armbru@redhat.com
Subject: Re: [PATCH] [query-memory-size-summary] Report page size
Message-ID: <5d5tf73dy6braudustggagxek5gwrevb4nccw3ozxv2byaw7ag@xfuy5zkgcy6s>
References: <3200757e8218f65f873e79ab84a4b8382fbfa099.1684483058.git.gudkov.andrei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3200757e8218f65f873e79ab84a4b8382fbfa099.1684483058.git.gudkov.andrei@huawei.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 19, 2023 at 11:10:30AM +0300, Andrei Gudkov wrote:
> Some commands (query-migrate and calc-dirty-rate) report values
> in units of pages. However, currently the only place where we can
> get page size is through query-migrate and only after migration
> has started. query-memory-size-summary seems like an appropritate

appropriate

> place where it should be reported instead.
> 
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/machine.json          | 8 ++++++--
>  hw/core/machine-qmp-cmds.c | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

Your reasoning for exposing this information in more than one place,
because the new place is lighter-weight to access, makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


