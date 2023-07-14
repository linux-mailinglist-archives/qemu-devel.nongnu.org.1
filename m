Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911875332C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKDCT-0000vv-1g; Fri, 14 Jul 2023 03:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKDCQ-0000vh-Cs
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qKDCN-0002pe-Dx
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689319602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/lwflW4xdIO3g34OTnxaPhpMUWvDgPk4rnrowC6rzlc=;
 b=fGngMV8sd+WTIcC6S8WOvd3YyoILZFOCdR7snR9NjZFyHoPJ9EZY0vzoNWlf2fwMrcxVzB
 3BTkIJ80XJma0LXzc6Bpd075mLt3pti7K1vPCuoV1vbiyT6zjO6x6kRbB5KZtsLC6HSVVP
 WukClVNUWP8PzDbtQIvzOnyuP7kC3tk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-eepjlNo7N9WT3Rq8VJTHRQ-1; Fri, 14 Jul 2023 03:26:38 -0400
X-MC-Unique: eepjlNo7N9WT3Rq8VJTHRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 533C08D1684;
 Fri, 14 Jul 2023 07:26:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31E5C40C2063;
 Fri, 14 Jul 2023 07:26:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FE4821E6A1F; Fri, 14 Jul 2023 09:26:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Cc: jasowang@redhat.com,  mst@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,
 yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v4 4/6] ebpf: Added declaration/initialization routines.
References: <20230714022358.2438995-1-andrew@daynix.com>
 <20230714022358.2438995-5-andrew@daynix.com>
Date: Fri, 14 Jul 2023 09:26:37 +0200
In-Reply-To: <20230714022358.2438995-5-andrew@daynix.com> (Andrew
 Melnychenko's message of "Fri, 14 Jul 2023 05:23:56 +0300")
Message-ID: <878rbjgdhu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Andrew Melnychenko <andrew@daynix.com> writes:

> Now, the binary objects may be retrieved by id.
> It would require for future qmp commands that may require specific
> eBPF blob.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---

[...]

> diff --git a/ebpf/meson.build b/ebpf/meson.build
> index 2f627d6c7d..c9bbaa7c90 100644
> --- a/ebpf/meson.build
> +++ b/ebpf/meson.build
> @@ -1 +1 @@
> -system_ss.add(when: libbpf, if_true: files('ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> +common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
> \ No newline at end of file

Add a newline, please.


