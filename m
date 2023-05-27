Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E807132CD
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 08:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2nJW-0006Tv-09; Sat, 27 May 2023 02:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nJT-0006TW-G1
 for qemu-devel@nongnu.org; Sat, 27 May 2023 02:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2nJS-0006Hm-0c
 for qemu-devel@nongnu.org; Sat, 27 May 2023 02:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685168520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aUN9qcUGB1c7uqFf6EQsjwdu8T/gB7o/5K6eKTIMSRQ=;
 b=ad3T3INcmWnzWUitkPzPOeemE/kdIuCsQ2uS94NDH2l/jDDsFyt0aKKOnL/0gK7d2y9Jee
 5y0R3oI9h2LkcWxEgm+A1eAtDB9nFg0yO0idMopWEYokDiY2tg9musFGXfxplTjB94s3Y8
 giknhufbRpsYF3Q0+4kL9OygS6k5gjQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-gtYl4EuxOVKhvuZmNh08CQ-1; Sat, 27 May 2023 02:21:55 -0400
X-MC-Unique: gtYl4EuxOVKhvuZmNh08CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1C0F3804061;
 Sat, 27 May 2023 06:21:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB4020296C6;
 Sat, 27 May 2023 06:21:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA3A721E692E; Sat, 27 May 2023 08:21:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "T.J. Alumbaugh" <talumbau@google.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Yuanchu Xie <yuanchu@google.com>,  Yu
 Zhao <yuzhao@google.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 2/5] virtio-balloon: device has Working Set
 Reporting
References: <20230525222016.35333-1-talumbau@google.com>
 <20230525222016.35333-3-talumbau@google.com>
Date: Sat, 27 May 2023 08:21:53 +0200
In-Reply-To: <20230525222016.35333-3-talumbau@google.com> (T. J. Alumbaugh's
 message of "Thu, 25 May 2023 22:20:13 +0000")
Message-ID: <878rda47lq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"T.J. Alumbaugh" <talumbau@google.com> writes:

>  - working_set_vq to receive Working Set reports from guest
>  - notification_vq to send config or request to guest
>  - add working set as object property on device
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index ff070ec828..4ba8c74b64 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -550,6 +550,32 @@
>   'returns': ['CommandLineOptionInfo'],
>   'allow-preconfig': true}
>  
> +##
> +# @MemoryBin:
> +#
> +# A bin of memory with a size in bytes. File-backed and
> +# anonymous memory are tracked separately.
> +#
> +# @anon: number of bytes of anonymous memory
> +# @file: number of bytes of file-backed memory

Please format like

   # A bin of memory with a size in bytes.  File-backed and anonymous
   # memory are tracked separately.
   #
   # @anon: number of bytes of anonymous memory
   #
   # @file: number of bytes of file-backed memory

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

Separating member sections with blank lines helps with catching certain
errors.  rST loves to surprise...

> +##
> +{ 'struct': 'MemoryBin',
> +  'data': { 'anon': 'uint64',
> +            'file': 'uint64' } }
> +

[...]


