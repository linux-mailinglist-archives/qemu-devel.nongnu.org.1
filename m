Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A036683039C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 11:30:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ3Ae-0007kE-Ai; Wed, 17 Jan 2024 05:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3AZ-0007jt-22
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ3AX-0002QC-Et
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 05:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705487350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeIBmt+MIti9/vxZogvw7S0c9cVZFXPSjUC3D616zT8=;
 b=O9uCkX/wTV/h+7F8nB5A9VRbKAsYWufJsEpwwRTuJ3SWKGf9ZDaWTOKRXaqJ6ABtzQO7KG
 2NG4C8KSI1vn4GZkvpOXhakdlKJ8Qtdw9yv0Izp6YUpfSne6qduqomXP3Xi9nFXGbgIbF6
 eBqSBDfZOsZB/X1nBvGBi01xSWPJH8s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166--AGyiUrKOTeAYd1pPH_O8A-1; Wed, 17 Jan 2024 05:29:08 -0500
X-MC-Unique: -AGyiUrKOTeAYd1pPH_O8A-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68174924600so23236786d6.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 02:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705487348; x=1706092148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SeIBmt+MIti9/vxZogvw7S0c9cVZFXPSjUC3D616zT8=;
 b=ByKOrZiRlN2he0yCqGCFkDXI+abyVYGzHVHNvuSDclCcnrOh+wQkvHkkNxN0XSWf8D
 NIIEd0VspQXDEfKTObrS5ptVtuED71ELrZU51E7cy/kIl6vKydh13x24NZP5BENAgvgq
 BfiRGPBpGHVrbOc2konSgHar6GnSihBXu+EQVTT7koSOURqtq7928XyotQ48qj66JhHs
 JK0coagaA8XEluJxBjJAiJtrpe7hFf5cjTcDT40Qj/JT5utzkO5BiOXgJxt30bb/b8MD
 PA+Ro4r/KfW8MJfNCYy6gHLtzb1unmCRGMGoyjWaZ886aHRXxt5OjgT4Gr4w1cY0D8Nd
 Q3VQ==
X-Gm-Message-State: AOJu0YwlaSxYN7ssD1dk8Ap9Xy6frI4a9ajNAHG1KmbTWU2y/6tyDhES
 MALYIHMaSfPoC1HLQ1cOEjLKImRJAz4kQEXiC7C3BmRNEZmMKNo6Aik+DtbLFxhufhQ4C/OyI+w
 haObYNTJh+fQ7hhKUBzizJtEI1NImzH/jYUGNZtu0QxKe4ZAgoGo8
X-Received: by 2002:ad4:5ae4:0:b0:681:7843:5d58 with SMTP id
 c4-20020ad45ae4000000b0068178435d58mr823943qvh.18.1705487347762; 
 Wed, 17 Jan 2024 02:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHShfrU5/iLIeu37oZ/4099XQq445R3rXGCjm0Om3Kb1z8RFvo4eRrY5dWj6IcRAQmo2Kq6Q==
X-Received: by 2002:ad4:5ae4:0:b0:681:7843:5d58 with SMTP id
 c4-20020ad45ae4000000b0068178435d58mr823934qvh.18.1705487347465; 
 Wed, 17 Jan 2024 02:29:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a0cec8e000000b0068173c2ff1fsm1056819qvo.78.2024.01.17.02.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 02:29:03 -0800 (PST)
Message-ID: <9c4093af-089a-4b75-9022-be1a8971f1f7@redhat.com>
Date: Wed, 17 Jan 2024 11:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] reset: qemu_register_reset_one()
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <20240117091559.144730-2-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 1/17/24 10:15, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> Cleanup the code to use a single entrance on register reset hooks.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/core/reset.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/hw/core/reset.c b/hw/core/reset.c
> index d3263b613e..8cf60b2b09 100644
> --- a/hw/core/reset.c
> +++ b/hw/core/reset.c
> @@ -39,23 +39,26 @@ typedef struct QEMUResetEntry {
>  static QTAILQ_HEAD(, QEMUResetEntry) reset_handlers =
>      QTAILQ_HEAD_INITIALIZER(reset_handlers);
>  
> -void qemu_register_reset(QEMUResetHandler *func, void *opaque)
> +static void qemu_register_reset_one(QEMUResetHandler *func, void *opaque,
> +                                    bool skip_snap)
>  {
>      QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
>  
>      re->func = func;
>      re->opaque = opaque;
> +    re->skip_on_snapshot_load = skip_snap;
>      QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
>  }
>  
> -void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
> +void qemu_register_reset(QEMUResetHandler *func, void *opaque)
>  {
> -    QEMUResetEntry *re = g_new0(QEMUResetEntry, 1);
> +    /* By default, do not skip during load of a snapshot */
> +    qemu_register_reset_one(func, opaque, false);
> +}
>  
> -    re->func = func;
> -    re->opaque = opaque;
> -    re->skip_on_snapshot_load = true;
> -    QTAILQ_INSERT_TAIL(&reset_handlers, re, entry);
> +void qemu_register_reset_nosnapshotload(QEMUResetHandler *func, void *opaque)
> +{
> +    qemu_register_reset_one(func, opaque, true);
>  }
>  
>  void qemu_unregister_reset(QEMUResetHandler *func, void *opaque)


