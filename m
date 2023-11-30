Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22627FEC82
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:07:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8dvk-0004vb-Js; Thu, 30 Nov 2023 05:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8dvZ-0004tl-L1
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r8dvY-00085c-5D
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 05:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701338746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F89Pd4rvGUoyS07KzWGAZGP8//xnxcaClXR54+jFKhY=;
 b=fJaYYdi5RzrVhGEZAVL9mvHQL1MGQSXMSH0hxMuV8JLXp/Kn3+L3zyoo6x4oRoYvkChHS6
 8a57b7/roLdHnDMDg94jkZ1/3ghr7l8Tp6mIMQvfbnNd2QSKgO6f/i3z0REB984YXnPXPO
 YzUvimbjJjWgO7uoi9M/SAnnGvlKznM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-6U0cABG6OkKfL3aqAPOGMg-1; Thu,
 30 Nov 2023 05:05:43 -0500
X-MC-Unique: 6U0cABG6OkKfL3aqAPOGMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95BF71C06E07;
 Thu, 30 Nov 2023 10:05:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A8F71C060AE;
 Thu, 30 Nov 2023 10:05:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 480F721E6A1F; Thu, 30 Nov 2023 11:05:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  Klaus Jensen
 <its@irrelevant.dk>,  qemu-block@nongnu.org,  hare@suse.de,  David
 Hildenbrand <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Keith Busch <kbusch@kernel.org>,  Hanna Reitz
 <hreitz@redhat.com>,  dmitry.fomichev@wdc.com,  Kevin Wolf
 <kwolf@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org
Subject: Re: [RFC v2 1/7] docs/qcow2: add zd_extension_size option to the
 zoned format feature
References: <20231127085641.3729-1-faithilikerun@gmail.com>
 <20231127085641.3729-2-faithilikerun@gmail.com>
Date: Thu, 30 Nov 2023 11:05:41 +0100
In-Reply-To: <20231127085641.3729-2-faithilikerun@gmail.com> (Sam Li's message
 of "Mon, 27 Nov 2023 16:56:35 +0800")
Message-ID: <87a5qvd096.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

Sam Li <faithilikerun@gmail.com> writes:

> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> ---
>  docs/interop/qcow2.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 0f1938f056..458d05371a 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -428,6 +428,9 @@ The fields of the zoned extension are:
>                     The offset of zoned metadata structure in the contained
>                     image, in bytes.
>  
> +          44 - 51:  zd_extension_size
> +                    The size of zone descriptor extension data in bytes.
> +

Indentation is off.

>  == Full disk encryption header pointer ==
>  
>  The full disk encryption header must be present if, and only if, the


