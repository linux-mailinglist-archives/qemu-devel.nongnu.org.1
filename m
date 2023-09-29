Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C57B2C92
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7He-0002sN-BY; Fri, 29 Sep 2023 02:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Ha-0002jT-18
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7HU-0001Em-Tt
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695970028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HRLmADXZ/06XlQUBoOuiqbxlAdZViQjqEDnkOyIneeY=;
 b=Qp1vXF+OA0RaxNeX/TBQ/Kn0B1CQSTBr5MrojsvSRVhcK7MihHgIeeqGjY6RueuAlWZgdU
 f07ZJq/Gr1YJsX8UU1a9uGuTQyEc7V6lXipS6PgVwV1AwfoCYLT8uNRVm+eXLGGurf2s4i
 OeflawQv66R0eaVKLxAPKAIU7eLz9w4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-Zz_JHSTVMDOrmC89-oRwPA-1; Fri, 29 Sep 2023 02:47:06 -0400
X-MC-Unique: Zz_JHSTVMDOrmC89-oRwPA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64C55101A585
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 06:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43010492C37
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 06:47:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 415D221E6904; Fri, 29 Sep 2023 08:47:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Eric Auger
 <eric.auger@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] intel_iommu: Fix shadow local variables on "size"
References: <20230922160410.138786-1-peterx@redhat.com>
Date: Fri, 29 Sep 2023 08:47:05 +0200
In-Reply-To: <20230922160410.138786-1-peterx@redhat.com> (Peter Xu's message
 of "Fri, 22 Sep 2023 12:04:10 -0400")
Message-ID: <877co9iihi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> This patch fixes the warning of shadowed local variable:
>
> ../hw/i386/intel_iommu.c: In function =E2=80=98vtd_address_space_unmap=E2=
=80=99:
> ../hw/i386/intel_iommu.c:3773:18: warning: declaration of =E2=80=98size=
=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>  3773 |         uint64_t size =3D mask + 1;
>       |                  ^~~~
> ../hw/i386/intel_iommu.c:3747:12: note: shadowed declaration is here
>  3747 |     hwaddr size, remain;
>       |            ^~~~
>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Queued, thanks!


