Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63375EE4E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrFI-0007Ep-TC; Mon, 24 Jul 2023 04:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNrFH-0007Eh-8O
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNrFF-0007oB-LU
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690188524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6ruvE4x290N+Qim9jiXydgguffRZ+qXXRKoYI5JdWU=;
 b=VNHaOiq/H18MFpGrjTc9mdNbXGtdlAA6Ghx942l9ifR5NDWlPDCq6YxMD6r064GrHZGkFJ
 0s1HRzSk0jpm3du0IVYu68vpXsGdSlINwSNjR5AqSxDFB4r9juMU4yKDlF0aj1IVREI7OL
 850FjJx/uSQG/qsttTEKqAyUUoYsezs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-gtiXN25ON121PCHedRphXw-1; Mon, 24 Jul 2023 04:48:42 -0400
X-MC-Unique: gtiXN25ON121PCHedRphXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3B303813F20;
 Mon, 24 Jul 2023 08:48:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BC6E1121315;
 Mon, 24 Jul 2023 08:48:41 +0000 (UTC)
Date: Mon, 24 Jul 2023 09:48:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Sergii Zasenko <sergii@zasenko.name>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Allow UNIX socket for VNC websocket
Message-ID: <ZL4654MGVB9ZWXdu@redhat.com>
References: <20230723210355.28717-1-sergii@zasenko.name>
 <CAJ+F1C+_y8APEqWq2fL0DHA3gYLD+wCkwUp+8D1MpARcVfFr_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+_y8APEqWq2fL0DHA3gYLD+wCkwUp+8D1MpARcVfFr_Q@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 24, 2023 at 12:08:26PM +0400, Marc-André Lureau wrote:
> Hi
> 
> Daniel, in commit 275e0d616b ("ui: refactor code for populating
> SocketAddress from vnc_display_open"), you said "This refactoring also
> removes the restriction that prevents enabling websockets when the plain
> VNC server is listening on a UNIX socket.". But you didn't remove the
> condition. I suppose it was a left-over?

That commit was allowing the regular VNC port to be put on UNIX
socket, at the same time as WS was enabled, it wasn't trying to
put WS on a UNIX socket. Still I seee no reason to keep the
limitation.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


