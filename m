Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8A81CA4F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 13:52:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGezt-0003GP-8j; Fri, 22 Dec 2023 07:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGezo-0003FT-DW
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGezl-0008HN-J1
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 07:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703249475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ParxBq6NpzQ+iH0tJHnc4A6gO2AivaR6o/aLtaHUn7s=;
 b=d9ACPtS60+Oka2L/YBWc9djhpLLN2i7Xdk6N0TQAbhm3KmIfUyVsQNvewzggq+SDR53/9i
 PJRarUzKjSwqi8gw0X2FBJDMEtd+Gznn6Wwy9TFFc4uRyGXdOu8zoFkp0q7gxgWE9/6j9x
 dmVFLK5Bg96F8kk9KoACKG0A+xhkp30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-OeRZnaXpMOCYhPpU5RPcpA-1; Fri, 22 Dec 2023 07:51:12 -0500
X-MC-Unique: OeRZnaXpMOCYhPpU5RPcpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 36AAE185A782;
 Fri, 22 Dec 2023 12:51:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2475A2166B31;
 Fri, 22 Dec 2023 12:51:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2056E21E6920; Fri, 22 Dec 2023 13:51:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 alxndr@bu.edu,  bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v7 0/4] compare machine type compat_props
In-Reply-To: <20231214155333.35643-1-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Thu, 14 Dec 2023 18:53:29 +0300")
References: <20231214155333.35643-1-davydov-max@yandex-team.ru>
Date: Fri, 22 Dec 2023 13:51:10 +0100
Message-ID: <874jgah03l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

Something odd is going on here.

Your cover letter and PATCH 4 arrived here with

    Content-Type: text/plain; charset=UTF-8

Good.

PATCH 2:

    Content-Type: text/plain; charset="US-ASCII"; x-default=true

PATCH 1 and 3:

    Content-Type: text/plain; charset=N

git-am chokes on that:

    error: cannot convert from N to UTF-8


