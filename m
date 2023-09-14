Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 750CA7A0317
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgktO-00044u-84; Thu, 14 Sep 2023 07:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgktJ-00044l-GE
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgktH-000504-Ot
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694692329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkAUVfWhw+h7K6XY0hr0iTVIL+JbJgon6IsrpQ7oyJw=;
 b=ZwLeuVhD6velb6wijrPNxc/34V8JpQLFJgJ0jcby89BSDrMJuT1uVmKchOVQNpUvocnSJM
 p88vaMhmftrKZBE6IfHSR1ZbC+KjN6FS8ihHu8eRuVwfTHD1PH2490Jpcw2oHvSoPGV2DP
 Zw7+RFy1Cjev1iHGtTABhrZglhIUdOc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-jnxE1G2lMCaBGPlu3dSPaQ-1; Thu, 14 Sep 2023 07:52:08 -0400
X-MC-Unique: jnxE1G2lMCaBGPlu3dSPaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DFA5185A79B
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 11:52:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E7C210F1BE7;
 Thu, 14 Sep 2023 11:52:07 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:52:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 14/14] ui: add precondition for dpy_get_ui_info()
Message-ID: <ZQLz5bjfCJ3iOpw3@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
 <20230912104649.1638640-15-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912104649.1638640-15-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 12, 2023 at 02:46:48PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Ensure that it only get called when dpy_ui_info_supported(). The
> function should always return a result. There should be a non-null
> console or active_console.

Empirically that does not appear to be the case. After this patch,
a no-args QEMU launch immediately aborts:

$ ./build/qemu-system-x86_64 
qemu-system-x86_64: ../ui/console.c:818: dpy_get_ui_info: Assertion `dpy_ui_info_supported(con)' failed.
Aborted (core dumped)

This ought to be running the GTK UI for me. Manually ask for
SDL instead and it doesn't crash.

> 
> Modify the argument to be const as well.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/ui/console.h | 2 +-
>  ui/console.c         | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 79e4702912..28882f15a5 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -329,7 +329,7 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
>                                    uint64_t interval);
>  void unregister_displaychangelistener(DisplayChangeListener *dcl);
>  
> -bool dpy_ui_info_supported(QemuConsole *con);
> +bool dpy_ui_info_supported(const QemuConsole *con);
>  const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);
>  int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info, bool delay);
>  
> diff --git a/ui/console.c b/ui/console.c
> index aa1e09462c..4a4f19ed33 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -801,7 +801,7 @@ static void dpy_set_ui_info_timer(void *opaque)
>      con->hw_ops->ui_info(con->hw, head, &con->ui_info);
>  }
>  
> -bool dpy_ui_info_supported(QemuConsole *con)
> +bool dpy_ui_info_supported(const QemuConsole *con)
>  {
>      if (con == NULL) {
>          con = active_console;
> @@ -815,6 +815,8 @@ bool dpy_ui_info_supported(QemuConsole *con)
>  
>  const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
>  {
> +    assert(dpy_ui_info_supported(con));
> +
>      if (con == NULL) {
>          con = active_console;
>      }
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


