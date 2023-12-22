Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F281C7AB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:56:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcF7-0003yj-5o; Fri, 22 Dec 2023 04:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcF5-0003yb-Sv
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:54:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGcF4-0003fg-Fo
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703238893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Aa+duHC0VS5my5Dntzmdnw4Xd4v9oxLw2k1Hg5tgPU=;
 b=UpVXIJsHVxUFd9dLBEWbDRHrEXTr+bN9Sd4bCyI7xV+00o45HloYzr/jXuZLd8o5kLRruH
 PwUiqaAM9bD++LiBUhdl52wmUIaP8RVxKFw3PPZXDu2WH7my8XgObAdGEMfbwJ6QoHeXjE
 u6CL+0KzMovExvy8n8VIUzLsxq8yofE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-4hSvgweEOoaTQDyXJmq1zA-1; Fri, 22 Dec 2023 04:54:49 -0500
X-MC-Unique: 4hSvgweEOoaTQDyXJmq1zA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8544B85A588;
 Fri, 22 Dec 2023 09:54:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F26B40C6EB9;
 Fri, 22 Dec 2023 09:54:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3573621E6920; Fri, 22 Dec 2023 10:54:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v2 1/2] qapi/virtio: Add feature and status bits for
 x-query-virtio-status
In-Reply-To: <3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Sat, 18 Nov 2023 23:22:49 +0800")
References: <cover.1700319559.git.yong.huang@smartx.com>
 <3c7161a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com>
Date: Fri, 22 Dec 2023 10:54:47 +0100
Message-ID: <878r5mwoig.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Hyman Huang <yong.huang@smartx.com> writes:

> This patch allows to display feature and status bits in
> virtio-status.
>
> Applications could find it helpful to compare status and features
> that are numeric encoded. For example, an upper application could
> use the features (encoded as a number) in the output of "ovs-vsctl
> list interface" and the feature bits fields in the output of QMP
> command "x-query-virtio-status" to compare directly when attempting
> to ensure the correctness of the virtio negotiation between guest,
> QEMU, and OVS-DPDK. Not applying any more encoding.
>
> This patch also serves as a preparation for the next one, which implements
> a vhost-user test case about acked features of vhost-user protocol.
>
> Note that since the matching HMP command is typically used for human,
> leave it unchanged.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

We discussed v1 some more since you posted this.  Do you intend to do a
v3?


