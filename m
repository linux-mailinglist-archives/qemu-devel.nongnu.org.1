Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21A830ABA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:14:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Xg-0002oT-D1; Wed, 17 Jan 2024 11:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQ8Xe-0002mf-2P
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQ8Xc-0001Ju-Pf
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 11:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705508004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iHamPQ65HDyrSljte1Xx1td3eL0KovyaYhgNg9YB8Ik=;
 b=QEjoK6E7BNnVVsSncg48adIV6CuCPWFmufnNDElcp73n+5Mq7xR4gYysB/x0hkz68Rt/iW
 XOY8OOAs+o0pP44GRzvTOV/PZfs2nvTXZjb/gkIraWxekzwsaeglab0zt2Zfb4i4qZbCQV
 uiJ0xsVftj0sVnn3jjQl3An3h9Oxl8M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-MByo9WEfMSO7AY6CmjAMdg-1; Wed, 17 Jan 2024 11:13:20 -0500
X-MC-Unique: MByo9WEfMSO7AY6CmjAMdg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79217800076;
 Wed, 17 Jan 2024 16:13:20 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56E35492BC6;
 Wed, 17 Jan 2024 16:13:19 +0000 (UTC)
Date: Wed, 17 Jan 2024 17:13:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/3] iotests: add filter_qmp_generated_node_ids()
Message-ID: <Zaf8npvl1ideUgtF@redhat.com>
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116190042.1363717-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 16.01.2024 um 20:00 hat Stefan Hajnoczi geschrieben:
> Add a filter function for QMP responses that contain QEMU's
> automatically generated node ids. The ids change between runs and must
> be masked in the reference output.
> 
> The next commit will use this new function.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


