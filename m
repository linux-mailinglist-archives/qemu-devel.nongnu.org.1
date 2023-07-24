Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAA75F540
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:39:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNttC-0002JG-E4; Mon, 24 Jul 2023 07:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtt8-0002Iw-Og
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qNtt6-0004Cx-VF
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690198683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bq/XRsipZA1hoAv7qtF+to3SKyhZLboJGz194ks4AwM=;
 b=bLInycWjxpZxKS/Tn7X4WSOro9f328WmvvblRiI0ZKCO1g2aUhGWjfFB0W7Sv5EMOcMiQ1
 Uu3/X2DUEov5Uv5lVhI1hWM4Xsnz5mDIDH/LHVvwFLaPKLCRXnb88MAN0c7TCXY9BTbHQc
 yZg1DckwNhF3Pl46/Zm69z9K4z2HcLQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-82M4ltLWMuuf0FfX33SDhw-1; Mon, 24 Jul 2023 07:38:00 -0400
X-MC-Unique: 82M4ltLWMuuf0FfX33SDhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C36F93810D25;
 Mon, 24 Jul 2023 11:37:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9623410E5E;
 Mon, 24 Jul 2023 11:37:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79B2021E64D0; Mon, 24 Jul 2023 13:37:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 4/6] qapi: Add HvBalloonDeviceInfo sub-type to
 MemoryDeviceInfo
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <a23da090a925e98e98ccc15505345b277bcf393b.1689786474.git.maciej.szmigiero@oracle.com>
Date: Mon, 24 Jul 2023 13:37:58 +0200
In-Reply-To: <a23da090a925e98e98ccc15505345b277bcf393b.1689786474.git.maciej.szmigiero@oracle.com>
 (Maciej S. Szmigiero's message of "Thu, 20 Jul 2023 12:13:01 +0200")
Message-ID: <87zg3lmtex.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Used by the hv-balloon driver to report its provided memory state
> information.
>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
>  qapi/machine.json          | 39 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c3e55ef9e9cd..7b06ed35decb 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -247,6 +247,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      MemoryDeviceInfo *value;
>      PCDIMMDeviceInfo *di;
>      SgxEPCDeviceInfo *se;
> +    HvBalloonDeviceInfo *hi;
>  
>      for (info = info_list; info; info = info->next) {
>          value = info->value;
> @@ -304,6 +305,20 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                  monitor_printf(mon, "  node: %" PRId64 "\n", se->node);
>                  monitor_printf(mon, "  memdev: %s\n", se->memdev);
>                  break;
> +            case MEMORY_DEVICE_INFO_KIND_HV_BALLOON:

This is the only occurence of MEMORY_DEVICE_INFO_KIND_HV_BALLOON at the
end of the series.  Where are MemoryDeviceInfo with this union tag
created?

> +                hi = value->u.hv_balloon.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               hi->id ? hi->id : "");
> +                if (hi->has_memaddr) {
> +                    monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
> +                                   hi->memaddr);
> +                }
> +                monitor_printf(mon, "  max-size: %" PRIu64 "\n", hi->max_size);
> +                if (hi->memdev) {
> +                    monitor_printf(mon, "  memdev: %s\n", hi->memdev);
> +                }
> +                break;
>              default:
>                  g_assert_not_reached();
>              }

[...]


