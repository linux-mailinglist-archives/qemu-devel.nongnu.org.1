Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A497E35F5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:33:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GZv-0001dC-TW; Tue, 07 Nov 2023 02:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0GZt-0001d3-CR
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0GZr-00054x-JH
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699342365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=28aVtoo4zRxY641hWKrnT2cBNMVkW/LXGHIcXghy9TQ=;
 b=FeVYvGEL7w/uwoFMxQ1lN5SZXk2K8SOEFARuZ33Rs26WA4fFD+NsMcFtW1lleCOsXydevt
 HJAC3rOAcBtir2NjveknjJ2IomxYDm7YXAFMimqD6S3Dr4LhS/TLvYAX2WZN8k5/GcR0UL
 KvEMUBC/pdSo7S6j5hCe7SQ7ljwATiY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-5n58VsxPOJappXCPPTPEFQ-1; Tue, 07 Nov 2023 02:32:43 -0500
X-MC-Unique: 5n58VsxPOJappXCPPTPEFQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so33578455e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 23:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699342362; x=1699947162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28aVtoo4zRxY641hWKrnT2cBNMVkW/LXGHIcXghy9TQ=;
 b=mPcKw32JuuN+TsSx5vBcF2/HYy7TrX3ZcY69hXEdHQwvFfzp0bpIDaTsWsDXoVbDaE
 z02l8tDWUY3fCjJ2rXODUTyl58HRwLbjYAE66m5Hgya2lKYTNmd2WcnjprKyyiY1D4VC
 MU+gRj4reWqcS3c3JoR59Nd2sT0S+iw0PAftl5oyj+fsowDH7bRlX7X8SEzl2Cy4teEp
 84tJ/7pmPfShWHYxyWhpN3b7rWVR6psr5BGsXttclSJU2i5/HudbTzd8ghojTNUOIGBw
 zu9H+hF9oZ24t0SFRuzJRg5WxPRLll8OF6GUHj5qESelKF6wChRlfQ/pJV0Q5c1eF1qJ
 xeJQ==
X-Gm-Message-State: AOJu0YwKOLwXOnnld2RPm7h7sYHSCUr+Emlyg9M51G/VM2YlwD/1mRq6
 UItUQhPIrok3sbQOnX0xJHIXM1iCHs6YoJHKzN476UarTWtqt7eTcHNqWqj9jtmisvfmQPPnDuz
 qn2+UzpEqfCLQt34=
X-Received: by 2002:adf:f811:0:b0:32d:ad44:cec1 with SMTP id
 s17-20020adff811000000b0032dad44cec1mr25875311wrp.3.1699342362651; 
 Mon, 06 Nov 2023 23:32:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7m7myxb/O0RVQQbLKaaw1D1AdSsM/xjrIUDISj3ei3ixERg7rBcqhEEiyPD1wXaGG6DvfJQ==
X-Received: by 2002:adf:f811:0:b0:32d:ad44:cec1 with SMTP id
 s17-20020adff811000000b0032dad44cec1mr25875289wrp.3.1699342362301; 
 Mon, 06 Nov 2023 23:32:42 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a8-20020a5d5088000000b0032d2489a399sm1528145wrt.49.2023.11.06.23.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 23:32:41 -0800 (PST)
Date: Tue, 7 Nov 2023 02:32:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mlevitsk@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Message-ID: <20231107023155-mutt-send-email-mst@kernel.org>
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Nov 03, 2023 at 01:56:02PM +0300, Dmitrii Gavrilov wrote:
> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
> the failure case of qdev_device_add. It seems call of drain_call_rcu was
> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
> under happy path too. What led to overall performance degradation of
> qmp_device_add.
> 
> In this patch call of drain_call_rcu moved under handling of failure of
> qdev_device_add.


Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Also:

Fixes: 7bed89958b ("device_core: use drain_call_rcu in in qmp_device_add")
Cc: "Maxim Levitsky" <mlevitsk@redhat.com>


> 
> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
> ---
>  system/qdev-monitor.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1b8005a..dc7b02d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>          return;
>      }
>      dev = qdev_device_add(opts, errp);
> -
> -    /*
> -     * Drain all pending RCU callbacks. This is done because
> -     * some bus related operations can delay a device removal
> -     * (in this case this can happen if device is added and then
> -     * removed due to a configuration error)
> -     * to a RCU callback, but user might expect that this interface
> -     * will finish its job completely once qmp command returns result
> -     * to the user
> -     */
> -    drain_call_rcu();
> -
>      if (!dev) {
> +        /*
> +         * Drain all pending RCU callbacks. This is done because
> +         * some bus related operations can delay a device removal
> +         * (in this case this can happen if device is added and then
> +         * removed due to a configuration error)
> +         * to a RCU callback, but user might expect that this interface
> +         * will finish its job completely once qmp command returns result
> +         * to the user
> +         */
> +        drain_call_rcu();
> +
>          qemu_opts_del(opts);
>          return;
>      }
> -- 
> 2.34.1
> 
> 


