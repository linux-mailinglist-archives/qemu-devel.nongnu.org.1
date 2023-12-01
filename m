Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57168800712
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:32:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zrB-0001rj-O7; Fri, 01 Dec 2023 04:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8zr9-0001rZ-Ei
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8zr7-0006zY-BG
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701423039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uV0dQMMBqa7A5Fe7N/Adl//tVvQkLJqHjlFM1EAKIqc=;
 b=dXkJFXOAic5+/opRD2p8JIP8bLh5zDj8c+WdrJc1syDLhHa0I5GcZGvGB89RrTiaahLdQ/
 YzaWdiE6pUtWeFE2iP3kP9jlJcBynDZGTl/7jCq6Nh6LZVossQcvyza148ozQCuEm3Kb5B
 Metwy0BDO01M1Po0ivQ416ePM5zVqLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-anckKfRXM-qQ6yS6XWv-tg-1; Fri, 01 Dec 2023 04:30:36 -0500
X-MC-Unique: anckKfRXM-qQ6yS6XWv-tg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFEA1185A78A;
 Fri,  1 Dec 2023 09:30:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1144310EA5;
 Fri,  1 Dec 2023 09:30:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BE5721E6A1F; Fri,  1 Dec 2023 10:30:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 alxndr@bu.edu,  bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 1/4] qom: add default value
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-2-davydov-max@yandex-team.ru>
Date: Fri, 01 Dec 2023 10:30:34 +0100
In-Reply-To: <20231108153827.39692-2-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Wed, 8 Nov 2023 18:38:24 +0300")
Message-ID: <877clyz2v9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> qmp_qom_list_properties can print default values if they are available
> as qmp_device_list_properties does, because both of them use the
> ObjectPropertyInfo structure with default_value field. This can be useful
> when working with "not device" types (e.g. memory-backend).
>
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qom/qom-qmp-cmds.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 7c087299de..e91a235347 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -212,6 +212,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
>          info->name = g_strdup(prop->name);
>          info->type = g_strdup(prop->type);
>          info->description = g_strdup(prop->description);
> +        info->default_value = qobject_ref(prop->defval);
>  
>          QAPI_LIST_PREPEND(prop_list, info);
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>


