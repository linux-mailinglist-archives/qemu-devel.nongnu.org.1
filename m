Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0DF82C154
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 15:05:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI9k-00081s-CR; Fri, 12 Jan 2024 09:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOI8m-0007DS-PE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rOI8k-0006pT-Vp
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 09:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705068244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1QVN8BKnnj2NM9pM2llPjQmSGBCzsdVPe90nv7Mei0=;
 b=F85UBdcfyPbeiHW/g02evf9688peJICtFboIOA+tKw2GDbCAHq/w7jPpvVQw4qzSexlUl3
 jD4qTLJG9NDoYluvU2cLj8bXi9aIg3jQ7KPf0Ic4Kk0X3x8ltP0HbLNsLIfdFthKa3Yh8v
 7zWxzGAwQFgY9Ez/Sh4hAbrDFoEPnZI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-K6sP_pxkMK-A5MjFq9CMEA-1; Fri, 12 Jan 2024 09:04:00 -0500
X-MC-Unique: K6sP_pxkMK-A5MjFq9CMEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD6BA830FD7;
 Fri, 12 Jan 2024 14:03:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E5B492BC6;
 Fri, 12 Jan 2024 14:03:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FEB421E6691; Fri, 12 Jan 2024 15:03:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 2/2] hmp: Drop unknown feature and status bits
In-Reply-To: <6f0de9a1c82f64c4055908573d82a1c86c4d99e8.1704382761.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Fri, 5 Jan 2024 00:19:35 +0800")
References: <cover.1704382761.git.yong.huang@smartx.com>
 <6f0de9a1c82f64c4055908573d82a1c86c4d99e8.1704382761.git.yong.huang@smartx.com>
Date: Fri, 12 Jan 2024 15:03:58 +0100
Message-ID: <87h6jiodgx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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

Hyman Huang <yong.huang@smartx.com> writes:

> The QMP command "x-query-virtio-status" outputs the full
> feature and status bit information, so there is no need
> to maintain it in the HMP output; drop it.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

I'm not sure hiding unknown bits from HMP users is a good idea.  Sure,
you can use QMP to find them, but why would you when HMP gives no clue
that its output is incomplete?

I'd simply keep them, i.e. drop this patch.


