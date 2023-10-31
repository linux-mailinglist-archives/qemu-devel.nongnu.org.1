Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5D7DCD1F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 13:44:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxo5S-0001s9-LD; Tue, 31 Oct 2023 08:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxo5P-0001rj-Tg
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qxo5O-0001Ex-ES
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 08:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698756188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZjuhsWvHN10Tcv3Z3VP1HRKTcjKKFkrk2o7cngddWE=;
 b=CEgMEDATTHjJS7ePQy2E7ZEFAC7IUJG8O3fO8XajRnxJ33J6JRqe1ICzkzUmzmiOynt0Ln
 SX7gqt1ibh4hph2N9mdGYGNe6+ifmUQBNv9EJ05PO9knLx8LcrophJr/FWmsYLZWtRJnUI
 Jzbt5RSK7mbvkudZfVNXY0V7ZzfXh18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-t5uul4AGO-iL-UNdpCi_Xw-1; Tue, 31 Oct 2023 08:43:06 -0400
X-MC-Unique: t5uul4AGO-iL-UNdpCi_Xw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084e263ec4so39964885e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 05:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698756185; x=1699360985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZjuhsWvHN10Tcv3Z3VP1HRKTcjKKFkrk2o7cngddWE=;
 b=GZfW8iuH/erH/Iv3BgkL3vzOYqOul/X1UUy6gZSBo8H//EmduG0UUzsVOmBEHCuaRh
 z8xvSFyyorHLsaSRr0mcMUDE28mxh0DvvY0HB7k1epUZU1kYSMxNsCUnIqtI4KT7mPO4
 Xts29o/vCuY6CFWHD8AFpN6F9be/RhoBp8jZaYPL7iZmwm3jmXXnPDe6AyDZlUP7Xwuy
 pSAzur+ylSBmmNuegxbA/O7lC37WZ2y5YmcVf0FssAWRTeoSOxCQDcx5dHogs4HXP6Tw
 lQQo9TGKfVJedckcQkSsKGhaWpL4bBdOqrPwZuP5PvIwy+pLKNk6p3H9lq6e11vIVxbq
 YssQ==
X-Gm-Message-State: AOJu0YxmR0SR9EfZeAsTydVO3p+TZNBf1TqbfpipdVJWDMfkQoyLx6I3
 YqDx0S8sxs8GmCAA0Il7p5NeJUN22ihNLGwpRoPRdr+cBQsNEqSb8oR5TQ5Yw3u6ADgRLX/xIO3
 NqkixMH3eEZXtYhc=
X-Received: by 2002:a5d:4d89:0:b0:32d:95dc:c065 with SMTP id
 b9-20020a5d4d89000000b0032d95dcc065mr9583867wru.19.1698756185349; 
 Tue, 31 Oct 2023 05:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHppnU1/bae+lQ+JAFvkXq6nQjGAIicOP5Dquv/CaeiWuICKyJeSneuEM+gpqFOZTVEbmrDhQ==
X-Received: by 2002:a5d:4d89:0:b0:32d:95dc:c065 with SMTP id
 b9-20020a5d4d89000000b0032d95dcc065mr9583843wru.19.1698756185000; 
 Tue, 31 Oct 2023 05:43:05 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d6107000000b0032da49e18fasm1457160wrt.23.2023.10.31.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 05:43:04 -0700 (PDT)
Date: Tue, 31 Oct 2023 08:43:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, npiggin@gmail.com,
 danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, dave@treblig.org, jasowang@redhat.com,
 michael.roth@amd.com, kkostiuk@redhat.com, david@redhat.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: Re: [PATCH 6/7] balloon: Fix a misleading error message
Message-ID: <20231031084245-mutt-send-email-mst@kernel.org>
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031111059.3407803-7-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Tue, Oct 31, 2023 at 12:10:58PM +0100, Markus Armbruster wrote:
> The error message
> 
>     {"execute": "balloon", "arguments":{"value": -1}}
>     {"error": {"class": "GenericError", "desc": "Parameter 'target' expects a size"}}
> 
> points to 'target' instead of 'value'.  Fix:
> 
>     {"error": {"class": "GenericError", "desc": "Parameter 'value' expects a size"}}
> 
> Root cause: qmp_balloon()'s parameter is named @target.  Rename it to
> @value to match the QAPI schema.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge

> ---
>  system/balloon.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/system/balloon.c b/system/balloon.c
> index e0e8969a4b..fda7af832e 100644
> --- a/system/balloon.c
> +++ b/system/balloon.c
> @@ -90,17 +90,17 @@ BalloonInfo *qmp_query_balloon(Error **errp)
>      return info;
>  }
>  
> -void qmp_balloon(int64_t target, Error **errp)
> +void qmp_balloon(int64_t value, Error **errp)
>  {
>      if (!have_balloon(errp)) {
>          return;
>      }
>  
> -    if (target <= 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "target", "a size");
> +    if (value <= 0) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "value", "a size");
>          return;
>      }
>  
> -    trace_balloon_event(balloon_opaque, target);
> -    balloon_event_fn(balloon_opaque, target);
> +    trace_balloon_event(balloon_opaque, value);
> +    balloon_event_fn(balloon_opaque, value);
>  }
> -- 
> 2.41.0


