Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E327F9F68
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 13:18:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7aYl-0005th-Vk; Mon, 27 Nov 2023 07:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7aYa-0005sb-0R
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:17:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7aYM-0005NI-9r
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701087449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMZTfdQXkhvP4TCG3NVcK87f7z939e1VmO+oiG5oLF4=;
 b=ezAbTMjzchnmlVPT5o3y3DgPc7wDDi9Vyl5r+HGBCyxM6eg5hIX4Y42lmw8+bK4iswqel8
 aTgQWAQSwIxrQX1McO+eqdzz/MOS449H0Uj3AHJUzXoUN5E3DUDvxYnzVuWD2VrCZ639Sz
 vELO9mpOr957r5iRq4aNf7KHV+nSaNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-IyXSmZWgOFCAoyKFU1xD8g-1; Mon,
 27 Nov 2023 07:17:27 -0500
X-MC-Unique: IyXSmZWgOFCAoyKFU1xD8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4809D1C06E01;
 Mon, 27 Nov 2023 12:17:27 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79F4620268D1;
 Mon, 27 Nov 2023 12:17:26 +0000 (UTC)
Date: Mon, 27 Nov 2023 13:17:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 den@virtuozzo.com
Subject: Re: [PATCH] iotests: fix default MT detection
Message-ID: <ZWSI1TfYQ17V9skv@redhat.com>
References: <20231122121538.32903-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122121538.32903-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 22.11.2023 um 13:15 hat Andrey Drobyshev geschrieben:
> MT is being detected based on "-M help" output, and we're searching for
> the line ending with " (default)".  However, in downstream one of the
> MTs marked as deprecated might become the default, in which case this
> logic breaks as the line would now end with " (default) (deprecated)".
> To fix potential issues here, let's relax that requirement and detect
> the mere presence of " (default)" line instead.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Thanks, applied to the block branch. (I did however change "MT" to
"machine type" in the commit message because at first I was confused
what you meant with it.)

Kevin


