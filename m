Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B32817039
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:20:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDX5-0002SB-2r; Mon, 18 Dec 2023 08:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDX3-0002Rm-E3
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDX2-0002Zr-1i
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702905579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NghmvvW+SpB5ynOV0Nrq50rjtrsI8hlufQxTmRwP/xM=;
 b=UHw1IdNpI0jfY6yeX+hbbeC9+189NiekjmloMJsm5yEQ9hKELCi9sYBSsqkupp3p9CO/m+
 VK5UwIfU0BmchWD8baeDxMmggXRbSs6CQtVc7izFg6igctzmgLcmVkb5H6hOxPF3ESkpLy
 x+L23iYZOxMN3DaKxROTnBQg9zkFJoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-cnAdWwD2Nzm0gySz3UjkOg-1; Mon, 18 Dec 2023 08:19:36 -0500
X-MC-Unique: cnAdWwD2Nzm0gySz3UjkOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82191890F62;
 Mon, 18 Dec 2023 13:19:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4591121306;
 Mon, 18 Dec 2023 13:19:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C91721E6920; Mon, 18 Dec 2023 14:19:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 alxndr@bu.edu,  bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 4/4] scripts: add script to compare compatible
 properties
In-Reply-To: <620bdb50-39fb-4096-a5eb-df724f31f505@yandex-team.ru> (Maksim
 Davydov's message of "Wed, 13 Dec 2023 17:48:19 +0300")
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-5-davydov-max@yandex-team.ru>
 <87o7faxncr.fsf@pond.sub.org>
 <620bdb50-39fb-4096-a5eb-df724f31f505@yandex-team.ru>
Date: Mon, 18 Dec 2023 14:19:34 +0100
Message-ID: <87jzpbsl5l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> On 12/1/23 12:51, Markus Armbruster wrote:
>> Review, anyone?
>
> Only Vladimir

To be clear: I'm soliciting a second review.

[...]


