Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D574D229
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInWy-0001zR-8W; Mon, 10 Jul 2023 05:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qInWt-0001yY-FG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qInWo-0003ai-Iy
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688982597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BY2rz2OYfJrKRqRVVQ6K7pqOp6frMppx8hSX/7UzocU=;
 b=BiQs43ECTdHJ1Qh501SxH1TCNewXS79b2ZqbEOABlpoHZqR7vxGaX9+rxOQnTOuQJkshWv
 oR8om1YwTwMC49NYyYhqMT50uSMIjlyf6vuc55PDN2+aIYjPB5kbjUqyIt7Jvkg28kOUrJ
 xoY6eNdx30/MUs0OOLbSkKTMFTpLMRg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-ZHCBKEpXNXa5AU3HHHBYQw-1; Mon, 10 Jul 2023 05:49:54 -0400
X-MC-Unique: ZHCBKEpXNXa5AU3HHHBYQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BC3D1C28CE3;
 Mon, 10 Jul 2023 09:49:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C590F2166B26;
 Mon, 10 Jul 2023 09:49:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD01C21E6A1F; Mon, 10 Jul 2023 11:49:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-trivial@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Juan Quintela
 <quintela@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH] docs/devel: Fix coding style in style.rst
References: <20230710092638.161625-1-thuth@redhat.com>
Date: Mon, 10 Jul 2023 11:49:49 +0200
In-Reply-To: <20230710092638.161625-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 10 Jul 2023 11:26:38 +0200")
Message-ID: <87mt049juq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Thomas Huth <thuth@redhat.com> writes:

> As defined earlier in this file, the opening curly brace of
> functions should be placed on a separate line. So we should
> do it in the examples here, too.
>
> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Fixes: 821f296756 ("docs: document use of automatic cleanup functions in glib")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/devel/style.rst | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index aa5e083ff8..3cfcdeb9cd 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -567,7 +567,8 @@ For example, instead of
>  
>  .. code-block:: c
>  
> -    int somefunc(void) {
> +    int somefunc(void)
> +    {
>          int ret = -1;
>          char *foo = g_strdup_printf("foo%", "wibble");
>          GList *bar = .....
> @@ -588,7 +589,8 @@ Using g_autofree/g_autoptr enables the code to be written as:
>  
>  .. code-block:: c
>  
> -    int somefunc(void) {
> +    int somefunc(void)
> +    {
>          g_autofree char *foo = g_strdup_printf("foo%", "wibble");
>          g_autoptr (GList) bar = .....
>  
> @@ -613,7 +615,8 @@ are still some caveats to beware of
>  
>  .. code-block:: c
>  
> -    char *somefunc(void) {
> +    char *somefunc(void)
> +    {
>          g_autofree char *foo = g_strdup_printf("foo%", "wibble");
>          g_autoptr (GList) bar = .....

Reviewed-by: Markus Armbruster <armbru@redhat.com>


