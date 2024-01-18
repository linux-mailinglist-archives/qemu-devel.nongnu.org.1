Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6DF831CC6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:48:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUcF-00047U-K8; Thu, 18 Jan 2024 10:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQUcD-000453-Bk
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQUcB-0007oO-QE
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705592854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iACCbUSH7oZbWmn74l1bUXTWVqrESrMd9c8YW72QaZY=;
 b=ZsBfFpU4eNx6qWWLHMuKhT7vh333rKUQT5g27nRD4gtwob38rbq5aUmGww75xdVhIdgiSj
 /Z1VQ8xxAQ2fuhrMEqFyCR/pueBLoEIyS+fku5y4q0yj4/qdl4QzbXNWVTvYOXzqTHEP3b
 jdA2rV1GWlbXEO1BI96sZ702VA3BGjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-ONpylVGGMgKYKTpV9o-p_w-1; Thu, 18 Jan 2024 10:47:30 -0500
X-MC-Unique: ONpylVGGMgKYKTpV9o-p_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D9D185A58B;
 Thu, 18 Jan 2024 15:47:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4BE2166B33;
 Thu, 18 Jan 2024 15:47:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E433A21E680D; Thu, 18 Jan 2024 16:47:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] ui/gtk: Strip trailing '\n' from error string arguments
In-Reply-To: <20240118153411.2907-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 18 Jan 2024 16:34:11
 +0100")
References: <20240118153411.2907-1-philmd@linaro.org>
Date: Thu, 18 Jan 2024 16:47:28 +0100
Message-ID: <87v87q8wz3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> error_report() strings should not include trailing newlines.
>
> Noticed running:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h \
>     --sp-file scripts/coccinelle/err-bad-newline.cocci \
>     --keep-comments --use-gitgrep --dir .
>   ./ui/gtk.c:1094:56:"gtk: unexpected touch event type\n"
>
> Fixes: 5a4cb61ae1 ("ui/gtk: enable backend to send multi-touch events")
> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  ui/gtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..c819c72a20 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1091,7 +1091,7 @@ static gboolean gd_touch_event(GtkWidget *widget, G=
dkEventTouch *touch,
>          type =3D INPUT_MULTI_TOUCH_TYPE_END;
>          break;
>      default:
> -        warn_report("gtk: unexpected touch event type\n");
> +        warn_report("gtk: unexpected touch event type");
>          return FALSE;
>      }

I don't like the error message (drop the "gtk: " prefix or work it into
the message), but that's a separate issue.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


