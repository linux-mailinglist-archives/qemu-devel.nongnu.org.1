Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 497AD78286F
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3Zq-0005dI-I5; Mon, 21 Aug 2023 08:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY3Zm-0005ZG-S3
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY3Zk-0004ZC-Ck
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692619201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BMBw7UjbLGUBQ4nuMgLJkDNOXMXv/SwRpFTKgI9Oqls=;
 b=iTLOSBzPLa/yvvuKnHCTDAchXtmKVn52seUVPmkLj2x6/MD8Ll7ggmUDffTSZBJVU8i5d0
 s7e3DyHEReS0MXtT9qqKJf0fOvCAegw+2gz5SeFVDgjEmO3V+jCc6ZGvVTT3AUqM32ey2s
 DMKTbRRGPIlk2BE1ufsx+D+9ZomkKY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-l4qel4lcPpGoi-_X4qqjyw-1; Mon, 21 Aug 2023 08:00:00 -0400
X-MC-Unique: l4qel4lcPpGoi-_X4qqjyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2D4281B13D;
 Mon, 21 Aug 2023 11:59:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1903492C13;
 Mon, 21 Aug 2023 11:59:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DAE021E690D; Mon, 21 Aug 2023 13:59:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org,  imp@bsdimp.com
Subject: Re: [PATCH v3 00/32] Implement the stat system calls for FreeBSD.
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
Date: Mon, 21 Aug 2023 13:59:58 +0200
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com> (Karim Taha's
 message of "Sun, 13 Aug 2023 10:41:21 +0200")
Message-ID: <87y1i4ehc1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Subjects should start with a subsystem tag.  Diffstat suggests
"bsd-user:".


